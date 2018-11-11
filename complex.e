note
	description: "[
		Representation of complex numbers:  z = x + yi where i = sqrt(-1)
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2012, Jimmy J. Johnson"
	license:	"Eiffel Forum License v2 (see forum.txt)"

class
	COMPLEX

inherit

	NUMERIC

	SAFE_DOUBLE_MATH
		rename
			one as double_one,
			zero as double_zero
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_real, a_imaginary: DOUBLE)
			-- Create an imaginary number with `a_real' and `a_imaginary' part
		do
			x := a_real
			yi := a_imaginary
		ensure
			real_part_assigned: very_close (x, a_real)
			imaginary_part_assigned: very_close (yi, a_imaginary)
		end

feature -- Access

	x: DOUBLE
			-- The real part of Current

	yi: DOUBLE
			-- The imaginary part of Current

	phase: DOUBLE
			-- or argument, or phi, of Current
		do
			if x > 0.0 then
				Result := arc_tangent (yi / x)
			elseif x < 0.0 and yi >= 0.0 then
				Result := arc_tangent (yi / x + Pi)
			elseif x < 0.0 and yi < 0.0 then
				Result := arc_tangent (yi / x - Pi)
			elseif x = 0.0 and yi > 0.0 then
				Result := Pi / 2
			elseif x = 0.0 and yi < 0.0 then
				Result := -Pi / 2
			elseif x = 0.0 and yi = 0.0 then
				Result := 0.0
			end
		end

	magnitude: DOUBLE
			-- The absolute value or modulus
		do
			Result := sqrt (x * x + yi * yi)
		ensure
			definition: very_close (Result, sqrt (x * x + yi * yi))
		end

	magnitude_squared: DOUBLE
			-- The `magnitude' squared; used in fractal computations, for
			-- example, to avoid taking the square root.
		do
			Result := x * x + yi * yi
		ensure
			definition: very_close (Result, x * x + yi * yi)
		end

	squared: like Current
			-- Convinience feature for Current^2
		do
			Result := Current * Current
		end

	conjugate: like Current
			-- The complex conjugate of Current
		do
			create Result.make (x, -yi)
		ensure then
			definition_real_part: very_close (Result.x, x)
			definition_imaginary_part: very_close (Result.yi, -yi)
		end

	reciprocal: like Current
			-- The reciprocal of Current
		require
			not_zero: not is_zero
		local
			d: like Current
		do
			create d.make (x * x, yi * yi)
			Result := conjugate / d
		end

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result.make (1.0, 1.0)
		ensure then
			definition: very_close (x, 1.0) and very_close (yi, 1.0)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make (0.0, 0.0)
		ensure then
			definition: very_close (x, 0.0) and very_close (yi, 0.0)
		end

feature -- Status report

	is_zero: BOOLEAN
			-- Does Current represent zero?
		do
			Result := very_close (x, 0.0) and very_close (yi, 0.0)
		end

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
			-- True if either the real or imaginary part of `other' is non-zero.
		do
			Result := not (very_close (other.x, 0.0) and very_close (other.yi, 0.0))
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		obsolete
			"[2008_04_01] Will be removed since not used."
		do
			Result := True
		end

feature -- Basic operations

	plus alias "+" (other: like Current): like Current
			-- Sum with `other' (commutative).
		do
			create Result.make (x + other.x, yi + other.yi)
		ensure then
			definition_real_part: very_close (Result.x, x + other.x)
			definition_imaginary_part: very_close (Result.yi, yi + other.yi)
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		do
			create Result.make (x - other.x, yi - other.yi)
		ensure then
			definition_real_part: very_close (Result.x, x - other.x)
			definition_imaginary_part: very_close (Result.yi, yi - other.yi)
		end

	product alias "*" (other: like Current): like Current
			-- Product by `other'
		do
			create Result.make (x * other.x - yi * other.yi, yi * other.x + x * other.yi)
		ensure then
			definition_real_part: very_close (Result.x, x * other.x - yi * other.yi)
			definition_imaginary_part: very_close (Result.yi, yi * other.x + x * other.yi)
		end

	quotient alias "/" (other: like Current): like Current
			-- Division by `other'
		local
			r, i: DOUBLE
			d: DOUBLE
		do
			d := other.x * other.x + other.yi * other.yi
			r := (x * other.x + yi * other.yi) / d
			i := (yi * other.x - x * other.yi) / d
			create Result.make (r, i)
		ensure then
			definition_real_part: very_close (Result.x,
				(x * other.x + yi * other.yi) / (other.x * other.x + other.yi * other.yi))
			definition_imaginary_part: very_close (Result.yi,
				(yi * other.x - x * other.yi) / (other.x * other.x + other.yi * other.yi))
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result.make (x, yi)
		ensure then
			definition_real_part: very_close (Result.x, x)
			definition_imaginary_part: very_close (Result.yi, yi)
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result.make (-x, -yi)
		ensure then
			definition_real_part: very_close (Result.x, -x)
			definition_imaginary_part: very_close (Result.yi, -yi)
		end

	power alias "^" (n: INTEGER): like Current
			-- Current raised to `n'
		local
			rn: DOUBLE
			phi: DOUBLE
		do
				-- Implemented using polar representation and de Moivre's formula
			rn := magnitude^n
			phi := phase
			create Result.make (rn * cosine (n * phi), rn * sine (n * phi))
		end

end
