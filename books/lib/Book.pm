package Book;
use Dancer2;
use Dancer2::Plugin::DBIC;

our $VERSION = '0.1';

my %books = ();

get '/' => sub {
    my @books = schema->resultset('Book')->all;
    return to_json \@books;
};

get '/:id' => sub {
    my $id = route_parameters->get('id');
    if (exists $books{$id}) {
        return to_json $books{$id};
    }
    status 404;
    return to_json { error => 'Book not found' };
};

post '/' => sub {
    my $new_book = schema->resultset('Book')->create({
        title  => body_parameters->get('title'),
        author => body_parameters->get('author'),
    })->get_columns;

    status 201;
    return to_json $new_book;
};

del '/:id' => sub {
    my $id = route_parameters->get('id');

    if(exists $books{$id}) {
        delete $books{$id};
        return to_json { success => 'Book deleted successfully' };
    }

    status 404;
    return to_json { error => 'Book not found'};

};

true;