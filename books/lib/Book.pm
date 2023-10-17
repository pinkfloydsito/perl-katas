package Book;
use Dancer2;
use Dancer2::Plugin::DBIC;

our $VERSION = '0.1';

get '/' => sub {
    response_header 'Content-Type' => 'application/json';

    my @books = schema->resultset('Book')->all;
    my @all_boooks = ();
    foreach(0..$#books){
        my $book = $books[$_]->{_column_data};
        push (@all_boooks, $book);
    }
    return to_json \@all_boooks;
};

get '/:id' => sub {
    my %books = ();
    my $id = route_parameters->get('id');
    my $book = resultset('Book')->find($id);
    if (defined $book) {
        return to_json $book->{_column_data};
    }
    status 404;
    return to_json { error => 'Book not found' };
};

post '/' => sub {
    my $body = from_json( request->body );
    my $new_book = schema->resultset('Book')->create({
        title  => $body->{'title'},
        author => $body->{'author'},
    });

    status 201;
    return to_json $new_book->{_column_data};
};

del '/:id' => sub {
    my %books = ();
    my $id = route_parameters->get('id');
    my $book = resultset('Book')->find($id);

    if (defined $book) {
        $book->delete;
        return to_json { success => 'Book deleted successfully' };
    }

    status 404;
    return to_json { error => 'Book not found'};

};

true;