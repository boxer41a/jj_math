note
	description: "[
		A MATRIX with only one column.
		]"
	date: "20 Sep 08"
	author:		"Jimmy J. Johnson"

class
	COLUMN_MATRIX

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
			-- Create a matrix with 1 column and 3 rows.
		do
			make (3)
		end

	make (a_number: INTEGER)
			-- Create an instance with `a_number' rows
		require
			number_large_enough: a_number >= 0
		do
			matrix_make (a_number, 1)
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
			from i := 1
			until i > count
			loop
				put (item (i, 1) + other.item (i, 1) , i, 1)
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
				put (item (i, 1) * a_number, i, 1)
				i := i + 1
			end
		end

feature -- Querry

	transposition: ROW_MATRIX	--, conjugation: like Current is
			-- Return the conjugate or `transpose' of Current.
		local
			r: INTEGER
		do
			create Result.make (nb_rows)
			from
				r := 1
			until
				r > nb_rows
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
			Result := a_other.nb_cols = 1
			from i := 1
			until not Result or else i > count
			loop
				Result := very_close (item (i, 1), a_other.item (i, 1))
				i := i + 1
			end
		end

invariant

	only_one_column: nb_cols = 1

end
