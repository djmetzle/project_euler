#!/usr/bin/ruby
puts "Problem #137"

def mysqrt(x)
	return 0 if x==0 
	m=x
	p=x
	loop do
		r=(m+p/m)/2
		return m if m<=r
		m=r
	end
end

def is_square n
	return (mysqrt n)**2 == n
end

def q a
	return 5*a**2 + 2*a + 1
end

def is_nugget n
	return is_square(q(n))
end

last = 2
found = 1
while found < 15 do
	next_guess = (last * 6.8541).round
	n = 0
	loop do
		up = next_guess + n
		down = next_guess - n
		if is_nugget up
			found += 1 
			puts "Found #{up}"
			last = up
			break
		end
		if is_nugget down
			found += 1 
			puts "Found #{down}"
			last = down
			break
		end
		n += 1
	end
end

