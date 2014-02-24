#-------------------------------------------------------------------------------
# Usage in MySQL client: SOURCE examples.sql
# Version: 1.0
# Author: Vincent VanBuren
# Purpose: The MySQL queries below offer some examples for using the entrez_gene
#          database. You can cut and paste individual queries into the MySQL 
#          client.
# Requires: Assumes existence of the entrez_gene database as created by 
#           get_entrez.sh and load_entrez.sh.
#-------------------------------------------------------------------------------
#                             examples.sql
# Example MySQL code for using the local entrez_gene database and associated 
#                  tables created with Entrez Starter Kit.
#                         Part of Entrez Starter Kit.
# Copyright (C) 2014 Kepler Biocomputing LLC <http://keplerbiocomputing.com>

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


# EXAMPLE QUERIES FOR THE entrez_gene DATABASE


# MySQL query that gets the top 50 co-cited genes for gene ID 5460
SELECT '5460' AS 'query', gene_info.tax_id, gene2pubmed.gene_id, symbol, COUNT(*) AS co_citations 
FROM entrez_gene.gene2pubmed, gene_info 
WHERE pubmed_id IN (select pubmed_id from entrez_gene.gene2pubmed where gene_id='5460') AND gene2pubmed.gene_id=gene_info.gene_id 
GROUP BY gene_id 
ORDER BY COUNT(*) DESC 
LIMIT 50;


# MySQL query that gets the top 5000 pubmed IDs by the number of gene IDs cited
SELECT pubmed_id, COUNT(*)
FROM gene2pubmed
GROUP BY pubmed_id 
ORDER BY COUNT(*) DESC
LIMIT 5000;



