#!/usr/bin/ruby
puts "Euler 114"

MAX=1e6

BlockSet = Struct.new(:m, :n)

$tiles = {}
def tilings n, m
   param = BlockSet.new(m,n)
   return $tiles[param] if $tiles.key?(param)
   sum = 1
   return ($tiles[param] = sum) unless m >= n
   (0..(m-n)).each { |start_pos|
      (n..(m-start_pos)).each { |length|
         sum += tilings(n, m-start_pos-length-1)
      }
   }
   return ($tiles[param] = sum)
end

def least_n m
   n = m+1
   while true do
      n += 1
      ts = tilings(m, n)
      return n if ts > MAX
   end
end

puts least_n 3
puts least_n 10
puts least_n 50

