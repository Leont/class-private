#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Class::Private' );
}

diag( "Testing Class::Private $Class::Private::VERSION, Perl $], $^X" );
