use bignum;

%cache = ();

sub f_k {
	my $k = shift;
	my $n = shift;

	if ($n == 0) { return 1; }

	my $sum = 0;

	for (my $i=0; $i<= $n; $i++) {
		my $div = $i / $k;
		my $arg = $div->bfloor();
		if (exists $cache{$arg}) {
			$sum += $cache{$arg};
		} else {
			print "Cache miss $i : $arg\n";
			my $ret = f_k($k,$arg);
			$cache{$arg} = $ret;
			$sum += $ret;	
		}
	}
	return $sum;
}

#print "f_k(5,10) : ", f_k(5,10),"\n";
#print "f_k(7,100) : ", f_k(7,100),"\n";
#print "f_k(2,1000) : ",f_k(2,1000),"\n";

$bigsum = 0;

print "Start working...\n";
for (my $x=2;$x<=10;$x++) {
	print "On step $x\n";
	%cache = ();
	$bigsum += f_k($x,10e14);	
}

print $bigsum,"\n";
print $bigsum->bmod(10e9 + 7),"\n";
