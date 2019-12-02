#!/usr/bin/ruby

# Euler 95

N_MAX = 1e3
#N_MAX = 2e4
#N_MAX = 1e6


divisor_sums = {}

def sigma(n,d_sums)
	puts "===#{n}==="
	s_sum = 0
	p_i = 0
	p_num = 0
	while n - p_num >= 0
		if (p_i > 0)
			p_i *= -1
		else
			p_i = ( -1 * p_i ) + 1
		end
		p_num = (3*p_i*p_i - p_i) / 2
		if n - p_num == 0
			s_sum += n
			break
		end
		if n - p_num > 0
			k_d = (-1)**(p_i + 1)
			s_sum += k_d * d_sums[n-p_num]
			#puts "#{n} #{p_num} #{p_i} #{k_d} #{s_sum}"
		else
			break
		end
	end

	return s_sum
end

# Build divisor sum table
(1...N_MAX).each { |n|
	s = sigma(n,divisor_sums)
	puts "#{n} : #{s}"
	divisor_sums[n] = s
}

puts
puts " -- Built divisor list"
puts

p divisor_sums
exit

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

