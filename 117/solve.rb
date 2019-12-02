#!/usr/bin/ruby
puts "Euler 117"

TILES=[1,4]

$memo = {}

def tilings n
   return 0 if n < 1
   return $memo[n] if $memo.key?(n)
   count = 0
   TILES.each { |t|
      if (n-t) == 0      
         count += 1
      end
      if (n-t) > 0
         count += tilings(n-t)
      end
   }
   $memo[n] = count
   return count
end

puts tilings 1
puts tilings(5)-1
puts tilings(50)-1
