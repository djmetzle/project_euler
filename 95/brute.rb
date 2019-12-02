#!/usr/bin/ruby

# Euler 95

#N_MAX = 1e3
#N_MAX = 2e4
N_MAX = 1e6


divisor_sums = {}

# Build divisor sum table
(1...N_MAX).each { |n|
	d_sum = 0
	(1..n/2).each { |d|
		if n % d == 0
			d_sum += d
		end
	}
	if n % 1e3 == 0
		puts "#{n}..."
	end
	divisor_sums[n] = d_sum
}

puts
puts " -- Built divisor list"
puts

chain_lengths = { 1=>1 }

def find_chain_length(n, d_sums)
	chain = [n]
	last_val = n
	while chain.include? last_val
		unless d_sums[last_val]
			break
		end
		last_val = d_sums[last_val]
		if chain.include? last_val
			unless last_val == chain[0]
				break
			end
			puts "Found chain! #{n} : #{chain.length} :: #{chain}"
			return chain.length
		end
		chain.push last_val
	end
	return nil
end

(1...N_MAX).each { |n|
	chain_length = find_chain_length(n, divisor_sums)
	if chain_length
		chain_lengths[n] = chain_length
	end
	if n % 1e5 == 0
		puts "#{n}..."
	end
}

puts
puts "-- Found Chains"
puts

max_length = chain_lengths.values.max

chain_members = chain_lengths.select { |k,v| v == max_length }.keys

p max_length
p chain_members
puts "ANS: #{chain_members.min}"

