#!/usr/bin/ruby

N = 3

$increasing_digits = lambda { |d| return (d..9).to_a }
$decreasing_digits = lambda { |d| return (0..d).to_a }

def brute_sol n
   solutions = 0
   i_sol = 0
   d_sol = 0
   (1...10**n).each { |i|
      increasing = true
      decreasing = true
      digits = i.to_s.split('').map { |d| d.to_i }
      digits.each_index { |i|
         next if digits[i+1].nil?
         if digits[i] > digits[i+1]
            increasing = false
            next
         end
         if digits[i] < digits[i+1]
            decreasing = false
            next
         end
      }
      solutions += 1 if increasing || decreasing
   }
   return solutions
end

def increasing_array n, d
   digits = $increasing_digits.call(d)
   if n == 1
      return digits.map { |d| [d, 1] }.to_h
   end
   sub_counts = {}
   digits.each { |d| 
      sub_counts[d] = increasing_array(n-1, d)
   }
   return sub_counts
end

def decreasing_array n, d
   digits = $decreasing_digits.call(d)
   if n == 1
      return digits.map { |d| [d, 1] }.to_h
   end
   sub_counts = {}
   digits.each { |d| 
      sub_counts[d] = decreasing_array(n-1, d)
   }
   return sub_counts
end

(1..N).each { |n|
   puts "N: #{n}"
   i_array = increasing_array(n, 1)
   #i = i_array.values.reduce(:+)
   pp i_array
   d_array = decreasing_array(n, 9)
   #dec = d_array.values.reduce(:+)
#   pp d_array
   #brute = brute_sol n
   #p [i, dec]
   #puts "SUMS: #{i + dec - 10*n} vs #{brute}"
#   dec[0] = 0 
#   puts "#{i} + #{d} = #{i + d}"
}

