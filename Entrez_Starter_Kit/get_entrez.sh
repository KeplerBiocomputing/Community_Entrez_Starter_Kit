#!/bin/bash
#-------------------------------------------------------------------------------
# Usage: bash get_entrez.sh
# Version: 1.1
# Author: Vincent VanBuren
# Email: vvanburen@gmail.com
# Purpose: This shell script (developed on Mac OS X; should be compatable with
#          Linux) will create a directory called entrez_downloads (deleting it 
#          first if it already exists), and use ftp to retrieve Entrez Gene 
#          tables from NCBI to that directory, including GeneRIFs. The script 
#          will then retrieve the current homologene.data file from Homologene
#          and the taxdump directory from NCBI's Taxonomy server.
#          All compressed (.gz) files in the entrez_downloads directory are
#          uncompressed. All archived (.tar files) are unpacked.
# Called by: update_entrez.pl
# Requires: process_taxonomy.pl
#-------------------------------------------------------------------------------
#                              get_entrez.sh
#   A shell script that gets Entrez data files from NCBI via FTP, unpacks
# them, and performs some minimal processing to ready them for loading into
#                                a database.
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
perl gnu.pl "                            get_entrez.sh
                       Part of Entrez Starter Kit
               Copyright (C) 2014  Kepler Biocomputing LLC
                     <http://keplerbiocomputing.com>"  skip_interactive

rm -r entrez_downloads
mkdir entrez_downloads
cd entrez_downloads

# GET ENTREZ DATA FILES
ftp ftp://ftp.ncbi.nih.gov/gene/<<ftpEntrezGene
cd GeneRIF
get interactions.gz
get generifs_basic.gz
cd ../DATA
get gene_info.gz
get gene2go.gz
get gene_group.gz
get gene_history.gz
get gene2accession.gz
get gene2ensembl.gz
get gene2pubmed.gz
get gene2refseq.gz
get gene_neighbors.gz
get gene_refseq_uniprotkb_collab.gz
get gene2vega.gz
get gene2sts
get gene2unigene
get mim2gene_medgen
quit
ftpEntrezGene

# GET HOMOLOGENE DATA FILE
ftp ftp://ftp.ncbi.nlm.nih.gov/pub/HomoloGene/ <<ftpHomologene
cd current
get homologene.data
quit
ftpHomologene

# GET TAXDUMP DIRECTORY
ftp ftp://ftp.ncbi.nih.gov/pub/taxonomy/ <<ftpTaxonomy
get taxdump.tar.gz
quit
ftpTaxonomy


# EXPAND COMPRESSED FILES AND UNPACK ARCHIVES
tar -xzvf *.tar.gz
gunzip -v *.gz


# MAKE A FILE CONTAINING JUST TAXONOMIC IDS AND SCIENTIFIC NAMES
echo "Making taxid_taxname.dmp from names.dmp..."
cat names.dmp | grep scientific\ name >taxid_taxname.dmp
echo "Done making taxid_taxname.dmp."
echo ""
echo "Processing taxid_taxname.dmp to make taxid_taxname file..."
perl ../process_taxonomy.pl
echo "Done making taxid_taxname file."
echo ""
cd ..


# END OF SCRIPT 
