use v5.10;
use warnings;
use strict;
use POSIX;

sub det {
	my $ux = shift;
	my $uy = shift;
	my $vx = shift;
	my $vy = shift;
	return $ux*$vy - $uy*$vx;
}

sub solve_a {
	my $v0x = shift;
	my $v0y = shift;
	my $v1x = shift;
	my $v1y = shift;
	my $v2x = shift;
	my $v2y = shift;

	my $num = -1.0 * det($v0x, $v0y, $v2x, $v2y);
	my $den = det($v1x,$v1y,$v2x,$v2y);

	return $num / $den;
}

sub solve_b {
	my $v0x = shift;
	my $v0y = shift;
	my $v1x = shift;
	my $v1y = shift;
	my $v2x = shift;
	my $v2y = shift;

	my $num = 1.0 * det($v0x, $v0y, $v1x, $v1y);
	my $den = det($v1x,$v1y,$v2x,$v2y);

	return $num / $den;
}

sub validate {
	my $a = shift;
	my $b = shift;
	if (($a <= 0.0) || ($b <= 0.0)) { 
		return 0;
	}
	if ( $a + $b >= 1.0 ) {
		return 0;
	}
	return 1;
}

sub main {
	my $filename = 'triangles.txt';
	open(my $fh, '<:encoding(UTF-8)', $filename)
		or die "Could not open file '$filename' $!";

	my $counter = 0;
	while (my $row = <$fh>) {
		chomp $row;
		($v0x, $v0y, $v1x, $v1y, $v2x, $v2y) = split(',', $row);
		# express v1 and v2 as vectors from v0
		$v1x -= $v0x;
		$v1y -= $v0y;
		$v2x -= $v0x;
		$v2y -= $v0y;
		my $a = solve_a($v0x, $v0y,$v1x,$v1y,$v2x,$v2y);
		my $b = solve_b($v0x, $v0y,$v1x,$v1y,$v2x,$v2y);
		if (validate($a,$b)) {
			$counter++;
		}
	}
	say("Found Interoir: $counter");
}

main();
