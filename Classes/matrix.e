note
	description: "[
			A two demensional matrix.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"

class
	MATRIX

inherit

		-- Because this class inherits from NUMERIC the preconditions to the basic operation
		-- features, `infix "+"', `infix "-"', `infix "*"', `infix "/"', `prefix "+"'
		-- and `prefix "-"' (deferred in NUMERIC) will not be effective because the
		-- preconditions need to be stronger in this class.  For example, `infix "+"'
		-- here requires matrixes of the same size, but the precondition in NUMERIC
		-- simply requires other to be non-void.
		-- To combat this, the preconditions were duplicated as check statements in
		-- the body of the features.
		-- Features `one' and `zero' don't really work for this class.  Feature `one'
		-- can only apply to square matrix; feature `zero' okay.

		-- Is inheriting from NUMERIC useful?  Not sure.  jjj  18 Sep 2018

	NUMERIC
		undefine
			default_create,
			copy,
			is_equal
		end

	ARRAY2 [DOUBLE]
		rename
			make as array2_make,	-- obsolete
			height as nb_rows,
			width as nb_cols
		redefine
			default_create
		end

inherit {NONE}

	SAFE_DOUBLE_MATH
		export
			{NONE}
				all
			{ANY}
				very_close
		undefine
			default_create,
			copy,
			is_equal
		end

create
	default_create,
	make,
	make_from_other

feature {NONE} -- Initialization

	default_create
			-- Create a 3-by-3 matrix filled with 0's.
		do
			make (3, 3)
		end

	make (a_num_rows, a_num_cols: INTEGER)
			-- Create a matrix filled with 0's.
			-- A zero-by-zero matrix is the "empty" matrix.
		require
			rows_big_enough: a_num_rows >= 0
			colums_big_enough: a_num_cols >= 0
		do
			if a_num_rows = 0 or else a_num_cols = 0 then
				make_empty
				nb_rows := a_num_rows
				nb_cols := a_num_cols
			else
				make_filled (0.0, a_num_rows, a_num_cols)
			end
		ensure then
			proper_size: nb_rows = a_num_rows and nb_cols = a_num_cols
		end

	make_from_other (a_other: MATRIX)
			-- Create and initialize from `a_other'
		require
			other_exists: a_other /= Void
		local
			i, j: INTEGER
		do
			make (a_other.nb_rows, a_other.nb_cols)
			from i := 1
			until i > a_other.nb_rows
			loop
				from j := 1
				until j > a_other.nb_cols
				loop
					put (a_other.item (i, j), i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

feature -- Access

	row_matrix (a_index: INTEGER): ROW_MATRIX
			-- row number `a_index' as a row matrix
		require
			in_range: a_index > 0 and a_index <= nb_rows
		local
			c: INTEGER
 		do
			create Result.make (nb_cols)
			from
				c := 1
			until
				c > nb_cols
			loop
				result.put (item (a_index, c), 1, c)
				c := c + 1
			end
		ensure
			correct_size: Result.nb_rows = 1 and Result.nb_cols = nb_cols
			definition:  -- fix me
		end

	column_matrix (a_index: INTEGER): COLUMN_MATRIX
			-- column `a_index' as a column matrix
		require
			in_range: a_index > 0 and a_index <= nb_cols
		local
			r: INTEGER
 		do
			create Result.make (nb_rows)
			from
				r := 1
			until
				r > nb_rows
			loop
				result.put (item (r, a_index), r, 1)
				r := r + 1
			end
		ensure
			correct_size: Result.nb_rows = nb_rows and Result.nb_cols = 1
			definition:  -- fix me
		end

feature -- Transformation

	set_identity
			-- Make the matrix the identity matrix.
		require
			is_square_matrix: is_square
		local
			i: INTEGER
		do
			initialize (0)
			from
				i := 1
			until
				i > nb_rows
			loop
				put (1.0, i, i)
				i := i + 1
			end
		ensure
			set_to_identity: is_identity
		end

	clean
			-- Set those attributes close to zero equal to zero.
		local
			r, c: INTEGER
			v: DOUBLE
		do
			from r := 1
			until r > nb_rows
			loop
				from c := 1
				until c > nb_cols
				loop
					v := item (r, c)
					if very_close (v, 0.0) then
						put (0.0, r, c)
					elseif very_close (v, 1.0) then
						put (1.0, r, c)
					end
					c := c + 1
				end
				r := r + 1
			end
		end

	negate
			-- Reverse the sign of each element.
		do
			scalar_multiply (-1)
		ensure
--			definition: (Current + old Current).is_zero
		end

	add (a_other: MATRIX)
			-- Add `a_other' to current.
			-- The matrix consisting of elements (i, j) + a_other's elements (i, j)
		require
			matrix_exists:  a_other /= Void
			matrixes_same_size: is_same_size (a_other)
		local
			r, c: INTEGER
		do
			from
				r := 1
			until
				r > nb_rows
			loop
				from
					c := 1
				until
					c > nb_cols
				loop
					put (item(r,c) + a_other.item(r,c), r,c)
					c := c + 1
				end
				r := r + 1
			end
		end

	subtract (a_other: MATRIX)
			-- Subtract `a_other' from current.
			-- The matrix consisting of elements (i, j) - a_other's elements (i, j)
		require
			matrix_exists:  a_other /= Void
			matrixes_same_size: is_same_size (a_other)
		do
			add (-a_other)
		end

	scalar_multiply (a_number: DOUBLE)
			-- Multiply by a scalar (a real number).
		local
			r, c: INTEGER
		do
			from
				r := 1
			until
				r > nb_rows
			loop
				from
					c := 1
				until
					c > nb_cols
				loop
					put (item(r,c) * a_number, r, c)
					c := c + 1
				end
				r := r + 1
			end
		end

	scalar_divide (a_number: DOUBLE)
			-- Divide by a scalar (a real number).
		require
			not_zero: not very_close (a_number, 0.0)
		do
			scalar_multiply (1.0 / a_number)
		end

	frozen multiply (a_other: MATRIX)
			-- Multiply the two matrixes.
		require
			other_exists: a_other /= Void
			matrices_conform: a_other.conforms (Current)
		local
			r, c, i: INTEGER
			tot: DOUBLE
			m: like Current
		do
			check
				matrix_exists: a_other /= Void
				matrices_conform: a_other.conforms (Current)
					-- because...see comment near inheritance clause for NUMERIC.
			end
			m := deep_twin
			from
				r := 1
			until
				r > m.nb_rows
			loop
				from
					c := 1
				until
					c > a_other.nb_cols
				loop
					from
						i := 1
						tot := 0
					until
						i > m.nb_cols
					loop
						tot := tot + m.item(r,i) * a_other.item(i,c)
						i := i + 1
					end
					put (tot, r, c)
					c := c + 1
				end
				r := r + 1
			end
		ensure then
			row_count_unchanged: nb_rows = old nb_rows
			collumn_count_unchanged: nb_cols = old nb_cols
			valid_column_count: nb_cols = a_other.nb_cols
		end

	frozen transpose
			-- Interchange rows and columns
		local
			m: MATRIX
			r, c: INTEGER
		do
			m := transposition
			make (m.nb_rows, m.nb_cols)
			from r := 1
			until r > nb_rows
			loop
				from c := 1
				until c > nb_cols
				loop
					put (m.item (r, c), r, c)
					c := c + 1
				end
				r := r + 1
			end
		ensure
			correct_size: nb_rows = old nb_cols and nb_cols = old nb_rows
		end

	invert
			-- Invert the matrix.
		require
			is_square_matrix: is_square
			determinant_not_zero: not (very_close (determinant, 0.0))
		local
			d: DOUBLE
		do
				-- 1/determinant * adjoint
			d := determinant
			adjoin
--			scalar_multiply (1.0 / determinant)
			scalar_multiply (1.0 / d)
		end

	frozen adjoin
			-- Change the matrix into its adjoint.
		require
			is_square: is_square
		local
			m: MATRIX
			r, c: INTEGER
		do
			create m.make (nb_rows, nb_cols)
			from r := 1
			until r > nb_rows
			loop
				from c := 1
				until c > nb_cols
				loop
					m.put (cofactor (r, c), r, c)
					c := c + 1
				end
				r := r + 1
			end
			m.transpose
			from r := 1
			until r > nb_rows
			loop
				from c := 1
				until c > nb_cols
				loop
					put (m.item (r, c), r, c)
					c := c + 1
				end
				r := r + 1
			end
		end

	remove_row (a_row: INTEGER)
			-- Delete row 'a_row' from the matrix.
		require
			can_remove_row: nb_rows > 0
			valid_row: a_row >= 1 and a_row <= nb_rows
		local
			temp: like Current
			r, c, i: INTEGER
		do
			temp := twin
			make (nb_rows - 1, nb_cols)
			from
				r := 1
			until
				r > temp.nb_rows or else nb_cols = 0
			loop
				if r /= a_row then
					if r < a_row then
						i := r
					else
						i := r - 1
					end
					from
						c := 1
					until
						c > temp.nb_cols
					loop
						put (temp.item (r,c), i, c)
						c := c + 1
					end
				end
				r := r + 1
			end
		ensure
			one_row_less: nb_rows = old nb_rows - 1
		end

	remove_column (a_col: INTEGER)
			-- Delete column 'a_col' from the matrix.
		require
			can_remove_column: a_col > 0
			valid_column: a_col >= 1 and a_col <= nb_cols
		local
			temp: like Current
			r, c, i: INTEGER
		do
			temp := twin
			make (nb_rows, nb_cols - 1)
			from
				r := 1
			until
				r > temp.nb_rows
			loop
				from
					c := 1
				until
					c > temp.nb_cols or else nb_rows = 0
				loop
					if c /= a_col then
						if c < a_col then
							i := c
						else
							i := c - 1
						end
						put (temp.item (r,c), r, i)
					end
					c := c + 1
				end
				r := r + 1
			end
		ensure
			one_row_less: nb_cols = old nb_cols - 1
		end

feature  -- Basic operations

	minor (i, j: INTEGER): DOUBLE
			-- The determinant of the sub-matrix obtained by striking out
			-- row `i' and column `j'.
			-- "Handbook of Engineering Fundamentals", 3rd edition, Eshbach, page 230.
		require
			matrix_big_enough: nb_rows > 0 and nb_cols > 0
			is_square_matrix: is_square
			index_in_range: 1 <= i and i <= nb_rows and 1 <= j and j <= nb_cols
		local
			m: MATRIX
		do
				-- Cannot use twin here, because the type attached to `m' could
				-- be a descendant, such as D3_MATRIX, whose invariant does not
				-- allow rows and columns to be removed.
--			m := twin
			create m.make_from_other (Current)
			m.remove_row (i)
			m.remove_column (j)
			check
				 m.is_square	-- because remove both a row and column from square matrix.
			end
			Result := m.determinant
		end

	cofactor (i, j: INTEGER): DOUBLE
			-- The determinant of a square matrix of order (n-1)
			-- obtained by removing row 'i' and column 'j' multiplied
			-- by (-1) raised to the 'i + j' power.
			-- In other words, (-1)^(i + j) * minor (i, j).
			-- "Handbook of Engineering Fundamentals", 3rd edition, Eshbach, page 230.
		require
			is_square_matrix: is_square
			index_in_range: 1 <= i and i <= nb_rows and 1 <= j and j <= nb_cols
		do
			Result := minor (i, j) * (-1^(i+j))
		end

	determinant: DOUBLE
			-- The determinant of the matrix.
		require
			is_square_matrix: is_square
		local
			c: INTEGER
		do
			if nb_cols = 0 then
				Result := 1.0			-- by definition of "empty matrix" see wiki
			elseif nb_cols = 1 then
				Result := item (1,1)
			elseif nb_cols = 2 then
				Result := item (1,1) * item (2,2) - item (1,2) * item (2,1)
			else
				from
					c := 1
				until
					c > nb_cols
				loop
					Result := Result + item (1,c) * cofactor (1,c)
					c := c + 1
				end
			end
		end

	frozen identity alias "+": like Current
			-- A copy of Current.  Inherited as deferred from NUMERIC.
		do
			Result := twin
		end

	frozen negation, additive_inverse, opposite alias "-" alias "−": like Current
			-- Same as `negate' but does not change current.
		do
			Result := twin
			Result.negate
		end

	frozen plus alias "+" (a_other: MATRIX): like Current
			-- Same as `add' but does not change current.
		require else
			matrix_exists: a_other /= Void
			matrixes_same_size: is_same_size (a_other)
		do
				-- See comment near inheritance clause for NUMERIC.
			check
				matrix_exists: a_other /= Void
				matrixes_same_size: is_same_size (a_other)
					-- because...see comment near inheritance clause for NUMERIC.
			end
			Result := twin
			Result.add (a_other)
		end

	scalar_product (a_number: DOUBLE): like Current
			-- Copy of Current multiplies by `a_number'.
		do
			Result := twin
			Result.scalar_multiply (a_number)
		end

	minus alias "-" alias "−" (a_other: MATRIX): like Current
			-- Same as `subtract' but does not change current.
		require else
			matrix_exists: a_other /= Void
			matrixes_same_size: is_same_size (a_other)
		do
			check
				matrix_exists: a_other /= Void
				matrixes_same_size: is_same_size (a_other)
					-- because...see comment near inheritance clause for NUMERIC.
			end
			Result := twin
			Result.subtract (a_other)
		end

	difference (a_other: MATRIX): like Current
			-- Synonym for `minus'.
		require else
			matrix_exists: a_other /= Void
			matrixes_same_size: is_same_size (a_other)
		do
			check
				matrix_exists: a_other /= Void
				matrixes_same_size: is_same_size (a_other)
					-- because...see comment near inheritance clause for NUMERIC.
			end
			Result := minus (a_other)
		end

	product alias "*" alias "×" (a_other: like Current): like Current
			-- The product between Current and `a_other'.
		require else
			matrix_exists: a_other /= Void
			matrices_conform: a_other.conforms (Current)
		local
			r, c, i: INTEGER
			tot: DOUBLE
		do
			check
				matrix_exists: a_other /= Void
				matrices_conform: a_other.conforms (Current)
					-- because...see comment near inheritance clause for NUMERIC.
			end
			create Result.make (nb_rows, a_other.nb_cols)
			from
				r := 1
			until
				r > nb_rows
			loop
				from
					c := 1
				until
					c > a_other.nb_cols
				loop
					from
						i := 1
						tot := 0
					until
						i > nb_cols
					loop
						tot := tot + item(r,i) * a_other.item(i,c)
						i := i + 1
					end
					Result.put (tot, r, c)
					c := c + 1
				end
				r := r + 1
			end
		ensure then
			valid_row_count: Result.nb_rows = nb_rows
			valid_column_count: Result.nb_cols = a_other.nb_cols
		end

	transposition: MATRIX	--, conjugation: like Current is
			-- Return the conjugate or `transpose' of Current.
		local
			r, c: INTEGER
		do
			create Result.make (nb_cols, nb_rows) -- these are reversed.
			from
				r := 1
			until
				r > nb_rows
			loop
				from
					c := 1
				until
					c > nb_cols
				loop
					Result.put (item(r,c), c, r)
					c := c + 1
				end
				r := r + 1
			end
		ensure
			current_unchanged: nb_rows = old nb_rows and nb_cols = old nb_cols
			correct_size: Result.nb_rows = nb_cols and Result.nb_cols = nb_rows
		end

	inversion: like Current
			-- Same as `invert' but does not change current.
		require
			is_square: is_square
			determinant_not_zero: not very_close (determinant, 0.0)
		do
			Result := twin
			Result.invert
		ensure
			identity_property: (Result * Current).is_identity and (Current * Result).is_identity
			inversion_property: Result.inversion.is_very_close (Current)
		end

	adjoint: MATRIX
			-- Compute the adjoint of Current
		require
			is_square: is_square
		do
			Result := twin
			Result.adjoin
		end

feature -- Status Report

	is_square: BOOLEAN
			-- Is this a square matrix?
		do
			Result := nb_rows = nb_cols
		ensure
			valid_result: Result implies nb_rows = nb_cols
		end

	is_zero: BOOLEAN
			-- Are all the elements = 0?
		local
			r, c: INTEGER
		do
			Result := True
			from
				r := 1
			until
				r > nb_rows or not Result
			loop
				from
					c := 1
				until
					c > nb_cols or not Result
				loop
					Result := very_close (item (r, c), 0.0)
					c := c + 1
				end
				r := r + 1
			end
		ensure
			definition: Result implies for_all (agent very_close (?, 0.0))
		end

	is_column_zero (c: INTEGER): BOOLEAN
			-- Is each item in column `c' equal to zero?
		require
			in_range: c > 0 and c <= nb_cols
		do
			Result := column_matrix(c).is_zero
		ensure
			definition: Result implies column_matrix (c).for_all (agent very_close (?, 0.0))
		end

	is_row_zero (r: INTEGER): BOOLEAN
			-- Is each item in row `r' equal to zero?
		require
			in_range: r > 0 and r <= nb_rows
		do
			Result := row_matrix(r).is_zero
		ensure
			definition: Result implies row_matrix (r).for_all (agent very_close (?, 0.0))
		end

	is_nonsingular: BOOLEAN
			-- Is matrix nonsigular?  Does it have an inverse?
			-- "Matrices and Linear Algebra", Schneider & Barker, 1968, pg. 25
		do
			Result := not very_close (determinant, 0.0);
		end

	is_symmetric: BOOLEAN
			-- Is current matrix equal to its conjugation / transposition?
		local
			is_sym: BOOLEAN
			i, j: INTEGER
		do
--			Result := is_very_close (transposition)		-- O(n^2)
			if is_square then
				is_sym := true		-- assume it is, until finding otherwise
				from i := 1
				until i > count - 1 or not is_sym
				loop
					from j := i + 1
					until j > count or not is_sym
					loop
						is_sym := very_close (item (i, j), item (j,i))
						j := j + 1
					end
				end
				Result := is_sym
			end
		ensure
			valid_result: Result implies is_very_close (transposition)
		end

	is_skew_symmetric, is_anti_symmetric: BOOLEAN
			-- Is this matrix skew-symmetric or anti-symmetric?
			-- True if equal to the negation of its transposition.
			-- "Matrices With Applications", Campbell, 1968, pg 49
		do
			Result := is_very_close (-transposition)
		ensure
			valid_result: Result implies is_very_close (-transposition)
		end

	is_diagonal: BOOLEAN
			-- Is this a diagonal matrix?
			-- Are all non-diagonal elements of a square matrix zero?
		local
			r, c: INTEGER
		do
			Result := is_square
			from
				r := 1
			until
				r > nb_rows or not Result
			loop
				from
					c := 1
				until
					c > nb_cols or not Result
				loop
					if r /= c then
						Result := very_close (item (r, c), 0.0)
					end
					c := c + 1
				end
				r := r + 1
			end
		ensure
			result_implies_square: Result implies is_square
			definition:  -- fix me.
		end

	is_orthogonal: BOOLEAN
			-- Is Current an orthogonal matrix?
			-- (I.e. is it square and is the inverse equal to the transpose?)
		do
			Result := is_square and then (inversion.is_very_close (transposition))
		ensure
			definition: Result implies is_square and then (inversion.is_very_close (transposition))
		end

	is_scalar: BOOLEAN
			-- Is this a scalar matrix?
			-- Is this a diagonal matrix and furthermore are the diagonal elements all equal?
		local
			r: INTEGER
		do
			Result := is_diagonal
			from
				r := 1
			until
				r > nb_rows or not Result
			loop
				Result := very_close (item (r, r), item (1,1))
				r := r + 1
			end
		ensure
			result_implies_diagonal: Result implies is_diagonal
			definition: -- Fix me.
		end

	is_identity: BOOLEAN
			-- Is this an identity matrix?
			-- Is this a diagonal matrix with all diagonal elements equal to 1?
		local
			r: INTEGER
		do
			Result := is_diagonal
			from
				r := 1
			until
				r > nb_rows or not Result
			loop
				Result := very_close (item (r, r), 1.0)
				r := r + 1
			end
		ensure
			result_implies_diagonal: Result implies is_diagonal
			definition:  -- Fix me.
		end

	is_same_size (other: MATRIX): BOOLEAN
			-- Is this matrix the same size as 'other'?
		require
			other_not_void: other /= Void
		do
			Result := nb_rows = other.nb_rows and nb_cols = other.nb_cols
		ensure
			valid_result: Result implies nb_rows = other.nb_rows and nb_cols = other.nb_cols
		end

	is_transpose (other: MATRIX): BOOLEAN
			-- Is this matrix the transposition / conjugation of 'other'?
		require
			other_exists: other /= Void
		do
--			Result := equal (Current, other.transposition)
			Result := transposition.is_very_close (other)
		end

	conforms (other: MATRIX): BOOLEAN
			-- Does this matrix conform to 'other'?
		require
			other_exists: other /= Void
		do
			Result := nb_rows = other.nb_cols
		ensure
			valid_result: Result implies nb_cols = other.nb_rows
		end

feature -- Comparison

	is_very_close (a_other: MATRIX): BOOLEAN
			-- Is Current made of *basicly* the same items as `a_other'?
			-- This uses `very_close' from {SAFE_DOUBLE_MATH} to determine if the items
			-- in Current are close enough to be considered the same.
		local
			i, j: INTEGER
		do
			if nb_rows = a_other.nb_rows and nb_cols = a_other.nb_cols then
				if lower = a_other.lower and then upper = a_other.upper then
					from
						Result := True
						i := 1
					until
						not Result or i > nb_rows
					loop
						from j := 1
						until j > nb_cols
						loop
							Result := very_close (item (i, j), a_other.item (i, j))
							j := j + 1
						end
						i := i + 1
					end
				end
			else
				Result := False
			end
		ensure then
			definition_1: Result implies lower = a_other.lower and then upper = a_other.upper
			definition_2:  -- Fix me.  -- for_all (agent...)
		end

feature -- Output

	show
			-- Printable string representation of the matrix.
		local
			r, c: INTEGER
		do
			io.putstring ("MATRIX is:")
			io.new_line
			from
				r := 1
			until
				r > nb_rows
			loop
				from
					c := 1
				until
					c > nb_cols
				loop
					io.put_double (item (r,c))
					io.putstring ("   ")
					c := c + 1
				end
				io.new_line
				r := r + 1
			end
		end

feature {NONE} -- Inapplicable

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		do
			check
				do_not_call: False
					-- because does not apply to this class
			end
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		do
			check
				do_not_call: False
					-- because does not apply to this class
			end
		end

	quotient alias "/" alias "÷" (other: like Current): like Current
			-- Division by `other'
		do
			check
				do_not_call: False then
					-- because does not apply to this class
			end
		end

invariant

	valid_size:


end








































