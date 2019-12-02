use POSIX;

$, = ':';

sub is_prime {
        my $n = shift;
	if ($n <= 2) { return 0; }
        my $max = sqrt($n);
        my $N = floor($max);
        for (my $i=3; $i<=$N; $i+=2) {
                if (($n % $i) == 0) { return 0; }
        }
        return 1;
}

our @digits = ();
our @indicies = ();  
our $N_digits = 1;

sub test_case {
	my $count = 0;
	my @copy_digits = @digits;	
	for (my $n=0; $n<10; $n++) {
		foreach $i (@indicies) {
			$copy_digits[$i] = $n;
		}
		print join('',@copy_digits),"\n";
	}
}


sub main {
	my $N = 0;
	while ($N < 3) {
		$N++;
		print "Number of Digits: $N\n";
		for ($D = 1; $D <= $N; $D++) {		
			print "Number of Digit Substitutions: $D\n";
			@indicies = ();
			for ($pos = 1; $pos <= $D; $pos++) {
				push @indicies, $pos; 
			}
			print @indicies,"\n";
		}
	}	

}

main();
