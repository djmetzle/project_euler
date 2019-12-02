#!/usr/bin/ruby

b = 15
n = 21

target = 1000000000000

while n < target
	b_i = 3 * b + 2 * n - 2
	n_i = 4 * b + 3 * n - 3
	b = b_i
	n = n_i
end

puts "ANS: #{b}"
