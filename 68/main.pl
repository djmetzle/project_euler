#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 62

sub swap {
	my $arr_ref = shift;
	my $i = shift;
	my $j = shift;
	my $temp = $arr_ref->[$i];
	$arr_ref->[$i] = $arr_ref->[$j];
	$arr_ref->[$j] = $temp;
}

sub permute {
	my $arr_ref = shift;
	my $l = shift;
	my $r = shift;
	if ($l == $r) {
		#say @{$arr_ref};
	} else {
		for (my $i = 1; $i <= $r; $i++) {
			swap($arr_ref, $l, $i);
			permute($arr_ref, $l+1, $r);
			swap($arr_ref, $l, $i);
		}
	}
}

sub main {
	$, = ' ';
	my @array = (1,2,3,4,5,6,7,8,9,10);
	my $n = 10;
	permute(\@array,0,$n-1);

}

main();
