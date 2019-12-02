#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 75

#our $N = 50; # test case

our $N = 1500000;

sub relatively_prime {
        my $a = shift;
        my $b = shift;
        return ($a<$b) ? relatively_prime($b, $a) : !($a % $b) ? ($b==1) : relatively_prime($b, $a % $b);
}

our %triple_count;

sub generate_all_triples {
	for (my $n=1; $n*$n <= $N; $n++) {
		for (my $m=$n+1; $m*$m <= $N; $m++) {
			if (!relatively_prime($n,$m)) {
				next;
			}
			if ( ($n % 2 != 0) &&  ($m % 2 != 0) ) {
				next;
			}
			for (my $k=1; 2*$k*$m*$n <= $N; $k++) {
				my $a = $k * ( $m*$m - $n*$n);
				my $b = 2 * $k * $m * $n; 
				my $c = $k * ( $m*$m + $n*$n );
				my $length = $a + $b + $c;
				if (!exists $triple_count{$length}) {
					$triple_count{$length} = 0;
				}
				#say "$length  = $a $b $c";
				$triple_count{$length} += 1;
			}
		} 
	} 
}

sub count_singles {
	my $count = 0;
	$, = ' ';
	say keys %triple_count;
	foreach my $key (keys %triple_count) {
		if ($key > $N) { next; }
		if ($triple_count{$key} == 1) {
			$count++;
		}
	}
	say "ANS: $count";
}

sub main {
	generate_all_triples();
	count_singles();
}

main();
