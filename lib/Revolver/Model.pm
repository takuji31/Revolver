package Revolver::Model;
use 5.012001;
use strict;
use warnings;
use utf8;

use Array::Diff;
use Moo;

use Revolver::SQLMaker;

with 'Revolver::Role::DB', 'Revolver::Role::Exception';

has row_class => (
    is => 'ro',
);

sub _create_row {
    my ($self, @params) = @_;
    return $self->row_class->new(db => $self->db, model => $self, @params);
}

use Data::Dumper;
sub table {shift->row_class->table}
sub _primary_key {shift->row_class->_primary_key}
sub _columns {shift->row_class->_columns}

sub _insert {
    my ($self, $values, $prefix) = @_;

    $prefix //= 'INSERT INTO';

    unless (ref $values eq 'HASH') {
        $self->throw_exception('insert values must be hashref');
    }

    my $table = $self->table;
    warn 'hoge';
    #TODO deflate
    my ($sql, @binds) = $self->sql_maker->insert($table, $values, {prefix => $prefix});

    $self->dbh->do($sql, {}, @binds);
}

sub fast_insert {
    my $self = shift;

    $self->_insert(@_);
    return $self->last_insert_id($self->table);
}

sub insert {
    my $self = shift;
    $self->_insert(@_);

    my $pk = $self->_primary_key;

    my $values = $_[0];
    if (@$pk == 1 && !defined $values->{$pk->[0]}) {
        $values->{$pk->[0]} = $self->last_insert_id($self->table);
    }

    my %cond;

    for my $column (sort keys %$values) {
        my $value = $values->{$column};
        next if ref $value && ref $value eq 'SCALAR';
        if ($column ~~ @{$self->_columns}) {
            $cond{$column} = $value;
        }
    }

    if (@$pk && @$pk == keys %cond) {
        return $self->find(map {$cond{$_}} @{$self->_primary_key});
    }

    $self->_create_row(row_data => $values);
}

1;
