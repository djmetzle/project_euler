#!/usr/bin/ruby

# Euler 83

# test data
weights = [
	[131, 673, 234, 103,  18],
	[201,  96, 342, 965, 150],
	[630, 803, 746, 422, 111],
	[537, 699, 497, 121, 956],
	[805, 732, 524,  37, 331],
]

weights = File.open("matrix.txt").map{ |line|
	line.strip.split(",").map{|val| val.to_i}
}

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
	def is_node?(node)
		node.i == @i and node.j == @j
	end
end

def next_current
	$unvisited.select { |node| node}.select { |node| node.d }.min_by { |node| node.d }
end

def in_unvisited?(node)
	$unvisited.any? { |unv| unv.is_node?(node) }
end

def find_node(i,j)
	$unvisited.find_index { |unv| unv.i == i and unv.j == j }
end

length = weights.length
width = weights[0].length

$unvisited = []

# starting node
start_node = Node.new(0,0,weights[0][0])
start_node.d = start_node.w
$unvisited.push start_node


# init $unvisited
(0...length).each { |row|
	(0...width).each { |col|
		unless row == 0 and col == 0
			node = Node.new(row,col,weights[row][col])
			$unvisited.push(node)
		end
	}
}

end_node = Node.new(length-1,width-1, 0)

def update_node(n_i, current_node)
	d = current_node.d + $unvisited[n_i].w
	if ($unvisited[n_i].d) and ($unvisited[n_i].d > d)
		$unvisited[n_i].d = d
	end
	unless ($unvisited[n_i].d)
		$unvisited[n_i].d = d
	end

end


count = 0

current_node = nil
while in_unvisited?(end_node) and count < 10
	current_node = next_current
	i = current_node.i
	j = current_node.j
	unless i-1 < 0
		neighbor = find_node(i-1,j)
		if (neighbor)
			update_node(neighbor, current_node)
		end
	end
	unless i+1 >= length
		neighbor = find_node(i+1,j)
		if (neighbor)
			update_node(neighbor, current_node)
		end
	end
	unless j-1 < 0
		neighbor = find_node(i,j-1)
		if (neighbor)
			update_node(neighbor, current_node)
		end
	end
	unless j+1 >= width
		neighbor = find_node(i,j+1)
		if (neighbor)
			update_node(neighbor, current_node)
		end
	end
	cur_index = find_node(i,j)
	p cur_index
	$unvisited.delete_at(cur_index)
end

p current_node
