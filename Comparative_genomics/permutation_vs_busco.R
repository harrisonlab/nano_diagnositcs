setwd("C:/Users/did23faz/OneDrive - Norwich Bioscience Institutes/Desktop/R")

library(dplyr)
library(ggplot2)
library(data.table)

predector_df <- read.table("download/tmp08092024/THeavenDRCT72020_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenDRCT72020_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenDRCT72020_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data4 <- merged_data2
#####################################################################################################################################################################################################################################################################################
predector_df <- read.table("download/tmp08092024/THeavenDRCT72021_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenDRCT72021_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenDRCT72021_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data5 <- merged_data2
#####################################################################################################################################################################################################################################################################################
predector_df <- read.table("download/tmp08092024/THeavenSCOTT2020_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenSCOTT2020_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenSCOTT2020_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data6 <- merged_data2
#####################################################################################################################################################################################################################################################################################
predector_df <- read.table("download/tmp08092024/THeavenpOGB2019_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenpOGB2019_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenpOGB2019_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data7 <- merged_data2
#####################################################################################################################################################################################################################################################################################
predector_df <- read.table("download/tmp08092024/THeavenp11_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenp11_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenp11_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data8 <- merged_data2
#####################################################################################################################################################################################################################################################################################
predector_df <- read.table("download/tmp08092024/THeavenpOGB2021_1_abinitio_annotations3.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
predector <- predector_df[grepl("\\.t1$", predector_df[, 1]), ] 
nonest <- read.table("download/tmp08092024/THeavenpOGB2021_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df <- read.table("download/tmp08092024/THeavenpOGB2021_1_busco_blast2.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
blast_df2 <- blast_df[!duplicated(blast_df[[1]]), ]
blast <- blast_df2[grepl("\\.t1$", blast_df2[, 1]), ] 
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, blast, by = "name", all = TRUE)

colnames(merged_data2) <- c('name','secretomep_score','secretomep_odds','secretomep_weight','secretomep_warning','mildew_orthology_match','outgroup_orthology_match','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','IG_five_prime','IG_three_prime','strand','BUSCO_blast_match','BUSCO_blast_pident','BUSCO_blast_length','BUSCO_blast_mismatch','BUSCO_blast_gapopen','BUSCO_blast_qstart','BUSCO_blast_qend','BUSCO_blast_sstart','BUSCO_blast_send','BUSCO_blast_evalue','BUSCO_blast_bitscore','BUSCO_blast_qseq','BUSCO_blast_sseq')
merged_data2$BUSCO_blast_match <- ifelse(is.na(merged_data2$BUSCO_blast_match), 0, 1)
columns_to_remove <- c('BUSCO_blast_pident', 'BUSCO_blast_length', 'BUSCO_blast_mismatch', 'BUSCO_blast_gapopen', 'BUSCO_blast_qstart', 'BUSCO_blast_qend', 'BUSCO_blast_sstart', 'BUSCO_blast_send', 'BUSCO_blast_evalue', 'BUSCO_blast_bitscore', 'BUSCO_blast_qseq', 'BUSCO_blast_sseq')
merged_data2 <- merged_data2[, !(names(merged_data2) %in% columns_to_remove)]
merged_data2$IG_five_prime <- abs(merged_data2$IG_five_prime)
merged_data2$IG_three_prime <- abs(merged_data2$IG_three_prime)

merged_data9 <- merged_data2


#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################

#permutation test

setwd("C:/Users/did23faz/OneDrive - Norwich Bioscience Institutes/Desktop/R")

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste("p112020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
text <- print(paste("_", "_", "_","_", "_"))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################################################################################################


#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste("p112020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[df_all$outgroup_orthology_match == 0 & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("p112020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("p112020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("OGB2019 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("OGB2019 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("SCOTT2020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("SCOTT2020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

df_all <- df

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_five_prime, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_five_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$IG_five_prime)
text <- print(paste("DRCT72020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
mean_other1 <- mean(subset(df_filtered$IG_three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$IG_three_prime, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$IG_three_prime)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$IG_three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$IG_three_prime)
text <- print(paste("DRCT72020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$IG_five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$IG_three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(IG_five_prime) & IG_five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(IG_three_prime) & IG_three_prime != 99999)
df_filtered <- df_filtered3 
df_filtered$total_IG = df_filtered$IG_five_prime + df_filtered$IG_three_prime

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
average <- mean(df_filtered$total_IG)

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)
