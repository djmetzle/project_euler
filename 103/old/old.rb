#!/usr/bin/ruby

# Euler 103

require 'set'

def set_sum(combo)
	return combo.reduce(:+)
end

$valid = {}
def valid_spec?(combo)
	if $valid.key?(combo)
		return $valid[combo]
	end
	spec_set = combo.to_set
	len = combo.length
	all_subsets = []
	(1...len).each { |left_subset_width|
		left_subsets = combo.combination(left_subset_width).to_a
		(1...len).each { |right_subset_width|
			right_subsets = combo.combination(right_subset_width).to_a
			left_subsets.each { |subset|
				b = subset.to_set	
				b_sum = set_sum(b.to_a)
				b_size = b.size
				right_subsets.each { |other_subset|
					c = other_subset.to_set
					if b == c
						next
					end
					c_sum = set_sum(c.to_a)
					c_size = c.size
					#puts "#{b_size} #{c_size} #{c_sum} #{b_sum}"
					if b_sum == c_sum
						$valid[combo] = false
						return false
					end
					if (b_size > c_size) && (b_sum < c_sum)
						$valid[combo] = false
						return false
					end
					if (c_size > b_size) && (c_sum < b_sum)
						$valid[combo] = false
						return false
					end
				}
			}
		}
	}
	puts "Valid combo: #{combo}"
	$valid[combo] = true
	return true
end

def search(width, n)
		values = (1..n).to_a
		combos = values.combination(width).to_a
		specials = combos.select { |c|
			valid_spec?(c)
		}
		return specials
end

(1..6).each { |n|
	puts "N: #{n}"
	search_n = n
	found = false

	while not found
		search_n += 1
		puts "Search N: #{search_n}"

		sols = search(n, search_n)
		
		unless sols.size > 0
			next
		end

		sums = sols.map { |c| [c.reduce(:+), c] }.to_h
		min_sum = sums.keys.min
		min_sol = sums[min_sum]
		
		puts "#{min_sum} #{min_sol}"
		puts min_sol.map {|x| x.to_s}.join{|s|}
		found = true
	end
}
