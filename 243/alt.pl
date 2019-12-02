use warnings;
use strict;
use POSIX;
use v5.10;

use Math::BigRat;

our $threshold = Math::BigRat->new("15499/94744");
#our $threshold = Math::BigRat->new("4/10");

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
	push @primes, $search;
}

sub check_resiliance {
	my $n = shift;
	my $res_count = 0;
	for (my $i=1;$i<$n;$i++) {
		my $frac = Math::BigRat->new("$i/$n");
		$frac->bnorm();
		if ($frac->numerator() == $i) {
			$res_count++;
		}
	}
	return $res_count;
}

sub main {
	find_next_prime();
	say "Find: ", $threshold;
	my $n = 2;
	my $prime = 1;
	my $res = Math::BigRat->new("1");
	while ($res >= $threshold) {
		my $n = Math::BigRat->new("2");
		for (my $i=1; $i<(scalar @primes); $i++) {
			$n *= $primes[$i];
		}
		my $res_count = check_resiliance($n);
		my $den = $n - 1;
		my $cur_res = Math::BigRat->new("$res_count/$den");
		if ($cur_res < $res) {
			say "$n : Found new Res: $cur_res";
			$res = $cur_res;
		}
		find_next_prime();
	}
	say "$n Res: ", $res;
}

main();
