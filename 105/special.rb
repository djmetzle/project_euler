#!/usr/bin/ruby

# Euler 103

def set_sum(set)
	return set.reduce(:+)
end

def all_subsets(set)
	subsets = []
	(1...set.length).each { |l|
		subsets = subsets + set.combination(l).to_a
	}
	puts "Found #{subsets.length} subsets..."
	return subsets
end

def is_special?(set)
	subsets = all_subsets(set)
	(0...subsets.length).each { |i|
		(i+1...subsets.length).each { |j|
			left = subsets[i]
			right = subsets[j]
			left_sum = set_sum(left)
			right_sum = set_sum(right)
			if left_sum == right_sum
				return false
			end
			if right.length > left.length and right_sum <= left_sum
				return false
			end
		}
	}
	return true
end


