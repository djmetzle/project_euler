#        [0,1,2,3,4,5,6,7,8,9]
digits = [0,1,0,0,0,0,0,0,0,0]

require 'pp'

sum = 1;
n = 1;
while n < 1e1;
	n+=1;
	last_digits = digits.dup
	last_digits.each_index { |i|
		digits[i] += last_digits[i]
	}
	pp digits	
end
puts "#{n} : #{sum}"
