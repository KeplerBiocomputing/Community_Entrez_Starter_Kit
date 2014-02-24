#!/bin/bash
#-------------------------------------------------------------------------------
# Usage: bash update_entrez.sh
# Version: 1.1
# Author: Vincent VanBuren
# Purpose: Create/updates a local Entrez database that includes GeneRIFs, Homologene, and Taxonomic names.
# Requires: -create_entrez.sql
#	    -clean.pl
#           -load_entrez.sh
#         
#           
#-------------------------------------------------------------------------------
#                              update_entrez.sh
#          Creates or updates a local entrez_gene database, then populates
#                 it with the latest data files from NCBI.
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
perl gnu.pl "                            update_entrez.sh
                       Part of Entrez Starter Kit
               Copyright (C) 2014  Kepler Biocomputing LLC
                     <http://keplerbiocomputing.com>"

bash get_entrez.sh
bash load_entrez.sh
