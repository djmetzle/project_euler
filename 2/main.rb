#!/usr/bin/ruby

# Project Euler Problem 2

cur = 1
last = 1

fib = [cur]

until cur > 4_000_000
	fib.push(cur)
	temp = cur
	cur = cur + last
	last = temp
end

puts fib.select{|x| x.even?}.reduce(:+)
