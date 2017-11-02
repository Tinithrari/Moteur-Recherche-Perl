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

# Get the documentSimilarity function
require 'documentSimilarity.pl';

# Get the tempfile function
use File::Temp qw/tempfile/;

=pod
=begin comment

This function read request from the keyboard and compute the similarity between the request and the presents document
In: None
Out: The most similar document from the directory

=end comment
=cut

my $researchSuffix = "*.html";

sub makeRequest {
    my $request = <>;
    my $mostSimilar = undef;
    my $highestSimilarity = -1;

    my ($fileFlow, $fileName) = tempfile();
    print($fh "$request");

    foreach my $file (glob($researchSuffix)) {
        my $similarity = documentSimilarity($fileName, $file);

        die("A problem occured during the request, please try again later") if ($similarity < 0);

        if ($similarity > $highestSimilarity) {
            $highestSimilarity = $similarity;
            $mostSimilar = $file;
        }
    }

    close($fileFlow);

    return $mostSimilar;
}
