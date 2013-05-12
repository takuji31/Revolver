requires 'perl'                     => '5.012001';
requires 'DBI'                      => '0';
requires 'DBIx::Handler'            => '0';
requires 'DBIx::Inspector'          => '0.11';
requires 'SQL::Maker'               => '0';
requires 'Moo'                      => '0';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

