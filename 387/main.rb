#!/usr/bin/ruby

require 'prime'

# Euler 387

#N = 30
#N = 202
#N = 2012
#N = 10000
N = 1e14

def niven?(n)
	digit_sum = n.to_s.split('').map(&:to_i).reduce(:+)
	return n % digit_sum == 0
end

def rht?(n)
	str_n = n.to_s
	str_len = str_n.length
	(0...str_len).each { |trunc|
		sub_str = str_n[0..trunc]
		sub_n = sub_str.to_i
		unless niven?(sub_n)
			return false
		end
	}
	return true
end

def strong?(n)
	unless niven?(n)
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

sum = 0

Prime.each(N) {|n|
	if n < 10
		next
	end
	if srhthp?(n)
		puts "#{n} #{sum}"
		sum += n
	end
}

puts "ANS: #{sum}"


