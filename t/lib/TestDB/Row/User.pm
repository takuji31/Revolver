package TestDB::Row::User;
use 5.012001;
use strict;
use warnings;
use utf8;

use Moo;

extends 'Revolver::Row';

my $pkg = __PACKAGE__;

$pkg->table('user');

#all parameters are optional
$pkg->add_columns('id', 'name', 'is_hoge', 'created_at', 'type');

$pkg->set_column_extras(
   id => {
       data_type => 'integer',
       is_auto_increment => 1,
       is_nullable => 0,
    },
   name => {
       data_type => 'varchar',
       size => 64,
       is_nullable => 0,
   },
   is_hoge => {
       data_type => 'tinyint',
       is_nullable => 0,
   },
   created_at => {
       data_type => 'datetime',
       is_nullable => 0,
   },
   type => {
       data_type => 'enum',
       default_value => 'user',
       extra => {
           list => [
               'user',
               'admin',
               'deleted'
           ]
       },
       is_nullable => 0,
   },
);

$pkg->set_primary_key('id');

#$pkg->add_unique_index('user', ['user']);

1;
