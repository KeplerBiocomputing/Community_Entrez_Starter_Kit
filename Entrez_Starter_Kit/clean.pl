#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Usage: perl clean.pl <filename>
# Version 1.0
# Author: Vincent VanBuren
# Email: vvanburen@gmail.com
# Purpose: This perl script replaces field values that are lone dashes with NULL characters in a "clean." version of a data file.
# Called by: load_entrez.sh
# Called on: -interactions
#            -mim2gene_medgen
#            -gene_history
#-------------------------------------------------------------------------------
#                                 clean.pl
#  A perl script that creates modified data files where field values of '-' are
#                    replaced with NULL characters ("\N").
#                         Part of Entrez Starter Kit.
#    Copyright (C) 2014 Kepler Biocomputing LLC <http://keplerbiocomputing.com>

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


use strict;


my $filename=@ARGV[0];

my $outfile="clean.$filename";


open (IN, "$filename") or die ("could not open infile: $filename\n$!\n");

open (OUT, ">$outfile") or die ("could not open outfile: $outfile\n$!\n");

while (my $readline=<IN>)
{
	chomp $readline;
	my @data=split("\t", $readline);
	my $outline='';
	foreach my $field (@data)
	{
		if ($field eq "-")
		{
			# THEN PRINT A NULL CHARACTER TO THE NEW FILE INSTEAD
			$outline="$outline\\N\t";
		}
		else
		{
			$outline="$outline$field\t";
		}
	}
	#GET RID OF LAST TAB
	chop $outline;
	#ADD A NEWLINE TO THE END
	$outline="$outline\n";
	
	print OUT $outline;
}

close IN;
close OUT;
exit;

