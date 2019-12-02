use POSIX;
use v5.10;

$, = ':';

our $N = 10;

our @convergent = ();

sub generate_convergent {
	my $N = shift;
	my $stop = 0;
	my $base = 2;
	while ($stop < $N) {
		my $value = 1;
		push @convergent, 1;
		$stop = scalar @convergent;
		if ($stop < $N) {
			push @convergent, $base;
		}
		$stop = scalar @convergent;
		if ($stop < $N) {
			push @convergent, 1;
		}
		$base *= 2;
		$stop = scalar @convergent;
	}

	return;
}

sub main {
	generate_convergent($N);
	say scalar @convergent . " :: ", @convergent;
}

main();
