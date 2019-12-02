#!/usr/bin/ruby
puts "Euler 113"

def get_single_digit_array
   single_digits = Array.new(10, 1)
   single_digits[0] = 0
   return single_digits
end

def print_out digit_array
   digit_array.each_with_index do |x, i|
      puts " #{i}: #{x}"
   end
end

def iterate_inc digit_array
   next_array = Array.new(10,0)
   (1..9).each { |i|
      (1..9).each { |j|
         if i >= j
            next_array[i] += digit_array[j]
         end
      }
   }
   return next_array
end

def iterate_dec digit_array
   next_array = Array.new(10,0)
   (0..9).each { |i|
      (0..9).each { |j|
         if i <= j
            next_array[i] += digit_array[j]
         end
      }
   }
   return next_array
end

def inc_table n
   by_digits = []
   by_digits[1] = get_single_digit_array
   (2..n).each { |d|
      by_digits[d] = iterate_inc by_digits[d-1]
   }
   return by_digits
end

def dec_table n
   by_digits = []
   by_digits[1] = get_single_digit_array
   (2..n).each { |d|
      by_digits[d] = iterate_dec by_digits[d-1]
   }
   return by_digits
end

def n_increasing n
   table = inc_table n
   return table.reject(&:nil?).map { |row| row.reduce(:+) }.reduce(:+)
end

def n_decreasing n
   table = dec_table n
   return table.reject(&:nil?).map { |row| row.reduce(:+) }.reduce(:+)
end

def n_duplicates n
   return 9*n
end

def n_total n
   return puts n_increasing(n) + n_decreasing(n) - n_duplicates(n)
end

puts n_total 6
puts n_total 10

puts n_total 100
