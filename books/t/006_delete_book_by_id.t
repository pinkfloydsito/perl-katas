use strict;
use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use JSON;
use DBI;

my $db_name     = 'books_db_test';
my $db_user     = 'lamariajose.morillo';
my $db_password = '';
my $db_host = 'localhost';

my $dbh = DBI->connect("dbi:Pg:dbname=$db_name;host=$db_host", $db_user, $db_password)
    or die "Cannot connect to testing database: $DBI::errstr";


use Book;

my $app = Book->to_app;

subtest 'DELETE / endpoint' => sub {
    my @inserted_item_ids = load_fixtures($dbh);

    my $test = Test::More->builder;

    my $test_app = Plack::Test->create($app);
    my $res = $test_app->request(DELETE '/1');

    is($res->code, 200, 'Element was deleted');

    $dbh->disconnect;
};

done_testing();

sub load_fixtures {
    my ($dbh) = @_;

    my $insert_data_sql = <<'SQL';
    INSERT INTO book (id, author, title)
    VALUES
        (1, 'Author 1', 'Title 1');
SQL

    $dbh->do($insert_data_sql) or warn "Error inserting data: " . $dbh->errstr;

    return (1);
}
