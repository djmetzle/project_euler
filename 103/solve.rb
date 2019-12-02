#!/usr/bin/ruby

require 'set'

puts "Euler 103"

optimal = [nil, Set[1]]
test_set = Set[3,5,6,7]


def get_set_sum set
   return set.to_a.reduce(&:+)
end

def needs_check? a, b
   #p [a, b]
   return false unless a.size == b.size
   a.to_a.zip(b.to_a).each do |pair|
      #p pair
      return true if pair[1] < pair[0]
   end
   return false
end

def first_rule? a, b
   a_sum = a.reduce(:+)
   b_sum = b.reduce(:+)
   return a_sum != b_sum
end

def second_rule? a, b
   a_size = a.size
   b_size = b.size
   a_sum = a.reduce(:+)
   b_sum = b.reduce(:+)
   return true if a_size == b_size
   if a_size > b_size
      return false if a_sum < b_sum
   end
   if a_size < b_size
      return false if a_sum > b_sum
   end
   return true
end

def both_rules? a, b
   a_sum = a.reduce(:+)
   b_sum = b.reduce(:+)
   return false if a_sum == b_sum
   a_size = a.size
   b_size = b.size
   return true if a_size == b_size
   if a_size > b_size
      return false if a_sum < b_sum
   end
   if a_size < b_size
      return false if a_sum > b_sum
   end
   return true
end

def all_subsets_enum set
   return Enumerator.new do |s|
      (1...set.size).each do |size|
         set.to_a.combination(size).lazy.each do |subset|
            s.yield subset
         end
      end
   end
end

def disjoint_subsets_enum set
   n = set.size
   return Enumerator.new do |x|
      subsets = all_subsets_enum(set).to_a
      counter = 0
      subsets.combination(2).lazy.each do |p|
         subset_pair = p.map { |el| el.to_set }
         next unless subset_pair[0].disjoint? subset_pair[1]
         x.yield subset_pair
      end
   #   puts "#{n}: Needed Checks: #{counter}"
   end
end

def is_valid_set? set
   disjoint_enum = disjoint_subsets_enum set
   disjoint_enum.lazy.each do |dss|
      return false unless both_rules? dss[0], dss[1]
   end
   return true
end

def get_guess set
   guess = Set[]
   set_size = set.size
   middle_el = set.to_a[set_size/2]
   guess.add(middle_el)
   set.each do |el|
      guess.add(middle_el + el)
   end
   return guess
end

def get_set_sum set
   return set.to_a.reduce(&:+)
end

def get_all_nearby_enum set, width
   return Enumerator.new do |s|
      original_set = set.to_a
      original_set_size = original_set.size
      deltas = (-width..width).to_a
      deltas.repeated_permutation(set.size).lazy.each { |p|
         shifted = original_set.zip(p).map { |a| a.reduce(:+) }
         next if shifted.any? { |x| x < 1 }
         shifted_set = shifted.to_set
         next if shifted_set.size != original_set_size
         s.yield shifted.to_set
      }
   end
end

def test_needed_checks
   #(2..4).each do |n|
   (2..12).each do |n|
      guess = get_guess optimal[n-1]
      p guess
      dss = disjoint_subsets_enum(guess).to_a
      len = dss.length
      puts "#{n}: #{len}"
      optimal[n] = guess
   end
   exit 0
end
#test_needed_checks

(2..7).each do |n|
   guess = get_guess optimal[n-1]
   best_sum = get_set_sum guess
   best_guess = guess
   all_enum = get_all_nearby_enum guess, 3
   all_enum.lazy.each do |tester|
      #p tester
      next unless is_valid_set? tester
      tester_sum = get_set_sum(tester)
      if tester_sum < best_sum
         best_sum = tester_sum
         best_guess = tester
      end
   end
   p best_guess
   optimal[n] = best_guess
end
