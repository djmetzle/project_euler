use warnings;
use strict;
use POSIX;
use v5.10;

use Math::BigRat;

our $threshold = Math::BigRat->new("15499/94744");
#our $threshold = Math::BigRat->new("4/10");

sub check_resiliance {
	my $n = shift;
	my $res_count = 0;
	my $max = $n / 5;
	for (my $i=1;$i<$n;$i++) {
		if (relatively_prime($n,$i)) {
			$res_count++;
		}
		if ($res_count > $max) {
			say "Bail";
			return $n;
		}
	}
	return $res_count;
}

our @composites = (4,6,8,9,10,12,14,15,16,17,20,21,22,24,25,26,27,28,30);

our @primes = (2,3,5,7,11,13,17,19,23,29,31);
sub find_search_start {
	my $prod = $primes[0];
	for (my $i = 1; $i < (scalar @primes); $i++) {
		my $n = $prod * $primes[$i];
		say "$i: Check $n";
		my $res_count = check_resiliance($n);
		my $den = $n - 1;
		my $cur_res = Math::BigRat->new("$res_count/$den");
		if ($cur_res < $threshold) {
			say "Found search start: $prod";	
			return $prod;
		}
		$prod = $n;
	}
}

sub product_to {
	my $x = shift;
	my $prod = $primes[0];
	for (my $i = 1; $primes[$i] <= $x; $i++) {
		$prod *= $primes[$i];
	}
	return $prod;
}

sub relatively_prime {
	my $a = shift;
	my $b = shift;
	return ($a<$b) ? relatively_prime($b, $a) : !($a % $b) ? ($b==1) : relatively_prime($b, $a % $b);
}

sub find_gcd {
	
my $a = shift;
	my $b = shift;
	while ($b != 0) {
		my $r = $a % $b;
		$a = $b;
		$b = $r;
	}
	return $a;
}

sub check_resiliance_factor {
	my $n = shift;
	my $res_count = check_resiliance($n);
	my $den = $n - 1;
	my $cur_res = Math::BigRat->new("$res_count/$den");
	if ($cur_res < $threshold) {
		return 1;
	}
	return 0;	
}

sub main {
	say "Product up to 23: ", product_to(23);
	my $base = product_to(23);
	foreach my $c (@composites) {
		my $prod = $c * $base;
		say "$c: $prod";
		#if (check_resiliance_factor($prod)) {
		#	say "Found solution! $prod";
		#	exit;
		#}
	}
	say "Find: ", $threshold;
	my $n = 150150;	
	my $res = Math::BigRat->new("1");
	my $den = $n;
	while ($res >= $threshold) {
		$n+=10;
		my $res_count = check_resiliance($n);
		my $den = $n - 1;
		my $cur_res = Math::BigRat->new("$res_count/$den");
		if ($cur_res < $res) {
			say "$n : Found new Res: $cur_res";
			$res = $cur_res;
		}
	}
	say "$n Res: ", $res;
}

main();
