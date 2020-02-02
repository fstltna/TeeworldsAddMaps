#!/usr/bin/perl

use strict;
use warnings;

# Set this to your maps folder
my $MapFolder = "/root/twserver/data/maps";

# Other globals
my $filename = "";
my $OutputHead = "twserver.head";
my $OutputFile = "twserver.cfg";

system("cp $OutputHead $OutputFile");
open(my $fh, '>>', $OutputFile) or die "Could not append to '$OutputFile' $!";

# Creates the file 
sub ProcessFile
{
	# add_vote "Map: ctf1" "change_map ctf1"
	my $Basename = substr($filename, 0, length($filename) - 4);
	my $result = sprintf("add_vote \"%s\" \"change_map %s\"", $Basename, $Basename);
	print $fh "$result\n";
}

# Open the folder
opendir(DIR, $MapFolder) or die "Could not open '$MapFolder' $!\n";

# Loop for each file in that directory
while ($filename = readdir(DIR))
{
	# Is the File a map?
	if (substr($filename, -4) eq ".map")
	{
		# Process it
		ProcessFile();
	}
}
closedir(DIR);
close $fh;

exit 0;
