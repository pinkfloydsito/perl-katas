use strict;
use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use JSON;
use DBI;

my $db_name     = 'books_db_test';
my $db_user     = 'postgres';
my $db_password = 'postgres';

my $dbh = DBI->connect("dbi:Pg:dbname=$db_name", $db_user, $db_password)
    or die "Cannot connect to testing database: $DBI::errstr";


use Book;

my $app = Book->to_app;

subtest 'GET / endpoint' => sub {
    my @inserted_item_ids = load_fixtures($dbh);

    my $test = Test::More->builder;

    my $test_app = Plack::Test->create($app);
    my $res = $test_app->request(GET '/');

    is($res->code, 200, 'HTTP status code is 200 OK');

    my $content = $res->content;

    my $data = eval { decode_json($content) };

    ok(!$@, 'Response is valid JSON');

    my @books = @{$data};

    foreach my $book (@books) {
        print "Author: $book->{author}, Title: $book->{title}\n";
    }

    is(scalar @books, 3, 'There are 3 books in the response');

    is($books[0]->{author}, 'Author 1', 'Author of the first book');
    is($books[0]->{title}, 'Title 1', 'Title of the first book');

    is($books[1]->{author}, 'Author 2', 'Author of the second book');
    is($books[1]->{title}, 'Title 2', 'Title of the second book');

    is($books[2]->{author}, 'Author 3', 'Author of the third book');
    is($books[2]->{title}, 'Title 3', 'Title of the third book');

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
