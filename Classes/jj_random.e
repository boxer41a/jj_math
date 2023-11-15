note
	description: "[
		Descendent of {RANDOM} that can return a random integer
		restricted to a range of values between `upper' and `lower'.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	JJ_RANDOM

inherit

	RANDOM
		redefine
			set_seed
		end

create
	make, set_seed

feature {NONE} -- Initialization

	set_seed (a_seed: INTEGER)
			-- Initialize sequence using `s' as the `seed', initializing
			-- `lower' and `upper' if not set already
		do
			Precursor (a_seed)
			if upper = 0 then
				upper := Modulus
			end
			last := seed
		end

feature -- Access

	lower: INTEGER
			-- The lower value of the range used by `normalized'

	upper: INTEGER
			-- The upper of value of range used by `normalized'

	next: INTEGER
			-- The next random number normalized to be in the
			-- semi-open interval [`lower', `upper')
			-- Adapted from http://stackoverflow.com/questions/2509679
			-- "The recursion gives a perfectly uniform distribution."
		local
			rng: INTEGER	-- range
			rem: INTEGER	-- remainder
			bkt: INTEGER	-- bucket
		do
			last := next_random (last)		-- in [0, Modulus)
			rng := upper - lower
			rem := Modulus \\ rng
			bkt := Modulus // rng
				-- There are range buckets, plus one smaller interval within
				-- remainder of Modulus
			if last < Modulus - rem then
				Result := lower + (last // bkt)
			else
				Result := next;         -- recurse here
			end
		ensure
			result_large_enough: Result >= lower
			result_small_enough: Result < upper
		end

feature -- Element change

	set_range (a_lower, a_upper: INTEGER)
			-- Restrict the range in which `normalized' numbers fall to
			-- the semi-open interval [`a_lower', `a_upper')
		require
			lower_big_enough: a_lower >= 0
			upper_small_enough: a_upper <= Modulus
			upper_after_lower: a_upper > a_lower
		do
			lower := a_lower
			upper := a_upper
		end

feature {NONE} -- Implementation

	last: INTEGER
			-- Used to save the last value in `next' for use next time around

end
