#!/usr/bin/ruby -w

# Euler 88

N = 40

def divisors_of(n)
	result = (1...n).select { |i| n % i == 0}
	return result
end

$partitions_memo = {}
def partitions(n)
	# base case
	if n == 1
		return [[1]]
	end
	# memoize
	if $partitions_memo[n] && n < 10
		return $partitions_memo[n]
	end

	partitions = [ [n] ]
	divisors = divisors_of(n)
	divisors.each { |i|
		rem = n - i
		rem_parts = partitions(rem)
		rem_parts.each { |part|
			candidate = [i,part].flatten.sort
			partitions.push candidate
		}
	}
	partitions = partitions.uniq

	# memoize
	$partitions_memo[n] = partitions
	return partitions
end

def filter_product_sums(partitions)
	return partitions.select { |p| p.reduce(:+) == p.reduce(:*) }
end


p_sums = {}

(2..2*N).each { |x| 
	if x % 10 == 0
		puts "partitions #{x}"
	end
	parts = partitions(x)
	p_sums[x] = filter_product_sums(parts)
	#puts "#{x} #{p_sums[x].length}"
}

puts "Found Partitions!"

mins = {0=>0}

p_sums.each { |n, sums|
	#puts "#{n} #{sums}"
	sums.each { |set|
		len = set.length
		s = set.reduce(:+)
		unless mins[len]
			mins[len] ||= s
		end
		if mins[len] > s
			mins[len] = s
		end
	}
}

puts "Finding Mins!"
#p mins
min_lengths = mins.values[2..N]
puts "ANS: " + min_lengths.uniq.reduce(:+).to_s
