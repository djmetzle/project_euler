

sum = 1;
n = 1;
while n < 1e6;
	n+=1;
	digits = 0
	sum_copy = sum 
	while (sum_copy > 0)
		sum_copy /= 10
		digits += 1
	end

	sum += 1 (0..digits) {

	}
	puts "#{digits}"

	puts "#{n} #{sum}"
end
puts "#{n} : #{sum}"
