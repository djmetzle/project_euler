#!/usr/bin/ruby

# Euler 65

N = 100

def build_expansion
	expansion = [2]
	k = 1

	while expansion.length < N
		n = expansion.length
		expansion[n] = 1
		if expansion.length < N
			n = expansion.length
			expansion[n] = 2*k
			k += 1
		end
		if expansion.length < N
			n = expansion.length
			expansion[n] = 1
		end
	end

	return expansion
end

def rollup_expansion(expansion)
	n = expansion.length - 1
	while n > 0
		b = Rational(expansion.pop)
		n -= 1
		expansion[n] += 1/b
	end
	return expansion[0]
end

expansion = build_expansion
fraction = rollup_expansion(expansion)
num = fraction.numerator

p num.to_s.split("").map{ |c| c.to_i }.inject(0){|sum,x| sum + x }


