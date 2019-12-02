#!/usr/bin/perl

use v5.10;

use warnings;
use strict;

use POSIX;
use Math::BigRat;

our $N = 5;
our $Ns = $N*$N;

our @half_prob;
our @even_prob;

our @half_init_state;
our @even_init_state;

our @half_iter;
our @even_iter;

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

sub get_f_norm {
        my $arr_ref = shift;
        my $sum = Math::BigRat->new("0");
        for (my $i = 1; $i <= $Ns; $i++) {
		foreach my $n (keys %{$arr_ref->[$i]}) {
			$sum += $arr_ref->[$i]->{$n}->copy() * $arr_ref->[$i]->{$n}->copy();
		}
        }
	say "Fnorm: $sum";
        return $sum;
}

sub copy_vec {
	my $vec_ref = shift;
	my @copy;
	for (my $i=1; $i<=$Ns; $i++) {
		$copy[$i] = $vec_ref->[$i]->copy();
	}
	return \@copy;
}

sub copy_matrix {
	my $arr_ref = shift;
	my @copy;
	for (my $i=1; $i<=$Ns; $i++) {
		$copy[$i] = {};
		foreach my $n (keys %{$arr_ref->[$i]}) {
			$copy[$i]->{$n} = $arr_ref->[$i]->{$n}->copy();
		}
	}
	return \@copy;
}

sub matrix_diff {
	my $next_ref = shift;
	my $prev_ref = shift;
	my @copy;
	for (my $i=1; $i<=$Ns; $i++) {
		$copy[$i] = {};
	}
	for (my $i=1; $i<=$Ns; $i++) {
		for (my $j=1; $j<=$Ns; $j++) {
			if (exists $next_ref->[$i]->{$j}) {
				$copy[$i]->{$j} = $next_ref->[$i]->{$j}->copy();
			}
			if (exists $prev_ref->[$i]->{$j}) {
				if (exists $copy[$i]->{$j}) {
					$copy[$i]->{$j} -= $prev_ref->[$i]->{$j}->copy();
				} else {
					$copy[$i]->{$j} = $prev_ref->[$i]->{$j}->copy()->bneg();
				}
			}
		}
	}
	return \@copy;
}

sub matrix_mult {
	my $l_ref = shift;
	my $r_ref = shift;
	my @copy;
	for (my $i=1; $i<=$Ns; $i++) {
		$copy[$i] = {};
	}
	for (my $i=1; $i<=$Ns; $i++) {
		for (my $j=1; $j<=$Ns; $j++) {
			foreach my $n (keys %{$l_ref->[$i]}) {
				if (exists $r_ref->[$n]->{$j}) {
					$copy[$i]->{$j} += $l_ref->[$i]->{$n}->copy() * $r_ref->[$n]->{$j}->copy();
				}
			}
		}
	}
	return \@copy;
}

sub dump_map {
	my $arr_ref = shift;
	$, = " ";
	for (my $i=1; $i<=$Ns; $i++) {
		print "$i => ";
		foreach my $n (keys %{$arr_ref->[$i]}) {
			print "$n ";
		}
		print "\n";
	}
}
	

sub invert_next_iter {
	my $init_ref = shift;
	my $arr_ref = shift;
	my @next;
	for (my $i=1; $i<=$Ns; $i++) {
		$next[$i] = {};
	}

	return \@next;
}


sub matrix_invert {
	my $arr_ref = shift;
	my @init;
	# get initial matrix
	my $l1 = get_l1_norm($arr_ref);
	for (my $i=1; $i<=$Ns; $i++) {
		$init[$i] = {};
	}
	for (my $i=1; $i<=$Ns; $i++) {
		foreach my $n (keys %{$arr_ref->[$i]}) {
			$init[$n]->{$i} = $arr_ref->[$i]->{$n}->copy();
			$init[$n]->{$i} /= $l1->copy();
		}
	}
	my $f_norm = Math::BigRat->new("1");
	my $iters = 0;
	my $thresh = Math::BigRat->new("1/10");
	$thresh->bpow(10);
	say "";
	say "$thresh";
	while ($iters < 10 && $f_norm > $thresh) {
		$iters++;
		say "Invert round: $iters";
		my $mult = matrix_mult($arr_ref,\@init);
		my @inter;
		for (my $i=1; $i<=$Ns; $i++) {
			$inter[$i] = {};
		}
		for (my $i=1; $i<=$Ns; $i++) {
			foreach my $n (keys %{$mult->[$i]}) {
				if ($n == $i) {
					$inter[$i]->{$n} = Math::BigRat->new("2");

				} else {
					$inter[$i]->{$n} = Math::BigRat->new("0");
				}
				$inter[$i]->{$n} -= $mult->[$i]->{$n}->copy(); 
			}
		}
		my $next_ref = matrix_mult(\@inter,\@init);
		my $diff = matrix_diff($next_ref,\@init);
		$f_norm = get_f_norm($diff);
		say "Fnorm of diff: ",$f_norm->as_float(12);
		for (my $i=1; $i<=$Ns; $i++) {
			foreach my $n (keys %{$next_ref->[$i]}) {
				$init[$i]->{$n} = $next_ref->[$i]->{$n}->copy();
			}
		}
	}	
}

sub initialize_probs {
	my $init_val = Math::BigRat->new(1/$Ns);
	say "Initial uniform probability: " . $init_val->as_float(12);
	for (my $i = 1; $i <= $Ns; $i++) {
		$half_prob[$i] = $init_val->copy();
		$even_prob[$i] = $init_val->copy();
	}
}

sub initialize_states {
	for (my $i = 1; $i <= $Ns; $i++) {
		$half_init_state[$i] = {};
		$even_init_state[$i] = {};
		my @adj = @{build_adjacent_list($i)};
		my $count = scalar @adj;
		foreach my $n (@adj) {
			$even_init_state[$i]->{$n} = Math::BigRat->new("1/$count");
			if ($i == $n) {
				$half_init_state[$i]->{$n} = Math::BigRat->new("1/2");
			} else {
				my $den = 2 * ($count - 1);
				$half_init_state[$i]->{$n} = Math::BigRat->new("1/$den");
			}
		}
	}
	say "Initialized State Transition Matricies";
}

sub get_inverse_iterators {
	for (my $i = 1; $i <= $Ns; $i++) {
		$half_iter[$i] = {};
		$even_iter[$i] = {};
		foreach my $n (keys %{$half_init_state[$i]}) {
                        if ($n == $i) {
                                $half_iter[$i]->{$n} = $half_init_state[$i]->{$n}->copy() - 1;
                        } else {
                                $half_iter[$i]->{$n} = $half_init_state[$i]->{$n}->copy();
                        }
		}
		foreach my $n (keys %{$even_init_state[$i]}) {
                        if ($n == $i) {
                                $even_iter[$i]->{$n} = $even_init_state[$i]->{$n}->copy() - 1;
                        } else {
                                $even_iter[$i]->{$n} = $even_init_state[$i]->{$n}->copy();
                        }
		}
	}
	
	matrix_invert(\@half_iter);
	matrix_invert(\@even_iter);

	say "Found Inverse Iterators";
}

sub main {
	# initialize uniform probability vectors
	initialize_probs();
	# initialize state vectors
	initialize_states();

	print "init = [";
	for (my $i = 1; $i <= $Ns; $i++) {
		print "$half_prob[$i]";
		if ($i != $Ns) { print "; "; }
	}
	print "]\n";

	# print out half 
	print "half = [";
	for (my $i = 1; $i <= $Ns; $i++) {
		for (my $j = 1; $j <= $Ns; $j++) {
			if (exists $half_init_state[$i]->{$j}) {
				print "$half_init_state[$i]->{$j}";
			} else {
				print "0";
			}
			if ($j == $Ns) {
				print ";\n";
			} else {
				print " ";
			}

		}
	}
	print "]\n";
	# print out even
	print "even = [";
	for (my $i = 1; $i <= $Ns; $i++) {
		for (my $j = 1; $j <= $Ns; $j++) {
			if (exists $even_init_state[$i]->{$j}) {
				print "$even_init_state[$i]->{$j}";
			} else {
				print "0";
			}
			if ($j == $Ns) {
				print ";\n";
			} else {
				print " ";
			}

		}
	}
	print "]\n";
	# get inverse iteration matrix
	#get_inverse_iterators();
	# inverse iterate to convergence
	# report answer
}

main();
