package TestDB;
use 5.012_001;
use strict;
use warnings;
use utf8;

use Moo;

extends 'Revolver::Schema';

__PACKAGE__->load_model_and_rows;

1;
