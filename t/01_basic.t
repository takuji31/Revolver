use strict;
use warnings;
use utf8;
use t::Util;
use Test::More;
use Test::Exception;

use TestDB;
use Time::Piece::Plus;
test_db {
    my $db = TestDB->connect('dbi:mysql:revolver', 'root', '', {});

    my $model = $db->model('User');
    $db->dbh->do('truncate user');
    my $last_insert_id = $model->fast_insert({name => 'Hoge', is_hoge => 1, type => 'admin', created_at => localtime->mysql_datetime});

    ok 1;
};

done_testing;
