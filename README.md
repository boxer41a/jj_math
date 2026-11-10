# jj_math
This cluster provides Eiffel classes for matrix/vector operations, converting angles, generating random numbers within a range, and safely comparing floating point numbers.

The class of greatest interest at this time is [SAFE\_DOUBLE\_MATH](./classes/safe_double_math.e).  It provides features for comparisons of real numbers. overcoming comparison shortcomings inherent in the floating point representation.

Class [DOUBLE\_ANGLES](./classes/double_angles) provides features to convert between degrees and radians.