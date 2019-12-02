$N=300300;
my $max_count = 0;
while ($N) {
	$N++;
	$count = 0;
	for ($x = $N+1; $x <= 2*$N; $x++) {
		$rem = ($N*$x) % ($x-$N);
		if ( $rem == 0 ) { $count++; }
	}
	if ($count > $max_count) {
		print "$N : $count\n";
		$max_count = $count;
	}
	if ($count > 1000000) { print "Solution!: $N\n";}
}
