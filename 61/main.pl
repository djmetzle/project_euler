#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 61

our $N = 3; # test case
our $N = 6;

our %numbers;

our %chains;

our @possibles;

sub f_poly {
	my $s = shift;
	my $n = shift;
	my $f = $n + ($s-2)*$n*($n-1)/2;
	return $f;
}

sub populate_hash {
	for (my $s = 3; $s < 3+$N; $s++) {
		$numbers{$s} = {};
		my $n = 1;
		my $fn = 1;
		while ($fn < 10000) {
			$numbers{$s}->{$fn} = 1;
			$n++;
			$fn = f_poly($s,$n);
		}
	}
	say "Populated Arrays";
}

sub populate_chains {
	my $count = 0;
	for (my $s = 3; $s < 3 + $N; $s++) {
		print "$s ::";
		foreach my $el (keys %{$numbers{$s}}) {
			if ($el < 1000) { next; }
			my $substr = substr "$el", 2,2;
			for (my $t = 3; $t < 3 + $N; $t++) {
				if ($s == $t) { next; }
				foreach my $oel (keys %{$numbers{$t}}) {
					if ($oel < 1000) { next; }
					my $osubstr = substr "$oel", 0,2;
					if ($substr eq $osubstr) {
						#say "$el : $substr :: $oel : $osubstr";
						$count++;
						if (!exists $chains{$el}) {
							$chains{$el} = {};
						}
						$chains{$el}->{$oel} = 1;
					}
				}
			}

		}
		print "\n";
	}
	say "Count: $count";
}

our %sum_list;

sub validate {
	my $arr_ref = shift;
	say "Validate: ", @{$arr_ref};
	my $sum = 0;

        my %counts;
        for (my $s=3; $s<3+$N; $s++) {
                $counts{$s} = 0;
                foreach my $r (@{$arr_ref}) {
                        if (exists $numbers{$s}->{$r}) {
                                $counts{$s} += 1;
                        }
                }
		if ($s % 3 != 0) {
			if ($counts{$s} != 1) {
				return 0;
			}
		}
        }

	foreach my $el (@{$arr_ref}) {
		$sum += $el;
	}
	say "SUM: $sum";
	$sum_list{$sum} = 1;
}

sub search {
	my $arr_ref = shift;
	my $depth = shift;
	my $el = shift;
	my $search = shift;
	foreach my $next (%{$chains{$el}}) {
		$arr_ref->[$depth] = $next;
		if ($depth < $N - 1) {
			my $ret = search($arr_ref, $depth+1,$next,$search);
			if ($ret) { say "$ret"; }
		} else {
			if ($search == $next) {
				my $true = validate($arr_ref);
				return $el;
			}
		}
	}
}

sub build_possibles {
	foreach my $el (keys %chains) {
		my @array;
		if (search(\@array,0,$el,$el)) {
			say @array;
		}
	}
}

sub main {
	$, = " ";
	populate_hash();
	populate_chains();
	build_possibles();
	say "SUM_LIST: ", keys %sum_list;
}

main();
