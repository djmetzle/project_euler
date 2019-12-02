#!/usr/bin/ruby

# Euler 111

require 'prime'

#N = 4
N = 10

LOWER_BOUND = 10 ** (N-1)
UPPER_BOUND = 10 ** N

puts "#{LOWER_BOUND} ==> #{UPPER_BOUND}"

def digit_counts(n)
	counts = {}
	(0..9).each { |d| counts[d] = 0 }
	digits = n.to_s.split('').map{|d| d.to_i}
	digits.each { |d| counts[d] += 1 }
	return counts
end


count = 0

m = {}
n = {}
s = {}

(0..9).each {|d|
	m[d] = 0
	n[d] = 0
	s[d] = 0
}


Prime.each(UPPER_BOUND) { |p|
	if p < LOWER_BOUND
		next
	end
	count += 1
	counts = digit_counts(p)
	counts.each { |d,c|
		if m[d] < c
			m[d] = c
			n[d] = 0
			s[d] = 0
		end
		if m[d] == c
			n[d] += 1
			s[d] += p
		end
	}
}

puts "Count: #{count}"
p m 
p n
p s

puts "ANS: #{s.values.reduce(:+)}"


