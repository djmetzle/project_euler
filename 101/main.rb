#!/usr/bin/ruby -w

# Euler 101

$generator_coeffs = [1,-1,1,-1,1,-1,1,-1,1,-1,1]

def generator(n)
	sum = 0
	(0...$generator_coeffs.length).each { |i|
		sum += $generator_coeffs[i] * n**i
	}
	return sum
end

def interpolate(points, x)
	terms = points.map { |key, value|
		term = value	
		points.each { |i, sec|
			if i != key 
				num = x - i
				den = Rational(key - i)
				term *= num / den
			end
		}
		term.floor
	}
	return terms.reduce(:+)
end

bad_sum = 0

(1...$generator_coeffs.length).each { |d| 
	points = {}
	(1..d).map { |x| points[x] = generator(x) }
	next_bad = d
	while interpolate(points, next_bad) == generator(next_bad)
		next_bad += 1
	end
	puts "#{next_bad} #{interpolate(points, next_bad)}"
	bad_sum += interpolate(points, next_bad)
}

puts bad_sum
