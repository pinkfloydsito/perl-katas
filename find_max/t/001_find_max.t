use strict;
use warnings;
use Test::More tests => 3;

use lib './lib';

use FindMax;

is( find_max(1, 5, 3, 9, 2), 9, 'Max is 9' );
is( find_max(-1, -5, -3), -1, 'Max is -1' );
is( find_max(0, 0, 0, 0), 0, 'Max is 0' );
