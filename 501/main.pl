use bignum;

our $CASE = 1e3;

our @primes = (2);

sub is_prime {
	my $n = shift;
	my $max = $n->bsqrt();
	my $N = $max->bceil();
	for (my $i=3; $i<=$N; $i+=2) {
		if (($n % $i) == 0) { return 0; }
	}
	return 1;
}

sub find_primes {
	for ($i = 3; $i <= ($CASE / 2); $i+=2) {
		if (is_prime($i)) { 
			print "Prime Found: $i\n";
			push @primes, $i; 
		}
	}
	return;
} 

sub main {
	print "Finding Primes for $CASE\n";
	find_primes();
	print "Primes Found\n";
	my $count = 0;
	# check powers of 3
	foreach $a (@primes) {
		foreach $b (@primes) {
			if ($a >= $b) { next; } 
			if ($a * $a * $a * $b <= $CASE) { $count++; }
			if ($b * $b * $b * $a <= $CASE) { $count++; }
		}
	}
	foreach $a (@primes) {
		foreach $b (@primes) {
			foreach $c (@primes) {
				if ( ($b >= $c) or ($a >= $b) ) {  next; }
				if ($a * $b * $c <= $CASE) { $count++; }
			}
		}
	}
	# check the rest
	print "Found $count\n";
}



main();
