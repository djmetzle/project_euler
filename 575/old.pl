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
	my $init_val = Math::BigRat->new(1/$Ns);
	say "Initial uniform probability: " . $init_val->as_float(12);
	for (my $i = 1; $i <= $Ns; $i++) {
		$halfprobs[$i] = $init_val;
		$evenprobs[$i] = $init_val;
	}
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
			say "$i => $n";
			$evenstates[$n]->{$i} = Math::BigRat->new("1/$count");
			if ($i == $n) {
				$halfstates[$n]->{$i} = Math::BigRat->new(1/2);
			} else {
				my $den = 2 * ($count - 1); 
				$halfstates[$n]->{$i} = Math::BigRat->new("1/$den");
			}
		}
	}
}

sub calc_max_delta {
	my $maxdelta = Math::BigRat->new("0");
	my $n = shift;
	my $nplusone = shift;
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		my $plus = $nplusone->[$isq];
		my $same = $n->[$isq];
		my $delta = $nplusone->[$isq] - $n->[$isq];
		if ($delta->is_neg()) {
			$delta->bneg();
		}
		if ($delta > $maxdelta) {
			$maxdelta = $delta;
		}
	}
	return $maxdelta;
}

sub normalize {
	my $probs = shift;
	my $sum = Math::BigRat->new("0");
	for (my $i = 1; $i <= $Ns; $i++) {
		$sum += $probs->[$i];
	}
	for (my $i = 1; $i <= $Ns; $i++) {
		$probs->[$i] *= 1/$sum;
	}
	#say "NORMALIZE: ",$sum->as_float();
	return;
}


sub sum_half {
	my $sum = Math::BigRat->new("0");
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		$sum += $halfprobs[$isq];
	}
	return $sum;
}

sub sum_even {
	my $sum = Math::BigRat->new("0");
	for (my $i = 1; $i <= $N; $i++) {
		my $isq = $i * $i;
		$sum += $evenprobs[$isq];
	}
	return $sum;
}

sub get_l1_norm {
	my $arr_ref = shift;
	my $max = Math::BigRat->new("0");
	for (my $i = 1; $i <= $Ns; $i++) {
		my $sum = Math::BigRat->new("0");
		foreach my $n (keys %{$arr_ref->[$i]}) {
			if ($arr_ref->[$i]->{$n}->is_neg()) {
				$sum -= $arr_ref->[$i]->{$n};
			} else {
				$sum += $arr_ref->[$i]->{$n};
			}
		}
		if ($sum > $max) { 
			$max = $sum;
		}
	}
	return $max;
}

sub get_inf_norm {
	my $arr_ref = shift;
	return 1;
}

sub matrix_invert {
	my $iters = 10;
	# newtons method
	my $arr_ref = shift;;
	my $one_norm = get_l1_norm($arr_ref);
	say "L1: $one_norm";
	my $inf_norm = get_inf_norm($arr_ref);
	say "INF: $inf_norm";
	my @initial;
	
	# initialize 
	for (my $i = 1; $i <= $N; $i++) {
		$initial[$i] = {};
		foreach my $n (keys %{$arr_ref->[$i]}) {
			# NOTE! Transpose here
			$initial[$n]->{$i} = $arr_ref->[$i]->{$n}->copy();
			$initial[$n]->{$i} /= $one_norm;
		}
	}
}

sub initialize_guess {
	my $arr_ref = shift;
	my @guess;
	for (my $i = 1; $i <= $Ns; $i++) {
		$guess[$i] = {};
		foreach my $n (keys %{$arr_ref->[$i]}) {
			# NOTE! Transpose here
			$guess[$n]->{$i} = $arr_ref->[$i]->{$n};
		}
	}
	my $l1_norm = get_l1_norm(\@guess);
	for (my $i = 1; $i <= $Ns; $i++) {
		foreach my $n (keys %{$guess[$i]}) {
			$guess[$i]->{$n} /= $l1_norm;
		}
	}
	return \@guess;
}

sub get_half_iterator_inverse {
	my @ret;
	for (my $i = 1; $i <= $Ns; $i++) {
		$ret[$i] = {};
		foreach my $n (keys %{$halfstates[$i]}) {
			if ($n == $i) {
				$ret[$i]->{$n} = $halfstates[$i]->{$n} - 1;
			} else {
				$ret[$i]->{$n} = $halfstates[$i]->{$n};
			}
		}
	}
	matrix_invert(\@ret);
	return \@ret;
}

sub get_even_iterator_inverse {
	my @ret;
	for (my $i = 1; $i <= $Ns; $i++) {
		$ret[$i] = {};
		foreach my $n (keys %{$evenstates[$i]}) {
			if ($n == $i) {
				$ret[$i]->{$n} = $evenstates[$i]->{$n} - 1;
			} else {
				$ret[$i]->{$n} = $evenstates[$i]->{$n};
			}
		}
	}
	matrix_invert(\@ret);
	return \@ret;
}

sub main {
	initialize_probs();
	initialize_state_matrix();
	my $hii = get_half_iterator_inverse();
	my $eii = get_even_iterator_inverse();

	my $half = sum_half();
	say "HALF PROB: ", $half->as_float();
	my $even = sum_even();
	say "EVEN PROB: ", $even->as_float();
	my $ans = Math::BigRat->new("1/2") * $half + Math::BigRat->new("1/2") * $even;
	say "ANSWER: ", $ans->as_float();
}

main();
