#!/usr/bin/ruby

# Euler 88

#MAX=6
#MAX=12
MAX=12000

$divisor_memo = []

def divisors_of(n)
	if $divisor_memo[n]
		return $divisor_memo[n]
	end
	result = (1..n).select { |i| n % i == 0}
	$divisor_memo[n] = result
	return result
end

def minimal(k)
	min = nil
	(k..2*k).each { |p|
		divs = divisors_of(p)
		divs.repeated_combination(k).each { |c|
			sum = c.reduce(:+)
			prod = c.reduce(:*)
			if (sum == prod)
				unless min
					min = sum
				end
				if sum < min
					min = sum
				end
			end
		}
	}
	puts "#{k} #{min}"
	return min
end

sum_set = []

(2..MAX).each { |k|
	sum_set.push minimal(k)
}

sum = sum_set.uniq.reduce(:+)

puts "ANS: #{sum}"
