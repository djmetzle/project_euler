#!/usr/bin/ruby

require 'prime'

# Euler 549

#N = 10
#N = 100
N = 1e8

def factor_set(n)
	factors = {}
	divs = Prime.prime_division(n)
	divs.each { |set|
		factors[set[0]] = set[1]
	}
	return factors
end

def factor_merge(left, right)
	merge = {}
	left_keys = left.keys
	right_keys = right.keys
	all_keys = left_keys + right_keys
	all_keys.each { |k|
		merge[k] = (left[k] ? left[k] : 0) + (right[k] ? right[k] : 0)
	}
	return merge
end

# memoized factorial
$fac = {1 => 1}
def fac(n)
	if $fac[n]
		return $fac[n]
	end
	n_set = factor_set(n)
	ret = (1..n).reduce(:*)
	return ret
end

$smalls = { 1 => 1 }

def smallest(n)
	if $smalls[n]
		return $smalls[n]
	end
	if Prime.prime?(n)
		return n
	end
	d_set = factor_set(n)
	factors = d_set.keys.length
	if factors == 1
		factor = d_set.keys[0]
		mult = 1
		while mult
			if fac(mult * factor) % n == 0
				$smalls[n] = mult*factor
				return mult * factor 
			end
			mult += 1
		end
	end

	max_set = d_set.map { |factor, power| smallest(factor**power) }
	max_min = max_set.max
	return max_min
end


sum = 0

(2..N).each { |n| 
	small = smallest(n)
	if n % 1e6 == 0
		puts "SMALL: #{n} : #{small}"
	end
	sum += small
}

puts "ANS: #{sum}"
