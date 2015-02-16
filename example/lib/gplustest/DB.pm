use utf8;
package gplustest::DB;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;



sub connection {
    my $self = shift;
    my $rv = $self->next::method( @_ );

    $rv->storage->sql_maker->quote_char('"');
    $rv->storage->sql_maker->name_sep('.');

    return $rv;
}

sub do_connect {
    my $self = shift;


    $self->connect(
        'dbi:SQLite:dbname=gplustest',
        '',
        '',
        );
}

our $VERSION = 1;

1;
