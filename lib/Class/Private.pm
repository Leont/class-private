package Class::Private;

use strict;
use warnings;
use Scalar::Util qw/refaddr/;

our $VERSION = '0.01';

my %vars;

sub new {
	my $class = shift;
	return bless {}, $class;
}

use overload '%{}' => sub {
	my $self = shift;
	return $vars{ refaddr($self) }{ scalar caller } ||= {};
};

sub DESTROY {
	my $self = shift;
	delete $vars{ refaddr($self) };
	return;
}

1;    # End of Class::Private

__END__

=head1 NAME

Class::Private - The great new Class::Private!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Class::Private;

    my $foo = Class::Private->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 new


=head1 AUTHOR

Leon Timmermans, C<< <leont at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-class-private at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Class-Private>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Class::Private


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Class-Private>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Class-Private>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Class-Private>

=item * Search CPAN

L<http://search.cpan.org/dist/Class-Private>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
