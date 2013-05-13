package Revolver::SQLMaker;
use 5.012001;
use strict;
use warnings;
use utf8;

use parent qw/SQL::Maker/;

__PACKAGE__->load_plugin(qw/InsertMulti/);

1;
