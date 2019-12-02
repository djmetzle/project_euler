#!/usr/bin/ruby

# Euler 88

MAX=6
#MAX=12000

sum = 0

$digits = []

def advance_digits(pos)
	if $digits.reduce(:*) > $digits.reduce(:+) 
		$digits[pos] = $digits[pos-1]
		unless pos - 1 < 0
			advance_digits(pos-1)
		end
	else
		$digits[pos] += 1
	end
end

(2..MAX).each { |k|
	puts "K: #{k}"
	# init digits
	$digits = []
	(0...k).each { |i| $digits[i] = 1 }
	$digits[k-1] = 1
	$digits[k-2] = 2

	while advance_digits(k-1)
		p $digits
		if $digits.reduce(:*) == $digits.reduce(:+) 
			puts "Solution Found!"
			p $digits
			p $digits.reduce(:+)
			break
		end
	end
}
