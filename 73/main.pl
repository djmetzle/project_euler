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
	my $count = 0;
	my $counting = 0;
	while ($c <= $n) {
		my $val = ($n + $b) / $d;
		my $k = int($val);
		my $a_temp = $c;
		my $b_temp = $d;
		$c = $k*$c - $a;
		$d = $k*$d - $b;
		$a = $a_temp;
		$b = $b_temp;
		if (($a == 1) && ($b == 2)) {
			say "ANS: $count";
			exit();
		}
		if ($counting) {
			if ($count % 1000 == 0) {
				say "$count";
			}
			$count++;
		}
		if (($a == 1) &&  ($b == 3)) {
			say "Start counting";
			$counting = 1;
		}
	}
}

sub main {
	farey(12000);
}

main();
