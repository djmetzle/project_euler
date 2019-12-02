use POSIX;
use v5.10;

# Project Euler Problem 66

$, = ':';

sub validate {
	my $x = shift;
	my $y = shift;
	my $D = shift;
	if (($x*$x - $D * $y*$y) == 1) {
		say "$x^2 - $D * $y^2 = 1 !!!";
		return 1;
	}
	return 0;
}

sub search {
	my $D = shift;
	my $x = 1;
	while ($x) {
		say "Search $x...";
		$ys = ($x*$x - 1)/($D * 1.0);
		if ($ys == 0) { $x++; next; }
		$yr = sqrt($ys);
		if ($yr == int($yr)) {
			$y = int($yr);
			if (validate($x,$y,$D)) {
				say "Found: $x $y $D";
				return $x;
			}
		}
		$x++;
	}
}

our $searchN = 1000;
our $minimum = 0;

sub main {
	search: for (my $d = 2; $d <= $searchN; $d++) {
		say "Search $d";
		if ( sqrt($d) == int(sqrt($d)) ) {
			say "Found square $d";	
			next search;
		}
		for (my $i=2;$i * $i < $d; $i++) {
			if ($i*$i == $d) {
				say "Found square $d";	
				next search;
			}
		}
		$ret = search($d);
		say "Found $ret";
		if ($ret > $minimum) {
			say "Found new largest! : $ret";
			$minimum = $ret;
		}
	}
	say '==================================';
	say "Largest X found: $minimum";
	say '==================================';
}

main();
