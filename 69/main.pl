use warnings;
use strict;
use POSIX;
use v5.10;

our $SEARCH = 1000000;

sub relatively_prime {
	my $a = shift;
	my $b = shift;
	return ($a<$b) ? relatively_prime($b, $a) : !($a % $b) ? ($b==1) : relatively_prime($b, $a % $b);
}

sub totient { 
	my $n = shift;
	my $count = 0;
	for (my $i=1;$i<$n;$i++) {
		if (relatively_prime($n,$i)) {
			$count++;
		}
	}
	say "Totient: $n :: $count";
	return $count;	
}


our $max_rat = 0;
our $max_totient = 0;
our $max_n;

sub main {
	for (my $i = $SEARCH; $i>1; $i-=2) {
		my $tot = totient($i);
		my $rat = 1.0 * $i / $tot;
		if ($rat > $max_rat) {
			say "Found New Max: $i :: $tot :: $rat";
			$max_totient = $tot;
			$max_n = $i;
			$max_rat = $rat;
		}

	}
	say "Max: $max_n :: $max_totient :: $max_rat";
}

main();
