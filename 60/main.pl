use POSIX;
use v5.10;

# Project Euler Problem 60

$, = ':';

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
	my $N = scalar @primes;
	my $last = $primes[$N-1] + 2;
	for (my $i = $last; $i; $i += 2) {
		if (is_prime($i)) {
			say "Found Prime: $i";
			push @primes, $i;
			return;
		}
	}
}

# recusive to search indicies through primes
sub next_index {
	my $index = shift;
	#say "next_index: $index";
	$indicies[$index]++;
	if ($index == $N - 1) {
		say "Inc Last Index: $indicies[$index]";

		find_next_prime();
		return;
	}
	if ($indicies[$index] == $indicies[$index+1]) {
		if ($index == 0) {
			$indicies[$index] = 0;
		} else {
			$indicies[$index] = $indicies[$index - 1] + 1;
		}
		next_index($index+1);
	}
}


sub mark_bad_pair {
	my $i = shift;
	my $j = shift;
	my $i_p = $indicies[$i];
	my $j_p = $indicies[$j];
	if (!exists($bad_pairs[$i_p])) {
		$bad_pairs[$i_p] = {};
	}
	$bad_pairs[$i_p]->[j_p] = 1;
}

sub check_bad_pair {
	my $i = shift;
	my $j = shift;
	my $i_p = $indicies[$i];
	my $j_p = $indicies[$j];
	if ($bad_pairs[$i_p]->[$j_p]) {
		return 1;
	}
	return 0;
}

# memoize
our %bad_pairs;
sub validate {
	for (my $i =0; $i < $N - 1; $i++) {
		for (my $j = $i + 1; $j < $N; $j++) {
			if (check_bad_pair($i,$j)) {
				return $i;
			}
		}
	}
	# for each pair
	for (my $i =0; $i < $N - 1; $i++) {
		for (my $j = $i + 1; $j < $N; $j++) {
			$p1 = $primes[$indicies[$i]];
			$p2 = $primes[$indicies[$j]];
			$t1 = int($p1.$p2);
			$t2 = int($p2.$p1);
			if (!is_prime($t1)) { 
				mark_bad_pair($i,$j);
				return $i;
			}
			if (!is_prime($t2)) { 
				mark_bad_pair($i,$j);
				return $i;
			}
		}
	}
	return -1;
}

our @primes = (2,3,5,7,11);

our @indicies = (0,1,2,3,4);

our $max_prime = 0;

our $N = 5;

sub main {
	while (1) {
		#say @indicies;
		my $bad = validate();
		if ($bad == -1) {
			say "Found Solution!";
			for (my $i = 0; $i < $N; $i++) {
				say "$i : $primes[$indicies[$i]]";
			}
			return;
		}
		next_index($bad);
	}
}

main();

