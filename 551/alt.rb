

sum = 1;
n = 1;
while n < 1e6;
	n+=1;
	digit_sum = sum.to_s.split("").map { |digit| digit.to_i }.inject(0, :+)
	sum += digit_sum
end
puts "#{n} : #{sum}"
