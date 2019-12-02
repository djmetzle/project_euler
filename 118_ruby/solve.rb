#!/usr/bin/ruby

require 'prime'

#N=3
N=9

class SetPartitions
   attr_accessor :n

   attr_reader :k, :m

   def initialize n
      @n = n
      init_k_m
   end

   def get_next_partition
      (@n-1).downto(1).each do |i|
         if @k[i] <= @m[i-1]
            @k[i] = @k[i] + 1
            @m[i] = [@m[i], @k[i]].max
            ((i+1)..(n-1)).each do |j|
               @k[j] = @k[0]
               @m[j] = @m[i]
            end
            return @k
         end
      end
      return nil
   end

   private
   def init_k_m
      @k = Array.new(@n, 0)
      @m = Array.new(@n, 0)
   end
end

BASE_SET = (1..N).to_a

def subsets_gen
   return Enumerator.new do |e|
      sp = SetPartitions.new N
      loop do
         next_p = sp.get_next_partition
         break unless next_p
         subsets = Array.new(N) { Array.new }
         next_p.each_with_index { |pn, i| 
            subsets[pn].push(BASE_SET[i])
         }
         e.yield subsets
      end
   end
end

def shuffle_gen
   return Enumerator.new do |e|
      subsets_gen.each do |s| 
         perms = s.reject(&:empty?).map { |digit_set|
            digit_set.permutation(digit_set.length).to_a.map { |shuf|
               shuf.join('').to_i
            }
         }
         perms.shift.product(*perms).each { |concat|  
            e.yield concat
         }
      end
   end
end

count = 0
shuffle_gen.each { |subset|
   count += 1 unless subset.any? { |el| !Prime.prime?(el) }
}

p count
