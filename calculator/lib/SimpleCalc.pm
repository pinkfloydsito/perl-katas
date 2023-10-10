package SimpleCalc;

use strict;
use warnings;

use Exporter::Auto;

sub add {
    my ($a, $b) = @_;

    return $a + $b;
}

sub subtract {
    my ($a, $b) = @_;

    return $a - $b;

}


sub multiply {

    my ($a, $b) = @_;

    return $a * $b;
}


sub divide {

    my ($a, $b) = @_;

    return $a / $b;
}

1;