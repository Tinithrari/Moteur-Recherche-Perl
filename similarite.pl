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

# Get the hashFile function
require 'hash.pl';

# Get the union function
require 'union.pl';

# Get the arrayContainsString function
require 'arrayContainsString.pl'

=pod
=begin comment

compute the similarity of two documents
In : d1, the path of document 1
         d2, the path of document 2
Out : a real between 0 and 1, 0 when no similarity, 1 if it's completely similar, or a negative number if there is an error

=end comment
=cut

my $similarityError = 0;

sub documentSimilarity {

    # Verification de la presence des arguments
    if (@_ != 2) {
        $similarityError = -1;
        return $similarityError;
    }

    my ($d1, $d2) = @_;

    # Verification de la validite des arguments
    if (! -d $d1 || ! -d $d2) {
        $similarityError = -2;
        return $similarityError;
    }

    my $hashD1 = hashFile($d1);
    my $hashD2 = hashFile($d2);

    if (ref($hashD1) != "ARRAY" || ref($hashD2) != "ARRAY") {
        $similarityError = -3;
        return $similarityError;
    }

    # Obtiens l'union des clés des tables de hachages
    my $words = union( \(keys($hashD1)) , \(keys($hashD2)) );

    my $numerateur = 0;
    my $denominateur = 0;
    
    # Calcule le numerateur
    foreach (my $w (@$words)) {
        my $intermediateComputing = 0;
        
        if (arrayContainsString(\(keys($hashD1)), $w)) {
            $intermediateComputing = $hashD1{$w};
        }
        
        if (arrayContainsString(\(keys($hashD2)), $w)) {
            $intermediateComputing *= $hashD2{$w};
        }

        if (arrayContainsString(\(keys($hashD1)), $w) && arrayContainsString(\(keys($hashD2)), $w)) {
            $intermediateComputing *= 0.5;
            $intermediateComputing *= $intermediateComputing;
            $numerateur += $intermediateComputing;
        }
    }

    # TODO Calcul du dénominateur
}
