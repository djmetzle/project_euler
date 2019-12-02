#!/usr/bin/ruby

# Euler 103

def set_sum(set)
	return set.reduce(:+)
end

def all_subsets(set)
	subsets = []
	(1...set.length).each { |l|
		combos = set.combination(l).to_a
		#puts "Combinations: #{l} #{combos}"
		subsets = subsets + combos
	}
	puts "Found #{subsets.length} subsets..."
	return subsets
end

def disjoint_subset_pairs(subsets)
	subset_pairs = []
	(0...subsets.length).each { |i|
		(i+1...subsets.length).each { |j|
			left_set = subsets[i]
			right_set = subsets[j]
			disjoint = true
			left_set.each { |lel|
				if right_set.include? lel
					disjoint = false
				end
			}
			right_set.each { |rel|
				if left_set.include? rel
					disjoint = false
				end
			}
			unless disjoint
				#puts "non-DISJOINT #{left} ::: #{right}"
				next
			end
			#puts "DISJOINT #{left_set} ::: #{right_set}"
			subset_pairs.push [left_set, right_set]
		}
	}
	return subset_pairs
end

def valid_size_sums?(subsets)
	puts subsets.count
	subsets.each { |set_pair|
		left = set_pair.first
		right = set_pair.last
		left_count = left.count
		right_count = right.count
		left_sum = left.reduce(:+)
		right_sum = right.reduce(:+)
		if left_count > right_count
			unless left_sum > right_sum
				return false
			end
		end
		if left_count < right_count
			unless left_sum < right_sum
				return false
			end
		end
	}
	return true
end

def pair_increasing?(set_pair)
	left = set_pair.first
	right = set_pair.last
	n_els = left.count
	(0...n_els).each { |i|
		lv = left[i]
		rv = right[i]
		unless lv < rv
			return false
		end
	}
	return true
end

def no_equal_sums(subsets)
	test_count = 0
	subsets.each { |set_pair|
		left = set_pair.first
		right = set_pair.last
		left_count = left.count
		right_count = right.count
		if left_count == right_count and left_count > 1
			unless pair_increasing?(set_pair)
				test_count += 1
				if left.reduce(:+) == right.reduce(:+)
					return false
				end
			end
		end
	}
	puts "Performed #{test_count} equality checks"
	return true
end

def is_special?(set)
	subsets = all_subsets(set)
	subset_pairs = disjoint_subset_pairs(subsets)
	unless valid_size_sums?(subset_pairs)
		return false
	end
	unless no_equal_sums(subset_pairs)
		return false
	end
	return true
end
