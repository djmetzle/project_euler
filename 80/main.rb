#!/usr/bin/ruby

#

require 'bigdecimal'
require 'bigdecimal/math'

def is_square?(n)
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

N=100

total = 0
(1..N).each { |n|
	unless is_square?(n)
		exp = BigDecimal(n).sqrt(100)
		string = exp.to_s.split(".")[1][0...100]
		sum = string.split("").map { |c| c.to_i }.inject(0) {|sum,x| sum+= x}
		puts sum
		total+=sum
	end
}
puts "Total: #{total}"


