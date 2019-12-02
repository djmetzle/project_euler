#!/usr/bin/perl

use v5.10;

use warnings;
use strict;

use POSIX;
use Math::BigRat;

our $N = 5;
our $Ns = $N*$N;

our @halfprobs;
our @evenprobs;

our @probs_delta;

our @halfstates;
our @evenstates;


sub build_adjacent_list {
	my $n = shift;
	my @adj = ();
	push @adj, $n;
	if (((($n-1)%$N)-(($n-2)%$N)) == 1) {
		push @adj, $n-1;
	}
	if (((($n)%$N)-(($n-1)%$N)) == 1) {
		push @adj, $n+1;
	}
	if (($n-$N) > 0) {
		push @adj, $n-$N;
	}
	if (($n+$N) <= $Ns) {
		push @adj, $n+$N;
	}
	return \@adj;
}

# initialize to uniform probability
sub initialize_probs {
	my $init_val = 1.0/$Ns;
	say "Initial uniform probability: " . $init_val;
	for (my $i = 1; $i <= $Ns; $i++) {
		my @adj = @{build_adjacent_list($i)};
		my $count = scalar @adj;
		$halfprobs[$i] = 1.0;
		$evenprobs[$i] = 1.0;
	}
	normalize(\@halfprobs);
	normalize(\@evenprobs);
	print_half();
}

sub initialize_state_matrix {
	# hash of hashes
	$, = " ";
	for (my $i = 1; $i <= $Ns; $i++) {
		$halfstates[$i] = {};
		$evenstates[$i] = {};
		my @adj = @{build_adjacent_list($i)};
		my $count = scalar @adj;
		foreach my $n (@adj) {
			$evenstates[$n]->{$i} = 1.0/$count;
			if ($i == $n) {
				$halfstates[$n]->{$i} = 0.5;
			} else {
				my $den = 2 * ($count - 1); 
				$halfstates[$n]->{$i} = 1.0/$den;
			}
		}
	}
}

sub calc_max_delta {
	my $maxdelta = 0.0;
	my $n = shift;
	my $nplusone = shift;
	my $nd = 0.0;
	my $npod = 0.0;
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		$npod = $nplusone->[$isq];
		$nd = $n->[$isq];
	}
	return abs($npod-$nd);
}

sub normalize {
	my $probs = shift;
	my $sum = 0.0;
	for (my $i = 1; $i <= $Ns; $i++) {
		$sum += $probs->[$i];
	}
	for (my $i = 1; $i <= $Ns; $i++) {
		$probs->[$i] *= 1.0/$sum;
	}
	#say "NORMALIZE: ",$sum;
	return;
}

sub iterate_half {
	my $maxdelta = 1.0;
	my $thresh = 1.0e-12;
	my $iters = 0;
	while ( $maxdelta > $thresh ) {
		$iters++;
		#say "Iteration: $iters";
		my @probstemp;
		for (my $i = 1; $i <= $Ns; $i++) {
			# zero temp
			$probstemp[$i] = 0.0;
		}
		# perform mult into temp
		for (my $i = 1; $i <= $Ns; $i++) {
			my $sum = 0.0;
			foreach my $n (keys %{$halfstates[$i]}) {
				my $mult = ($halfprobs[$n]) * ($halfstates[$i]->{$n}); 
				$sum += $mult;
			}
			$probstemp[$i] = $sum ;
		}
		normalize(\@probstemp);
		# calc max delta
		my $delta = calc_max_delta(\@halfprobs,\@probstemp);
		say "Iter: $iters : Max Delta: ", $delta;
		if ($delta < $maxdelta) {
			$maxdelta = $delta;
		}
		# copy temp to probs
		for (my $i = 1; $i <= $Ns; $i++) {
			$halfprobs[$i] = $probstemp[$i];
		}
	}
}

sub iterate_even {
	my $maxdelta = 0.1;
	my $thresh = 1.0e-12;
	my $iters = 0;
	while ( $maxdelta > $thresh ) {
		$iters++;
		my @probstemp;
		for (my $i = 1; $i <= $Ns; $i++) {
			# zero temp
			$probstemp[$i] = 0.0;
		}
		# perform mult into temp
		for (my $i = 1; $i <= $Ns; $i++) {
			my $sum = 0.0;
			foreach my $n (keys %{$evenstates[$i]}) {
				my $mult = ($evenprobs[$n]) * ($evenstates[$i]->{$n}); 
				$sum += $mult;
			}
			$probstemp[$i] = $sum ;
		}
		normalize(\@probstemp);
		# calc max delta
		my $delta = calc_max_delta(\@evenprobs,\@probstemp);
		say "Iteration: $iters : Max Delta: ", $delta;
		if ($delta < $maxdelta) {
			$maxdelta = $delta;
		}
		# copy temp to probs
		for (my $i = 1; $i <= $Ns; $i++) {
			$evenprobs[$i] = $probstemp[$i];
		}
	}
}

sub sum_half {
	my $sum = 0.0;
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		$sum += $halfprobs[$isq];
	}
	return $sum;
}

sub sum_even {
	my $sum =0;
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		$sum += $evenprobs[$isq];
	}
	return $sum;
}

sub print_half {
	for (my $i = 1; $i < $Ns; $i+=$N) {
		for (my $j=0; $j<$N; $j++) {
			my $q = $i+$j;
			print "$q:", $halfprobs[$q], "  ";
		}
		print "\n";
	}
}

sub main {
	initialize_probs();
	initialize_state_matrix();
	iterate_half();
	print_half();
	iterate_even();
	my $half = sum_half();
	say "HALF PROB: ", $half;
	my $even = sum_even();
	say "EVEN PROB: ", $even;
	my $ans = 0.5 * $half + 0.5 * $even;
	say "ANSWER: ", $ans;
}

main();
