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
=end comment
=cut

use strict;
use warnings;

=pod
=begin comment

This function create the union of two arrays
In: a1, a reference on an array
    a2, a reference on an array
Out: The union of the two arrays

=end comment
=cut

my $unionError = 0;

sub union {
    if (@_ != 2) {
        $unionError = 1;
        return \$unionError;
    }

    my ($a1, $a2) = @_;

    if (ref($a1) ne "ARRAY" && ref($a2) ne "ARRAY") {
        $unionError = 2;
        return \$unionError;
    }

    $unionError = 0;

    my @un;

    # Add each word in the union
    grep { unshift(@un, $_) } @$a2;

    # Add non-present word in the array
    grep { my $word = $_; unshift(@un, $word) if ( grep {$_ ne $word} @un ); } @$a2;

    return \@un;
}

1;
