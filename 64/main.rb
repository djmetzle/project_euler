#!/usr/bin/ruby

# Euler 64

# N=13
N=10000

def find_base(n)
	return Math.sqrt(n).floor
end

def init_period_finder(n)
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

def test_repetition(expansion)
	n = expansion[:a].length
	(1...n-1).each { |i|
		a_match = expansion[:a][i] == expansion[:a][n-1]
		d_match = expansion[:d][i] == expansion[:d][n-1]
		m_match = expansion[:m][i] == expansion[:m][n-1]
		if a_match and d_match and m_match
			return true
		end
	}
	return false
end

def find_period(n)
	expansion = init_period_finder(n)
	expansion = iterate_finder(n, expansion)
	while not test_repetition(expansion)
		expansion = iterate_finder(n, expansion)
	end
	return expansion[:a].length - 2
end

count =0
(2..N).each { |n| 
	sq = Math.sqrt(n)
	unless (sq.to_i * sq.to_i == n)
		period = find_period n
		if period.odd?
			count += 1
		end
	end
}
puts "Odd Count: #{count}"
