use strict;
use warnings;
use Test::More tests => 4;

use lib './lib';

use SimpleCalc;

is( add(1, 5), 6, 'Addition = 6' );
is( subtract(1, 5), -4, 'Subtract = -4' );
is( multiply(1, 5), 5, 'Multiplication = 5' );
is( divide(5, 5), 1, 'Division = 1' );

1;