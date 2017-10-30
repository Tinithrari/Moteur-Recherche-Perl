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
use Test::More tests => 4;
use Test::Deep;
use Data::Dumper;

require "hash.pl";

sub areIdentical {
    if (@_ != 2) {
        return undef;
    }

    my $hash1;
    my $hash2;

    $hash1 = $_[0];
    $hash2 = $_[1];

    if (%$hash1 ne %$hash2) {
        return undef;
    }

    foreach my $k (keys(%$hash1)) {
        if (!defined($hash2->{$k})) {
            return undef;
        }

        if ($hash1->{$k} ne $hash2->{$k}) {
            return undef;
        }
    }

    return 1;
}

my $refer = hashFile();

ok(ref($refer) eq "SCALAR" && $$refer == 1, "no argument test"); # Check no file case

$refer = hashFile("notExist.txt");
ok(ref($refer) eq "SCALAR" && $$refer == 2, "file not exits test"); # Check file not exist case

my %expectedHash = ("adnexam" => 4, "igitur" => 1, "praetenturis" => 3, "Lycaoniam" => 2, "pascebantur" => 2, "provincialium" => 2, "John-Michon" => 1 );

$refer = hashFile("test.txt");
ok(ref($refer) eq "HASH", "Returned type for good file");

ok(areIdentical($refer, \%expectedHash), "Check result for a good file");
