#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 77

our @primes = (2,3);

#memoized
our %primes = ();
sub is_prime {
        my $n = shift;
        if (exists $primes{$n}) {
                return $primes{$n};
        }
        if ($n <= 2) { return 0; }
        if ($n % 2 == 0) {
                $primes{$n} = 0;
                return 0;
        }
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

sub find_next_prime {
        my $N = scalar @primes;
        my $search = $primes[$N-1];
        do {
                $search += 2;
        } while (!is_prime($search));
	say "Found new prime: $search";
        push @primes, $search;
}

sub inflate_primes {
	my $n = shift;
	while ($primes[$#primes] < $n) {
		find_next_prime();
	}
}

sub count_prime_reps {
	my $n = shift;
	my $ways = 0;
	if ($n < 2) { return 0; }
	if ($n == 2) { return 1; }
	if (is_prime($n)) {
		#	say "$n is prime";
		$ways++;
	}
	for (my $i = 0; $primes[$i] < $n; $i++) {
		my $p = $primes[$i];
		my $diff = $n - $p;
		if ($diff >= $p) { next; }
		$ways += count_prime_reps($diff);

	}
	return $ways;
}


sub calc_sum {
	my $n = shift;
	my $ways = 0;
	if ($n < 2) { return 0; }
	if ($n == 2) { return 1; }
	say "Calc sum: ",@primes;
	for (my $i = 0; $primes[$i] < $n; $i++) {
		my $p = $primes[$i];
		my $diff = $n - $p;
		if ($diff < $p) { next; }
		$ways += count_prime_reps($diff);
	}
	say "$n : $ways";
	return $ways;
}

#our $s = 5000;
our $s = 5000;

sub main {
	$, = ' ';
	for (my $i = 2; $i<=10; $i++) {
		if ($i % 1000 == 0) { say "I: $i"; }
		inflate_primes($i);
		say "Primes: ", @primes;
		my $ways = calc_sum($i);
		#if ($ways > $s) {
			say "$i: $ways";
			#last;
			#}
	}
}

main();
