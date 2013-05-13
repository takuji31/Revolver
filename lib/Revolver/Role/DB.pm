package Revolver::Role::DB;
use 5.012001;
use strict;
use warnings;
use utf8;

use Moo::Role;

has db => (
    is => 'ro',
    isa => sub {
        die "db must be sub class of Revolver" unless $_[0]->isa('Revolver');
    },
);

has sql_maker => (
    is => 'lazy',
);

sub dbh { shift->db->dbh }
sub last_insert_id {shift->db->last_insert_id(@_)}

sub _build_sql_maker {
    my $self = shift;

    return Revolver::SQLMaker->new(driver => $self->dbh->{Driver}->{Name});
}

1;
