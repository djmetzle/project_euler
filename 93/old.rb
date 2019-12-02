#!/usr/bin/ruby

# Euler 93
	
OPERATORS = [ :+, :-, :*, :/ ]
OP_COMBOS = OPERATORS.repeated_permutation(3).to_a

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

def reduce_set_by_operators(ps, ops)
	target_values = {}

	ops.each_with_index { |op, index|
		lv = ps[index]
		rv = ps[index + 1]
		if op == :/
			if rv == 0
				next
			end
			rv *= 1.0
		end
		reduced = lv.send(op,rv)
		local_ps = ps.dup
		local_ops = ops.dup
		local_ps[index] = reduced
		local_ps.delete_at(index+1)
		local_ops.delete_at(index)
		if local_ops.length > 0
			# recurse!
			target_values = target_values.merge(reduce_set_by_operators(local_ps, local_ops))
		else
			if local_ps[0] > 0.0 
				if local_ps[0].eql? local_ps[0].floor 
					target_values[local_ps[0].floor] = true
				end
			end
		end
	}
	ops.each_with_index { |op, index|
		lv = ps[index]
		rv = ps[index + 1]
		if op == :/
			if rv == 0
				next
			end
			rv *= 1.0
		end
		reduced = lv.send(op,rv)
		local_ps = ps.dup
		local_ops = ops.dup
		local_ps[index+1] = reduced
		local_ps.delete_at(index)
		local_ops.delete_at(index)
		if local_ops.length > 0
			# recurse!
			target_values = target_values.merge(reduce_set_by_operators(local_ps, local_ops))
		else
			if local_ps[0] > 0.0 
				if local_ps[0].eql? local_ps[0].floor 
					target_values[local_ps[0].floor] = true
				end
			end
		end
	}
	return target_values
end

def calculate_target_set(perms_set)
	target_set = {}

	perms_set.each { |ps|
		OP_COMBOS.each { |op_set|
			target_values = reduce_set_by_operators(ps,op_set)
			target_set = target_set.merge(target_values)
		}
	}

	puts "length: #{target_set.keys.length}"
	return target_set
end

sets = (0..9).to_a.combination(4).to_a

max_consec = 0
max_set = nil
sets.each { |base_set|
	p base_set
	perms_set = base_set.permutation.to_a
	target_set = calculate_target_set(perms_set)
	longest = longest_consec(target_set)
	if longest > max_consec
		puts "Found new longest: #{longest} :: #{base_set}"
		max_consec = longest
		max_set = base_set.dup
	end
}

puts "Longest: #{max_consec}"
p max_set

