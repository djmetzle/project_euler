#!/usr/bin/ruby

# Euler 103

require_relative './special.rb'

sets = []

File.open('sets.txt').each { |line|
	sets.push line.strip.split(',').map { |v| v.to_i }
}

sum = 0
sets.each { |set|
	p set
	if is_special?(set)
		puts "#{set.count} #{set}"
		sum += set_sum(set)
	end
}

puts "ANS: #{sum}"
