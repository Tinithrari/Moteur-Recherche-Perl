#!/usr/bin/perl

=pod
=begin comment
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end
=cut

use strict;
use warnings;
use Test::More tests => 6;
use Test::Deep;
use Data::Dumper;

require "browsingDirectory.pl";

my $refer = browseDirectory();

ok(ref($refer) eq "SCALAR", "check return type for first error");
ok($$refer == 1, "Checking first error code");

$refer = browseDirectory("Not a directory");

ok(ref($refer) eq "SCALAR", "check return type for second error");
ok($$refer == 2, "Checking second error code");

$refer = browseDirectory(".");

ok(ref($refer) eq "HASH", "Check return type for a normal case");

# print(Dumper(%$refer));

ok(defined($refer->{"./browsingDirectory.pl"})
 && defined($refer->{"./hash.pl"}) && defined($refer->{"./test-hash.pl"})
  && defined($refer->{"./LICENSE"}) && defined($refer->{"./README.md"})
   && defined($refer->{"./test-browsingDirectory.pl"}) && defined($refer->{"./test.txt"}));
