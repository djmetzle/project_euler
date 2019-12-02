#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 71

sub fac {
	my $x = shift;
	if ($x == 0) { return 1; }
	my $prod = $x;
	for (my $i=1;$i<$x;$i++) {
		$prod *= $i;
	}
	return $prod;
}

sub fac_sum {
	my $n = shift;
	my $sum = 0;
	my @digits = split '', "$n";
	foreach my $d (@digits) {
		my $fac = fac($d);
		$sum += $fac;
	}
	return $sum;
}

sub test_chain {
	my $n = shift;
	my %values;
	my $next = $n;
	my $length = 0;
	while (1) {
		if(exists $values{$next}) {
			#say "Found repeat: $next after $length";
			last;
		}
		$values{$next} = 1;
		$next = fac_sum($next);
		#say "Next :$next";
		$length++;
	}
	#say "$n : Length: $length";
	return $length;
}

sub main {
	my $N = 1e6;
	my $count = 0;
	for (my $i=1;$i<$N;$i++) {
		my $length = test_chain($i);
		if ($length > 60) {
			say "Something's wrong";
		}
		if ($length == 60) {
			$count++;
			say "$i";
		}
	}
	say "ANS: $count";
}

main();
