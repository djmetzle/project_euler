#!/usr/bin/ruby

# Euler 79

entries= File.open('keylog.txt').map { |line|
	line.strip.split("").map {|c| c.to_i}
}

tree = {}
entries.each { |a|
	left = a[0]
	first = a[1]
	second = a[2]
	tree[first] ||= []

	if not tree[first].include? left
		tree[first].push left
	end
	tree[second] ||= []
	if not tree[second].include? left
		tree[second].push left
	end
	if not tree[second].include? first 
		tree[second].push first
	end
}



p tree
