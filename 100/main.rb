#!/usr/bin/ruby

# Euler 100

def is_square?(n)
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

START=1000000000000
#START=1

n = START
while true
	if n % 1000000 == 0
		puts n
	end
	op = 1 + 2 * n * ( n - 1)
	unless is_square?(op)
		n += 1
		next
	end

	sq = Math.sqrt(op).floor
	if sq.odd?		
		puts "Solution Found! #{n}"
		break
	end

	n += 1
end


