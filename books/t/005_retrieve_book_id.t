use strict;
use warnings;
use Test::More;
use Plack::Test;
use JSON;

my $app = Plack::Test::create(sub {
    my $env = shift;
    
    my $id = $env->{REQUEST_URI} =~ s{/api/v1/book/}{};
    if ($id == 1) {
        return [200, ['Content-Type' => 'application/json'], ['{"id":"Book id"}']];
    } else {
        return [404, ['Content-Type' => 'application/json'], ['{"error":"Book not found"}']];
    }
});

plan tests => 2;

my $response = $app->request('GET', '/api/v1/book/1');
is($response->code, 200, 'HTTP status code should be 200');
my $content = from_json($response->content);
is($content->{$id}, 'Book id', 'Response contains book details');

$response = $app->request('GET', '/api/v1/book/1000');
is($response->code, 404, 'HTTP status code should be 404');
$content = from_json($response->content);
is($content->{error}, 'Book not found', 'Response contains "Book not found" error message');

done_testing();
