#!/usr/bin/perl

use warnings;
use strict;
use v5.10;
use POSIX;

use Data::Dumper;

# Project Euler Problem 151

our @days;
our @day_probs;

sub make_node {
	my $counts = shift;
	my $prob = shift;
	my $hash_ref = {
			'counts' => $counts,
			'prob' => $prob,
	};
	return $hash_ref;

}

sub chop_up {
	my $size = shift;
	my $counts = shift;
	my @temp;
	for (my $i=0; $i<4; $i++) {
		$temp[$i] = $counts->[$i];
	}
	$temp[$size] -= 1;
	for (my $i = $size + 1; $i < 4; $i++) {
		$temp[$i] += 1;
	}
	$temp[3] += 1;
	return \@temp;
}

sub remove_one {
	my $counts = shift;
	$counts->[3] -= 1;
}

sub count_up_sheets {
	my $counts = shift;
	my $sum = 0;
	for (my $i=0;$i<4;$i++) {
		$sum += $counts->[$i];
	}
	return $sum;
}

sub iterate_day {
	my $this_day = shift;
	$days[$this_day] = [];
	$day_probs[$this_day] = 0.0;
	my $prev_day = $this_day - 1;
	foreach my $state (@{$days[$prev_day]}) {
		#print Dumper($state);
		my $counts = $state->{'counts'};
		my $state_prob = $state->{'prob'};
		my $total_count = count_up_sheets($counts);
		if ($total_count == 1) {
			$day_probs[$this_day] += $state->{'prob'};
		}
		for (my $i=0;$i<4;$i++) {
			my $next;
			my $next_prob = 1.0 * $state_prob * $counts->[$i] / $total_count;
			if ($counts->[$i] == 0) {
				next;
			}
			if ($i < 3) {
				$next = chop_up($i,$counts);
			} else {
				my @temp;
				for (my $i=0; $i<4; $i++) {
					$temp[$i] = $counts->[$i];
				}
				$next = \@temp;
			}
			remove_one($next);
			my $next_state = make_node($next,$next_prob); 
			push @{$days[$this_day]}, $next_state;
		}
	}
}

sub sum_probs_of_day {
	my $this_day = shift;
	my $sum = 0.0;
	foreach my $state (@{$days[$this_day]}) {
		my $count = count_up_sheets($state->{'counts'});
		if ($count == 1) {
			$sum += $state->{'prob'};
		}
	}
	return $sum;
}

sub initialize {
	$days[1] = [
		make_node( [ 1, 1, 1, 1], 1),
	];	
	$day_probs[1] = 0;
}

sub main {
	initialize();
	for (my $day=2; $day < 16; $day++) {
		iterate_day($day);
	}
	for (my $day=2; $day < 16; $day++) {
		say "$day : ", sum_probs_of_day($day);
	}
	my $sum = 0.0;
	for (my $day=2; $day < 16; $day++) {
		$sum += $day_probs[$day];
	}
	say $sum;
}

main();
