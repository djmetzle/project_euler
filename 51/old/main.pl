#!/usr/bin/perl

use v5.10;
use warnings;
use strict;
use POSIX;

# Project Euler Problem 51

$, = ':';

our $max_family = 0;

#memoized
our %primes = ();
sub is_prime {
        my $n = shift;
	if (exists $primes{$n}) {
		return $primes{$n};
	}
	if ($n <= 2) { return 0; }
        my $max = sqrt($n);
        my $N = floor($max);
        for (my $i=3; $i<=$N; $i+=2) {
                if (($n % $i) == 0) { 
			$primes{$n} = 0;
			return 0;
		}
        }
	$primes{$n} = 1;
        return 1;
}

sub search_space {
	my $width = shift;
	say "Search $n replacements";
	for (my $n=1; $n <= $width; $n++) {
		say "Search $n replacements";

	}

sub main {
	search_space(2);

}

main();
