package t::Util;
use 5.012001;
use strict;
use warnings;
use utf8;

use File::Basename qw/dirname/;
use File::Spec;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');

use parent qw/Exporter/;

our @EXPORT = qw/
    test_db
/;

sub test_db (&) {
    my ($code, ) = @_;

    unlink 'test.db' if -f 'test.db';

    $code->('dbi:SQLite:test.db','','');
}

1;
