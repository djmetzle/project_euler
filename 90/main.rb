#!/usr/bin/ruby

# Euler 90

combinations = (0..9).to_a.combination(6).to_a

combinations.map { |c|
}

distinct_combos = 0

combinations.each_with_index { |c1, i|
	combinations.each_with_index { |c2, j|
		if i <= j
			next
		end
		found_squares = (1..9).map { |i| [i*i, false] }.to_h

		c1.each { |c1v|
			c2.each { |c2v|
				lv = "#{c1v}#{c2v}".to_i 
				rv = "#{c2v}#{c1v}".to_i 
				if found_squares.has_key?(lv)
					found_squares[lv] = true
				end
				if found_squares.has_key?(rv)
					found_squares[rv] = true
				end
				if c1v == 6
					lv = "#{9}#{c2v}".to_i 
					rv = "#{c2v}#{9}".to_i 
					if found_squares.has_key?(lv)
						found_squares[lv] = true
					end
					if found_squares.has_key?(rv)
						found_squares[rv] = true
					end
				end
				if c1v == 9
					lv = "#{6}#{c2v}".to_i 
					rv = "#{c2v}#{6}".to_i 
					if found_squares.has_key?(lv)
						found_squares[lv] = true
					end
					if found_squares.has_key?(rv)
						found_squares[rv] = true
					end
				end
				if c2v == 6
					lv = "#{9}#{c1v}".to_i 
					rv = "#{c1v}#{9}".to_i 
					if found_squares.has_key?(lv)
						found_squares[lv] = true
					end
					if found_squares.has_key?(rv)
						found_squares[rv] = true
					end
				end
				if c2v == 9
					lv = "#{6}#{c1v}".to_i 
					rv = "#{c1v}#{6}".to_i 
					if found_squares.has_key?(lv)
						found_squares[lv] = true
					end
					if found_squares.has_key?(rv)
						found_squares[rv] = true
					end
				end
			}
		}

		unless found_squares.has_value?(false)
			distinct_combos += 1
		end
	}
}

puts "ANS: #{distinct_combos}"

found_squares = (1..9).map { |i| [i*i, false] }.to_h
