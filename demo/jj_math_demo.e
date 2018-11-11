class JJ_MATH_DEMO

inherit

	SAFE_DOUBLE_MATH

	DOUBLE_ANGLES

create
	make

feature {NONE} -- Initialization

	make
			-- Run the tests
		do
			demo_safe_double_math
			demo_double_angles
			test_matrix
			test_vector
			convert_problem
			test_adjoin
			test_row_matrix_catcall
		end

feature -- Basic operations

	demo_safe_double_math
			-- Print result of all exported features
		local
			x: DOUBLE
		do
			io.put_string ("Output for features of SAFE_DOUBLE_MATH: %N")
			io.put_string ("   Precision = " + precision.out + "%N")
			io.put_string ("   negative_precision = " + negative_precision.out + "%N")
			io.put_string ("   largest = " + largest.out + "%N")
			io.put_string ("   smallest = " + smallest.out + "%N")
			io.put_string ("   default_tolerance = " + default_tolerance.out + "%N")
			io.put_string ("   small_number = " + small_number.out + "%N")
			io.put_string ("   one = " + one.out + "%N")
			io.put_string ("   zero = " + zero.out + "%N")
			io.put_string ("   infinity = " + infinity.out + "%N")
			io.put_string ("   undefined = " + undefined.out + "%N")
			io.put_string ("   limited_value (-0.000001) = " + limited_value (-0.000001).out + "%N")
			io.put_string ("   radix = " + radix.out + "%N")
			io.put_string ("   inverse_radix = " + inverse_radix.out + "%N")
			io.put_string ("   full_mantissa = " + full_mantissa.out + "%N")
		end

	demo_double_angles
			-- Print result of feature calls
		do
			io.put_string ("Output for features of DOUBLE_ANGLES")
			io.new_line
			io.put_string ("  degree_complement (20) = " + degree_complement (20).out + "%N")
			io.put_string ("  radian_complement (Pi/3) = " + radian_complement (Pi/3).out + "%N")
			io.put_string ("  radians_to_degrees (4.4820055191214383535400378934788) = " +
				radians_to_degrees (4.4820055191214383535400378934788).out + "%N")
			io.put_string ("  radians_to_degrees (-2Pi) = " +
				radians_to_degrees (-2*Pi).out + "%N")
			io.put_string ("  radian_supplement (2Pi) = " + radian_supplement (2*Pi).out + "%N")
		end

	value: DOUBLE
		do
			Result := 20;
		end

	procedure_call (a_double: DOUBLE; expected: DOUBLE)
		do
			check
				same: a_double = expected
			end
		end

	convert_problem
		local
			d: DOUBLE
		do
			d := value
			procedure_call (1.0 / value, 1.0/d)
--			scalar_multiply ({DOUBLE}1.0 / determinant)
--			scalar_multiply (1.0 / d)
		end

	test_matrix
			-- Test the matrix operations
		local
			m: MATRIX
			d: DOUBLE
		do
			create m.make (4, 4)
			d := m.determinant
			io.put_string ("SUPPORT_CLUSTER_DEMO.test_matrix:  determinant = " + m.determinant.out)
			io.new_line
			check
				determinant_is_zero: very_close (m.determinant, 0.0)
			end

			create m.make (5, 5)
			m[1,1] := 11;  m[1,2] := 12;  m[1,3] := 13;  m[1,4] := 14;  m[1,5] := 15
			m[2,1] := 21;  m[2,2] := 50;  m[2,3] := 23;  m[2,4] := 24;  m[2,5] := 25
			m[3,1] := 31;  m[3,2] := 32;  m[3,3] := 33;  m[3,4] := 34;  m[3,5] := 35
			m[4,1] := 41;  m[4,2] := 42;  m[4,3] := 43;  m[4,4] := 44;  m[4,5] := 45
			m[5,1] := 100;  m[5,2] := 52;  m[5,3] := 53;  m[5,4] := 54;  m[5,5] := 55

			m.show
			d := m.determinant
			io.put_string ("SUPPORT_CLUSTER_DEMO.test_matrix:  determinant = " + m.determinant.out)
			io.new_line

			create m.make (4, 4)
			m[1,1] := 3.0	m[1,2] := 4.0	m[1,3] := 6.0	m[1,4] := 1.0
			m[2,1] := 0.0	m[2,2] := 1.0	m[2,3] := 0.0	m[2,4] := 3.0
			m[3,1] := 0.0	m[3,2] := 1.0	m[3,3] := 0.0	m[3,4] := 4.0
			m[4,1] := 1.0	m[4,2] := -2.0	m[4,3] := 1.0	m[4,4] := 3.0
			m.show
			d := m.determinant
			io.put_string ("SUPPORT_CLUSTER_DEMO.test_matrix:  determinant = " + m.determinant.out)
			io.new_line

			create m.make (4, 4)
			m[1,1] := 0.0	m[1,2] := 4.0	m[1,3] := 0.0	m[1,4] := -3.0
			m[2,1] := 1.0	m[2,2] := 1.0	m[2,3] := 5.0	m[2,4] := 2.0
			m[3,1] := 1.0	m[3,2] := -2.0	m[3,3] := 0.0	m[3,4] := 6.0
			m[4,1] := 3.0	m[4,2] := 0.0	m[4,3] := 0.0	m[4,4] := 1.0
			m.show
			d := m.determinant
			io.put_string ("SUPPORT_CLUSTER_DEMO.test_matrix:  determinant = " + m.determinant.out)
			io.new_line

			create m.make (0, 0)
			d := m.determinant
			io.put_string ("SUPPORT_CLUSTER_DEMO.test_matrix:  determinant of empty matrix = " + m.determinant.out)
			io.new_line
		end

	test_adjoin
			-- "Matrices With Applications", Hugh G. Campbell,
			-- page 82, Example 2
		local
			m, ans: MATRIX
		do
			create m.make (3, 3)
			m[1,1] := 2.0	m[1,2] := 4.0	m[1,3] := 0.0
			m[2,1] := 0.0	m[2,2] := 2.0	m[2,3] := 1.0
			m[3,1] := 3.0	m[3,2] := 0.0	m[3,3] := 2.0
			m.adjoin
			create ans.make (3, 3)
			ans[1,1] := 4.0	ans[1,2] := -8.0	ans[1,3] := 4.0
			ans[2,1] := 3.0	ans[2,2] := 4.0	ans[2,3] := -2.0
			ans[3,1] := -6.0	ans[3,2] := 12.0	ans[3,3] := 4.0
			check
				expected:  m.is_very_close (ans)
			end

			create m.make (1, 1)
			m.adjoin
		end

	test_row_matrix_catcall
		local
			r: ROW_MATRIX
			m: MATRIX
			ans: COLUMN_MATRIX
		do
			create r.make (4)
			r.enter (-10.0, 1)
			r.enter (20.0, 2)
			r.enter (30.0, 3)
			r.enter (-40.0, 4)
			m := r
			m.transpose
			create ans.make (4)
			ans.enter (-10.0, 1)
			ans.enter (20.0, 2)
			ans.enter (30.0, 3)
			ans.enter (-40.0, 4)
			io.put_string ("test_catcall: m = %N")
			m.show
		end

	test_vector
		local
			v1, v2: VECTOR
		do
			create v1
			v1.show
			create v1.make (3)
			create v2.make (3)
			v1.enter (0, 1)	v1.enter (3, 2)	v1.enter (-7, 3)
			v2.enter (2, 1)	v2.enter (3, 2)	v2.enter (1, 3)
			v1.show
			v2.show
			print ("Dot product = " + v1.dot_product (v2).out)
			print ("%N")
		end

feature {NONE} -- Implementation

	m1: MATRIX
			--
		once
			create Result.make (2, 2);
			Result.put (2.0, 1, 1);	Result.put (2.0, 1, 2);
			Result.put (6.0, 2, 1);	Result.put (9.0, 2, 2);
		end

	m2: MATRIX
			--
		once
			create Result.make (2, 2);
			Result.put (3.0, 1, 1);	Result.put (1.0, 1, 2);
			Result.put (1.0, 2, 1);	Result.put (0.0, 2, 2);
		end

	m1a_left: MATRIX
			-- "Matrices With Applications", Hugh G. Campbell, page 35.
		once
			create Result.make (2, 2);
			Result.put (2.0, 1, 1);	Result.put (1.0, 1, 2);
			Result.put (3.0, 2, 1);	Result.put (4.0, 2, 2);

		end

	m1a_right: MATRIX
			-- "Matrices With Applications", Hugh G. Campbell, page 35.
		once
			create Result.make (2, 2);
			Result.put (0.0, 1, 1);	Result.put (1.0, 1, 2);
			Result.put (2.0, 2, 1);	Result.put (-1.0, 2, 2);

		end

	a48: MATRIX
			-- "Matrices With Applications", Hugh G. Campbell, page 48.
		once
			create Result.make (2, 3);
			Result.put (2.0, 1, 1);	Result.put (1.0, 1, 2);	Result.put (4.0, 1, 3);
			Result.put (0.0, 2, 1);	Result.put (3.0, 2, 2); Result.put (6.0, 2, 3);
		end

	a58: MATRIX
			-- "Matrices With Applications", Hugh G. Campbell, page 58.
		once
			create Result.make (4, 4);
			Result.put (3.0, 1, 1);	Result.put (4.0, 1, 2);	Result.put (6.0, 1, 3); Result.put (1.0, 1, 4)
			Result.put (0.0, 2, 1);	Result.put (1.0, 2, 2); Result.put (0.0, 2, 3); Result.put (3.0, 2, 4)
			Result.put (0.0, 3, 1);	Result.put (1.0, 3, 2);	Result.put (0.0, 3, 3); Result.put (4.0, 3, 4)
			Result.put (1.0, 4, 1);	Result.put (-2.0, 4, 2); Result.put (1.0, 4, 3); Result.put (3.0, 4, 4)
		end

	a84: MATRIX
			-- "Matrices With Applications", Hugh G. Campbell, page 84.
		once
			create Result.make (3, 3);
			Result.put (2.0, 1, 1);	Result.put (4.0, 1, 2);	Result.put (0.0, 1, 3);
			Result.put (0.0, 2, 1);	Result.put (2.0, 2, 2); Result.put (1.0, 2, 3);
			Result.put (3.0, 3, 1);	Result.put (0.0, 3, 2);	Result.put (2.0, 3, 3);
		end

end
