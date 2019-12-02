#!/usr/bin/ruby
puts "Problem #138"

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

def l_sq_p b
   return (5/4.0)*b**2 + 2*b + 1
end
def l_sq_n b
   return (5/4.0)*b**2 - 2*b + 1
end

b = 1
while b < 300 
   b += 1
   puts "B: #{b}"
   if is_square(l_sq_p(b))
      puts b
   end
   if is_square(l_sq_n(b))
      puts b
   end
end


