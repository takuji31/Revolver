package Revolver::Role::Exception;
use 5.012001;
use strict;
use warnings;
use utf8;

use Moo::Role;

use Revolver::Exception;

sub throw_exception {
    my ($class, @params) = @_;
    Revolver::Exception->throw(@params);
}
1;
