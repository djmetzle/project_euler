#!/usr/bin/ruby

# Euler 206

def is_square?(n)          
	    sq = Math.sqrt(n).floor
		    return sq*sq == n      
end                        

def to_int(perm)
	str = ''
	(0...9).each { |i|
		str += "#{i+1}#{perm[i]}"
	}
	str += '0'
	return str.to_i
end

DIGIT_SUBS = (0..9).to_a.repeated_permutation(9)

DIGIT_SUBS.each { |sub|
	p sub
	n = to_int(sub)
	if is_square?(n)
		puts "ANS: #{Math.sqrt(n).floor}"
		exit
	end

}
