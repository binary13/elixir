###############################################################################
#
# Euler 23
#
###############################################################################

# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of 28
# would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less than n
# and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123 can
# be written as the sum of two abundant numbers. However, this upper limit cannot
# be reduced any further by analysis even though it is known that the greatest
# number that cannot be expressed as the sum of two abundant numbers is less than
# this limit.

# Find the sum of all the positive integers which cannot be written as the sum of
# two abundant numbers.

defmodule Euler23 do

	def go(n \\ 28123) do
		nums = generate_abundant_numbers(n)
		Enum.filter(1..n, &(!is_sum_of_abundant?(&1, nums)))
		|> Enum.sum
	end

	def is_abundant?(num) do
		num < sum_prop_divisors(num)
	end

	# Generates a list of abundant numbers less than a given limit
	def generate_abundant_numbers(num \\ 12, list \\ [], limit) do
		cond do
			num > limit -> list
			is_abundant?(num) -> generate_abundant_numbers(num + 1, list ++ [num], limit)
			true -> generate_abundant_numbers(num + 1, list, limit)
		end
	end

	# Determines if a given number can be written as the sum of two abundant numbers
	def is_sum_of_abundant?(num, nums) do
		for a <- nums, b <- nums do a+b end
		|> Enum.any?(&(&1==num))
	end

	def sum_prop_divisors(num) do
		divisors(num)
		|> Enum.sum
	end

	def divisors(num) do
	    find_factors(num)
	end

	defp find_factors(num, divisor \\ 1, factors \\ [])

	defp find_factors(num, divisor, factors) when divisor > num/2 do
	    Enum.sort(factors)
	end

	defp find_factors(num, divisor, factors) do
	    if rem(num, divisor) == 0 do
	      find_factors(num, divisor+1, factors ++ [divisor])
	    else
	      find_factors(num, divisor+1, factors)
	    end
	end

	# def filter_nonsum_ints(list) do

	# end
end
