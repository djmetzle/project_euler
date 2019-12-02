#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 71

sub farey {
	my $n = shift;
	my $a = 0;
	my $b = 1;
	my $c = 1;
	my $d = $n;
	say "$a / $b";
	while ($c <= $n) {
		my $val = ($n + $b) / $d;
		my $k = int($val);
		my $a_temp = $c;
		my $b_temp = $d;
		$c = $k*$c - $a;
		$d = $k*$d - $b;
		if (($a_temp == 3) && ($b_temp == 7)) {
			say "ANS: $a";
		}
		$a = $a_temp;
		$b = $b_temp;
	}
}

sub main {
	farey(1e6);
}

main();
