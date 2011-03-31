
use strict;
use warnings;

BEGIN { require 5.006; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Shorthand for common attribute options',
  'AUTHOR' => 'Chris Weyl <cweyl@alumni.drew.edu>',
  'BUILD_REQUIRES' => {
    'Carp' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Scalar::Util' => '0',
    'Test::Moose' => '0',
    'Test::More' => '0.94',
    'perl' => '5.004'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'MooseX-AttributeShortcuts',
  'EXE_FILES' => [],
  'LICENSE' => 'lgpl',
  'NAME' => 'MooseX::AttributeShortcuts',
  'PREREQ_PM' => {
    'Moose' => '0',
    'Moose::Exporter' => '0',
    'Moose::Util::MetaRole' => '0',
    'MooseX::Role::Parameterized' => '0',
    'MooseX::Types::Common::String' => '0',
    'namespace::autoclean' => '0'
  },
  'VERSION' => '0.002',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



