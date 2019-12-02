#!/usr/bin/ruby

# Euler 82

class Node
	attr_accessor :i
	attr_accessor :j
	attr_accessor :w
	attr_accessor :d
	def initialize(i, j, w)
		@i = i
		@j = j
		@w = w
		@d = nil
	end
end

def init_nodes
	rows = []
	File.open("matrix.txt").each do |line|
		rows.push line.strip.split(",").map { |el| el.to_i }
	end

	$length = rows.length
	$width = rows[0].length

	$nodes = []
	(0...$length).each { |i| 
		$nodes.push []
		(0...$width).each { |j|
			$nodes[i].push Node.new(i,j,rows[i][j])
		}
	}

	# init first column with distances
	(0...$length).each { |i| $nodes[i][0].d = $nodes[i][0].w }
end

def update_neighbor(node, i, j)
	neighbor = $nodes[i][j]
	
	unless neighbor.d
		$nodes[i][j].d = node.d + neighbor.w
		return
	end
	if $nodes[i][j].d > node.d + neighbor.w
		$nodes[i][j].d = node.d + neighbor.w
	end
end

def update_neighbors(row,col)
	node = $nodes[row][col]
	unless row-1 < 0
		update_neighbor(node,row-1,col)
	end
	unless row+1 >= $length
		update_neighbor(node,row+1,col)
	end
	unless col+1 >= $width
		update_neighbor(node,row,col+1)
	end
	
end

def run_dijkstra
	(0...$length).each { |row|
		$nodes[row][1].d = $nodes[row][0].d + $nodes[row][1].w
	}
	(0...$length).each { |time| 
		(1...$width-1).each { |col|
			(0...$length).each { |row|
				update_neighbors(row, col)
			}
		}
	}
end

init_nodes
run_dijkstra

finals = $nodes.map { |row|
	row[$width-1].d
}

puts finals.min
