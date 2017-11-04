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
use Data::Dumper;

=pod
This function hash a document and return each word of documents with its oc number

return a reference on the error code if there is an error
=cut

my $hashError = 0; # Hash error code 
use constant HASHERRORMESSAGES => ["No error", "Missing file argument", "The file doesn't exists", "Cannot open the file"];

sub hashFile 
{
	if (@_ == 0) {
		$hashError = 1;
		return \$hashError;
	}

	if (! -e $_[0]) {
		$hashError = 2;
		return \$hashError;
	}

	# Get a filename and open it
	my $filename = $_[0];
	my $file;

	if (! open($file, "<", $filename)) {
		$hashError = 3;
		return \$hashError;
	}
	my %oc;

	# Get each line and parse it to get the words
	my $fileContent = "";
	while (my $line = <$file>) {
		$fileContent .= $line;
	}
	
	($fileContent =~ s/<[^>]+>/ /g); # A word is only composed of letters
	my @matches = ($fileContent =~ m/[a-zA-Z\-]+/g);

	foreach my $word (@matches) {
		if (defined($oc{$word})) {
			++$oc{$word};
		} else {
			$oc{$word} = 1;
		}
	}

	close($file);
	return \%oc;
}

=pod
Return display the error type of the hash function
=cut
sub hashError {
	print(STDERR (HASHERRORMESSAGES)[$hashError]);
}

1; # for inclusions
