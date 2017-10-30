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
use Test::More tests => 1;
use Test::Deep;

require "hash.pl";

sub areIdentical {
    if (@_ != 2) {
        return undef;
    }

    my $hash1;
    my $hash2;

    $hash1 = $_[0];
    $hash2 = $_[1];

    if (%$hash1 != %$hash2) {
        return 0;
    }

    foreach my $k (keys(%$hash1)) {
        if (!defined(%$hash2{$k})) {
            return undef;
        }
        if ($$hash1{$k} != $$hash2{$k}) {
            return undef;
        }
    }

    return 1;
}

ok(ref(hashFile()) == "SCALAR" && hashFile() == 1, "no argument test"); # Check no file case
ok(ref(hashFile("notExist.txt")) == "SCALAR" && hashFile("notExist.txt") == 2, "file not exits test"); # Check file not exist case

open(my $f, "<", "test.txt");
ok(ref(hashFile("test.txt")) == "SCALAR" && hashFile("test.txt") == 3, "File already used test"); # Check can't read the file
close($f);

my %expectedHash = {"adnexam" => 4, "igitur" => 3, "praetenturis" => 3, "lycaoniam" => 2, "pascebantur" => 2, "provincialium" => 2, "John-Michon" => 1};

ok(ref(hashFile("test.txt")) == "HASH", "Returned type for good file");

my %result = hashFile("test.txt");

ok(areIdentical(\%result, \%expectedHash), "Check result for a good file");