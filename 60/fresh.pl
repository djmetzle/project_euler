use POSIX;
use v5.10;

# Project Euler Problem 60

$, = ' ';

# memoize
our %prime_memo;
sub is_prime {
        my $n = shift;
	if (exists $prime_memo{$n} ) { return $prime_memo{$n}; }
	if ($n <= 2) { return 0; }
        if ($n % 2 == 0) {
                $prime_memo{$n} = 0;
                return 0;
        }
        my $max = sqrt($n);
        my $N = floor($max);
        for (my $i=3; $i<=$N; $i+=2) {
                if (($n % $i) == 0) { 
			$prime_memo{$n} = 0;
			return 0; 
		}
        }
	$prime_memo{$n} = 1;
        return 1;
}

sub find_next_prime {
	my $N = scalar @primes;
	my $last = $primes[$N-1] + 2;
	for (my $i = $last; $i; $i += 2) {
		if (is_prime($i)) {
			say "Found Prime: $i";
			push @primes, $i;
			return;
		}
	}
}


our @primes = (2,3,5,7,11);

our %pairs;

sub validate {
	my $i = shift;
	my $j = shift;
	my $i_p = $primes[$i];
	my $j_p = $primes[$j];
	$t1 = int($i_p.$j_p);
	$t2 = int($j_p.$i_p);
	if (!is_prime($t1)) {
		return;
	}
	if (!is_prime($t2)) {
		return;
	}
	if (!exists $pairs{$i}) {
		say "Created pairs[$i]";
		$pairs{$i} = {};
	}
	$pairs{$i}->{$j} = 1;
	return;
}

sub search_for_chain {
	my $N = shift;
	say "Find Chain of length: $N";
	my $cur = 0;
	my $index= (sort {$a <=> $b} keys %pairs)[$cur];
	my @indicies;
	push @indicies, $index;
	for (my $i=1; $i< $N; $i++) {
		my $val = $primes[$index];
		my $index_search = 0;
		my $next_index = (sort {$a <=> $b} keys %{$pairs{$index}})[$index_search];
		foreach my $vi (@indicies) {
			while (!$pairs{$vi}->{$index_search}) {
				$index_search++;
			}
		}	
		$next_index = (sort {$a <=> $b} keys %{$pairs{$index}})[$index_search];
		my $next_val = $primes[$next_index];
		say "$index: $val: $next_val";
		$index = $next_index;
	}
	#foreach my $p (sort {$a <=> $b} keys %pairs) {
	#}
}

our @chains;
sub generate_chains {
	foreach my $a (sort {$a <=> $b} keys %pairs) {
		foreach my $b (sort {$a <=> $b} keys %{$pairs{$a}}) {
			foreach my $c (sort {$a <=> $b} keys %{$pairs{$b}}) {
				if ($pairs{$a}->{$c}) {
					foreach my $d (sort {$a <=> $b} keys %{$pairs{$c}}) {	
						if (($pairs{$a}->{$d}) && ($pairs{$b}->{$d})) {
							foreach my $e (sort {$a <=> $b} keys %{$pairs{$d}}) {	
								if (($pairs{$a}->{$e}) && ($pairs{$b}->{$e}) && ($pairs{$c}->{$e})) {
									say "Found five chain: $a $b $c $d $e";

								}
							}
						}
					}
				}
			}
		}
	}

}


sub print_answer{
	my @ps = (5,691,750,867,1050);
	my $sum = 0;
	foreach my $p (@ps) {
		say "$p : ", $primes[$p];
		$sum += $primes[$p];
	}
	say "sum: $sum";
}



sub main {
	while (scalar @primes < 1200) {
		find_next_prime();
	}
	print_answer();
	exit();
	say "Populated Primes: ", scalar keys %prime_memo;
	for (my $i=0; $i < scalar @primes; $i++) {
		for (my $j=$i+1; $j< scalar @primes; $j++) {
			validate($i,$j);
		}
	}
	my $N = 4;
	#search_for_chain($N);
	generate_chains($N);
}

main();

