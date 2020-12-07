# P.aphanis genome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis sampled from strawberry as part of Nano Diagnistics PhD.

## Collecting data

All following commands were exectuted from the folder:
```bash
/projects/nano_diagnostics
```
Raw MiSeq sequence data for P.aphanis was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/DRCT72020_1_f.fq.gz

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/DRCT72020_1_r.fq.gz

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_1_f.fq.gz
ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_1_r.fq.gz
```
The fragaria ananassa 'camarosa' genome was linked from its download location. Originally downloaded from rosaceae.org/species/fragaria/
```bash
mkdir -p assembly/genome/fragaria/ananassa

ln -s /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.fasta
```
There is no published P. aphanis genome assembly for comparison, the P/ leucotricha genome is assumed to be the most closely related available.

The existing Podosphaera leucotricha was downloaded.
```bash
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales
wget -P P_leocotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip P_leocotricha/JAATOF01.1.fsa_nt.gz
cd /projects/nano_diagnostics

samtools faidx assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
```
A low coverage unpublished P.aphanis genome assembly was accessed
```bash
mkdir -p /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/

cp -s -r /projects/oldhome/groups/harrisonlab/project_files/podosphaera/assembly/spades/P.aphanis/ /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/
```
The wheat powdery  mildew genome was downloaded
```bash
wget -P assembly/genome/NCBI/erysiphales/B_graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz
```
The grape powdery mildew genome was downloaded
```bash
wget -P assembly/genome/NCBI/erysiphales/E_necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna.gz
```
Our P.aphanis transcriptome is accessed at:
```bash
ls assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/assembly/Trinity.fasta
```
The podosphaera xanthii shotgun assembled transcriptome was downloaded - assembled using trinity by Angelini et al.
```bash
mkdir -p rawdata/P_xanthii/AngeliniExp/transcriptome/

cd rawdata/P_xanthii/AngeliniExp/transcriptome/

#no download from ncbi available
wget ftp://ftp.ebi.ac.uk/pub/databases/ena/tsa/public/gh/GHEF01.fasta.gz

gunzip GHEF01.fasta.gz 
```
The podosphaera pannosa transcriptome was downloaded - assembled using trinity by N.Fonseca
```bash
mkdir -p rawdata/P_pannosa/N_FonsecaExp/transcriptome/

srun -p long --pty bash

cd rawdata/P_pannosa/N_FonsecaExp/transcriptome/

wget https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/GH/DE/GHDE01/GHDE01.1.fsa_nt.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/GH/DE/GHDE01/GHDE01.1.gbff.gz

gunzip GHDE01.1.fsa_nt.gz # fasta file

gunzip GHDE01.1.gbff.gz #Genebank file
```

## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_aphanis/*/*/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#615754
#615755

#The number of raw reads were counted:

cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/DRCT72020_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#46,331,871
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/DRCT72020_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#46,331,871
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. 
```bash
for ReadDir in $(ls -d rawdata/P_aphanis/*/THeavenDRCT72020_1/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5,6 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#615756

#The number of trimmed reads were counted:
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#44,242,374
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,596,379
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#44,242,374
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#350,503
```
The data was visualised following trimming.
```bash
for QCData in $(ls dna_qc/P_aphanis/*/THeavenDRCT72020_1/*/*/*/*.fq.gz); do
echo $QCData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#615768
#615769
#615770
#615771
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the Fragaria ananassa 'camarosa' genome.
```bash
screen -r
srun -p long  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa
bowtie2-build /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta camarosa_index

#An alignment of trimmed reads including unpaired reads was made to the camarosa strawberry genome, this produced a 14.04% overall alignment rate.
bowtie2 \
-x camarosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcamarosa.sam \
--un-gz THeavenDRCT72020_1unalignedcamarosa_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedcamarosa_fr.fq.gz \
-S THeavenDRCT72020_1alignedcamarosa.sam
echo finished

#46,189,256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    38395981 (86.79%) aligned concordantly 0 times
#    1313991 (2.97%) aligned concordantly exactly 1 time
#    4532402 (10.24%) aligned concordantly >1 times
#    ----
#    38395981 pairs aligned concordantly 0 times; of these:
#      19967 (0.05%) aligned discordantly 1 time
#    ----
#    38376014 pairs aligned 0 times concordantly or discordantly; of these:
#      76752028 mates make up the pairs; of these:
#        75932851 (98.93%) aligned 0 times
#        207939 (0.27%) aligned exactly 1 time
#        611238 (0.80%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1806338 (92.78%) aligned 0 times
#    20004 (1.03%) aligned exactly 1 time
#    120540 (6.19%) aligned >1 times
#14.04% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the ganan apple powdery mildew genome, this produced a 14.37% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/ganan_P_leucotricha
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/ganan_P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa ganan_P_leucotricha_index
bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedGananPleucotricha.sam \
-S THeavenDRCT72020_1alignedGananPleucotricha.sam
echo finished

#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    40057224 (90.54%) aligned concordantly 0 times
#    3369464 (7.62%) aligned concordantly exactly 1 time
#    815686 (1.84%) aligned concordantly >1 times
#    ----
#    40057224 pairs aligned concordantly 0 times; of these:
#      208102 (0.52%) aligned discordantly 1 time
#    ----
#    39849122 pairs aligned 0 times concordantly or discordantly; of these:
#      79698244 mates make up the pairs; of these:
#        75761277 (95.06%) aligned 0 times
#        2947021 (3.70%) aligned exactly 1 time
#        989946 (1.24%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1679770 (86.28%) aligned 0 times
#    235482 (12.10%) aligned exactly 1 time
#    31630 (1.62%) aligned >1 times
#14.37% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the low coverage P_aphanis powdery mildew genome, this produced a 58.71% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta cockerton_P_aphanis_index
bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_P_aphanis.sam \
-S THeavenDRCT72020_1alignedcockerton_P_aphanis.sam
echo finished

#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    21433685 (48.45%) aligned concordantly 0 times
#    20002748 (45.21%) aligned concordantly exactly 1 time
#    2805941 (6.34%) aligned concordantly >1 times
#    ----
#    21433685 pairs aligned concordantly 0 times; of these:
#      751443 (3.51%) aligned discordantly 1 time
#    ----
#    20682242 pairs aligned 0 times concordantly or discordantly; of these:
#      41364484 mates make up the pairs; of these:
#        36751817 (88.85%) aligned 0 times
#        2176622 (5.26%) aligned exactly 1 time
#        2436045 (5.89%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    588308 (30.22%) aligned 0 times
#    1155433 (59.35%) aligned exactly 1 time
#    203141 (10.43%) aligned >1 times
#58.71% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the wheat powdery mildew genome, this produced a 2.17% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/P_graminis
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/P_graminis
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna P_graminis_index
bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedP_graminis.sam \
--un-gz THeavenDRCT72020_1unalignedP_graminis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedP_graminis_fr.fq.gz \
-S THeavenDRCT72020_1alignedP_graminis.sam
echo finished
#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    43539730 (98.41%) aligned concordantly 0 times
#    59027 (0.13%) aligned concordantly exactly 1 time
#    643617 (1.45%) aligned concordantly >1 times
#    ----
#    43539730 pairs aligned concordantly 0 times; of these:
#      2560 (0.01%) aligned discordantly 1 time
#    ----
#    43537170 pairs aligned 0 times concordantly or discordantly; of these:
#      87074340 mates make up the pairs; of these:
#        86551805 (99.40%) aligned 0 times
#        261616 (0.30%) aligned exactly 1 time
#        260919 (0.30%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1914759 (98.35%) aligned 0 times
#    14070 (0.72%) aligned exactly 1 time
#    18053 (0.93%) aligned >1 times
#2.17% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the grape powdery mildew genome, this produced a 3.96% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/E_necator
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/E_necator
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna E_necator_index
bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedE_necator.sam \
--un-gz THeavenDRCT72020_1unalignedE_necator_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedE_necator_fr.fq.gz \
-S THeavenDRCT72020_1alignedE_necator.sam
echo finished
#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    43056994 (97.32%) aligned concordantly 0 times
#    993623 (2.25%) aligned concordantly exactly 1 time
#    191757 (0.43%) aligned concordantly >1 times
#    ----
#    43056994 pairs aligned concordantly 0 times; of these:
#      21321 (0.05%) aligned discordantly 1 time
#    ----
#    43035673 pairs aligned 0 times concordantly or discordantly; of these:
#      86071346 mates make up the pairs; of these:
#        85021183 (98.78%) aligned 0 times
#        893916 (1.04%) aligned exactly 1 time
#        156247 (0.18%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1833481 (94.18%) aligned 0 times
#    58706 (3.02%) aligned exactly 1 time
#    54695 (2.81%) aligned >1 times
#3.96% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the P.xanthii transcriptome, this produced a 11.98% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Angelini_P_xanthii
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Angelini_P_xanthii
bowtie2-build /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta Angelini_P_xanthii_index
bowtie2 \
-x Angelini_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedAngelini_P_xanthii.sam \
--un-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_fr.fq.gz \
-S THeavenDRCT72020_1alignedAngelini_P_xanthii.sam
echo finished
#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    40590633 (91.75%) aligned concordantly 0 times
#    2588552 (5.85%) aligned concordantly exactly 1 time
#    1063189 (2.40%) aligned concordantly >1 times
#    ----
#    40590633 pairs aligned concordantly 0 times; of these:
#      172945 (0.43%) aligned discordantly 1 time
#    ----
#    40417688 pairs aligned 0 times concordantly or discordantly; of these:
#      80835376 mates make up the pairs; of these:
#        77788227 (96.23%) aligned 0 times
#        1731587 (2.14%) aligned exactly 1 time
#        1315562 (1.63%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1807345 (92.83%) aligned 0 times
#    88733 (4.56%) aligned exactly 1 time
#    50804 (2.61%) aligned >1 times
#11.98% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the P.pannosa transcriptome, this produced a 6.36% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Fonseca_P_pannosa
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Fonseca_P_pannosa
bowtie2-build /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt Fonseca_P_pannosa_index
bowtie2 \
-x Fonseca_P_pannosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedFonseca_P_pannosa.sam \
--un-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_fr.fq.gz \
-S THeavenDRCT72020_1alignedFonseca_P_pannosa.sam
echo finished
#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    42358839 (95.74%) aligned concordantly 0 times
#    1156136 (2.61%) aligned concordantly exactly 1 time
#    727399 (1.64%) aligned concordantly >1 times
#    ----
#    42358839 pairs aligned concordantly 0 times; of these:
#      85156 (0.20%) aligned discordantly 1 time
#    ----
#    42273683 pairs aligned 0 times concordantly or discordantly; of these:
#      84547366 mates make up the pairs; of these:
#        82795645 (97.93%) aligned 0 times
#        1054563 (1.25%) aligned exactly 1 time
#        697158 (0.82%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    1886567 (96.90%) aligned 0 times
#    30097 (1.55%) aligned exactly 1 time
#    30218 (1.55%) aligned >1 times
#6.36% overall alignment rate
```
### Coverage
There is no existing genome to use for estimated coverage.
```bash
#Basic coverage calculation; coverage=(readlength*readnumber)/genomelength
(350bp x 46,189,256 reads)/39,000,000 = 414.5

#kmer counting was performed using kmc This allowed estimation of sequencing depth and total genome size. This excludes unpaired trimmed data.
conda activate kmc
for TrimPath in $(ls -d dna_qc/*/*/THeavenDRCT72020_1/*/*); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc
    TrimF=$(ls $TrimPath/F/*m.fq.gz)
    TrimR=$(ls $TrimPath/R/*m.fq.gz)
    echo $TrimF
    echo $TrimR
    sbatch $ProgDir/kmc_kmer_counting.sh $TrimF $TrimR
done
#615841 - fails
for TrimPath in $(ls -d dna_qc/*/*/THeavenDRCT72020_1/*/*); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc
    TrimF=$(ls $TrimPath/F/*m.fq.gz)
    TrimR=$(ls $TrimPath/R/*m.fq.gz)
    TrimunF=$(ls $TrimPath/F/*d.fq.gz)
    TrimunR=$(ls $TrimPath/R/*d.fq.gz)
    echo $TrimF
    echo $TrimR
    echo $TrimunF
    echo $TrimunR
    sbatch $ProgDir/kmc_kmer_counting.sh $TrimF $TrimR
done


#Coverage of the sequence data was also estimated via alignmnet with the unpublished low coverage P.aphanis assembly.
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
samtools view --threads 8 -bS THeavenDRCT72020_1alignedcockerton_P_aphanis.sam -o THeavenDRCT72020_1alignedcockerton_P_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_P_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam -o coverage.txt
#Coverage x136.8 14209/17365 contigs
```
### Kmer analysis toolkit
The quality of the first round of sequencing data was assessed using KAT.
```bash
screen -S kat
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the camarosa genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_camarosa-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_camarosa-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_camarosa-21-main.mx

srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the unpublished low coverage P.aphanis genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_cockerton_P_aphanis-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_cockerton_P_aphanis-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/reads_v_cockerton_P_aphanis-21-main.mx
```
## Assembly
Trimmed reads that did not align to the camarosa genome were taken as raw data for assembly.
```bash
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr.fq.1.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr-f.fq.gz
 
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr.fq.2.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr-r.fq.gz

mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_s.fq.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_s-s.fq.gz
#files were unzipped
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_fr-r.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1unalignedcamarosa_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades
# long partition, --careful flag used for mismatch correction, max memory 250gb, max threads 20
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#615827
```
Quast was used to assess the quality of genome assembly:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/615827/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#615846
```
### BUSCO
BUSCO was used to assess the quality of the genome assembly:
```bash
screen -S busco
srun -p himem  --mem 350G --pty bash

#BUSCO analysis was performed of the SPAdes assembly using three databases.
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
echo finished

#For comparison BUSCO was also performed on the camarosa genome.
conda activate BUSCO

for assembly in $(echo rawdata/F_ananassa/camarosa/genome); do
	Data=$(ls $assembly/F_ana_Camarosa_6-28-17.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
echo finished
```
### KAT

```bash
screen -S kat
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21-main.mx

#The camarosa genome was compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21 'rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21-main.mx
```
### Metabat2
```bash
#metabat requires assembled contigs and a BAM file with the mapping of reads to the contigs as an input. Therefore trimmed reads were aligned to our metagenome assembly and formatted appropriately:
screen -r
srun -p long  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/mystrawberrymildew
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/mystrawberrymildew
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta mystrawberrymildew_index
bowtie2 \
-x mystrawberrymildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedmystrawberrymildew.sam \
--un-gz THeavenDRCT72020_1unalignedmystrawberrymildew_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedmystrawberrymildew_fr.fq.gz \
-S THeavenDRCT72020_1alignedmystrawberrymildew.sam
echo finished

#46189256 reads; of these:
#  44242374 (95.78%) were paired; of these:
#    18908508 (42.74%) aligned concordantly 0 times
#    19178225 (43.35%) aligned concordantly exactly 1 time
#    6155641 (13.91%) aligned concordantly >1 times
#    ----
#    18908508 pairs aligned concordantly 0 times; of these:
#      1133202 (5.99%) aligned discordantly 1 time
#    ----
#    17775306 pairs aligned 0 times concordantly or discordantly; of these:
#      35550612 mates make up the pairs; of these:
#        30083287 (84.62%) aligned 0 times
#        3182662 (8.95%) aligned exactly 1 time
#        2284663 (6.43%) aligned >1 times
#  1946882 (4.22%) were unpaired; of these:
#    681199 (34.99%) aligned 0 times
#    1015429 (52.16%) aligned exactly 1 time
#    250254 (12.85%) aligned >1 times
#65.98% overall alignment rate

samtools view -S -b THeavenDRCT72020_1alignedmystrawberrymildew.sam > THeavenDRCT72020_1alignedmystrawberrymildew.bam
samtools sort THeavenDRCT72020_1alignedmystrawberrymildew.bam -o THeavenDRCT72020_1alignedmystrawberrymildew.sorted.bam
samtools index THeavenDRCT72020_1alignedmystrawberrymildew.sorted.bam
conda deactivate
cd /projects/nano_diagnostics
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/metabat2
cd analysis/P_aphanis/THeavenDRCT72020_1/metabat2
conda activate metabat2
runMetaBat.sh --saveCls --unbinned /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/mystrawberrymildew/THeavenDRCT72020_1alignedmystrawberrymildew.sorted.bam 
```
### Repeat Masking
Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
touch tmp.txt
for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta); do
  OutDir=$(dirname $Assembly)
  $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/WT_miniasm_pilon10_renamed.fasta --coord_file tmp.txt > $OutDir/log.txt
done
rm tmp.txt

ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Repeat_masking
BestAssembly=assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/*10_renamed.fasta
OutDir=assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/masked/rep_modeling
sbatch $ProgDir/rep_modeling.sh $BestAssembly $OutDir
#615941

screen -r
srun -p long  --mem 350G --pty bash
conda activate transposonpsi
cd /projects/nano_diagnostics
mkdir -p assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI
cd assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta man_contigs_unmasked.fa
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl man_contigs_unmasked.fa nuc
```





























```bash
For genome coverage, I would map reads back to the contigs, then use samtools depth to get the coverage counts - you can divide by the total length of all your contigs to get the mean coverage.  To determine duplicates, use picard-tools 's MapDuplicates on the aligned bam, followed by samtools flagstat to get numbers. 
```