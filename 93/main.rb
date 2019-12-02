#!/usr/bin/ruby

# Euler 93
	
OPERATORS = [ :+, :-, :*, :/ ]
OP_COMBOS = OPERATORS.repeated_permutation(3).to_a
DIGIT_COMBOS = (0..9).to_a.combination(4).to_a

def longest_consec(target_set)
	values = target_set.keys.sort

	consec = false
	last_value = 0
	consec_count = 0

	values.each { |v|
		if last_value != v - 1
			return consec_count
		end
		consec_count += 1
		last_value = v
	}
	return consec_count
end

def set_op_reduction(set, ops)
	found = {}
	ops.each_with_index { |op, i|
		unless op == :/ and set[i+1] == 0
			reduced = set.dup
			new_value = Rational(set[i]).send(op, set[i+1])
			#puts "#{set[i]} #{op} #{set[i+1]} = #{new_value}"
			reduced[i] = new_value
			reduced.delete_at(i+1)
			reduced_ops = ops.dup
			reduced_ops.delete_at(i)
			if reduced.length > 1
				found = found.merge(set_op_reduction(reduced,reduced_ops))
			else 
				value = reduced[0]
				if value.to_i == value and value >= 1
					#puts value.to_i
					found[value.to_i] = true
				end
			end
		end
	}
	return found
end

def find_targets(ordering)
	found = {}
	OP_COMBOS.each { |op_combo|
		found = found.merge(set_op_reduction(ordering, op_combo))
	}
	return found
end

def find_all_targets(set)
	orderings = set.permutation(4).to_a
	targets = {}
	orderings.each { |ordering|
		found_targets = find_targets(ordering)
		targets = targets.merge(found_targets)
	}
	puts "All Targets:"
	p targets.keys
	return targets
end


$max_consec = 0
$max_consec_set = []
def solve 
	n = 1
	DIGIT_COMBOS.each { |dc| 
		puts "Digit Combination:"
		p dc
		all_targets = find_all_targets(dc)
		consec = longest_consec(all_targets)
		if consec > $max_consec
			puts "Found new consec max: #{consec}"
			$max_consec = consec
			$max_consec_set = dc.dup
		end
	}
end

solve

puts "ANS: #{$max_consec}"
p $max_consec_set

