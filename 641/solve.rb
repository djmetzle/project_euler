#!/usr/bin/ruby
puts "Problem #641"

N = 6

$row = Array.new(N+1,1)
p $row

(2..N).each { |n|
   puts n
   (n..N).step(n).each { |r|
      puts $row[r]
      $row[r] += 1
   }
}

$row.shift
p $row
