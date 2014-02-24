#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Usage: perl ../process_taxonomy.pl
# Version 1.0
# Author: Vincent VanBuren
# Email: vvanburen@gmail.com
# Purpose: This perl script further processes the taxid_taxname.dmp file 
#          produced earlier by the get_entrez.sh script. Writes a new file
#          (taxid_taxname) that contains two tab-delimited columns (tax_id and 
#          tax_name).
# Called by: get_entrez.sh
# Requires: taxid_taxname.dmp file created by get_entrez.sh
#-------------------------------------------------------------------------------
#                           process_taxonomy.pl
# A perl script to extract tab-delimited tax_id-tax_name pairs from taxid_taxname.dmp.
#                       Part of Entrez Starter Kit.
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

my $filename="taxid_taxname.dmp";
my $outfile="taxid_taxname";

open (IN, "$filename") or die ("could not open infile: $filename\n$!\n");

open (OUT, ">$outfile") or die ("could not open outfile: $outfile\n$!\n");

while (my $readline=<IN>)
{
	chomp $readline;
	my ($tax_id, $tax_name, @rest)=split(/\|/, $readline);
	$tax_id=~s/\s//g;
	$tax_name=~s/\t//g;
	print OUT "$tax_id\t$tax_name\n";
}

close IN;
close OUT;
exit;

