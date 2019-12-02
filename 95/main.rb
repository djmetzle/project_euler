#!/usr/bin/ruby

require 'prime'

# Euler 95

divisor_sums = {}

# Build divisor sum table
(1...1e6).each { |n|
	d_sum = 1

	factors = [1]
	
	Prime.each(n/2 + 1) { |d|
		d_mult = 1
		while d_mult * d <= n / 2
			d_val = d_mult * d
			if (n % d_val == 0)
				unless factors.include? d_val
					factors.push d_val
				end
			end
			d_mult += 1
		end
	}
	divisor_sums[n] = factors.reduce(:+)
	if n % 1e4 == 0
		puts "#{n}..."
	end
}

puts "Fin"
