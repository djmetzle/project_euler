#!/usr/bin/ruby

# Euler 88

#MAX=6
#MAX=12
MAX=12000

def in_range?(k, base_set)
	return true
end

def inc_pos(pos, base_set)
	base_set[pos] ||= 1
	base_set[pos] += 1
	return base_set
end

def iterate_base(k, pos, base_set)
	base_set = inc_pos(pos, base_set)
	if pos > 0
		(0...pos).each { |i| base_set[i] = base_set[pos] }
	end
	if base_set.reduce(:*) > 2 * k
		unless base_set.any? { |v| v != 2 }
			return nil
		end
		base_set = iterate_base(k, pos + 1, base_set)
	end
	return base_set
end

def minimal(k)
	min = 2*k
	base_set = [1]
	while not base_set.nil? and in_range?(k, base_set)
		ones = (k - base_set.length)
		set_sum = base_set.reduce(:+) + ones
		red = base_set.reduce(:*)
		if set_sum == red
			if red < min
				min = red
			end
		end
		base_set = iterate_base(k, 0, base_set)
	end
	puts "Found min: #{k} : #{min}"
	return min
end

sum_set = []

(2..MAX).each { |k|
	sum_set.push minimal(k)
}

sum = sum_set.uniq.reduce(:+)

puts "ANS: #{sum}"
