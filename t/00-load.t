#!/usr/bin/env perl
#
# This file is part of MooseX-AttributeShortcuts
#
# This software is Copyright (c) 2011 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#

use Test::More tests => 1;

use Moose;
BEGIN { use_ok 'MooseX::AttributeShortcuts' }

diag("Testing MooseX-AttributeShortcuts $MooseX::AttributeShortcuts::VERSION, Perl $], $^X");
