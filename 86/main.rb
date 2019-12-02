#!/usr/bin/ruby

# Euler 86

#N_EXCEED=2000
N_EXCEED=1e6

def is_square?(n)
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

m = 1
sum = 0
while m
	m += 1
	sol_count = 0
	(1..m).each {|x|
		(x..m).each {|y|
			if is_square?((x+y)*(x+y) + m*m)
				sol_count+=1
			end
		}
	}
	puts "M #{m} : #{sol_count}"
	sum += sol_count
	if sum > N_EXCEED
		puts "Found #{m} : #{sum}"
		break
	end
end
