#!/usr/bin/ruby

# Euler 112

#TARGET = Rational(1,2)
#TARGET = Rational(9,10)
TARGET = Rational(99,100)

def explode(n)
	return n.to_s.split('').to_a.map { |d| d.to_i }
end

def increasing?(digits)
	last = 0
	digits.each { |d|
		if d >= last
			last = d
		else
			return false
		end
	}
	return true
end

def decreasing?(digits)
	last = 10
	digits.each { |d|
		if d <= last
			last = d
		else
			return false
		end
	}
	return true
end

def bouncy?(n)
	digits = explode(n)
	if increasing?(digits)
		return false
	end
	if decreasing?(digits)
		return false
	end
	return true
end

bouncy = 0
total = 99

while Rational(bouncy, total) < TARGET
	total += 1
	if bouncy?(total)
		bouncy += 1
	end
end

puts "ANS: #{total}"
puts "SANITY: #{Rational(bouncy,total)}"
