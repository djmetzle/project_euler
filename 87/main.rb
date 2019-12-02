require 'prime'

MAX = 5e7
#MAX = 5e1

puts MAX

MaxQ = MAX ** Rational(1,4) + 1
MaxC = MAX ** Rational(1,3) + 1
MaxS = MAX ** Rational(1,2) + 1

puts MaxQ
puts MaxC
puts MaxS

values = { 28 => true }

count = 0

Prime.each(MaxQ) do |q|
	Prime.each(MaxC) do |c|
		Prime.each(MaxS) do |s|
			n = s*s + c*c*c + q*q*q*q
			if n < MAX
				values[n] = true
			end
		end
	end
end

count = values.keys.count

puts "COUNT: X"
#puts "COUNT: #{count}"
