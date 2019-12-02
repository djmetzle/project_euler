#!/usr/bin/ruby

# Euler 89

numerals = File.open("roman.txt").map { |line|
	line.strip
}

minimal_forms = numerals.map { |v| v.gsub(/IIII|XXXX|CCCC|VIIII|LXXXX|DCCCC/, '##') }

minimal_counts = minimal_forms.map { |f| f.split("").length }

delta = minimal_forms.each_with_index.map { |v,i| numerals[i].length - minimal_counts[i]}

puts "ANS: #{delta.reduce(:+)}"

