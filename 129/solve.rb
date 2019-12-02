#!/usr/bin/ruby

MAX=1e6

$repcache = [0]

def build_repcache
   prev = 0
   (1..MAX).each { |n|
      r = 10 * prev + 1
      $repcache.push(r)
      prev = r
   }
   puts "built cache"
end

build_repcache
exit 0

def min_k n
   k = 1
   while true
      return k if repunit(k) % n == 0
      k += 1
   end
end

def find
   n = 0
   while true
      n += 1
      next unless n.gcd(10) == 1
      return n if min_k(n) > MAX
   end
end

p find
