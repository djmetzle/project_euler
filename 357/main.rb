#!/usr/bin/ruby

require 'prime'

# Euler 357

#N=100
N=100000000

def is_pg_int(n)
	(1..n).each { |i| 
		if n % i == 0
			unless Prime.prime?(i + n/i)
				return false
			end
		end
	}
	return true
end

sum = 0
(1..N).each { |n|
	if n % 10000 == 0
		puts n
	end
	if is_pg_int(n)
		sum += n	
	end
}

puts sum

