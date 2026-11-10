note
	description: "[
		Defines features to test the features in {SAFE_DOUBLE_MATH}.
	]"
	author: "Jimmy J Johnson"
	date: "11/2/26"

class
	SAFE_DOUBLE_MATH_TESTS

inherit

	JJ_TEST_FACILITIES

feature -- Access tests

	test_radix
			-- Verify that `radix' is greater than one.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "radix"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.radix.out + " > 1"
			print (tag + "%N")
			assert (tag, sdm.radix > 1)
		end

	test_inverse_radix
			-- Verify that `inverse_radix' is positive and is the
			-- reciprocal of `radix'.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "inverse_radix"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.inverse_radix.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.inverse_radix > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> radix * inverse_radix = 1.0"
			print (tag + "%N")
			assert (tag, sdm.very_close (sdm.radix * sdm.inverse_radix, 1.0))
		end

	test_precision
 			-- Verify that `precision' is positive and that adding it to
			-- one does not change the value of one.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "precision"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.precision.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.precision > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> " + (1.0 + sdm.precision).out + " = 1.0"
			print (tag + "%N")
			assert (tag, 1.0 + sdm.precision = 1.0)		-- Test if precision gives exactly 1.0
		end

	test_negative_precision
 			-- Verify that `negative_precision' is positive and that
			-- subtracting it from one does not change the value of one.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "negative_precision"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.negative_precision.out + " > 0.0"
			print (tag + "$N")
			assert (tag, sdm.negative_precision > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> " + (1.0 - sdm.negative_precision).out + " = 1.0"
			print (tag + "%N")
			assert (tag, 1.0 - sdm.negative_precision = 1.0)		-- Test if precision gives exactly 1.0
		end

	test_largest
 			-- Verify that `largest' is positive and finite, and that
			-- multiplying it by the radix produces infinity.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "largest"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.largest.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.largest > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> not is_infinite (" + sdm.largest.out + ")"
			print (tag + "%N")
			assert (tag, not sdm.is_infinite (sdm.largest))
			tag := "{" + generating_type.out + "}." + s + " ==> is_infinite (" + (sdm.largest * sdm.radix).out + ")"
			print (tag + "%N")
			assert (tag, sdm.is_infinite (sdm.largest * sdm.radix))
		end

	test_smallest
			-- Verify that `smallest' is positive and that dividing it by
			-- the radix produces zero.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "smallest"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.smallest.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.smallest > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> " + (sdm.smallest / sdm.radix).out + " = 0.0"
			print (tag + "%N")
			assert (tag, sdm.smallest / sdm.radix = 0.0)
		end

	test_small_number
			-- Verify that `small_number' is positive and very close to zero.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "small_number"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.small_number.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.small_number > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> very_close (" + sdm.small_number.out + ", 1.0)"
			print (tag + "%N")
			assert (tag, sdm.very_close (1.0 + sdm.small_number, 1.0))
		end

	test_default_tolerance
			-- Verify that `default_tolerance' is positive and equals the
			-- square root of `precision'.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "default_tolerance"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.default_tolerance.out + " > 0.0"
			print (tag + "%N")
			assert (tag, sdm.default_tolerance > 0.0)
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.default_tolerance.out + " = sqrt (" + sdm.precision.out + ")"
			print (tag + "%N")
			assert (tag, sdm.default_tolerance = sdm.sqrt (sdm.precision))
		end

	test_one
			-- Verify that `one' equals 1.0.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "one"
			divider (s)
			create sdm
			function (agent sdm.one, "one", 1.0)
		end

	test_zero
		-- Verify that `zero' equals 0.0.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "one"
			divider (s)
			create sdm
			function (agent sdm.zero, "zero", 0.0)
		end

	test_infinity
			-- Verify that `infinity' and its negative are recognized as infinite.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "infinity"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> is_infinite (" + sdm.infinity.out + ")"
			print (tag + "%N")
			assert (tag, sdm.is_infinite (sdm.infinity))
			tag := "{" + generating_type.out + "}." + s + " ==> is_infinite (" + (-sdm.infinity).out + ")"
			print (tag + "%N")
			assert (tag, sdm.is_infinite (-sdm.infinity))
		end

	test_nan
			-- Verify that `undefined' is not equal to itself.
		local
			s, tag: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "undefined"
			divider (s)
			create sdm
			tag := "{" + generating_type.out + "}." + s + " ==> " + sdm.nan.out + " /= " + sdm.nan.out
			print (tag + "%N")
			assert (tag, sdm.nan.is_nan)
		end

feature -- Query tests

	test_very_close
				-- Verify behavior for representative input values.	
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
			large: REAL_64
			nearby: REAL_64
		do
			s := "very_close"
			divider (s)
			create sdm
			predicate (agent sdm.very_close (1.0, 1.0), s, True)
			predicate (agent sdm.very_close (1.0, 1.00000001), s, True)
			predicate (agent sdm.very_close (1.0, 2.0), s, False)
			predicate (agent sdm.very_close (0.0, 0.0), s, True)
			predicate (agent sdm.very_close (1.0, 0.0), s, False)
			predicate (agent sdm.very_close (0.0, 1.0), s, False)
				-- Test close number, spread out, etc.
			large := sdm.largest
			nearby := large - large * (sdm.default_tolerance / 2.0)
			predicate (agent sdm.very_close (large, nearby), s, True)
			predicate (agent sdm.very_close (large, -large), s, False)
			predicate (agent sdm.very_close (sdm.smallest, large), s, False)
		end

	test_close_enough
 			-- Verify behavior for representative input values.	
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
			large: REAL_64
		do
			s := "close_enough"
			divider (s)
			create sdm
			predicate (agent sdm.close_enough (1.0, 1.0), s, True)
			predicate (agent sdm.close_enough (1.0, 1.00000001), s, True)
			predicate (agent sdm.close_enough (1.0, 2.0), s, False)
			predicate (agent sdm.close_enough (0.0, 0.0), s, True)
			predicate (agent sdm.close_enough (1.0, 0.0), s, False)
			predicate (agent sdm.close_enough (0.0, 1.0), s, False)
				-- Test close number, spread out, etc.
			large := sdm.largest
			predicate (agent sdm.close_enough (0.0, 0.0), s, True)
			predicate (agent sdm.close_enough (0.0, 0.5 * sdm.default_tolerance), s, True)
			predicate (agent sdm.close_enough (large, -large), s, False)
			predicate (agent sdm.close_enough (sdm.smallest, large), s, False)
		end

	test_very_close_with_tolerance
			-- Verify behavior for representative input values.
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
			large: REAL_64
			nearby: REAL_64
			t: REAL_64			-- tolerance
		do
			s := "very_close_with_tolerance"
			divider (s)
			create sdm
			t := 0.05
				-- Run some early tests
			predicate (agent sdm.very_close_with_tolerance (1.0, 1.0, t), s, True)
			predicate (agent sdm.very_close_with_tolerance (1.0, 1.1, t), s, False)
			predicate (agent sdm.very_close_with_tolerance (1.1, 1.0, t), s, False)
			predicate (agent sdm.very_close_with_tolerance (1.0, 2.0, t), s, False)
			predicate (agent sdm.very_close_with_tolerance (0.0, 0.0, t), s, True)
				-- Test values near the largest representable number.
			large := sdm.largest
			nearby := large - large * 0.01
			predicate (agent sdm.very_close_with_tolerance (large, nearby, t), s, True)
				-- Test subtraction that would overflow without scaling.
			predicate (agent sdm.very_close_with_tolerance (large, -large, t), s, False)
				-- Test very different magnitudes.
			predicate (agent sdm.very_close_with_tolerance (sdm.smallest, large, t), s, False)
				-- Test comparison with zero.
			predicate (agent sdm.very_close_with_tolerance (0.05, 0.0, t), s, False)
		end

	test_close_enough_with_tolerance
				-- Verify behavior for representative input values.	
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
			large: REAL_64
			nearby: REAL_64
			t: REAL_64			-- tolerance
		do
			s := "close_enough_with_tolerance"
			divider (s)
			create sdm
			t := 0.01
			predicate (agent sdm.close_enough_with_tolerance (1.0, 1.0, t), s, True)
			predicate (agent sdm.close_enough_with_tolerance (1.0, 1.1, t), s, False)
			predicate (agent sdm.close_enough_with_tolerance (1.1, 1.0, t), s, False)
			predicate (agent sdm.close_enough_with_tolerance (1.0, 2.0, t), s, False)
			predicate (agent sdm.close_enough_with_tolerance (0.0, 0.0, t), s, True)
				-- Test values near the largest representable number.
			large := sdm.largest
			nearby := large - large * 0.005
			predicate (agent sdm.close_enough_with_tolerance (large, nearby, t), s, True)
				-- Test subtraction that would overflow without scaling.
			predicate (agent sdm.close_enough_with_tolerance (large, -large, t), s, False)
				-- Test very different magnitudes.
			predicate (agent sdm.close_enough_with_tolerance (sdm.smallest, large, t), s, False)
				-- Test comparison with zero.
			predicate (agent sdm.close_enough_with_tolerance (0.05, 0.0, t), s, False)
		end

	test_inverse_square_root
				-- Verify behavior for representative input values.
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "inverse_square_root"
			divider (s)
			create sdm
			function (agent sdm.inverse_square_root (1.0), s, 1.0)
			function (agent sdm.inverse_square_root (4.0), s, 0.5)
			function (agent sdm.inverse_square_root (0.25), s, 2.0)
			function (agent sdm.inverse_square_root (100.0), s, 0.1)
		end

	test_limited_value
				-- Verify behavior for representative input values.
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "limited_value"
			divider (s)
			create sdm
			function (agent sdm.limited_value (0.0), s, sdm.small_number)
			function (agent sdm.limited_value (sdm.small_number / 2.0), s, sdm.small_number)
			function (agent sdm.limited_value (sdm.small_number * -0.5), s, -sdm.small_number)
			function (agent sdm.limited_value (2.0), s, 2.0)
			function (agent sdm.limited_value (-2.0), s, -2.0)
		end

	test_is_infinite
				-- Verify behavior for representative input values.
		local
			s: STRING_8
			sdm: SAFE_DOUBLE_MATH
		do
			s := "is_infinite"
			divider (s)
			create sdm
			predicate (agent sdm.is_infinite (sdm.infinity), s, True)
			predicate (agent sdm.is_infinite (0.0), s, False)
			predicate (agent sdm.is_infinite (1.0), s, False)
			predicate (agent sdm.is_infinite (-1.0), s, False)
			predicate (agent sdm.is_infinite (-sdm.infinity), s, True)
		end

end
