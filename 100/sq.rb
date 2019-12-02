#!/usr/bin/ruby

# Euler 100

def is_square?(n)
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

START=1000000
#START=1

i = START
while true
	sq = i * i
	q = ( 1 + 2 * ( sq - 1) )
	unless is_square?(q)
		i += 1
		next
	end

	n = (1 + Math.sqrt(q).floor) / 2
	unless (n > START * START)
		puts "Under N"
		i += 1
		next
	end
	op = 1 + 2 * n * ( n - 1)
	unless is_square?(op)
		i += 1
		next
	end

	sq = Math.sqrt(op).floor
	if sq.odd?		
		puts "Solution Found! #{n}"
		break
	end

	n += 1
end


