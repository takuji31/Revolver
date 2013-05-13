package Revolver;
use 5.012_001;
use strict;
use warnings;

our $VERSION = "0.01";

use DBI;
use DBIx::Handler;
use Moo;

has dbh_handler => (
    is => 'ro',
);

has dbh_coderef => (
    is => 'ro',
);

sub BUILDARGS {
    my $self = shift;

    my @args;
    if (@_ == 1 && ref $_[0] && ref $_[0] eq 'CODE') {
        @args = (dbh_coderef => $_[0]);
    } else {
        my ($dsn, $user, $pass, $attr) = @_;

        $attr //= {};

        #just copy from Amon2::DBI 0.32
        $attr->{RaiseError} = 1;
        $attr->{PrintError} = 0;
        $attr->{ShowErrorStatement} = 1;
        if ($DBI::VERSION >= 1.614) {
            $attr->{AutoInactiveDestroy} = 1 unless exists $attr->{AutoInactiveDestroy};
        }

        if ($dsn =~ /^dbi:SQLite:/i) {
            $attr->{sqlite_unicode} = 1 unless exists $attr->{sqlite_unicode};
        } elsif ($dsn =~ /^dbi:mysql:/i) {
            $attr->{mysql_enable_utf8} = 1 unless exists $attr->{mysql_enable_utf8};
        } elsif ($dsn =~ /^dbi:Pg:/i) {
            my $dbd_pg_version = eval { require DBD::Pg; (DBD::Pg->VERSION =~ /^([.0-9]+)\./)[0] };
            if ( !$@ and $dbd_pg_version < 2.99 ) { # less than DBD::Pg 2.99, pg_enable_utf8 must be set for utf8.
                $attr->{pg_enable_utf8} = 1 unless exists $attr->{pg_enable_utf8};
            }
        }

        @args = (dbh_handler => DBIx::Handler->new($dsn, $user, $pass, $attr));
    }

    return {@args};
}

sub connect {
    my $class = shift;
    return $class->new(@_);
}

sub dbh {
    my $self = shift;
    my $code = $self->dbh_coderef // sub { $self->dbh_handler->dbh };
    return $code->();
}

sub txn_manager {
    my $self = shift;

    if ($self->dbh_coderef) {
        DBI::TransactionManager->new(dbh => $self->dbh);
    } else {
        $self->dbh_handler->txn_manager;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Revolver - The O/R mapper

=head1 SYNOPSIS

    use Revolver;

=head1 DESCRIPTION

Revolver is ...

=head1 LICENSE

Copyright (C) Nishibayashi Takuji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Nishibayashi Takuji E<lt>takuji31@gmail.comE<gt>

=cut

