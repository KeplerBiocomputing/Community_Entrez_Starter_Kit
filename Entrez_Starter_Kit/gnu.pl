#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Usage: perl gnu.pl "<copyright information>" [skip_interactive]
# Author: Vincent VanBuren
# Purpose: gnu.pl will display some license information for top-level
#          interactive shell programs in this distribution.
#-------------------------------------------------------------------------------
#                                  gnu.pl
#    A perl script that reports licensing information at the command line 
#          when certain scripts are executed in Entrez Starter Kit.
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
my $tagline=$ARGV[0];
my $interactive=$ARGV[1];
print "----------------------------------------------------------------------------\n";
print "$tagline\n";
print "    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.\n";
print "    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.\n\n";
 print "----------------------------------------------------------------------------\n";   
print "To continue without showing any license details, just press return.\n";
if ($interactive eq "skip_interactive")
{
	print "\n\nSKIPPING INTERACTIVE SESSION FOR THIS SCRIPT.\n Please see the files 'W' and 'C' in the same directory as this script to view the respective license details referenced above.\n\n\n";
}
else
{
my $input=<STDIN>;
chomp $input;
if ($input eq 'show c')
{
	print "\n";
	print "License details for redistribution\n";
	print "----------------------------------\n";
	system ("cat C");
	print "\n";
	print "Press return to continue\n";
	my $wait=<STDIN>;
}
elsif ($input eq 'show w')
{
	print "\n";
	print "License details for disclaimer\n";
	print "------------------------------\n";
	system ("cat W");
	print "\n";
	print "Press return to continue.\n";
	my $wait=<STDIN>;
}
}
exit;

