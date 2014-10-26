#
# This file is part of MooseX-AttributeShortcuts
#
# This software is Copyright (c) 2011 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package MooseX::AttributeShortcuts;
BEGIN {
  $MooseX::AttributeShortcuts::AUTHORITY = 'cpan:RSRCHBOY';
}
BEGIN {
  $MooseX::AttributeShortcuts::VERSION = '0.001';
}

# ABSTRACT: Shorthand for common attribute options

use strict;
use warnings;

use namespace::autoclean;

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;

{
    package MooseX::AttributeShortcuts::Trait::Attribute;
BEGIN {
  $MooseX::AttributeShortcuts::Trait::Attribute::AUTHORITY = 'cpan:RSRCHBOY';
}
BEGIN {
  $MooseX::AttributeShortcuts::Trait::Attribute::VERSION = '0.001';
}
    use namespace::autoclean;
    use Moose::Role;

    # here we wrap _process_options() instead of the newer _process_is_option(),
    # as that makes our life easier from a 1.x/2.x compatibility perspective.

    before _process_options => sub {
        my ($class, $name, $options) = @_;

        if ($options->{is} eq 'rwp') {

            $options->{is}     = 'ro';
            $options->{writer} = "_$name";
        }

        if (defined $options->{builder} && $options->{builder} eq '1') {

            $options->{builder} = "_build_$name";
        }

        return;
    }

}

Moose::Exporter->setup_import_methods;

sub init_meta {
    shift;
    my %args = @_;

    Moose::Util::MetaRole::apply_metaroles(
        for => $args{for_class},
        class_metaroles => {
            attribute => [ 'MooseX::AttributeShortcuts::Trait::Attribute'],
        },
    );

    return $args{for_class}->meta;
}

1;



=pod

=head1 NAME

MooseX::AttributeShortcuts - Shorthand for common attribute options

=head1 VERSION

version 0.001

=head1 SYNOPSIS

    package Some::Class;

    use Moose;
    use MooseX::AttributeShortcuts;

    # same as: is => 'ro', writer => '_foo'
    has foo => (is => 'rwp');

    # same as: is => 'ro', builder => '_build_bar'
    has bar => (is => 'ro', builder => 1);

=head1 DESCRIPTION

Ever find yourself repeatedly specifing writers and builders, because there's
no good shortcut to specifying them?  Sometimes you want an attribute to have
a ro public interface, but a private writer.  And wouldn't it be easier to
just say "builder => 1" and have the attribute construct the canonical
"_build_$name" builder name for you?

This package causes an attribute trait to be applied to all attributes defined
to the using class.  This trait extends the attribute option processing to
handle the above variations.

=head1 NEW ATTRIBUTE OPTIONS

Unless specified here, all options defined by L<Moose::Meta::Attribute> and
L<Class::MOP::Attribute> remain unchanged.

Want to see additional options?  Ask, or better yet, fork on GitHub and send
a pull request.

For the following, "$name" should be read as the attribute name.

=head2 is => 'rwp'

Specifing is => 'rwp' will cause the following options to be set:

    is     => 'ro'
    writer => "_$name"

=head2 builder => 1

Specifying builder => 1 will cause the following options to be set:

    builder => "_build_$name"

=for Pod::Coverage init_meta

=head1 BUGS

All complex software has bugs lurking in it, and this module is no exception.

Please report any bugs to "bug-moosex-attributeshortcuts@rt.cpan.org", or
through the web interface at <http://rt.cpan.org>.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut


__END__

