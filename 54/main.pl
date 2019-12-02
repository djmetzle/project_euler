$,=':';
open my $FH, '<', 'poker.txt' or die "open failed $!\m";

sub compare_hands {
	my $first_hand_ref = shift;
	my $second_hand_ref = shift;
        (my $first_rank, my $first_high) = rank_hand(\@first);
        (my $second_rank, my $second_high)  = rank_hand(\@second);

	return 0;
}	

sub rank_hand {
	my $hand_rank = 0;
	my $high_card = 0;
	my $hand_ref = shift;
	my @cards = ();
	my @suits = ();
	foreach $card (@{$hand_ref}) {
		my @split_card = split '', $card;
		push @cards, $split_card[0];
		push @suits, $split_card[1];
	}

	# letters dont compare numerically
	for ($i=0;$i<5;$i++) {
		if ($cards[$i] eq 'T') { $cards[$i] = 10; }
		if ($cards[$i] eq 'J') { $cards[$i] = 11; }
		if ($cards[$i] eq 'Q') { $cards[$i] = 12; }
		if ($cards[$i] eq 'K') { $cards[$i] = 13; }
		if ($cards[$i] eq 'A') { $cards[$i] = 14; }
	}

	my @cards_temp = ();
	my @suits_temp = ();
	for ($i=0;$i<5;$i++) {	
		my $highest = 0;
		my $highest_index = 0;
		for ($j=0;$j<5;$j++) {
			if ($cards[$j] > $highest) {
				$highest = $cards[$j];		
				$highest_index = $j;
			}
		}
		unshift @cards_temp, $cards[$highest_index];
		unshift @suits_temp, $suits[$highest_index];
		$cards[$highest_index] = 0;
	}
	@cards = @cards_temp;
	@suits = @suits_temp;
	$high_card = $cards[4];

	# check for flush
	my $flush_flag = 1;
	my $first_suit = $suits[0];
	foreach $suit (@suits) {
		if ($suit ne $first_suit) { $flush_flag = 0; }
	}
	if ($flush_flag == 1) { 
#		print "FLUSH!\n"; 
		$hand_rank = 5; 
	}

	#check for straight
	my $straight_flag = 1;
	for ($i=1;$i<5;$i++) { 
		if ($cards[$i] != $cards[$i-1] + 1) { 
			$straight_flag = 0; 
		}
	}
	if ($straight_flag == 1) { 
#		print "STRAIGHT!\n"; 
		$hand_rank = 4; 
		if ($flush_flag == 1) {
#			print "STRAIGHT FLUSH!\n"; 
			$hand_rank = 8;
			if ($cards[0] == 10) {
#				print "ROYAL FLUSH!\n"; 
				$hand_rank = 9;
			} 
		}
	}

	# check for multiples hands	
	my @card_matches = (0,0,0,0,0);
	for ($i=0;$i<5;$i++) {
		for ($j=$i+1;$j<5;$j++) {
			if ($cards[$i] == $cards[$j]) {
				$card_matches[$i]++;
			}
		}
	}
	my $max_match_count = 0;
	my $n_matches = 0;
	my $highest_multiple = 0;
	for ($i=0;$i<5;$i++) {
		$match = $card_matches[$i];
		if ($max_match_count <= $match) { 
			if ($max_match_count > 0) {
				$n_matches++;
			}
			if ($highest_multiple < $cards[$i] ) { $highest_multiple = $cards[$i]; }
			$max_match_count = $match; 
		} 
	}
	if ($max_match_count == 3) { 
#		print "FOUR OF A KIND! @cards \n"; 
		$hand_rank = 7;
	}
	if ($max_match_count == 2) { 
#		print "$n_matches THREE OF A KIND! @cards \n"; 
		# check for fullhouse
		if ( ( ($card_matches[0] == 2) && ($card_matches[3]==1) )
				|| ( ( $card_matches[0] == 1 ) && ( $card_matches[2] == 2 ) ) ) {
#			print "$n_matches FULL HOUSE! @cards\n"; 
			$hand_rank = 6;
		}
		$hand_rank = 3;
	}
	if ($max_match_count == 1) { 
		if ($n_matches == 1) {
#			print "TWO PAIR! @cards\n"; 
			$hand_rank = 2;
		} else {
#			print "$n_matches PAIR! @cards\n"; 
			$hand_rank = 1;
			$high_card = $highest_multiple;
		}
	}
	
	return ($hand_rank, $high_card); 
}

my $win_count = 0;
my $tie_count = 0;

while (<$FH>) { 
	chomp;
	my $line = $_;
	my @cards = split('\ ', $line);
	my @first = @cards[0 .. 4];
	my @second = @cards[5..9];
	(my $first_rank, my $first_high) = rank_hand(\@first);
	(my $second_rank, my $second_high)  = rank_hand(\@second);
#	print "First: @first : rank: $first_rank\n";
#	print "Second: @second : rank: $second_rank\n";
	if ($first_rank > $second_rank) { $win_count++; }
	if ($first_rank == $second_rank) { 
		if ($first_rank == 0) {	
			if ($first_high > $second_high) {
#				print "HIGHCARD $first_high\n"; 
				$win_count++;
			}
			if ($first_high == $second_high) {
				print "ACTUAL TIE!\n";
			}
		} else { 
			if ($first_high > $second_high) {
				$win_count++;
			}
		}
	}
} 
print "First player wins: $win_count games.\n";
print "Tie Count: $tie_count games.\n";

