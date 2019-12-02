#!/usr/bin/ruby

require 'prime'

# Euler 387

#N = 30
#N = 202
#N = 2012
#N = 10000
N = 1e14

def harshad?(n)
	digit_sum = n.to_s.split('').map(&:to_i).reduce(:+)
	return n % digit_sum == 0
end

def rht?(n)
	str_n = n.to_s
	str_len = str_n.length
	(0...str_len).each { |trunc|
		sub_str = str_n[0..trunc]
		sub_n = sub_str.to_i
		unless harshad?(sub_n)
			return false
		end
	}
	return true
end

def strong?(n)
	unless harshad?(n)
		return false
	end
	digit_sum = n.to_s.split('').map(&:to_i).reduce(:+)
	divisor = n/digit_sum
	return Prime.prime?(divisor)
end

def srhthp?(n)
	unless Prime.prime?(n)
		return false
	end
	str_n = n.to_s
	sub_n = str_n[0...str_n.length-1].to_i
	if strong?(sub_n) and rht?(sub_n)
		return true
	end
	return false
end

base = (1..9).to_a

p base

next_set = []

base.each { |b|
	(0..9).each { |digit|
		test_val = (b.to_s + digit.to_s).to_i
		if harshad?(test_val)
			next_set.push test_val
		end
	}
}

max_found = next_set.max

while max_found < N
	base += next_set
	cur_set = next_set
	next_set = []
	cur_set.each { |b|
		(0..9).each { |digit|
			test_val = (b.to_s + digit.to_s).to_i
			if harshad?(test_val)
				next_set.push test_val
			end
		}
	}
	max_found = next_set.max
	puts "MAX: #{max_found}"
end

base += next_set

strong_set = base.select { |n| strong?(n) }

sum = 0

strong_set.each { |n|
	(0..9).each { |fd|
		test_val = (n.to_s + fd.to_s).to_i
		unless test_val <= N
			next
		end
		if Prime.prime?(test_val)
			puts "FOUND!: #{test_val}"
			sum += test_val
		end
	}
}

puts "ANS: #{sum}"
