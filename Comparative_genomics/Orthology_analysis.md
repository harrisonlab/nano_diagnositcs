# Powdery mildew orthology and comparative genomics analysis pipeline

Documentation of analysis and commands used for comparative genomics work as part of Nano Diagnostics PhD. - This file documents effector prediction within the three P. aphanis and three P. leucotricha genome assemblies generated previously, and comparison of orthogroups between the two species.

Genomes assembled and annotated in nano_diagnostics/P_aphanis and nano_diagnostics/P_leucotricha 

All the following commands were executed on the Crop Diversity HPC from the folder /home/theaven/scratch unless stated otherwise.

### Format fasta files
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
Fasta_file=/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta
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
OutDir=orthofinder52000
sbatch /home/theaven/scratch/apps/orthomcl/orthofinder.sh $Input_dir $Prefix $OutDir	
conda deactivate
#19684204
#19687639
 ```