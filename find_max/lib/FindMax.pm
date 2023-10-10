#!/usr/bin/perl
use strict;
use warnings;

sub find_max {
    my @array = @_;
    my $max = $array[0];
    foreach my $element (@array) {
        if ($element > $max) {
            $max = $element;
        }
    }

    return $max;
}

my @array = (1, 5, 3, 9, 2);
my $max = find_max(@array);
print "The maximum value is $max\n";
