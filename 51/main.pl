#!/usr/bin/perl

use warnings;
use strict;
use POSIX;
use v5.10;

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


our $Family = 0;
our $smallest = 0;

sub find_family {
	my $ref = shift;
	my $N = scalar @{$ref};
	my $size = 0;
	my @temp;
	foreach my $val (@{$ref}) {
		push @temp, $val;
	}
	my $subcount = 0;
	for (my $j=0; $j<$N; $j++) {
		if ($ref->[$j] == -1) {
			$subcount+=1;
		}
	}
	if ($subcount == 0) {
		return 1;
	}

	# test substitutions
	subloop: for (my $i=0; $i<10; $i++) {
		# copy i (sub var) to star positions
		for (my $j=0; $j<$N; $j++) {
			if ($ref->[$j] == -1) {
				if ($j==0 && $i==0) {
					next subloop;
				}
				$temp[$j] = $i;
			}
		}
		my $str = int(join('', @temp));
		if (is_prime($str)) {
			#say "Found prime: $str";
			$size++;
		}
	}

	return $size;
}

sub print_smallest {
	my $ref = shift;
	my $N = scalar @{$ref};
	my @temp;
	foreach my $val (@{$ref}) {
		push @temp, $val;
	}
	subloop: for (my $i=0; $i<10; $i++) {
		for (my $j=0; $j<$N; $j++) {
			if ($ref->[$j] == -1) {
				if ($i==0) {
					next subloop;
				}
				$temp[$j] = $i;
			}
		}
		my $str = int(join('', @temp));
		if (is_prime($str)) {
			return $str;
		}
	}
}

sub init_size {
	my $size = shift;
	my @ret;
	for (my $i=0;$i<$size;$i++) {
		push @ret, -1;
	}
	return \@ret;
}

sub inc_search {
	my $ref = shift;
	my $pos = shift;
	my $N = scalar @{$ref};
	my $i = $N - $pos - 1;
	#say "INC $i in : ", @{$ref};
	if ($pos == 0) {
		$ref->[$i] += 2;
	} else {
		$ref->[$i] += 1;
	}
	if ($ref->[$i] > 9) {
		if ($pos+1 == $N) {
			return 0;
		}
		$ref->[$i] = -1;
		my $return = inc_search($ref,$pos+1);
		if (!$return) { return 0; }
	}
	return 1;
}

sub main {
	my $test = [ -1, 3];
	my $size = find_family($test);
	say "Found Family sized: $size";
	my $num = print_smallest($test);
	say "Found number: $num";
	$, = ' ';
	my $search_size = 1;
	do {
		$search_size++;
		my $ref = init_size($search_size);
		do {
			my $size = find_family($ref);
			if ($size > $Family) {
				my $num = print_smallest($ref);
				say "Found new largest!";
				$Family = $size;
				say "SIZE: $size :: NUM: $num";

			}
		} while (inc_search($ref,0));
	} while ($Family < 8);
}

main();
