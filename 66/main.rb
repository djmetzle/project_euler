#!/usr/bin/ruby

# Pell's Equation

def is_square?(n)          
	    sq = Math.sqrt(n).floor
		    return sq*sq == n      
end                        

vals = {}

File.open("b002350.txt").each { |line|
	row = line.strip.split(" ").map { |int| int.to_i }
	n = row[0]
	x = row[1]
	unless is_square?(n)
		if n < 1000
			puts "#{n} :: #{x}"
			vals[n] = x
		end
	end
}

p vals

p vals.max_by{|k,v| v}
