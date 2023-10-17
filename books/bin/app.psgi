#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

use Plack::Builder;
use lib "$FindBin::Bin/../lib";


use Book;
use Dancer2;
use Dancer2::Plugin::DBIC;
use Path::Class;

my $environment = $ENV{'PLACK_ENV'} || 'development';

print "Building app for environment: $environment\n";


builder {
  mount '/api/v1/book'                => Book->to_app;
}

=begin comment

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

