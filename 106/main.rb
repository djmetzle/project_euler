#!/usr/bin/ruby

# Euler 106

require_relative './special.rb'

#test = [3,5,6,7,8,9,10]

test = [29, 44, 42, 59, 41, 36, 40]

subsets = all_subsets(test)
disjoint = disjoint_subset_pairs(subsets)

no_equal_sums(disjoint)

