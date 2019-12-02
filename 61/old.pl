#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 61

our $N = 3; # test case
#our $N = 6;

our %numbers;
our @search;

sub f_poly {
	my $s = shift;
	my $n = shift;
	my $f = $n + ($s-2)*$n*($n-1)/2;
	return $f;
}

sub populate_hash {
	for (my $s = 3; $s <=8; $s++) {
		$numbers{$s} = {};
		my $n = 1;
		my $fn = 1;
		while ($fn < 10000) {
			$fn = f_poly($s,$n);
			$numbers{$s}->{$fn} = 1;
			$n++;
		}
	}
	say "Populated Arrays";
}

sub init_search {
	for (my $i=3; $i<3+$N; $i++) {
		push @search, 10;
	}
}

sub validate_unique {
	for (my $i=0; $i<$N; $i++) {
		for (my $j=$i+1; $j<$N; $j++) {
			if ($search[$i] == $search[$j]) {
				return 0;
			}
		}
	}
	return 1;
}

sub validate_types {
	my @ring;
	for (my $i=0; $i<$N; $i++) {
		push @ring, int($search[($i-1)%$N].$search[$i]);
	}
	my %counts;
	for (my $s=3; $s<3+$N; $s++) {
		$counts{$s} = 0;
		foreach my $r (@ring) {
			if (exists $numbers{$s}->{$r}) {
				$counts{$s} += 1;
			}
		}
		if ($counts{$s} != 1) {
			return 0;
		}
	}
	return 1;
}

sub validate {
	#foreach my $i (@ring) { say $i; }
	if (!validate_unique()) {
		return 0;
	}
	if (!validate_types()) {
		return 0;
	}

	return 1;
}

sub inc_search {
	for (my $i=0; $i<$N; $i++) {
		if ($i == $N - 1) { say "Inc Last"; }
		$search[$i] += 1;
		if ($search[$i] < 100) {
			return;
		}
		$search[$i] = 10;
	}
}

sub main {
	for (my $i=1; $i<6;$i++) { say f_poly(8,$i); }
	populate_hash();
	init_search();
	while (!validate()) {
		inc_search();
	}
	my @ring;
	for (my $i=0; $i<$N; $i++) {
		push @ring, $search[($i-1)%$N].$search[$i];
	}
	foreach my $i (@ring) { say $i; }
}

main();
