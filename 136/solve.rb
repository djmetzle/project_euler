#!/usr/bin/ruby
puts "Problem #135"

#MAX = 100
MAX = 5e7

$sols = {}

def find_sols
   1.upto(MAX).each do |u|
      1.upto(MAX/u + 1).each do |v|
         n = u * v
         next unless n < MAX
         next unless 3*v > u
         next unless (u+v) % 4 == 0           
         next unless (3*v-u) % 4 == 0         
         $sols[n] ||= 0
         $sols[n] += 1
      end
      puts u if u % 1e6 == 0
   end
   return
end

find_sols

pp $sols.select { |n, sol| sol == 1 }.keys.length

