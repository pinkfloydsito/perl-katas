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

subtest 'GET by id / endpoint' => sub {
    my @inserted_item_ids = load_fixtures($dbh);

    my $test = Test::More->builder;

    my $test_app = Plack::Test->create($app);
    my $res = $test_app->request(GET '/1');

    is($res->code, 200, 'HTTP status code is 200 OK');

    my $content = $res->content;

    my $data = eval { decode_json($content) };

    my $book = $data;

    ok(defined $book, 'There is 1 book in the response');

    is($book->{author}, 'Author 1', 'The book has an author');
    is($book->{title}, 'Title 1', 'The book has a title');

    cleanup_fixtures($dbh, \@inserted_item_ids);
    $dbh->disconnect;
};

done_testing();

sub load_fixtures {
    my ($dbh) = @_;

    my $insert_data_sql = <<'SQL';
    INSERT INTO book (id, author, title)
    VALUES
        (1, 'Author 1', 'Title 1'),
        (2, 'Author 2', 'Title 2'),
        (3, 'Author 3', 'Title 3');
SQL

    $dbh->do($insert_data_sql) or warn "Error inserting data: " . $dbh->errstr;

    return (1, 2, 3);
}

sub cleanup_fixtures {
    my ($dbh, $item_ids) = @_;

    my $delete_data_sql = "DELETE FROM book WHERE id = ?";

    for my $item_id (@$item_ids) {
        $dbh->do($delete_data_sql, undef, $item_id) or die "Error deleting data: " . $dbh->errstr;
    }
}
