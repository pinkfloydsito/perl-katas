use strict;
use warnings;
use Test::More;
use DBI;

my $db_name = 'books_db_test';
my $db_user = 'postgres';
my $db_pass = 'postgres';
my $db_host = 'localhost';

my $dbh = DBI->connect("dbi:Pg:dbname=$db_name;dbhost=$db_host user=$db_user password=$db_pass")
    or die "Cannot connect to test database: $DBI::errstr";

my $stmt = $dbh->prepare("SELECT 1");
$stmt->execute;

my $result = $stmt->fetchrow_array;

ok( defined $result && $result == 1, 'Database connection is OK' );

$dbh->disconnect;

done_testing();