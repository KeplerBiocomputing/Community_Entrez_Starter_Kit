#-------------------------------------------------------------------------------
# Usage in MySQL client: SOURCE create_entrez.sql
# Version: 1.2
# Author: Vincent VanBuren
# Purpose: This mysql script will create an entrez_gene database and its 
#          associated tables.       
#-------------------------------------------------------------------------------
#                             create_entrez.sql
# MySQL code for creating a local entrez_gene database and associated tables.
#                         Part of Entrez Starter Kit.
# Copyright (C) 2014-2016 Kepler Biocomputing LLC <http://keplerbiocomputing.com>

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

DROP DATABASE IF EXISTS `entrez_gene`;
CREATE DATABASE  `entrez_gene` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `entrez_gene`;


CREATE TABLE  `entrez_gene`.`tax2organism` (
  `tax_id` int(11) DEFAULT NULL,
  `organism` text,
  KEY `tax2organism_index` (`tax_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`homologene` (
  `homologene_id` int(11) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `protein_gi` varchar(30) DEFAULT NULL,
  `protein_accession`  varchar(30) DEFAULT NULL,
  KEY `homologene_index_homologene` (`homologene_id`),
  KEY `homologene_index_symbol` (`symbol`),
  KEY `homologene_index_tax` (`tax_id`),
  KEY `homologene_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene_info` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) NOT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `locusTag` varchar(30) DEFAULT NULL,
  `synonyms` text,
  `dbXrefs` text,
  `chromosome` text,
  `map_location` text,
  `description` text,
  `type_of_gene` varchar(30) DEFAULT NULL,
  `symbol_nomen_auth` varchar(30) DEFAULT NULL,
  `full_name_nomen_auth` text,
  `status_nomen_auth` varchar(30) DEFAULT NULL,
  `other_designations` text,
  `mod_date` date DEFAULT NULL,
  KEY `gene_info_index_tax` (`tax_id`),
  KEY `gene_info_index_sym` (`symbol_nomen_auth`),
  KEY `gene_info_index_symbol` (`symbol`),
  PRIMARY KEY `gene_info_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`interactions` (
  `tax_id_1` int(11) DEFAULT NULL,
  `gene_id_1` int(11) DEFAULT NULL,
  `accn_vers_1` varchar(30) DEFAULT NULL,
  `name_1` text,
  `keyphrase` varchar(255) DEFAULT NULL,
  `tax_id_2` int(11) DEFAULT NULL,
  `interactant_id_2` varchar(30) DEFAULT NULL,
  `interactant_id_type_2` varchar(30) DEFAULT NULL,
  `accn_vers_2` varchar(30) DEFAULT NULL,
  `name_2` text,
  `complex_id` varchar(50) DEFAULT NULL,
  `complex_id_type` varchar(30) DEFAULT NULL,
  `complex_name` varchar(255) DEFAULT NULL,
  `pubmed_id_list` text,
  `last_mod` varchar(30) DEFAULT NULL,
  `generif_text` text,
  `source_interactant_id` varchar(30) DEFAULT NULL,
  `source_interactant_id_type` varchar(30) DEFAULT NULL,
  KEY `interactions_index_gene1` (`gene_id_1`),
  KEY `interactions_index_int2` (`interactant_id_2`),
  KEY `interactions_index_tax1` (`tax_id_1`),
  KEY `interactions_index_tax2` (`tax_id_2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2go` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `go_id` varchar(30) DEFAULT NULL,
  `evidence` varchar(255) DEFAULT NULL,
  `qualifier` varchar(255) DEFAULT NULL,
  `go_term` varchar(255) DEFAULT NULL,
  `pubmed_ids` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  KEY `gene2go_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2pubmed` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `pubmed_id` varchar(30) DEFAULT NULL,
  KEY `gene2pubmed_index_gene` (`gene_id`),
  KEY `gene2pubmed_index_pubmed` (`pubmed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2refseq` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  `RNA_nucleotide_accession_version` varchar(30) DEFAULT NULL,
  `RNA_nucleotide_gi` varchar(30) DEFAULT NULL,
  `protein_accession_version` varchar(30) DEFAULT NULL,
  `protein_gi` varchar(30) DEFAULT NULL,
  `genome_nuc_accession_version` varchar(30) DEFAULT NULL,
  `genome_nuc_gi` varchar(30) DEFAULT NULL,
  `start_pos_gen_accession` varchar(30) DEFAULT NULL,
  `end_pos_gen_accession` varchar(30) DEFAULT NULL,
  `orientation` varchar(30) DEFAULT NULL,
  `assembly` varchar(80) DEFAULT NULL,
  KEY `gene2refseq_index_protein` (`protein_accession_version`),
  KEY `gene2refseq_index_nuc` (`RNA_nucleotide_accession_version`),
  KEY `gene2refseq_index_tax` (`tax_id`),
  KEY `gene2refseq_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `entrez_gene`.`gene2ensembl` (
  `tax_id` int(11) NOT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `ensembl_gene_identifier` varchar(35) DEFAULT NULL,
  `RNA_nucleotide_accession_version` varchar(35) DEFAULT NULL,
  `ensembl_RNA_identifier` varchar(35) DEFAULT NULL,
  `protein_accession_version` varchar(35) DEFAULT NULL,
  `ensembl_protein_identifier` varchar(35) DEFAULT NULL
)  ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2sts` (
  `gene_id` int(11) DEFAULT NULL,
  `UniSTS_id` varchar(30) DEFAULT NULL,
  KEY `gene2sts_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2unigene` (
  `gene_id` int(11) DEFAULT NULL,
  `unigene_cluster` varchar(30) DEFAULT NULL,
  KEY `gene2unigene_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene_history` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `discontinued_gene_id` int(11) DEFAULT NULL,
  `discontinued_symbol` varchar(35) DEFAULT NULL,
  `discontinue_date` date DEFAULT NULL,
  KEY `gene_history_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`generifs_basic` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `pubmed_id` varchar(255) DEFAULT NULL,
  `last_update` varchar(30) DEFAULT NULL,
  `description` text,
  KEY `generifs_basic_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`mim2gene` (
  `mim_number` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  KEY `mim2gene_index` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE  `entrez_gene`.`gene2accession` (
  `tax_id` int(11) DEFAULT NULL,
  `gene_id` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `RNA_nuc_accession_version` varchar(30) DEFAULT NULL,
  `RNA_nuc_gi` varchar(30) DEFAULT NULL,
  `protein_accession_version` varchar(30) DEFAULT NULL,
  `protein_gi` varchar(30) DEFAULT NULL,
  `genome_nuc_accession_version` varchar(30) DEFAULT NULL,
  `genome_nuc_gi` varchar(30) DEFAULT NULL,
  `start_pos_gen_accession` varchar(30) DEFAULT NULL,
  `end_pos_gen_accession` varchar(30) DEFAULT NULL,
  `orientation` varchar(30) DEFAULT NULL,
  `assembly` varchar(100) DEFAULT NULL,
  KEY `gene2accession_index_RNA` (`RNA_nuc_accession_version`),
  KEY `gene2accession_index_DNA` (`genome_nuc_accession_version`),
  KEY `gene2accession_index_protein` (`protein_accession_version`),
  KEY `gene2accession_index_tax` (`tax_id`),
  KEY `gene2accession_index_gene` (`gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


