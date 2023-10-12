#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

use Plack::Builder;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Book;

builder {
  mount '/api/v1/book'                => Book->to_app;
}

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use Book;
use Plack::Builder;

builder {
    enable 'Deflater';
    Book->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Book;
use Book_admin;

use Plack::Builder;

builder {
    mount '/'      => Book->to_app;
    mount '/admin'      => Book_admin->to_app;
}

=end comment

=cut

