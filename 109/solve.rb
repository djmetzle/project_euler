#!/usr/bin/ruby

require 'set'

N=100

checkouts = []

POINTS = (1..20)
MODIFIERS = Set[1,2,3]

Throw = Struct.new(:mod, :p)
Checkout = Struct.new(:t1, :t2, :ft)

def points(t)
   return 0 if t.nil?
   return t.mod * t.p
end

def get_checkout_points c
   return points(c.t1) + points(c.t2) + points(c.ft)
end

def get_points_enum
   return Enumerator.new do |x|
      MODIFIERS.each do |m|
         POINTS.each do |p|
            x.yield(Throw.new(m, p))
         end
      end
      x.yield(Throw.new(1, 25))
      x.yield(Throw.new(2, 25))
   end
end

def get_doubles_enum
   return Enumerator.new do |x|
      POINTS.each do |p|
         x.yield(Throw.new(2, p))
      end
      x.yield(Throw.new(2, 25))
   end
end

def get_two_enum
   return Enumerator.new do |x|
      x.yield([nil,nil])
      get_points_enum.each { |c|
         x.yield([nil,c])
         x.yield([c,c])
      }
      get_points_enum.to_a.combination(2).each { |c|
         x.yield(c)
      }
   end
end

def get_all_enum
   return Enumerator.new do |x|
      get_doubles_enum.each do |d|
         get_two_enum.each do |t|
            x.yield(Checkout.new(t[0], t[1], d))
         end
      end
   end
end

count = 0
get_all_enum.each do |c|
   if get_checkout_points(c) < N
      count += 1
   end
end
puts count

