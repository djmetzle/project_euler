#!/usr/bin/ruby

# Euler 66

N=7
#N=1000

def is_square?(n) 
	sq = Math.sqrt(n).floor
	return sq*sq == n
end

def test_minimum_x(x,d)
	return x*x > d
end

def test_max_y(test_x, test_y, d)
	return ((test_x*test_x)-1) >= (d*test_y*test_y)
end

def test_solution(x,y,d)
	return ((x*x) - d * (y*y)) == 1
end

def find_solution(d,test_x)
	y_test = (test_x*test_x-1.0) / d
	if is_square?(y_test)
		return true
	end
	return false
	test_y = 1
	while test_max_y(test_x, test_y, d)
		if test_solution(test_x, test_y, d)
			puts "Solution found! #{test_x} #{d} #{test_y}"
			return true
		end
		#puts "Y: #{test_y}"
		test_y += 1
	end
	return false 
end

def find_minimal(d)
	test_x = 1
	found = false
	while not found
		test_x += 1
		#puts "X: #{test_x}"
		unless test_minimum_x(test_x,d)
			next
		end
		found = find_solution(d, test_x)
	end

	return test_x
end

maximal = 1

(2..N).each { |n| 
	unless is_square?(n)
		min = find_minimal(n)
		if min > maximal
			maximal = min
		end
	end
}

puts "Found max: #{maximal}"
