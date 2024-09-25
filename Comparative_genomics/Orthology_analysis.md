# Powdery mildew orthology and comparative genomics analysis pipeline

Documentation of analysis and commands used for comparative genomics work as part of Nano Diagnostics PhD. - This file documents effector prediction within the three P. aphanis and three P. leucotricha genome assemblies generated previously, and comparison of orthogroups between the two species.

Genomes assembled and annotated in nano_diagnostics/P_aphanis and nano_diagnostics/P_leucotricha 

All the following commands were executed on the Crop Diversity HPC from the folder /home/theaven/scratch unless stated otherwise.

### Format fasta files
```bash
cat /home/theaven/scratch/uncompressed/analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt /home/theaven/scratch/uncompressed/analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt > AP.txt
cat /home/theaven/scratch/uncompressed/analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt /home/theaven/scratch/uncompressed/analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt > ST.txt

python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file AP.txt --input /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta --output best_aphanis_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ST.txt --input /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta --output best_leucotricha_consensus_gene.fasta
```
```bash
ProjDir=/home/theaven/scratch/uncompressed/orthomcl2
cd $ProjDir
IsolateAbrv=All_mildew
WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
mkdir -p $WorkDir
mkdir -p $WorkDir/formatted
mkdir -p $WorkDir/goodProteins
mkdir -p $WorkDir/badProteins  

Id_field=1
Taxon_code=Bg01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417025.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417865.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg04
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000418435.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg05
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000441875.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg06
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_900519115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bg07
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bgs1
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bgs2
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bgs3
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bgs4
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bgs5
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bh01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_000401675.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bh02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bh03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Bh04
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900638725.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Ea01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/alphitoides/CLCBIO/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798755.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En04
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798775.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En05
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En06
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta #sketch
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=En07
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Ene1
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/neolycopersici/GCA_003610855.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Ep01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000208805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Ep02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000214055.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Epu1
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/pulchra/GCA_002918395.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Gc01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611195.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Gc02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611215.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Gc03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Gm01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Go01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Golovinomyces/orontii/MGH1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Lt01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Oh01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Oidium/heveae/GCA_003957845.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pp01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pm01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Phyllactinia/moricola/GCA_019455665.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Ps01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Pleochaeta/shiraiana/GCA_019455505.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pa01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pa02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pa03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pc01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/cerasii/GCA_018398735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pf01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pl01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pl02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pl03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Pl04
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Px01
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_010015925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Px02
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_014884795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=Px03
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=PlXX
Fasta_file=/home/theaven/scratch/uncompressed/best_leucotricha_consensus_gene.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
Taxon_code=PaXX
Fasta_file=/home/theaven/scratch/uncompressed/best_aphanis_consensus_gene.fasta
/home/theaven/scratch/apps/orthomcl/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

for WorkDir in $(ls -d analysis/orthology/orthofinder/*); do
ProgDir=/home/heavet/git_repos/tools/gene_prediction
Input_dir=$WorkDir/formatted
Min_length=10
Max_percent_stops=20
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
/home/theaven/scratch/apps/orthomcl/orthomclFilterFasta.pl $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file
done

conda activate orthofinder
Prefix=all_mildew
OutDir=orthofinder52000-2
sbatch /home/theaven/scratch/apps/orthomcl/orthofinder.sh $Input_dir $Prefix $OutDir	
conda deactivate
#19684204
#19687639
#22461276

ls /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.tsv
ls /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.GeneCount.tsv
ls /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Phylogenetic_Hierarchical_Orthogroups

#reroot the tree in itol (for CAFE analysis only genes present in the root species are retained in the analysis, tree was therefore rerooted to Parauncinula polyspora):
nano /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt

#count the sites in the alignment used to make the tree:
seqkit fx2tab -l /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}'

echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees; " >> r8s_ctl_file-m.txt
#echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/mildew-iq-reroot.txt)" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/SpeciesTree_rooted.txt)" >> r8s_ctl_file-m.txt
echo "End;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=3121748 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 Bg02 Ep01;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Pa01 Ep01;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_1 min_age=53.2 max_age=75;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=53.2 max_age=75;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt
#tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/iqtree_rerooted_r8s.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/mildew-only-tree_r8s.txt

mkdir /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe
cp /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.GeneCount.tsv /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe/.
awk 'BEGIN { FS=OFS="\t" } { print "n/a", $0 }' /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe/Orthogroups.GeneCount.tsv | awk 'BEGIN { FS=OFS="\t" } NR==1 { sub(/.*/, "Desc", $1) }; { print $0 }' | awk 'BEGIN { FS=OFS="\t" } { NF--; print }' > tmpfile && mv tmpfile /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe/Orthogroups.GeneCount.tsv

sbatch /home/theaven/scratch/apps/cafe/cafe5.sh /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe/Orthogroups.GeneCount.tsv /home/theaven/scratch/uncompressed/orthomcl2/analysis/cafe/mildew-only-tree_r8s.txt /home/theaven/scratch/uncompressed/orthomcl2/analysis/
#22558888










#Get consensus genes for genomes with 3 samples:
OrthoDir=/home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Px01' | grep -e 'Px02' | grep -e 'Px03' > ${OrthoDir}/xanthii_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Pl01' | grep -e 'Pl02' | grep -e 'Pl03' | grep -e 'Pl04' > ${OrthoDir}/leucotricha_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Pa01' | grep -e 'Pa02' | grep -e 'Pa03' > ${OrthoDir}/aphanis_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Gc01' | grep -e 'Gc02' | grep -e 'Gc03' > ${OrthoDir}/cichoracearum_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'En01' | grep -e 'En02' | grep -e 'En03' | grep -e 'En04' | grep -e 'En05' | grep -e 'En07' > ${OrthoDir}/necator_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Bh01' | grep -e 'Bh02' | grep -e 'Bh03' | grep -e 'Bh04' > ${OrthoDir}/hordei_orthogroups.tsv
cat ${OrthoDir}/Orthogroups.tsv | grep -e 'Bg01' | grep -e 'Bg02' | grep -e 'Bg03' | grep -e 'Bg04' | grep -e 'Bg05' | grep -e 'Bg06' | grep -e 'Bg07' > ${OrthoDir}/graminis_orthogroups.tsv

awk -F'\t' '{split($51, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/xanthii_orthogroups.tsv > ${OrthoDir}/xanthii_consensus_gene.txt #7008
awk -F'\t' '{split($45, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/leucotricha_orthogroups.tsv > ${OrthoDir}/leucotricha_consensus_gene.txt #8207
awk -F'\t' '{split($37, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/aphanis_orthogroups.tsv > ${OrthoDir}/aphanis_consensus_gene.txt #8814
awk -F'\t' '{split($31, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/cichoracearum_orthogroups.tsv > ${OrthoDir}/cichoracearum_consensus_gene.txt #9370
awk -F'\t' '{split($25, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/necator_orthogroups.tsv > ${OrthoDir}/necator_consensus_gene.txt #8481
awk -F'\t' '{split($16, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/hordei_orthogroups.tsv > ${OrthoDir}/hordei_consensus_gene.txt #7634
awk -F'\t' '{split($8, arr, ","); for (i in arr) {split(arr[i], subarr, "|"); print subarr[2]}}' ${OrthoDir}/graminis_orthogroups.tsv > ${OrthoDir}/graminis_consensus_gene.txt #7701

python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/xanthii_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/xanthii_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/leucotricha_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/leucotricha_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/aphanis_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/aphanis_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/cichoracearum_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/cichoracearum_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/necator_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/necator_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/hordei_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/hordei_consensus_gene.fasta
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file ${OrthoDir}/graminis_consensus_gene.txt --input /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output ${OrthoDir}/graminis_consensus_gene.fasta

for fasta in $(ls /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/*_consensus_gene.fasta); do
python3 /home/theaven/scratch/apps/tools/longest_variant.py $fasta $(echo $fasta | sed 's@.fasta@.longest.faa@g')
done

python3 /home/theaven/scratch/apps/tools/longest_variant.py /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.longest.faa


python3 /home/theaven/scratch/apps/tools/longest_variant.py /home/theaven/scratch/uncompressed/best_leucotricha_consensus_gene.fasta /home/theaven/scratch/uncompressed/best_leucotricha_consensus_gene_longest.fasta
python3 /home/theaven/scratch/apps/tools/longest_variant.py /home/theaven/scratch/uncompressed/best_aphanis_consensus_gene.fasta /home/theaven/scratch/uncompressed/best_aphanis_consensus_gene_longest.fasta


for fasta in $(); do



ProjDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho
cd $ProjDir
IsolateAbrv=All_mildew+
WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
mkdir -p $WorkDir
mkdir -p $WorkDir/formatted
mkdir -p $WorkDir/goodProteins
mkdir -p $WorkDir/badProteins  

for Fasta_file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/*clean_final_genes.pep.longest.faa | grep -v 'CLCBIO' | grep -v 'GCA_016906895' | grep -v 'GCA_006912115.1'); do
	mkdir $(dirname $Fasta_file)/$(echo $Fasta_file | cut -d '/' -f9 | sed 's@_clean_final_genes.pep.longest.faa@@g')
	cp $Fasta_file $(dirname $Fasta_file)/$(echo $Fasta_file | cut -d '/' -f9 | sed 's@_clean_final_genes.pep.longest.faa@@g')/.
done

x=0
for Fasta_file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/*/*clean_final_genes.pep.longest.faa | grep -v 'CLCBIO' | grep -v 'GCA_016906895' | grep -v 'GCA_006912115.1'); do
    x=$(printf "%02d" $x)
    Id_field=1
    Taxon_code=$(echo $Fasta_file | cut -d '/' -f9 | cut -c 1)$(echo $Fasta_file | cut -d '/' -f9 | cut -c 5)$x
    echo -e "${Taxon_code}\t${Fasta_file}" >> orthofindercode.txt
    ~/git_repos/Scripts/NBI/orthomclAdjustFasta.pl $Taxon_code $Fasta_file $Id_field
    x=$((10#$x + 1))
    mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
done

for WorkDir in $(ls -d analysis/orthology/orthofinder/$IsolateAbrv); do
Input_dir=$WorkDir/formatted
Min_length=10
Max_percent_stops=20
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
~/git_repos/Scripts/NBI/orthomclFilterFasta.pl $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file
done

Prefix=all_mildew+
OutDir=orthofinder52000-3
sbatch ~/git_repos/Wrappers/NBI/run_orthofinder.sh $Input_dir $Prefix $OutDir
#1418511

head -n11 analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv

head -n11 analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv

head -n11 analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv

head -n11 analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv

head -n11 analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv

#reroot the tree in itol (for CAFE analysis only genes present in the root species are retained in the analysis):
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted-rerooted.txt # rooted to Cry_neo_GCF_000091045.1
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt #rooted to Parauncinula
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt #rooted to S.cerevisiae
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt #rooted to S.cerevisiae
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt #rooted to arachnopeziza

#count the sites in the alignment used to make the tree:
seqkit fx2tab -l /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}' #135586
seqkit fx2tab -l /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}' #541307
seqkit fx2tab -l /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}' #506814
seqkit fx2tab -l /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}' #479742
seqkit fx2tab -l /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/MultipleSequenceAlignments/SpeciesTreeAlignment.fa | awk '{print $1 "\t" length($2)}' #509625


source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=135586 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 Sc75 Pg71;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Sc75 Ss77;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_3 Pg71 Um80;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_4 Ss77 Fo39;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_5 En28 Bg05;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_6 Tm79 Ss77;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_7 Om52 Bc21;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_1 min_age=583.2 max_age=749.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=437.8 max_age=670.2;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_3 min_age=428.4 max_age=551.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_4 min_age=239.7 max_age=320.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_6 min_age=387.7 max_age=723.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_7 min_age=131.4 max_age=222.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=479742 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_0 Bg01 Sc48;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_1 Bg06 Bh14;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Bg01 Pp33;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_3 Bg01 Pa36;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_4 En17 Gc28;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_5 En17 Bg01;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_0 min_age=437.8 max_age=670.2;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_1 min_age=0.0 max_age=11.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_3 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
#echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/exported-47-fix.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=509625 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_1 Bg06 Bh14;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Bg01 Pp33;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_3 Bg01 Pa36;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_4 En17 Gc28;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_5 En17 Bg01;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_1 min_age=0.0 max_age=11.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_3 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_r8s.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted-r8s.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted-r8s.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/exported-47-fix-r8s.txt

singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/collpse_newick_single_node_leaves.py /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/exported-47.txt /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/exported-47.tree

#convert orthofinder orthogroup counts to CAFE format
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Orthogroups/Orthogroups.GeneCount.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Orthogroups/Orthogroups.GeneCount.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Orthogroups/Orthogroups.GeneCount.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv
awk 'BEGIN { FS=OFS="\t" } { print "n/a", $0 }' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv | awk 'BEGIN { FS=OFS="\t" } NR==1 { sub(/.*/, "Desc", $1) }; { print $0 }' | awk 'BEGIN { FS=OFS="\t" } { NF--; print }' | awk 'BEGIN { FS=OFS="\t" } { if (NR == 1) { print; next } for(i=3; i<=NF; i++) if ($i > 99) next; print }' > tmpfile && mv tmpfile /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv
awk 'BEGIN { FS=OFS="\t" } { print "n/a", $0 }' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv | awk 'BEGIN { FS=OFS="\t" } NR==1 { sub(/.*/, "Desc", $1) }; { print $0 }' | awk 'BEGIN { FS=OFS="\t" } { NF--; print }' | awk 'BEGIN { FS=OFS="\t" } { if (NR == 1) { print; next } for(i=3; i<=NF; i++) if ($i > 99) next; print }' > tmpfile && mv tmpfile /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_r8s.txt /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_lamda.txt
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_lamda.txt #edit to reflect lamda groups groups

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew+
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_r8s.txt
lamdaTree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_lamda.txt
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew-ara-cer
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara-cer/formatted/orthofinder52000-6/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted-r8s.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#1932517,1939159,1941676

grep -v 'OG0000067\|OG0005783\|OG0000308\|OG0000543\|OG0000261\|OG0006472\|OG0000202\|OG0006619\|OG0002874\|OG0000365\|OG0006390\|OG0000270\|OG0000301\|OG0007202\|OG0000602\|OG0007348\|OG0006719\|OG0000848\|OG0000430\|OG0007521' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv > temp.tsv && mv temp.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew-ara
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted-r8s.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#1932053,1939119, 1948144
#Filtering families not present at the root from: 16968 to 6377
#^ this time calibrated tree is the most plausible + requires the removal of the least OGs, however is the same phylopattern as the old mildew tree, the new one has blumeria and podosphaera switched :/

grep -v 'OG0000356\|OG0000518\|OG0000046\|OG0000056\|OG0001218\|OG0000133\|OG0000185\|OG0000100\|OG0000125\|OG0000041\|OG0005576\|OG0005574\|OG0000147\|OG0000134\|OG0000068\|OG0000220\|OG0000275\|OG0005794' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv > temp.tsv && mv temp.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew-ara-2
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/exported-47-fix-r8s.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#1948336

Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
cat $Orthogroups | grep -v -e 'RA20' | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -e 'AP19' | grep -e 'AP20' | grep -e 'AP21'

cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -e 'Bg\|Bh' | grep -e 'En\|Ep0\|Ea\|Epu\|Oh' | grep -e 'Gc\|Gm\|Go' | grep -e 'Pl\|Px\|Pa\|Pc\|Pf' | wc -l
#5,571 orthogroups found across 
cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -e 'Bg' | grep -e 'Bh' | grep -e 'En' | grep -e 'Gc' | grep -e 'Pl' | grep -e 'Px' | grep -e 'Pa' | wc -l
#4,945
cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps' | grep -e 'Pl' | grep -e 'Px' | grep -e 'Pa' | wc -l
#85

cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Px\|Pa\|Pf\|Pc' | grep -e 'Pl' | wc -l #1,426
cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Px\|Pa\|Pf\|Pc' | grep -e 'Pl01'| grep -e 'Pl02'| grep -e 'Pl03'| grep -e 'Pl04' | wc -l #144
grep -o '\.t1' leu_only.txt | wc -l #689

cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Px\|Pl\|Pf\|Pc' | grep -e 'Pa' | wc -l #943
cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Px\|Pl\|Pf\|Pc' | grep -e 'Pa01'| grep -e 'Pa02'| grep -e 'Pa03' | wc -l #63
grep -o '\.t1' aph_only.txt | wc -l #235

cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Pa\|Pl\|Pf\|Pc' | grep -e 'Px' | wc -l #309
cat /home/theaven/scratch/uncompressed/orthomcl2/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000/Results_all_mildew/Orthogroups/Orthogroups.txt | grep -v -e 'Bg\|Bh\|Ea\|En\|Ep0\|Epu\|Gc\|Gm\|Go\|Lt\|Oh\|Pp\|Pm\|Ps\|Pa\|Pl\|Pf\|Pc' | grep -e 'Px01'| grep -e 'Px02'| grep -e 'Px03' | wc -l #8
grep -o '\.t1' xan_only.txt | wc -l #30

#Enriched for effectors?

grep -e 'Bg01'
grep -e 'Bg02'
grep -e 'Bg03'
grep -e 'Bg04'
grep -e 'Bg05'
grep -e 'Bg06'
grep -e 'Bg07'
grep -e 'Bgs1'
grep -e 'Bgs2'
grep -e 'Bgs3'
grep -e 'Bgs4'
grep -e 'Bgs5'
grep -e 'Bh01'
grep -e 'Bh02'
grep -e 'Bh03'
grep -e 'Bh04'
grep -e 'Ea01'
grep -e 'En01'
grep -e 'En02'
grep -e 'En03'
grep -e 'En04'
grep -e 'En05'
grep -e 'En06'
grep -e 'En07'
grep -e 'Ene1'
grep -e 'Ep01'
grep -e 'Ep02'
grep -e 'Epu1'
grep -e 'Gc01'
grep -e 'Gc02'
grep -e 'Gc03'
grep -e 'Gm01'
grep -e 'Go01'
grep -e 'Lt01'
grep -e 'Oh01'
grep -e 'Pp01'
grep -e 'Pm01'
grep -e 'Ps01'
grep -e 'Pa01'
grep -e 'Pa02'
grep -e 'Pa03'
grep -e 'Pc01'
grep -e 'Pf01'
grep -e 'Pl01'
grep -e 'Pl02'
grep -e 'Pl03'
grep -e 'Pl04'
grep -e 'Px01'
grep -e 'Px02'
grep -e 'Px03'


source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
#echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/mVeIYJ0Mh70RS-9hu7h-Vg_newick.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=509625 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_1 Bg06 Bh14;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 BLU_HOR_GCA_900237765.1 PAR_POL_PARPO1;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_3 Bg01 Pa36;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_4 En17 Gc28;" >> r8s_ctl_file-m.txt
#echo "mrca callibration_node_5 En17 Bg01;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_1 min_age=0.0 max_age=11.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_3 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt


 ```
 ```python
from Bio import Phylo
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

def collapse_single_leaf_nodes(tree):
    for clade in tree.find_clades(order='postorder'):
        if len(clade.clades) == 1 and clade.clades[0].is_terminal():
            leaf = clade.clades[0]
            clade.branch_length = (clade.branch_length or 0) + (leaf.branch_length or 0)
            clade.clades = []

def main():
    tree = Phylo.read(input_file, "newick")
    collapse_single_leaf_nodes(tree)
    Phylo.write(tree, output_file, "newick")

if __name__ == "__main__":
    main()
```

 ```bash
#for tsv in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/predector/Prothint/*.tsv); do
for tsv in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/predector/Prothint/*_annotations3.tsv); do
clean_annotations=$(dirname $tsv | cut -d '/' -f1,2,3,4,5,6,7,8,9,10)/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
ls $clean_annotations
done

file_1_file_1_g10031.t2
 ```
 ```bash
ProjDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho
cd $ProjDir
IsolateAbrv=All_mildew-ara
WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
mkdir -p $WorkDir
mkdir -p $WorkDir/formatted
mkdir -p $WorkDir/goodProteins
mkdir -p $WorkDir/badProteins  

x=0
for Fasta_file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000151065.3/Blu_gra_GCA_000151065.3_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000417025.1/Blu_gra_GCA_000417025.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000417865.1/Blu_gra_GCA_000417865.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000418435.1/Blu_gra_GCA_000418435.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000441875.1/Blu_gra_GCA_000441875.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_900519115.1/Blu_gra_GCA_900519115.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_905067625.1/Blu_gra_GCA_905067625.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153116/Blu_gra_SRR2153116_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153117/Blu_gra_SRR2153117_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153118/Blu_gra_SRR2153118_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153119/Blu_gra_SRR2153119_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153120/Blu_gra_SRR2153120_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_000401675.1/Blu_hor_GCA_000401675.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900237765.1/Blu_hor_GCA_900237765.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900239735.1/Blu_hor_GCA_900239735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900638725.1/Blu_hor_GCA_900638725.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798715.1/Ery_nec_GCA_000798715.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798735.1/Ery_nec_GCA_000798735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798755.1/Ery_nec_GCA_000798755.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798775.1/Ery_nec_GCA_000798775.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798795.1/Ery_nec_GCA_000798795.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_024703715.1/Ery_nec_GCA_024703715.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_neo_GCA_003610855.1/Ery_neo_GCA_003610855.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pis_GCA_000208805.1/Ery_pis_GCA_000208805.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pis_GCA_000214055.1/Ery_pis_GCA_000214055.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pul_GCA_002918395.1/Ery_pul_GCA_002918395.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611195.1/Gol_cic_GCA_003611195.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611215.1/Gol_cic_GCA_003611215.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611235.1/Gol_cic_GCA_003611235.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_oro_MGH1/Gol_oro_MGH1_clean_final_genes.pep.longest.faa  /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Lev_tau_CADEPA01/Lev_tau_CADEPA01_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Oid_hev_GCA_003957845.1/Oid_hev_GCA_003957845.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Par_pol_Parp01/Par_pol_Parp01_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Phy_mor_GCA_019455665.1/Phy_mor_GCA_019455665.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ple_shi_GCA_019455505.1/Ple_shi_GCA_019455505.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_DRT72020/Pod_aph_DRT72020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_DRT72021/Pod_aph_DRT72021_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_SCOTT2020/Pod_aph_SCOTT2020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_cer_GCA_018398735.1/Pod_cer_GCA_018398735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_fus_GCA_030378345.1/Pod_fus_GCA_030378345.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_GCA_013170925.1/Pod_leu_GCA_013170925.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGB2019/Pod_leu_OGB2019_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGB2021/Pod_leu_OGB2021_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGBp112020/Pod_leu_OGBp112020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_010015925.1/Pod_xan_GCA_010015925.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_014884795.1/Pod_xan_GCA_014884795.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_028751805.1/Pod_xan_GCA_028751805.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ara_ara_GCA_003988855.1/Ara_ara_GCA_003988855.1_clean_final_genes.pep.longest.faa); do
    x=$(printf "%02d" $x)
    Id_field=1
    Taxon_code=$(echo $Fasta_file | cut -d '/' -f9 | cut -c 1)$(echo $Fasta_file | cut -d '/' -f9 | cut -c 5)$x
    echo -e "${Taxon_code}\t${Fasta_file}" >> orthofindercode.txt
    ~/git_repos/Scripts/NBI/orthomclAdjustFasta.pl $Taxon_code $Fasta_file $Id_field
    x=$((10#$x + 1))
    mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
done

for WorkDir in $(ls -d analysis/orthology/orthofinder/$IsolateAbrv); do
Input_dir=$WorkDir/formatted
Min_length=10
Max_percent_stops=20
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
~/git_repos/Scripts/NBI/orthomclFilterFasta.pl $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file
done

Prefix=all_mildew
OutDir=orthofinder52000-7
sbatch ~/git_repos/Wrappers/NBI/run_orthofinder.sh $Input_dir $Prefix $OutDir
#1486744, 1495564, 1544016, 1544028





















source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=135586 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 Sc75 Pg71;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Sc75 Ss77;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_3 Pg71 Um80;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_4 Ss77 Fo39;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_5 En28 Bg05;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_6 Tm79 Ss77;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_7 Om52 Bc21;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_1 min_age=583.2 max_age=749.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=437.8 max_age=670.2;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_3 min_age=428.4 max_age=551.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_4 min_age=239.7 max_age=320.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_6 min_age=387.7 max_age=723.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_7 min_age=131.4 max_age=222.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=541307 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 Bg05 Bh13;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 Bg00 Pp32;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_3 Bg00 Pa35;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_4 En16 Gc27;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_5 En16 Bg00;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_1 min_age=0.0 max_age=11.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_3 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt
#echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=506814 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca blumeria_node Bh13 Bg01;" >> r8s_ctl_file-m.txt
echo "mrca podosphaera_node Pf39 Pa36;" >> r8s_ctl_file-m.txt
echo "mrca golovinomyces_node Go29 Gc26;" >> r8s_ctl_file-m.txt
echo "mrca erysiphe_node Ep25 En16;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_4 min_age=437.8 max_age=670.2;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s-2.txt
#tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s.txt
#tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_r8s.txt

#convert orthofinder orthogroup counts to CAFE format
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Orthogroups/Orthogroups.GeneCount.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/.
awk 'BEGIN { FS=OFS="\t" } { print "n/a", $0 }' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv | awk 'BEGIN { FS=OFS="\t" } NR==1 { sub(/.*/, "Desc", $1) }; { print $0 }' | awk 'BEGIN { FS=OFS="\t" } { NF--; print }' | awk 'BEGIN { FS=OFS="\t" } { if (NR == 1) { print; next } for(i=3; i<=NF; i++) if ($i > 99) next; print }' > tmpfile && mv tmpfile /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_r8s.txt /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_lamda.txt
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew+/formatted/orthofinder52000-3/Results_all_mildew+/Species_Tree/SpeciesTree_rooted_lamda.txt #edit to reflect lamda groups groups

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew-47-0
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s-2.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#1543986, 1544013, 1544015, 1544045
#Filtering families not present at the root from: 15818 to 5425 - Parauncinula as root 

grep -v 'OG0000037\|OG0000028\|OG0000034\|OG0000019\|OG0000013\|OG0000051\|OG0000032\|OG0000026\|OG0000024\|OG0000054\|OG0000033\|OG0000058\|OG0000022\|OG0000029\|OG0000076\|OG0000043\|OG0000112\|OG0002765\|OG0000068\|OG0000040' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv > temp.tsv && mv temp.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv

grep -v 'OG0000097\|OG0000101\|OG0000216\|OG0000069\|OG0000059\|OG0000049\|OG0000132\|OG0000110\|OG0000108\|OG0000050\|OG0000224\|OG0000250\|OG0000304\|OG0000144\|OG0000106\|OG0000179\|OG0000203\|OG0000189\|OG0000503' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv > temp.tsv && mv temp.tsv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount.tsv
 ```
```bash
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho
for fasta in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000151065.3/Blu_gra_GCA_000151065.3_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000417025.1/Blu_gra_GCA_000417025.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000417865.1/Blu_gra_GCA_000417865.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000418435.1/Blu_gra_GCA_000418435.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_000441875.1/Blu_gra_GCA_000441875.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_900519115.1/Blu_gra_GCA_900519115.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_GCA_905067625.1/Blu_gra_GCA_905067625.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153116/Blu_gra_SRR2153116_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153117/Blu_gra_SRR2153117_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153118/Blu_gra_SRR2153118_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153119/Blu_gra_SRR2153119_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_gra_SRR2153120/Blu_gra_SRR2153120_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_000401675.1/Blu_hor_GCA_000401675.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900237765.1/Blu_hor_GCA_900237765.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900239735.1/Blu_hor_GCA_900239735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Blu_hor_GCA_900638725.1/Blu_hor_GCA_900638725.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798715.1/Ery_nec_GCA_000798715.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798735.1/Ery_nec_GCA_000798735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798755.1/Ery_nec_GCA_000798755.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798775.1/Ery_nec_GCA_000798775.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_000798795.1/Ery_nec_GCA_000798795.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_nec_GCA_024703715.1/Ery_nec_GCA_024703715.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_neo_GCA_003610855.1/Ery_neo_GCA_003610855.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pis_GCA_000208805.1/Ery_pis_GCA_000208805.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pis_GCA_000214055.1/Ery_pis_GCA_000214055.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ery_pul_GCA_002918395.1/Ery_pul_GCA_002918395.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611195.1/Gol_cic_GCA_003611195.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611215.1/Gol_cic_GCA_003611215.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_cic_GCA_003611235.1/Gol_cic_GCA_003611235.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Gol_oro_MGH1/Gol_oro_MGH1_clean_final_genes.pep.longest.faa  /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Lev_tau_CADEPA01/Lev_tau_CADEPA01_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Oid_hev_GCA_003957845.1/Oid_hev_GCA_003957845.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Par_pol_Parp01/Par_pol_Parp01_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Phy_mor_GCA_019455665.1/Phy_mor_GCA_019455665.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ple_shi_GCA_019455505.1/Ple_shi_GCA_019455505.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_DRT72020/Pod_aph_DRT72020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_DRT72021/Pod_aph_DRT72021_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_aph_SCOTT2020/Pod_aph_SCOTT2020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_cer_GCA_018398735.1/Pod_cer_GCA_018398735.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_fus_GCA_030378345.1/Pod_fus_GCA_030378345.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_GCA_013170925.1/Pod_leu_GCA_013170925.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGB2019/Pod_leu_OGB2019_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGB2021/Pod_leu_OGB2021_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_leu_OGBp112020/Pod_leu_OGBp112020_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_010015925.1/Pod_xan_GCA_010015925.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_014884795.1/Pod_xan_GCA_014884795.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Pod_xan_GCA_028751805.1/Pod_xan_GCA_028751805.1_clean_final_genes.pep.longest.faa /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download4/Ara_ara_GCA_003988855.1/Ara_ara_GCA_003988855.1_clean_final_genes.pep.longest.faa); do
Species=$(basename $fasta | sed 's@_clean_final_genes.pep.longest.faa@@g')
echo $Species
sed '/^>/ s/$/ \['"$Species"'\]/' $fasta >> /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/mixed_genome_fasta4.faa
done

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho
OutFile="47-mildew-4"
Fasta=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/mixed_genome_fasta4.faa
Evalue="1-e2"
sbatch ~/git_repos/Wrappers/NBI/run_fastortho.sh $OutDir $OutFile $Fasta $Evalue
#1491753, 1495520, 1544018, 1544027

source /hpc-home/did23faz/mamba/bin/activate python2
python ~/git_repos/Scripts/NBI/mcl2rawcafe.py -i /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew.end -o /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.txt -sp "Blu_gra_GCA_000151065.3 Blu_gra_GCA_000417025.1 Blu_gra_GCA_000417865.1 Blu_gra_GCA_000418435.1 Blu_gra_GCA_000441875.1 Blu_gra_GCA_900519115.1 Blu_gra_GCA_905067625.1 Blu_gra_SRR2153116 Blu_gra_SRR2153117 Blu_gra_SRR2153118 Blu_gra_SRR2153119 Blu_gra_SRR2153120 Blu_hor_GCA_000401675.1 Blu_hor_GCA_900237765.1 Blu_hor_GCA_900239735.1 Blu_hor_GCA_900638725.1 Ery_nec_GCA_000798715.1 Ery_nec_GCA_000798735.1 Ery_nec_GCA_000798755.1 Ery_nec_GCA_000798775.1 Ery_nec_GCA_000798795.1 Ery_nec_GCA_024703715.1 Ery_neo_GCA_003610855.1 Ery_pis_GCA_000208805.1 Ery_pis_GCA_000214055.1 Ery_pul_GCA_002918395.1 Gol_cic_GCA_003611195.1 Gol_cic_GCA_003611215.1 Gol_cic_GCA_003611235.1 Gol_oro_MGH1 Lev_tau_CADEPA01 Oid_hev_GCA_003957845.1 Par_pol_Parp01 Phy_mor_GCA_019455665.1 Ple_shi_GCA_019455505.1 Pod_aph_DRT72020 Pod_aph_DRT72021 Pod_aph_SCOTT2020 Pod_cer_GCA_018398735.1 Pod_fus_GCA_030378345.1 Pod_leu_GCA_013170925.1 Pod_leu_OGB2019 Pod_leu_OGB2021 Pod_leu_OGBp112020 Pod_xan_GCA_010015925.1 Pod_xan_GCA_014884795.1 Pod_xan_GCA_028751805.1"


sed -i -e 's@Blu_gra_GCA_000151065.3@Bg00@g' \
-e 's@Blu_gra_GCA_000417025.1@Bg01@g' \
-e 's@Blu_gra_GCA_000417865.1@Bg02@g' \
-e 's@Blu_gra_GCA_000418435.1@Bg03@g' \
-e 's@Blu_gra_GCA_000441875.1@Bg04@g' \
-e 's@Blu_gra_GCA_900519115.1@Bg05@g' \
-e 's@Blu_gra_GCA_905067625.1@Bg06@g' \
-e 's@Blu_gra_SRR2153116@Bg07@g' \
-e 's@Blu_gra_SRR2153117@Bg08@g' \
-e 's@Blu_gra_SRR2153118@Bg09@g' \
-e 's@Blu_gra_SRR2153119@Bg10@g' \
-e 's@Blu_gra_SRR2153120@Bg11@g' \
-e 's@Blu_hor_GCA_000401675.1@Bh12@g' \
-e 's@Blu_hor_GCA_900237765.1@Bh13@g' \
-e 's@Blu_hor_GCA_900239735.1@Bh14@g' \
-e 's@Blu_hor_GCA_900638725.1@Bh15@g' \
-e 's@Ery_nec_GCA_000798715.1@En16@g' \
-e 's@Ery_nec_GCA_000798735.1@En17@g' \
-e 's@Ery_nec_GCA_000798755.1@En18@g' \
-e 's@Ery_nec_GCA_000798775.1@En19@g' \
-e 's@Ery_nec_GCA_000798795.1@En20@g' \
-e 's@Ery_nec_GCA_024703715.1@En21@g' \
-e 's@Ery_neo_GCA_003610855.1@En22@g' \
-e 's@Ery_pis_GCA_000208805.1@Ep23@g' \
-e 's@Ery_pis_GCA_000214055.1@Ep24@g' \
-e 's@Ery_pul_GCA_002918395.1@Ep25@g' \
-e 's@Gol_cic_GCA_003611195.1@Gc26@g' \
-e 's@Gol_cic_GCA_003611215.1@Gc27@g' \
-e 's@Gol_cic_GCA_003611235.1@Gc28@g' \
-e 's@Gol_oro_MGH1@Go29@g' \
-e 's@Lev_tau_CADEPA01@Lt30@g' \
-e 's@Oid_hev_GCA_003957845.1@Oh31@g' \
-e 's@Par_pol_Parp01@Pp32@g' \
-e 's@Phy_mor_GCA_019455665.1@Pm33@g' \
-e 's@Ple_shi_GCA_019455505.1@Ps34@g' \
-e 's@Pod_aph_DRT72020@Pa35@g' \
-e 's@Pod_aph_DRT72021@Pa36@g' \
-e 's@Pod_aph_SCOTT2020@Pa37@g' \
-e 's@Pod_cer_GCA_018398735.1@Pc38@g' \
-e 's@Pod_fus_GCA_030378345.1@Pf39@g' \
-e 's@Pod_leu_GCA_013170925.1@Pl40@g' \
-e 's@Pod_leu_OGB2019@Pl41@g' \
-e 's@Pod_leu_OGB2021@Pl42@g' \
-e 's@Pod_leu_OGBp112020@Pl43@g' \
-e 's@Pod_xan_GCA_010015925.1@Px44@g' \
-e 's@Pod_xan_GCA_014884795.1@Px45@g' \
-e 's@Pod_xan_GCA_028751805.1@Px46@g' \
/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.txt

awk 'BEGIN { FS=OFS="\t" } { if (NR == 1) { print; next } for(i=3; i<=NF; i++) if ($i > 99) next; print }' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.txt > tmpfile && mv tmpfile /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.tsv

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile="47-mildew"
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s-2.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#1543983, 1544019, 1544036, 1544038
#Filtering families not present at the root from: 33236 to 5450 - Parauncinula as root


#You may want to try removing the top few families with the largest difference
#between the max and min counts and then re-run the analysis.
#Failed to initialize any reasonable values
#Families with largest size differentials:
#1: 290
#4: 63
#5: 63
#6: 31
#45: 26

awk 'BEGIN { FS=OFS="\t" } { if (NR == 1) { print; next } for(i=3; i<=NF; i++) if ($i > 99) next; print }' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew-2_cafe_input.txt > tmpfile && mv tmpfile /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew-2_cafe_input.tsv

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile="47-mildew-2"
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew-2_cafe_input.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s.txt
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree



#Filtering families not present at the root from: 33488 to 3355 - yeast as root


cafe5 -i /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew_cafe_input.txt -t /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew/formatted/orthofinder52000-4/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s-2.txt --cores 32 -k 3 -e

cafe5 -i counts.tsv -t tree.txt -e

cafe5 -i /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/fastortho/47-mildew-2_cafe_input.txt -t /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-2/formatted/orthofinder52000-5/Results_all_mildew/Species_Tree/SpeciesTree_rooted_r8s.txt -o /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/test_results2

srun -p jic-short -c 32 --mem 50G --pty bash

cafe5 -i $Orthogroups -t $Tree -o ${OutDir}/${OutFile}_results --cores $cpu 
cafe5 -i $Orthogroups -t $Tree -o ${OutDir}/${OutFile}_results_k3 --cores $cpu -k 3 
cafe5 -i $Orthogroups -t $Tree -o ${OutDir}/${OutFile}_results_p_k3 --cores $cpu -p -k 3 
```

```bash
sed -i -e 's@BLU_GRA_GCA_000151065.3@Bg01@g' \
-e 's@BLU_GRA_GCA_000417025.1@Bg02@g' \
-e 's@BLU_GRA_GCA_000417865.1@Bg03@g' \
-e 's@BLU_GRA_GCA_000418435.1@Bg04@g' \
-e 's@BLU_GRA_GCA_000441875.1@Bg05@g' \
-e 's@BLU_HOR_GCA_900519115.1@Bg06@g' \
-e 's@BLU_GRA_GCA_905067625.1@Bg07@g' \
-e 's@BLU_GRA_SRR2153116@Bg08@g' \
-e 's@BLU_GRA_SRR2153117@Bg09@g' \
-e 's@BLU_GRA_SRR2153118@Bg10@g' \
-e 's@BLU_GRA_SRR2153119@Bg11@g' \
-e 's@BLU_GRA_SRR2153120@Bg12@g' \
-e 's@BLU_HOR_GCA_000401675.1@Bh13@g' \
-e 's@BLU_HOR_GCA_900237765.1@Bh14@g' \
-e 's@BLU_HOR_GCA_900239735.1@Bh15@g' \
-e 's@BLU_HOR_GCA_900638725.1@Bh16@g' \
-e 's@ERY_NEC_GCA_000798715.1@En17@g' \
-e 's@ERY_NEC_GCA_000798735.1@En18@g' \
-e 's@ERY_NEC_GCA_000798755.1@En19@g' \
-e 's@ERY_NEC_GCA_000798775.1@En20@g' \
-e 's@ERY_NEC_GCA_000798795.1@En21@g' \
-e 's@ERY_NEC_GCA_024703715.1@En22@g' \
-e 's@ERY_NEO_GCA_003610855.1@En23@g' \
-e 's@ERY_PIS_GCA_000208805.1@Ep24@g' \
-e 's@ERY_PIS_GCA_000214055.1@Ep25@g' \
-e 's@ERY_PUL_GCA_002918395.1@Ep26@g' \
-e 's@GOL_CIC_GCA_003611195.1@Gc27@g' \
-e 's@GOL_CIC_GCA_003611215.1@Gc28@g' \
-e 's@GOL_CIC_GCA_003611235.1@Gc29@g' \
-e 's@GOL_ORO_MGH1@Go30@g' \
-e 's@LEV_TAU_CADEPA01@Lt31@g' \
-e 's@ERY_QUE_GCA_003957845.1@Oh32@g' \
-e 's@PAR_POL_PARPO1@Pp33@g' \
-e 's@PHY_MOR_GCA_019455665.1@Pm34@g' \
-e 's@PLE_SHI_GCA_019455505.1@Ps35@g' \
-e 's@POD_APH_DRCT72020@Pa36@g' \
-e 's@POD_APH_DRCT72021@Pa37@g' \
-e 's@POD_APH_SCOTT2020@Pa38@g' \
-e 's@POD_CER_GCA_018398735.1@Pc39@g' \
-e 's@POD_FUS_GCA_030378345.1@Pf40@g' \
-e 's@POD_LEU_GCA_013170925.1@Pl41@g' \
-e 's@POD_LEU_P112019@Pl42@g' \
-e 's@POD_LEU_OGB2021@Pl43@g' \
-e 's@POD_LEU_OGB2020@Pl44@g' \
-e 's@POD_XAN_GCA_010015925.1@Px45@g' \
-e 's@POD_XAN_GCA_014884795.1@Px46@g' \
-e 's@POD_XAN_GCA_028751805.1@Px47@g' \
-e 's@ARA_ARA_GCA_003988855.1@Aa00@g' \
/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6-r8s.tree

OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe
OutFile=All_mildew-ara-pruned-species-tree2
Orthogroups=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/Orthogroups.GeneCount-7.tsv
Tree=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6-r8s.tree
lamdaTree=NA
sbatch ~/git_repos/Wrappers/NBI/run_cafe5.sh $OutDir $OutFile $Orthogroups $Tree $lamdaTree
#2132215,2275288
```

