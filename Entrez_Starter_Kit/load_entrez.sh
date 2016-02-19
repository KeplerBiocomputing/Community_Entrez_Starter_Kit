#!/bin/bash
#-------------------------------------------------------------------------------
# Usage: bash load_entrez.sh
# Version: 1.2
# Author: Vincent VanBuren
# Email: vvanburen@gmail.com
# Purpose: This shell script (developed on Mac OS X; should be compatable with
#          Linux) will load entrez data files (in ./entrez_downloads/) into a 
#          MySQL database (entrez_gene) as created by create_entrez.sql. 
# Called by: update_entrez.pl
# Requires: -create_entrez.sql
#	    -clean.pl
#           -Assumes that get_entrez.sh has been executed to create the 
#             entrez_downloads directory and retrieve entrez files to that 
#             directory.       
#-------------------------------------------------------------------------------
#                              load_entrez.sh
#  A shell script that loads local Entrez data files into a new local database.
#                         Part of Entrez Starter Kit.
#    Copyright (C) 2014-2016 Kepler Biocomputing LLC <http://keplerbiocomputing.com>

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
    


# EDIT THE FOLLOWING LINES TO PROVIDE YOUR MYSQL USER NAME AND PASSWORD
# WARNING: THIS TYPE OF PASSWORD USAGE CAN BE INSECURE
PASS="vince"		#MYSQL PASSWORD
USER="vanburen"		#MYSQL USERNAME
DB="entrez_gene"

perl gnu.pl "                            load_entrez.sh
                       Part of Entrez Starter Kit
               Copyright (C) 2014-2016  Kepler Biocomputing LLC
                     <http://keplerbiocomputing.com>"  skip_interactive


THIS_DIR="$PWD"
DATA_DIR="$PWD/entrez_downloads"


# CREATE THE MYSQL DATABASE TABLES
echo "Creating MySQL tables..."
mysql --user=$USER --password=$PASS -e "SOURCE $THIS_DIR/create_entrez.sql"
echo "Done creating tables."
echo ""


# REPLACE DASHES (-) IN THE interactions DATA FILE WITH NULL CHARACTERS (\N)
# CREATES NEW FILE: clean.interctions
echo "Fixing interaction, mim2gene_medgen, gene_history data tables..."
cd entrez_downloads
perl ../clean.pl interactions
perl ../clean.pl mim2gene_medgen
perl ../clean.pl gene_history
cd ..
echo "Replaced dashes with null characters. Done fixing tables."
echo "------------------------------------"
echo ""

# LOAD THE DATA
echo "Loading tax2organism table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/taxid_taxname' INTO TABLE tax2organism"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from tax2organism"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading homologene table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/homologene.data' INTO TABLE homologene"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from homologene"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene_info table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene_info' INTO TABLE gene_info IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene_info"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading interaction table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/clean.interactions' INTO TABLE interactions IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from interactions"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2go table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2go' INTO TABLE gene2go IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2go"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2pubmed table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2pubmed' INTO TABLE gene2pubmed IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2pubmed"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2refseq table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2refseq' INTO TABLE gene2refseq IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2refseq"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2ensembl table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2ensembl' INTO TABLE gene2ensembl IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2ensembl"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2sts table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2sts' INTO TABLE gene2sts IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2sts"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene2unigene table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2unigene' INTO TABLE gene2unigene IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2unigene"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading gene_history table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/clean.gene_history' INTO TABLE gene_history IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene_history"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading generifs_basic table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/generifs_basic' INTO TABLE generifs_basic IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from generifs_basic"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Loading mim2gene table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/clean.mim2gene_medgen' INTO TABLE mim2gene IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from mim2gene"
echo "Done loading table."
echo "------------------------------------"
echo ""



# THIS IS LARGE DATA FILE AND MAY TAKE SEVERAL MINUTES TO LOAD
echo "Large data file. Loading gene2accession table..."
mysql $DB --user=$USER --password=$PASS --local-infile -e "LOAD DATA LOCAL INFILE '$DATA_DIR/gene2accession' INTO TABLE gene2accession IGNORE 1 lines"
mysql $DB --user=$USER --password=$PASS -e "SELECT COUNT(*) as records_loaded from gene2accession"
echo "Done loading table."
echo "------------------------------------"
echo ""

echo "Done."
# END OF SCRIPT 
