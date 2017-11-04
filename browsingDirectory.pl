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

require "hash.pl"; # Hash function

=pod
Browse a directory to create a hash of each file present in the directory
In: The name of the directory
Out: a reference on an error code or on an hashmap corresponding to the hash.
=cut

use constant BROWSINGERROR => ["No error", "Missing argument", "The argument is not a directory"];

my $browsingError = 0; # Browsing Error

sub browseDirectory {
    # Check if there is the correct amount of parameter
    if (@_ != 1) {
        $browsingError = 1;
        return \$browsingError;
    }

    my $directoryName = $_[0];

    # Check if the parameter is a folder
    if (! -d $directoryName) {
        $browsingError = 2;
        return \$browsingError;
    }

    # Check if last character is a slash, if not, the character is append
    if ($directoryName !~ m/\/$/) {
        $directoryName .= "/";
    }

    $directoryName .= "*"; # add a star for the glob function
    my %folder = (); # Create the hash for the folder
    my %wordOccurencies = ();

    foreach my $file (glob($directoryName)) {
        if (! -f $file || ! -r $file) {
            next;
        }

        my $hashedFile = hashFile($file);
        $folder{$file} = $hashedFile;

        foreach my $word (keys(%$hashedFile)) {
            if (defined($wordOccurencies{$word})) {
                $wordOccurencies{$word}++;
            }
            else {
                $wordOccurencies{$word} = 1;
            }
        }
    }

    return (\%folder, \%wordOccurencies);
}

1; # for inclusion
