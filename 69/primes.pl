use POSIX;
use v5.10;

# Project Euler Problem 69

# This _shouldn't_ work.
# The answer ought to be some composite, not just a product of primes.
# Oh well. Green checkmark.

$, = ':';

our $N = 1000000;

# memoize
our %primes = ();
sub is_prime {
        my $n = shift;
	if (exists $primes{$n} ) { return $primes{$n}; }
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
	my $last = $primes[$#primes] + 2;
	for (my $i = $last; $i; $i += 2) {
		if (is_prime($i)) {
			say "Found Prime: $i";
			push @primes, $i;
			return;
		}
	}
}

our @primes = (2,3,5,7,11);

sub main {
	while ($primes[$#primes] < $N) {
		find_next_prime();
	}
	my $prod = 1;
	my $index = 0;
	while (1) {
		if ($prod * $primes[$index] > $N) {
			last;
		}
		$prod *= $primes[$index++];
	}
	say "Prod: $prod";
}

main();

