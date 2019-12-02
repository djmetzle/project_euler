#!/usr/bin/perl

use warnings;
use strict;
use v5.10;
use POSIX;

our $filename = 'base_exp.txt';

our @bases;
our @exps;

our $N;

sub read_in_lines {
	open(my $fh, '<:encoding(UTF-8)', $filename)
		or die "Could not open file '$filename' $!";

	my $n = 1;	
	while (my $row = <$fh>) {
		chomp $row;
		(my $base, my $exp) = split ',', $row;
		#say "$base :: $exp";
		$bases[$n] = $base;
		$exps[$n] = $exp;
		$n++;
	}
	$N = $n - 1;
}

sub search {
	my $max_i = 1;
	for (my $i=2;$i<=$N;$i++) {
		my $rbase = $bases[$max_i];
		my $rexp = $exps[$max_i];
		my $lbase = $bases[$i];
		my $lexp = $exps[$i];
		if (($lexp * log($lbase)) > ($rexp * log($rbase))) {
			say "Found new max_i: $i";
			$max_i = $i;
		}
	}
	return $max_i;
}


sub main {
	read_in_lines();
	say "Found $N lines";
	say "Found max: ", search();
}


main();
