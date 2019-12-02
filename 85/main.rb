#!/usr/bin/ruby

# Euler 85

x = 2
y = 3

def area(x,y)
	return x*y
end

def possibilities(x,y)
	possibilities = 0
	(1..x).each { |x_size|
		(1..y).each { |y_size|
			possibilities += (x-x_size+1)*(y-y_size+1)
		}
	}
	return possibilities
end

area = 0
width = 1

while area < 2e6
	width += 1
	area = possibilities(width,width)
#	puts "#{width}: #{area}"
end

sq_width = width

puts "Square Close! #{width}: #{area}"

area = 1
width = 1
while area < 2e6
	width += 1
	area = possibilities(1,width)
#	puts "#{width}: #{area}"
end

line_width = width

last_found = line_width

min = 2e10
min_area = 0
(1..sq_width).each { |x|
	(sq_width..last_found).reverse_each { |y|
		p = possibilities(x,y)
		if (p-2e6).abs < min
			min = (p-2e6).abs
			min_area = x*y
			last_found = y
			puts "new min! #{min} #{min_area}"
			break
		end
	}
}

puts "#{min} #{min_area}"


