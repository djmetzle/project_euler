#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 62

#our $N = 100; # test case
our $N = 1e7;

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

sub relatively_prime {
        my $a = shift;
        my $b = shift;
        return ($a<$b) ? relatively_prime($b, $a) : !($a % $b) ? ($b==1) : relatively_prime($b, $a % $b);
}

sub totient {
        my $n = shift;
	if ($n == 1) { return 1; }
	if (is_prime($n)) {
		return $n-1;
	}
	if ($n % 2 == 0) {
		my $m = $n >> 1;
		return !($m & 1) ? totient($m) << 1 : totient($m);
	}
	my $result = $n;
	for (my $p=2; $p*$p <= $n; ++$p) {
		if ($n % $p == 0) {
			while ($n % $p == 0) {
				$n /= $p;
			}
			$result -= $result / $p;
		}

	}
	if ($n>1) {
		$result -= $result / $n;
	}
        return $result;
}

sub compare_perms {
	my $nref = shift;
	my $mref = shift;
        for (my $i=0;$i<10;$i++) {
		if ($nref->[$i] != $mref->[$i]) {
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

our $min_rat = $N;
our $min_n = 1;

sub tot_rat {
	my $n = shift;
	my $tot = shift;
	return 1.0 * $n / $tot;
}


sub main {
	for (my $i=2;$i<$N;$i++) {
		my $tot = totient($i);
		my $n_digits = count_digits($i);
		my $tot_digits = count_digits($tot);
		my $rat = tot_rat($i,$tot);
		if ($rat >= $min_rat) {
			next;
		}
		if (compare_perms($n_digits,$tot_digits)) {
			say "Found perm: $i";
			$min_rat = $rat;
			$min_n = $i;
		}
	}
}

main();
