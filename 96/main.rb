#!/usr/bin/ruby

# Euler 96

class Sudoku
	attr_reader :cells
	attr_reader :possibles

	def initialize(sudoku=nil)
		if sudoku	
			@cells = Marshal.load(Marshal.dump(sudoku.cells))
			@possibles = Marshal.load(Marshal.dump(sudoku.possibles))
		else
			init_empty_cells
			init_possibles
		end
	end

	def init_empty_cells
		@cells = []
		(1..9).each { |i|
			@cells[i] = []
			(1..9).each { |j|
				@cells[i][j] = nil
			}
		}
	end

	def init_possibles
		@possibles = []
		(1..9).each { |i|
			@possibles[i] = []
			(1..9).each { |j|
				@possibles[i][j] = []
				(1..9).each { |p|
					@possibles[i][j].push p
				}
			}
		}
	end

	def set_cell(i,j,value)
		unless (1..9).include?(value)
			return false
		end
		unless @possibles[i][j].include?(value)
			return false
		end
		@cells[i][j] = value
		update_possibles
		return true
	end

	def print_out
		puts "GRID:"
		(1..9).each { |i|
			(1..9).each { |j|
				if @cells[i][j]
					print "#{@cells[i][j]} "
				else
					print "# "
				end
			}
			print "\n"
		}
		print_possibles
	end

	def print_possibles
		puts "POSSIBLES:"
		(1..9).each { |i|
			(0...3).each { |row|
				(1..9).each { |j|
					start_r = 3*(row) + 1	
					end_r = 3*(row+1)
					(start_r..end_r).each { |p_val|
						if @possibles[i][j].include?(p_val)
							print "#{p_val} "
						else
							print "  "
						end
					}
					print " | "
				}
				print "\n"
			}
			print "\n\n"
		}
	end

	def update_possibles
		(1..9).each { |i| (1..9).each { |j|
				cell_val = @cells[i][j]
				if cell_val
					@possibles[i][j] = []
					(1..9).each { |p_i|
						@possibles[p_i][j] = @possibles[p_i][j].reject { |p| p == cell_val }
						(1..9).each { |p_j|
							@possibles[i][p_j] = @possibles[i][p_j].reject { |p| p == cell_val }
						}
					}
					block_i = (i-1)/3
					block_j = (j-1)/3
					i_start = 3*block_i + 1
					j_start = 3*block_j + 1
					i_end = 3*(block_i+1)
					j_end = 3*(block_j+1)
					(i_start..i_end).each { |b_i|
						(j_start..j_end).each { |b_j|
							@possibles[b_i][b_j] = @possibles[b_i][b_j].reject { |p| p == cell_val }
						}
					}
				end
		}}
	end

	def valid?
		(1..9).each { |i| (1..9).each { |j|
			cell_val = @cells[i][j]
			unless cell_val
				if @possibles[i][j].length == 0
					return false
				end
			end
		}}
		return true
	end

	def solved?
		(1..9).each { |i|
			(1..9).each { |j|
				cell_val = @cells[i][j]
				unless cell_val
					return false
				end
			}
		}
		return true
	end

	def improve_solution
		improvements = true
		while improvements
			improvements = false
			(1..9).each { |i|
				(1..9).each { |j|
					if @possibles[i][j].length == 1
						#puts "#{i} #{j} has single possibility"
						improvements = true
						set_cell(i,j,@possibles[i][j][0])
					end
				}
			}
		end
	end

	def search_for_solution
		return recursive_search(self,0,0)
	end

	def recursive_search(puzzle,i,j)
		next_p = puzzle.next_possible(i,j)
		p next_p
		puzzle.possibles[next_p[:i]][next_p[:j]].each { |p|
			puzzle_copy = Sudoku.new(puzzle)
			puzzle_copy.set_cell(next_p[:i], next_p[:j], p)
			puzzle_copy.improve_solution
			next unless puzzle_copy.valid?
			if puzzle_copy.solved?
				return puzzle_copy
			end
			search_puzzle = recursive_search(puzzle_copy,next_p[:i], next_p[:j])
			if search_puzzle.solved?
				return search_puzzle
			end
		}
		return puzzle
	end

	# for search
	def next_possible(c_i,c_j)
		past_index = false
		if c_i == 0 && c_j == 0
			past_index = true
		end
		(1..9).each { |i|
			(1..9).each { |j|
				if past_index && @possibles[i][j].length > 0
					return { :i => i, :j => j }
				end

				if i == c_i && j == c_j
					past_index = true
				end
			}
		}
		return nil
	end

	def each_cell(operation)

	end
end


puzzles = []

grid_n = 0
File.open("sudoku.txt").each { |line|
	if line =~ /Grid/
		match_data = line.match(/Grid (\d+)/)
		grid_n = match_data[1].to_i
		puzzles[grid_n] = []
	else
		puzzles[grid_n].push line.strip.split('').map {|d| d.to_i}
	end
}

def solve_puzzle(puzzle)
	s = Sudoku.new
	(1..9).each {|i|
		(1..9).each {|j|
			unless puzzle[i-1][j-1] == 0
				ret = s.set_cell(i,j,puzzle[i-1][j-1])
				unless ret
					s.print_out
					raise "invalid puzzle found!"
				end
			end
		}
	}
	s.improve_solution
	if s.solved?
		return s
	end
	ps = s.search_for_solution
	ps.print_out
	return ps
end

solutions = (1...puzzles.length).map {|puzzle_n|
	puzzle = puzzles[puzzle_n]
	solve_puzzle(puzzle)
}

solutions.each_with_index { |puzzle, n|
	puts "#{n} : #{puzzle.solved?}"
}

puts "Solved: " + solutions.select { |puzzle| puzzle.solved? }.length.to_s

first_three = solutions.map { |s| s.cells[1][1..3] }
p first_three
rows = first_three.map { |s| s.join('').to_i }
p rows
solution_sum = rows.reduce(:+)
p solution_sum
