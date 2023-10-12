use utf8;
package Book::Schema::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Book::Schema::Result::Book

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<book>

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'book_id_seq'

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 author

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "book_id_seq",
  },
  "title",
  { data_type => "text", is_nullable => 0 },
  "author",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-10-12 15:05:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+vzDzuuhBY3RxukY/sNeOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
