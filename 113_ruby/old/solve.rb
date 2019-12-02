#!/usr/bin/ruby
puts "Euler 113"

def increasing? n
   digits = n.to_s.split('').map(&:to_i)
   digits.each_with_index do |digit, i|
      if i > 0
         return false if digit < digits[i-1]
      end
   end
   return true
end

def decreasing? n
   digits = n.to_s.split('').map(&:to_i)
   digits.each_with_index do |digit, i|
      if i < digits.size - 1
         return false if digit < digits[i+1]
      end
   end
   return true
end

def find_n_increasing n
   counts_per_width = []
   next_counts = (1..9).map { |digit| [digit, 1] }.to_h
   (0..n).each do |l|
      last_counts = Marshal.load(Marshal.dump(next_counts))
      counts_per_width.push last_counts
      next_counts = (1..9).map { |digit| [digit, 0] }.to_h
      next_counts.each do |d,c|  
         next_counts[d] = (10-d) * next_counts[d]
      end
   end
   p counts_per_width
   return counts_per_width.map { |width| width.values.reduce(:+) }.reduce(:+)
end


p find_n_increasing 1
p find_n_increasing 2
p find_n_increasing 3
puts
p find_n_increasing 5
