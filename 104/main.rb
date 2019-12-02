#!/usr/bin/ruby

# Euler 104

require 'set'

PAN_SET = (1..9).to_set

$fibs = [ 0, 1, 1]
def fib(n)
	if $fibs[n]
		return $fibs[n]
	end
	ret = fib(n-1) + fib(n-2)
	$fibs[n] = ret
	return ret
end

def test_first_pand?(str)
	len = str.length
	if len < 9
		return false
	end
	substr = str[0...9]
	digits = substr.split('').to_a.map { |d| d.to_i }
	digit_set = digits.to_set
	return digit_set == PAN_SET
end

def test_last_pand?(str)
	len = str.length
	if len < 9
		return false
	end
	substr = str[len-9...len]
	digits = substr.split('').to_a.map { |d| d.to_i }
	digit_set = digits.to_set
	return digit_set == PAN_SET
end

minus_one = 1
minus_two = 0
n = 1
while n
	n += 1
	f = minus_one + minus_two 
	minus_two = minus_one
	minus_one = f
	str = f.to_s
	if test_first_pand?(str) && test_last_pand?(str)
		puts "#{n}"
		exit
	end
end


