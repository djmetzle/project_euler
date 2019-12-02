#!/usr/bin/ruby

# Euler 64

#N=7
N=1000

def is_square?(n)
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

def find_base(n)
	return Math.sqrt(n).floor
end

def init_expansion(n)
	return {
		:m => [0],
		:d => [1],
		:a => [find_base(n)],
	}
end

def iterate_finder(s, expansion)
	n = expansion[:a].length - 1
	m = expansion[:d][n] * expansion[:a][n] - expansion[:m][n]
	d = (s - (m*m)) / expansion[:d][n]
	a = ((expansion[:a][0] + m)/d).floor
	expansion[:m][n+1] = m
	expansion[:d][n+1] = d
	expansion[:a][n+1] = a
	return expansion
end

def rollup_expansion(expansion)
    n = expansion[:a].length - 1
    while n > 0
        b = Rational(expansion[:a].pop)
        n -= 1
        expansion[:a][n] += 1/b
    end
	p expansion[:a]
    return expansion[:a][0]
end

def test_minimal(d, fraction)
	num = fraction.numerator
	den = fraction.denominator
	puts "#{num} / #{den}"
	return num*num - d*den*den ==  1
end

def find_minimal(n)
	expansion = init_expansion(n)
	while not test_minimal(n, rollup_expansion(expansion))
		expansion = iterate_finder(n, expansion)
	end
	return expansion
end

maximal = 1
(2..N).each { |d|
	unless is_square?(d)
		min = find_minimal(d)
		minimum = min[:a][0].numerator
		puts "Found #{d}: #{minimum}"
		if minimum > maximal
			maximal = minimum
		end
	end
}

puts "Found max: #{maximal}"
