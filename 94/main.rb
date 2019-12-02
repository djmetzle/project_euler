#!/usr/bin/ruby

# Euler 94

P_MAX = 1e9

sum = 0

x = 2
y = 1

while true
	a_times_3 = 2*x-1
	area_times_3 = y*(x-2)
	if a_times_3 > P_MAX
		break
	end

	if (a_times_3 > 0 &&
			area_times_3 > 0 &&
			a_times_3 % 3 == 0 &&
			area_times_3 % 3 == 0)
		a = a_times_3 / 3
		sum += 3 * a + 1
		puts sum
	end
	a_times_3 = 2*x+1
	area_times_3 = y*(x+2)
	if (a_times_3 > 0 &&
			area_times_3 > 0 &&
			a_times_3 % 3 == 0 &&
			area_times_3 % 3 == 0)
		a = a_times_3 / 3
		area = area_times_3 / 3
		sum += 3 * a - 1
		puts sum
	end
	next_x = 2*x + y*3
	next_y = 2*y + x
	x = next_x
	y = next_y
end

puts "SUM: #{sum}"
