package Revolver::Row;
use 5.012001;
use strict;
use warnings;
use utf8;

use Array::Diff;
use List::MoreUtils qw/uniq/;

use Moo;

extends 'Class::Data::Inheritable';

__PACKAGE__->mk_classdata('table');
__PACKAGE__->mk_classdata('_columns');
__PACKAGE__->mk_classdata('_primary_key');
__PACKAGE__->mk_classdata('_column_extras');

sub add_columns {
    my ($class, @columns) = @_;

    #TODO make accessor
    my $columns = $class->_columns // [];
    my @new_columns = Array::Diff->diff($columns, \@columns)->added;


    $class->_columns([uniq(@{$columns}, @new_columns)]);
}

sub set_column_extras {
    my ($class, %extras) = @_;
    $class->_column_extras({%{$class->_column_extras // {}}, %extras});
}

sub set_primary_key {
    my ($class, @keys) = @_;

    return unless @keys;

    $class->_primary_key(\@keys);
}

sub primary_key {@{shift->_primary_key}}

1;
