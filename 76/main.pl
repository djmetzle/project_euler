#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 76

#our $N = 5; # test case
our $N = 100;

sub way_count {
	my $n = shift;
	my @ways;
	$ways[0] = 1;
	for (my $i = 1; $i < $n; $i++) {
		for (my $j = $i; $j <= $n; $j++) {
			$ways[$j] += $ways[$j-$i];
		}
	}
	return $ways[$n];
}

sub main {
	say way_count($N);
}

main();
