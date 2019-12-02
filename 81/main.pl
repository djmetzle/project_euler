#use warnings;
use strict;
use v5.10;
use POSIX;

# Project Euler Problem 81

$, = ' ';

our $N;

our @matrix;

sub example_initialize {
	our $N = 5;
	@matrix = (
		[ 131, 673, 234, 103,  18 ],
		[ 201,  96, 342, 965, 150 ],
		[ 630, 803, 746, 422, 111 ],
		[ 537, 699, 497, 121, 956 ],
		[ 805, 732, 524,  37, 331 ],
	);
}

sub initialize {
	my $filename = "matrix.txt";
        open(my $fh, '<:encoding(UTF-8)', $filename)
                or die "Could not open file '$filename' $!";

        my $n = 0;
        while (my $row = <$fh>) {
                chomp $row;
                my @row = split ',', $row;
		$matrix[$n] = \@row;
                $n++;
        }
        $N = $n;
	say "Read in $N rows";
}

sub traverse_paths {
	my $x = shift;
	my $y = shift;
	my $node = {
		'x' => $x,
		'y' => $y,
		'value' => $matrix[$x]->[$y],
	};
	if ($x < $N-1) {
		my $node_ref = traverse_paths($x+1,$y);
		push @{$node->{'children'}}, $node_ref;
	}

	if ($y < $N-1) {
		my $node_ref = traverse_paths($x,$y+1);
		push @{$node->{'children'}}, $node_ref;
	}

	if ($x == $N-2 && $y == $N-2) {
		say "Hit the bottom!";
	}

	return $node;
}

sub make_node {
	my $x = shift;
	my $y = shift;
	my $value = shift;
	my $node = {
		'x' => $x,
		'y' => $y,
		'value' => $value
	};
	return $node;
}

sub reduce_set {
	my $arr_ref = shift;
	my @ret;
	#say "Input: ", @$arr_ref;
	node_list: foreach my $node (@$arr_ref) {
		my $x = $node->{'x'};
		my $y = $node->{'y'};
		my $value = $node->{'value'};
		#say "$x:$y => $value";
		node_diff: foreach my $nodediff (@$arr_ref) {
			# dont compare to self
			if ($node == $nodediff) {
				#say "Found same node";
				next node_diff;
			}
			if ($x == $nodediff->{'x'} && $y == $nodediff->{'y'}) {
				if ($value > $nodediff->{'value'}) {
					#say "Found Better node: $x, $y";
					# skip node
					next node_list;
				}
			}
		}
		# would be skipped here if shorter path node
		push @ret, $node;
	}	
	#say "Reduced: ", @ret;
	return \@ret;
}

sub next_iter {
	my $path_ref = shift;
	say "Run iter on num nodes: ", scalar @$path_ref;
	my @next_nodes;
	foreach my $node (@$path_ref) {
		my $x = $node->{'x'};
		my $y = $node->{'y'};
		if ($x < $N-1) {
			#say "Push new node: ",$x+1,", ",$y;
			my $next_value = $node->{'value'};
			$next_value += $matrix[$x+1]->[$y];
			my $new_node = make_node($x+1,$y,$next_value);
			push @next_nodes, $new_node;
		}

		if ($y < $N-1) {
			#say "Push new node: ",$x,", ",$y+1;
			my $next_value = $node->{'value'};
			$next_value += $matrix[$x]->[$y+1];
			my $new_node = make_node($x,$y+1,$next_value);
			push @next_nodes, $new_node;
		}
	}
	my $ret = reduce_set(\@next_nodes);
	return $ret;
}

sub main {
	#example_initialize();
	initialize();
	my $initial_node = make_node(0,0,$matrix[0]->[0]);
	my @initial_path = ( $initial_node );
	say "=Run";
	my $next_ref = next_iter(\@initial_path);
	do {
		$next_ref = next_iter($next_ref);
	} while ( scalar @$next_ref > 1);
	say $next_ref->[0]->{'value'};

}

main();
