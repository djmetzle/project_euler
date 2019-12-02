#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 62

our %cubes;
our $current = 1;
our $current_cube = 1;
our $found_count = 0;

sub find_next {
	$current++;
	$current_cube = $current * $current * $current;
	$cubes{$current_cube} = count_digits($current_cube);
}

sub compare_perms {
	my $n = shift;
	my $m = shift;
	my @dn = @{$cubes{$n}};
	my @dm = @{$cubes{$m}};
	#say "n : $n :: m : $m";
	#say "Compare: n ", @dn;
	#say "Compare: m ", @dm;
	if (scalar @dn != scalar @dm) {
		return 0;
	}
	for (my $i=0;$i< scalar @dn;$i++) {
		if ($dn[$i] != $dm[$i]) {
			return 0;
		}
	}
	return 1;
}

sub count_digits {
	my $n = shift;
	my @array;
	for (my $i=0;$i<10;$i++) {
		$array[$i] = 0;
	}
	my @digits = split '', $n;
	for (my $i=0;$i< scalar @digits;$i++) {
		$array[$digits[$i]] += 1;
	}
	return \@array;
}

sub count_perms {
	my $count = 0;
	foreach my $o (keys %cubes) {
		if ($o == $current_cube) {
			next;
		}
		if (compare_perms($o,$current_cube)){
			$count++;
		}
	}
	return $count;
}

sub print_perms {
	foreach my $o (keys %cubes) {
		if ($o == $current_cube) {
			next;
		}
		if (compare_perms($o,$current_cube)){
			say "$o";
		}
	}
	return;
}

sub init {
	say "Init.";
	$cubes{1} = count_digits(1);
	$found_count+=1;
}

our $N = 5;

sub main {
	init();
	while ($found_count < $N - 1) {
		find_next();
		my $c = count_perms();
		if ($c > $found_count) {
			$found_count = $c;
			say "Found new greatest! $current_cube : $found_count";
		}
	}
	print_perms();
}

main();
