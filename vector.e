note
	description: "[
			A general vector implemented as a ROW_MATRIX.
		]"
	date: "17 Sep 08"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"

class
	VECTOR

inherit

	ROW_MATRIX
		redefine
			is_zero
		end

create
	default_create,
	make
create {MATRIX}
	matrix_make		-- needed because of calls in ARRAY2.resize

feature -- Access

	length: DOUBLE
			-- Length of the vector.
			-- "Handbook of Engineering Fundamentals", 3rd edition, Eshbach, page 295.
		local
			i: INTEGER
			d: DOUBLE
			s: DOUBLE
		do
			from i := 1
			until i > count
			loop
				d := entry (i)
				s := s + d * d
				i := i + 1
			end
			Result := sqrt (s)
		end

	length_squared: DOUBLE
			-- The square of the `length' of the Vector
		do
			Result := length * length
		end

feature -- Transformation

	normalize
			-- Convert to a vector of length one.
			-- v' = v / ||v||
		require
			has_length: not is_zero
		local
			len_sq: DOUBLE
			fact: DOUBLE
		do
			len_sq := length_squared
			if very_close (len_sq, 0.0) then
				clean
			else
				fact := inverse_square_root (len_sq)
				scalar_multiply (fact)
			end
		ensure
			is_unit_vector: is_unit_vector
		end

feature -- Basic operations

	dot_product (other: VECTOR): DOUBLE
			-- Dot product of Current and `other'.
			-- "Essential Mathematics for Games and Interactive Applications", Van Verth &
			-- Bishop, 2004, p 29.
		local
			i: INTEGER
		do
			from i := 1
			until i > count
			loop
				Result := Result + item (1, i) * other.item (1, i)
				i := i + 1
			end
		end

feature -- Status report

	is_unit_vector: BOOLEAN
			-- Does this vector have length 1?
		do
			Result := very_close (length, 1.0)
		ensure
			definition: Result implies very_close (length, 1.0)
		end

	is_zero: BOOLEAN
			-- Does current have zero lenth?
		do
			Result := very_close (length_squared, 0.0)
		end

feature -- Querry

	normalized: like Current
			-- A normalized copy of Current.
		do
			Result := deep_twin
			Result.normalize
		end

invariant

	non_negative_length: length >= 0

end

