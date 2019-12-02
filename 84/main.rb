#!/usr/bin/ruby

# Euler 84

require 'pp'

def tile_string(n)
	return n.to_s.rjust(2, '0')
end

TRIPLE_PROB = (1.0/4.0) ** 3

DIE_ROLL_PROBS = {
	2 => 1.0/16.0 * (1-TRIPLE_PROB), # 2
	3 => 2.0/16.0 * (1-TRIPLE_PROB), # 3
	4 => 3.0/16.0 * (1-TRIPLE_PROB), # 4
	5 => 4.0/16.0 * (1-TRIPLE_PROB), # 5
	6 => 3.0/16.0 * (1-TRIPLE_PROB), # 6
	7 => 2.0/16.0 * (1-TRIPLE_PROB), # 7
	8 => 1.0/16.0 * (1-TRIPLE_PROB), # 8
}

Tiles = [
	"GO", "A1", "CC1", "A2", "T1", "R1", "B1", "CH1", "B2", "B3",
	"JAIL", "C1", "U1", "C2", "C3", "R2", "D1", "CC2", "D2", "D3",
	"FP", "E1", "CH2", "E2", "E3", "R3", "F1", "F2", "U2", "F3",
	"G2J", "G1", "G2", "CC3", "G3", "R4", "CH3","H1", "T2", "H2",
]

def find_tile_index(tile_name)
	Tiles.each_with_index { |tile, index|
		if tile == tile_name
			return index
		end
	}
end

N_TILES = Tiles.length
BASE_PROB = 1.0/N_TILES
G2J_INDEX = Tiles.index("G2J")
JAIL_INDEX = find_tile_index("JAIL")


# helpers
def find_next_u(index)
	while true
		index = (index + 1) % N_TILES
		if Tiles[index] =~ /U/
			return index
		end
	end
end

def find_next_r(index)
	while true
		index = (index + 1) % N_TILES
		if Tiles[index] =~ /R/
			return index
		end
	end
end

def print_state
	#p $state
	original_indexes = $state.map.with_index.sort.map(&:last).reverse
	p original_indexes.map { |i| "#{i} : #{Tiles[i]}" }
end

# Init state vector
$state = []
Tiles.each_with_index { |tile, index|
	$state[index] = BASE_PROB
	if tile == "G2J"
		$state[index] = 0.0
	end
	if tile == "JAIL"
		$state[index] = 2.0 * BASE_PROB
	end
}

# Init stochiastic matrix
$markov_matrix = []
Tiles.each_with_index { |tile, index|
	$markov_matrix[index] = []
	Tiles.each_with_index { |cross, cross_i|
		$markov_matrix[index][cross_i] = 0.0
	}
}

# implement rules
Tiles.each_with_index { |tile, index|
	# prob of rolling doubles
	$markov_matrix[index][G2J_INDEX] += TRIPLE_PROB
	DIE_ROLL_PROBS.each { |roll_spaces, roll_prob| 
		next_space = (index + roll_spaces) % N_TILES
		next_tile = Tiles[next_space]
		case next_tile
		when /G2J/
			$markov_matrix[index][JAIL_INDEX] += roll_prob
		when /CC/
			# 1 out of 16 to goto GO
			go_index = find_tile_index("GO")
			$markov_matrix[index][go_index] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto JAIL
			$markov_matrix[index][JAIL_INDEX] += roll_prob * (1.0/16.0)
			# otherwise stay
			$markov_matrix[index][next_space] += roll_prob * (14.0/16.0)
		when /CH/
			# 1 out of 16 to goto GO
			go_index = find_tile_index("GO")
			$markov_matrix[index][go_index] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto JAIL
			$markov_matrix[index][JAIL_INDEX] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto C1
			c1_index = find_tile_index("C1")
			$markov_matrix[index][c1_index] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto E3
			e3_index = find_tile_index("E3")
			$markov_matrix[index][e3_index] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto H2
			h2_index = find_tile_index("H2")
			$markov_matrix[index][h2_index] += roll_prob * (1.0/16.0)
			# 1 out of 16 to goto R1
			r1_index = find_tile_index("R1")
			$markov_matrix[index][r1_index] += roll_prob * (1.0/16.0)
			# 2 out of 16 to goto next R
			next_r = find_next_r(next_space)
			$markov_matrix[index][next_r] += roll_prob * (2.0/16.0)
			# 1 out of 16 to goto next U
			next_u = find_next_u(next_space)
			$markov_matrix[index][next_u] += roll_prob * (1.0/16.0)
			# 1 out of 16 to go back 3 spaces
			$markov_matrix[index][next_space - 3] += roll_prob * (1.0/16.0)
			# otherwise stay
			$markov_matrix[index][next_space] += roll_prob * (6.0/16.0)
		else
			# base case
			$markov_matrix[index][next_space] += roll_prob
		end
	}
}

def iterate
	next_state = []
	for row in (0...N_TILES)
		next_state[row] = 0.0
		for col in (0...N_TILES)
			next_state[row] += $state[col] * $markov_matrix[col][row]
		end
	end
	$state = next_state
end

iteration = 0
while true
	iterate
	iteration += 1
	if (iteration % 100) == 0
		puts "Performed #{iteration} iterations"
		print_state
	end

end






