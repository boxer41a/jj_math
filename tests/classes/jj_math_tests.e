note
	description: "[
		Call test features for classes in the "jj_math" cluster..
	]"
	author: "Jimmy J Johnson"
	date: "11/2/26"

class
	JJ_MATH_TESTS

create
	make

feature {NONE} -- Initialization

	make
			-- Create an instance runing the test features as a demo
		do
			create angles
			create math
			create vector
			clear_screen (50)
				-- Run the test features
			run_double_angles_tests
			run_safe_double_math_tests
		end

	clear_screen (a_count: INTEGER)
			-- Print `a_count' blank lines to scroll previous output off the page
		local
			i: INTEGER
		do
			from i := 1
			until i > a_count
			loop
				print ("%N")
				i := i + 1
			end
		end

feature -- Basic operations

	run_double_angles_tests
			-- Run tests on {DOUBLE_ANGLES}
		do
			angles.divider ("{" + angles.generating_type.out + "}")

		end

	run_safe_double_math_tests
			-- Run tests on {SAFE_DOUBLE_MATH}
		do
			math.divider ("{" + math.generating_type.out + "}")
				-- Access
			math.test_radix
			math.test_inverse_radix
			math.test_precision
			math.test_negative_precision
			math.test_largest
			math.test_smallest
			math.test_small_number
			math.test_default_tolerance
			math.test_infinity
			math.test_nan
				-- Query
			math.test_very_close
			math.test_close_enough
			math.test_very_close_with_tolerance
			math.test_close_enough_with_tolerance
			math.test_is_infinite
			math.test_limited_value
			math.test_inverse_square_root
		end

feature {NONE} -- Implementation

	angles: DOUBLE_ANGLES_TESTS
			-- Object from which to call tests

	math: SAFE_DOUBLE_MATH_TESTS
			-- Object from which to call tests

	vector: VECTOR
			-- Object from which to call tests

end
