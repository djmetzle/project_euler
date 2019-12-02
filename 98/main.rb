#!/usr/bin/ruby

# Euler 98

def is_square?(n)          
	    sq = Math.sqrt(n).floor
		    return sq*sq == n      
end                        

def find_letter_counts(word)
	counts = {}
	word.chars.each { |c|
		i = c.ord - 64
		counts[i] ||= 0
		counts[i] += 1
	}
	return counts
end

def find_letter_list(word)
	letters = {}
	word.chars.each { |c|
		letters[c] = true
	}
	return letters.keys
end

words = File.open("words.txt").map { |line| line.strip.split(",") }[0]

words = words.map { |word| word.gsub(/"/, '') }

letter_counts = []
words.each_with_index { |word,i|
	letter_counts[i] = find_letter_counts(word)
}

anagram_pairs = []
(0...letter_counts.length).each { |i|
	(i+1...letter_counts.length).each { |j|
		if letter_counts[i] == letter_counts[j]
			anagram_pairs.push [i,j]
		end
	}
}

p anagram_pairs

max_square = 0

anagram_pairs.each { |pair|
	w1 = words[pair[0]]
	w2 = words[pair[1]]
	letters = find_letter_list(w1)
	subs = (0..9).to_a.repeated_combination(letters.length).to_a
	# filter duplicates
	subs = subs.reject { |sub|
		(0..9).any? { |v|
			sub.count(v) > 1 
		}
	}
	subs = subs.map { |sub| sub.permutation.to_a }.flatten(1) 
	subs = subs.reject { |sub| sub[0] == 0 }
	subs.each { |sub| 
		lookup = letters.zip(sub).to_h
		i1 = w1.split('').map { |c| lookup[c] }.join
		if i1[0].to_i == 0
			next
		end
		i1 = i1.to_i
		i2 = w2.split('').map { |c| lookup[c] }.join
		if i2[0].to_i == 0
			next
		end
		i2 = i2.to_i
		if is_square?(i1) and is_square?(i2)
			if i1 > max_square
				puts "New! #{i1}"
				max_square = i1
			end
			if i2 > max_square
				puts "New! #{i2}"
				max_square = i2
			end
			puts "#{w1} #{i1} :: #{w2} #{i2}"
		end
	}
}

puts "ANS: #{max_square}"
