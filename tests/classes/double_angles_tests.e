note
	description: "Summary description for {DOUBLE_ANGLES_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_ANGLES_TESTS

inherit

	JJ_TEST_FACILITIES

feature -- Query tests

	test_normalize_degrees
			-- Verify that `normalize_degrees' returns an angle in [0, 360).
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "normalize_degrees"
			divider (s)
			create da
			function (agent da.normalize_degrees (0.0), s, 0.0)
			function (agent da.normalize_degrees (45.0), s, 45.0)
			function (agent da.normalize_degrees (180.0), s, 180.0)
			function (agent da.normalize_degrees (315.0), s, 315.0)
			function (agent da.normalize_degrees (360.0), s, 0.0)
			function (agent da.normalize_degrees (405.0), s, 45.0)
			function (agent da.normalize_degrees (720.0), s, 0.0)
			function (agent da.normalize_degrees (765.0), s, 45.0)
			function (agent da.normalize_degrees (1080.0), s, 0.0)
		end

	test_is_normalized_degrees
			-- Verify that `is_normalized_degrees' recognizes angles in [0, 360).
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "is_normalized_degrees"
			divider (s)
			create da
			predicate (agent da.is_normalized_degrees (0.0), s, True)
			predicate (agent da.is_normalized_degrees (45.0), s, True)
			predicate (agent da.is_normalized_degrees (180.0), s, True)
			predicate (agent da.is_normalized_degrees (359.999), s, True)
			predicate (agent da.is_normalized_degrees (360.0), s, False)
			predicate (agent da.is_normalized_degrees (405.0), s, False)
			predicate (agent da.is_normalized_degrees (-45.0), s, False)
		end

	test_normalize_radians
			-- Verify that `normalize_radians' returns an angle in [0, 2 * Pi).
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "normalize_radians"
			divider (s)
			create da
			function (agent da.normalize_radians (0.0), s, 0.0)
			function (agent da.normalize_radians (Pi / 4.0), s, Pi / 4.0)
			function (agent da.normalize_radians (Pi), s, Pi)
			function (agent da.normalize_radians (7.0 * Pi / 4.0), s, 7.0 * Pi / 4.0)
			function (agent da.normalize_radians (2.0 * Pi), s, 0.0)
			function (agent da.normalize_radians (2.0 * Pi + Pi / 2.0), s, Pi / 2.0)
			function (agent da.normalize_radians (4.0 * Pi), s, 0.0)
			function (agent da.normalize_radians (4.0 * Pi + Pi / 2.0), s, Pi / 2.0)
		end

	test_is_normalized_radians
			-- Verify that `is_normalized_radians' recognizes angles in [0, 2 * Pi).
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "is_normalized_radians"
			divider (s)
			create da
			predicate (agent da.is_normalized_radians (0.0), s, True)
			predicate (agent da.is_normalized_radians (Pi / 4.0), s, True)
			predicate (agent da.is_normalized_radians (Pi), s, True)
			predicate (agent da.is_normalized_radians (2.0 * Pi - 0.000001), s, True)
			predicate (agent da.is_normalized_radians (2.0 * Pi), s, False)
			predicate (agent da.is_normalized_radians (5.0 * Pi / 2.0), s, False)
			predicate (agent da.is_normalized_radians (-Pi / 2.0), s, False)
		end

	test_degree_reciprocal
			-- Verify that `degree_reciprocal' returns the opposite angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "degree_reciprocal"
			divider (s)
			create da
			function (agent da.degree_reciprocal (0.0), s, 180.0)
			function (agent da.degree_reciprocal (90.0), s, 270.0)
			function (agent da.degree_reciprocal (180.0), s, 0.0)
			function (agent da.degree_reciprocal (270.0), s, 90.0)
			function (agent da.degree_reciprocal (360.0), s, 180.0)
			function (agent da.degree_reciprocal (22.5), s, 202.5)
			function (agent da.degree_reciprocal (45.0), s, 225.0)
			function (agent da.degree_reciprocal (135.0), s, 315.0)
			function (agent da.degree_reciprocal (225.0), s, 45.0)
			function (agent da.degree_reciprocal (315.0), s, 135.0)
		end

	test_radian_reciprocal
			-- Verify that `radian_reciprocal' returns the opposite angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "radian_reciprocal"
			divider (s)
			create da
			function (agent da.radian_reciprocal (0.0), s, Pi)
			function (agent da.radian_reciprocal (Pi / 2), s, 3 * Pi / 2)
			function (agent da.radian_reciprocal (Pi), s, 0.0)
			function (agent da.radian_reciprocal (3 * Pi / 2), s, Pi / 2)
			function (agent da.radian_reciprocal (2 * Pi), s, Pi)
			function (agent da.radian_reciprocal (Pi / 4), s, 5 * Pi / 4)
			function (agent da.radian_reciprocal (3 * Pi / 4), s, 7 * Pi / 4)
			function (agent da.radian_reciprocal (5 * Pi / 4), s, Pi / 4)
			function (agent da.radian_reciprocal (7 * Pi / 4), s, 3 * Pi / 4)
		end

	test_degree_supplement
			-- Verify that `degree_supplement' returns the supplementary angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "degree_supplement"
			divider (s)
			create da
			function (agent da.degree_supplement (0.0), s, 180.0)
			function (agent da.degree_supplement (30.0), s, 150.0)
			function (agent da.degree_supplement (45.0), s, 135.0)
			function (agent da.degree_supplement (90.0), s, 90.0)
			function (agent da.degree_supplement (120.0), s, 60.0)
			function (agent da.degree_supplement (150.0), s, 30.0)
			function (agent da.degree_supplement (180.0), s, 0.0)
		end

	test_radian_supplement
			-- Verify that `radian_supplement' returns the supplementary angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "radian_supplement"
			divider (s)
			create da
			function (agent da.radian_supplement (0.0), s, Pi)
			function (agent da.radian_supplement (Pi / 6), s, 5 * Pi / 6)
			function (agent da.radian_supplement (Pi / 4), s, 3 * Pi / 4)
			function (agent da.radian_supplement (Pi / 3), s, 2 * Pi / 3)
			function (agent da.radian_supplement (Pi / 2), s, Pi / 2)
			function (agent da.radian_supplement (2 * Pi / 3), s, Pi / 3)
			function (agent da.radian_supplement (3 * Pi / 4), s, Pi / 4)
			function (agent da.radian_supplement (5 * Pi / 6), s, Pi / 6)
			function (agent da.radian_supplement (Pi), s, 0.0)
		end

	test_degree_complement
			-- Verify that `degree_complement' returns the complementary angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "degree_complement"
			divider (s)
			create da
			function (agent da.degree_complement (0.0), s, 90.0)
			function (agent da.degree_complement (30.0), s, 60.0)
			function (agent da.degree_complement (45.0), s, 45.0)
			function (agent da.degree_complement (60.0), s, 30.0)
			function (agent da.degree_complement (90.0), s, 0.0)
		end

	test_radian_complement
			-- Verify that `radian_complement' returns the complementary angle.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "radian_complement"
			divider (s)
			create da
			function (agent da.radian_complement (0.0), s, Pi / 2)
			function (agent da.radian_complement (Pi / 12), s, 5 * Pi / 12)
			function (agent da.radian_complement (Pi / 6), s, Pi / 3)
			function (agent da.radian_complement (Pi / 4), s, Pi / 4)
			function (agent da.radian_complement (Pi / 3), s, Pi / 6)
			function (agent da.radian_complement (5 * Pi / 12), s, Pi / 12)
			function (agent da.radian_complement (Pi / 2), s, 0.0)
		end

	test_radians_to_degrees
			-- Verify that `radians_to_degrees' converts radians to degrees.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "radians_to_degrees"
			divider (s)
			create da
			function (agent da.radians_to_degrees (-2 * Pi), s, -360.0)
			function (agent da.radians_to_degrees (-3 * Pi / 2), s, -270.0)
			function (agent da.radians_to_degrees (-Pi), s, -180.0)
			function (agent da.radians_to_degrees (-Pi / 2), s, -90.0)
			function (agent da.radians_to_degrees (-Pi / 4), s, -45.0)
			function (agent da.radians_to_degrees (0.0), s, 0.0)
			function (agent da.radians_to_degrees (Pi / 4), s, 45.0)
			function (agent da.radians_to_degrees (Pi / 2), s, 90.0)
			function (agent da.radians_to_degrees (Pi), s, 180.0)
			function (agent da.radians_to_degrees (3 * Pi / 2), s, 270.0)
			function (agent da.radians_to_degrees (2 * Pi), s, 360.0)
		end

	test_degrees_to_radians
			-- Verify that `degrees_to_radians' converts degrees to radians.
		local
			s: STRING_8
			da: DOUBLE_ANGLES
		do
			s := "degrees_to_radians"
			divider (s)
			create da
			function (agent da.degrees_to_radians (-360.0), s, -2 * Pi)
			function (agent da.degrees_to_radians (-270.0), s, -3 * Pi / 2)
			function (agent da.degrees_to_radians (-180.0), s, -Pi)
			function (agent da.degrees_to_radians (-90.0), s, -Pi / 2)
			function (agent da.degrees_to_radians (-45.0), s, -Pi / 4)
			function (agent da.degrees_to_radians (0.0), s, 0.0)
			function (agent da.degrees_to_radians (45.0), s, Pi / 4)
			function (agent da.degrees_to_radians (90.0), s, Pi / 2)
			function (agent da.degrees_to_radians (180.0), s, Pi)
			function (agent da.degrees_to_radians (270.0), s, 3 * Pi / 2)
			function (agent da.degrees_to_radians (360.0), s, 2 * Pi)
		end

end
