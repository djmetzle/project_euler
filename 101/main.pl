use v5.10;
use warnings;
use strict;
use POSIX;

sub interpolate {
	(my $order, my $coeffs_ref) = @_;
	my $f_ref = shift;
	my @argCoeffs = @{$coeffs_ref};

	my @coeffs = ();

	return ($order,\@coeffs);
}

sub f_cube {
	my $x = shift;
	return $x*$x*$x;
}

sub f {
	my $x = shift;
	my $res = 1;
	$res -= $x;
	$res += $x**2;
	$res -= $x**3;
	$res += $x**4;
	$res -= $x**5;
	$res += $x**6;
	$res -= $x**7;
	$res += $x**8;
	$res -= $x**9;
	$res += $x**10;
	return $res;
}

sub main {
	my $orderCube = 3;
	my $orderF = 10;

	say "Run f cube test";
	for (my $i = 1; $i <= $orderCube; $i++) {
		say $i, " : ", f_cube($i);
	}

	say "Run f";
	for (my $i = 1; $i <= $orderF; $i++) {
		say $i, " : ", f($i);
	}
}

main();
