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

require 'makeRequest.pl';

=pod
=begin comment

Partie principale du programme

=end comment
=cut

if (@ARGV != 1) {
    print(STDERR "Usage: $0 <Directory>\n");
    exit(1);
}

my $directory = $ARGV[0];

if (! -d $directory) {
    print(STDERR "$directory is not a directory\n");
    exit(1);
}

chdir($directory) || die("Cannot access the directory\n");

for (;;) {
    my $file = makeRequest();
    print "$file\n";
}
