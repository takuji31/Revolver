requires 'perl'                     => '5.012001';
requires 'Array::Diff'              => '0';
requires 'Class::Data::Inheritable' => '0';
requires 'DBI'                      => '0';
requires 'DBIx::Handler'            => '0';
requires 'DBIx::Inspector'          => '0.11';
requires 'Exception::Tiny'          => '0';
requires 'Moo'                      => '0';
requires 'List::MoreUtils'          => '0';
requires 'SQL::Maker'               => '0';
requires 'Sub::Install'             => '0';


on 'test' => sub {
    requires 'Test::More', '0.98';
};

