$N=1;
while ($N) {
	$N++;
	$count = 0;
	for ($x = $N+1; $x <= 2*$N; $x++) {
		$rem = ($N*$x) % ($x-$N);
		if ( $rem == 0 ) { $count++; }
	}
	print "$N : $count\n";
	if ($count > 1000) { print "Solution!: $N\n";}
}
