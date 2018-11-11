note
	description: "[
			Basic angle to radians and back conversions.
		]"
	date: "1 Oct 99"
	author:		"Jimmy J. Johnson"

class
	DOUBLE_ANGLES

inherit

	SAFE_DOUBLE_MATH
		export
			{NONE} all
		end

	MATH_CONST
		export
			{ANY} all
		end

feature

	degree_reciprocal (degrees: DOUBLE): DOUBLE
			-- Angle in degrees that is oposite `degrees'
			-- in a 360 degree circle.
		require
			in_range: degrees >= 0 and degrees <= 360
		do
			if degrees >= 180 then
				Result := degrees - 180
			else
				Result := degrees + 180
			end
		ensure
			result_in_range: 0 <= Result and Result < 360
		end

	radian_reciprocal (radians: DOUBLE): DOUBLE
			-- Angle in radians that is oposite `radians'
			-- in a 360 degree circle.
		require
			in_range: radians >= 0 and radians <= 2 * Pi
		do
			if radians < Pi then
				Result := radians + Pi
			else
				Result := radians - Pi
			end
		ensure
			result_in_range: 0 <= Result and Result < 2 * Pi
		end

	degree_supplement (degrees: DOUBLE): DOUBLE
			-- The angle (in degrees) that is supplementary to `degrees'.
			-- (30 gives 150, etc.)
		require
			in_range: 0 <= degrees and degrees <= 180
		do
			Result := 180 - degrees
		ensure
			result_in_range: 0 <= Result and Result <= 180
			definition: very_close (Result + degrees, 180)
		end

	radian_supplement (radians: DOUBLE): DOUBLE
			-- The angle (in radians) that is supplementary to `radians'.
		require
			in_range: radians >= 0 and radians <= 2 * Pi
		do
			Result := 2 * Pi - radians
		ensure
			definition: very_close (Result + radians, 2 * Pi)
			result_in_range: Result >= 0 and Result <= 2 * Pi
		end

	degree_complement (degrees: DOUBLE): DOUBLE
			-- The angle (in degrees) that is complementary to `degrees'.
		require
			in_range: 0 <= degrees and degrees <= 90
		do
			Result := 90 - degrees
		ensure
			result_in_range: 0 <= Result and Result <= 90
			definition: very_close (Result + degrees, 90)
		end

	radian_complement (radians: DOUBLE): DOUBLE
			-- The angle (in radians) that is complementary to `radians'.
		require
			in_range: radians >= 0 and radians <= Pi
		do
			Result := Pi - radians
		ensure
			definition: very_close (Result + radians, Pi)
			result_in_range: 0 <= Result and Result <= Pi
		end

	radians_to_degrees (radians: DOUBLE): DOUBLE
			-- Convert radians to degrees.
		require
			radians_big_enough: radians >= -(2 * Pi)
			radians_small_enough: radians <= 2 * Pi
		do
			Result := radians * 180 / Pi
		ensure
			definition: very_close (Result, radians * 360 / (2 * Pi))
			result_in_range: Result >= -360 and Result <= 360
		end

	degrees_to_radians (degrees: DOUBLE): DOUBLE
			-- Convert degrees to radians.
		require
			degrees_big_enough: degrees >= -360
			degrees_small_enough: degrees <= 360
		do
			Result := degrees * Pi / 180
		ensure
			definition: very_close (Result, degrees * (2 * Pi) / 360)
			result_in_range: Result >= -2 * Pi and Result <= 2 * Pi
		end

end

