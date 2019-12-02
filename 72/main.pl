#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use POSIX;

# Project Euler Problem 62

#our $N = 8; # test case
our $N = 1e6;

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

sub main {
	my $size = 1;
	for (my $i=1;$i<=$N; $i++) {
		$size += totient($i);
	}
	$size -= 2; # dont count 0 and 1
	say "ANS: $size";
}

main();
