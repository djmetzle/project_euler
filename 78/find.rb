#!/usr/bin/ruby

# Euler 78

File.open('b000041.txt').each do |line|
	line = line.strip
	vals = line.split(" ")
	n = vals[0]
	combos = vals[1]
	#puts "#{n}: #{combos}"
	if combos.to_i % 1000000 == 0
		puts "#{n}"
	end
end
