note
	description: "[
		A MATRIX with only one row.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"

class
	ROW_MATRIX

inherit

	MATRIX
		rename
			make as matrix_make
		export
			{NONE}
				matrix_make,
				transpose,
				remove_column
		redefine
			default_create,
			clean,
			add,
			scalar_multiply,
			transposition,
			is_very_close
		end

create
	default_create,
	make
create {MATRIX}
	matrix_make		-- needed because of calls in ARRAY2.resize

feature {NONE} -- Initialization

	default_create
			-- Create a matrix with 1 row and 3 column.
		do
			make (3)
		end

	make (a_number: INTEGER)
			-- Create an instance with `a_number' items
		require
			number_large_enough: a_number >= 0
		do
			matrix_make (1, a_number)
		end

feature -- Element Change

	clean
			-- Set those attributes close to zero equal to zero.
		local
			i: INTEGER
			v: DOUBLE
		do
			from i := 1
			until i > count
			loop
				v := entry (i)
				if very_close (v, 0.0) then
					enter (0.0, i)
				elseif very_close (v, 1.0) then
					enter (1.0, i)
				end
				i := i + 1
			end
		end

feature -- Basic operations

	add (other: MATRIX)
			-- Add `other' by normal vector addition.
		local
			i: INTEGER
		do
				-- Redefined to remove inner loop.
			from i := 1
			until i > count
			loop
				put (item (1, i) + other.item (1, i) , 1, i)
				i := i + 1
			end
		end

	scalar_multiply (a_number: DOUBLE)
			-- Multiply by a scalar (a real number).
		local
			i: INTEGER
		do
				-- Redefined to remove inner loop.
			from i := 1
			until i > count
			loop
				put (item(1,i) * a_number, 1, i)
				i := i + 1
			end
		end

feature -- Querry

	transposition: COLUMN_MATRIX	--, conjugation: like Current is
			-- Return the conjugate or `transpose' of Current.
		local
			r: INTEGER
		do
			create Result.make (nb_cols)
			from
				r := 1
			until
				r > nb_cols
			loop
				Result.enter (entry (r), r)
				r := r + 1
			end
		end

feature -- Comparison

	is_very_close (a_other: MATRIX): BOOLEAN
			-- Is Current almost equal to `a_other'?
		local
			i: INTEGER
		do
			Result := a_other.nb_rows = 1
			from i := 1
			until not Result or else i > count
			loop
				Result := very_close (item (1, i), a_other.item (1, i))
				i := i + 1
			end
		end

invariant

	only_one_row: nb_rows = 1

end
