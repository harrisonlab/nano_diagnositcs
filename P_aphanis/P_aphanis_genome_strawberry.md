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
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/DRCT72020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/DRCT72020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/DRCT72020_3_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/DRCT72020_4_f.fq.gz

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/DRCT72020_1_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/DRCT72020_2_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/DRCT72020_3_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/DRCT72020_4_r.fq.gz

ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_1_f.fq.gz
ln -s /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_1_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_2_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_3_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_3_r.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_4_f.fq.gz
ln -s /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/1/all/DRCT72020_4_r.fq.gz

#Sequencing performed by H.Cockerton & A.Armitage was also linked
mkdir -p rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/1/all

ln -s /data/seq_data/miseq/2018/ANALYSIS/180227_M04465_0070_000000000-B86MV/Data/Intensities/BaseCalls/MildewC1_S1_L001_R1_001.fastq.gz rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/H_Cockerton2018_1_f.fq.gz
ln -s /data/seq_data/miseq/2018/ANALYSIS/180227_M04465_0070_000000000-B86MV/Data/Intensities/BaseCalls/MildewC1_S1_L001_R2_001.fastq.gz rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/H_Cockerton2018_1_r.fq.gz
ln -s /data/seq_data/miseq/2018/ANALYSIS/180227_M04465_0070_000000000-B86MV/Data/Intensities/BaseCalls/MildewC1_S1_L001_R1_001.fastq.gz rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/1/all/H_Cockerton2018_1_f.fq.gz
ln -s /data/seq_data/miseq/2018/ANALYSIS/180227_M04465_0070_000000000-B86MV/Data/Intensities/BaseCalls/MildewC1_S1_L001_R2_001.fastq.gz rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/1/all/H_Cockerton2018_1_r.fq.gz
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
An apple scab genome was downloaded
```bash
wget -P assembly/genome/NCBI/venturia/V_inaequalis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/351/075/GCA_003351075.1_ASM335107v1/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
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
#715652
#715653
#715654
#715655
#715656
#715657
#715658
#715659
#721875
#721876

#The number of raw reads were counted:

cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/DRCT72020_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#46,331,871
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/DRCT72020_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#46,331,871
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/DRCT72020_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#125,053,705
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/DRCT72020_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#125,053,705
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/DRCT72020_3_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#158,992,963
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/DRCT72020_3_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#158,992,963
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/DRCT72020_4_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#18,904,140
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/DRCT72020_4_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#18,904,140
cat rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/H_Cockerton2018_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#23,712,972
cat rawdata/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/H_Cockerton2018_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#23,712,972
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. 
```bash
for ReadDir in $(ls -d rawdata/P_aphanis/MiSeq/*/*/*);
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
#715660
#715661 
#715663
#715871
#721878

#The number of trimmed reads were counted:
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#44,242,374
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,596,379
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#44,242,374
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#350,503

zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz | echo $((`wc -l`/4))
#120,533,647
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#3,246,798
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz | echo $((`wc -l`/4))
#120,533,647
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#967,607

zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz | echo $((`wc -l`/4))
#154,120,231
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#3,673,782
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz | echo $((`wc -l`/4))
#154,120,231
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#876,913

zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz | echo $((`wc -l`/4))
#18,088,614
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#623,562
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz | echo $((`wc -l`/4))
#18,088,614
zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#140,495

zcat dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#22,482,779
zcat dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,110,466
zcat dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#22,482,779
zcat dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#59,680
```
The data was visualised following trimming.
```bash
for QCData in $(ls dna_qc/P_aphanis/MiSeq/*/*/*/*/*.fq.gz); do
echo $QCData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $QCData)
echo $OutDir
Outfile=$(basename -a $QCData)_fastqc
echo $Outfile
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#615768
#615769
#615770
#615771
#721880
#721881
#721882
#721883
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

bowtie2 \
-x camarosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1allunalignedcamarosa.sam \
--un-gz THeavenDRCT72020_1allunalignedcamarosa_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1allunalignedcamarosa_fr.fq.gz \
-S THeavenDRCT72020_1allalignedcamarosa.sam
echo finished
#348,460,905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    293519726 (87.10%) aligned concordantly 0 times
#    9812741 (2.91%) aligned concordantly exactly 1 time
#    33652399 (9.99%) aligned concordantly >1 times
#    ----
#    293519726 pairs aligned concordantly 0 times; of these:
#      157140 (0.05%) aligned discordantly 1 time
#    ----
#    293362586 pairs aligned 0 times concordantly or discordantly; of these:
#      586725172 mates make up the pairs; of these:
#        580453494 (98.93%) aligned 0 times
#        1584858 (0.27%) aligned exactly 1 time
#        4686820 (0.80%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    10747404 (93.65%) aligned 0 times
#    108991 (0.95%) aligned exactly 1 time
#    619644 (5.40%) aligned >1 times
#13.75% overall alignment rate

bowtie2 \
-x camarosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1combunalignedcamarosa.sam \
--un-gz THeavenDRCT72020_1combunalignedcamarosa_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1combunalignedcamarosa_fr.fq.gz \
-S THeavenDRCT72020_1combalignedcamarosa.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    301620392 (83.91%) aligned concordantly 0 times
#    12792520 (3.56%) aligned concordantly exactly 1 time
#    45054733 (12.53%) aligned concordantly >1 times
#    ----
#    301620392 pairs aligned concordantly 0 times; of these:
#      268147 (0.09%) aligned discordantly 1 time
#    ----
#    301352245 pairs aligned 0 times concordantly or discordantly; of these:
#      602704490 mates make up the pairs; of these:
#        593295715 (98.44%) aligned 0 times
#        2060262 (0.34%) aligned exactly 1 time
#        7348513 (1.22%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    11206758 (88.62%) aligned 0 times
#    212666 (1.68%) aligned exactly 1 time
#    1226761 (9.70%) aligned >1 times
#17.37% overall alignment rate

#An alignment was made to the camarosa genome with the Cockerton reads:
bowtie2 \
-x camarosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1cockertoncamarosa.sam \
--un-gz THeavenDRCT72020_1cockertoncamarosa_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1cockertoncamarosa_fr.fq.gz \
-S THeavenDRCT72020_1cockertoncamarosa.sam
echo finished
#23652925 reads; of these:
#  22482779 (95.05%) were paired; of these:
#    8100666 (36.03%) aligned concordantly 0 times
#    2979779 (13.25%) aligned concordantly exactly 1 time
#    11402334 (50.72%) aligned concordantly >1 times
#    ----
#    8100666 pairs aligned concordantly 0 times; of these:
#      111007 (1.37%) aligned discordantly 1 time
#    ----
#    7989659 pairs aligned 0 times concordantly or discordantly; of these:
#      15979318 mates make up the pairs; of these:
#        12842221 (80.37%) aligned 0 times
#        475404 (2.98%) aligned exactly 1 time
#        2661693 (16.66%) aligned >1 times
#  1170146 (4.95%) were unpaired; of these:
#    459354 (39.26%) aligned 0 times
#    103675 (8.86%) aligned exactly 1 time
#    607117 (51.88%) aligned >1 times
#71.17% overall alignment rate

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

bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1allunalignedGananPleucotricha.sam \
-S THeavenDRCT72020_1allalignedGananPleucotricha.sam
echo finished

#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    305886631 (90.77%) aligned concordantly 0 times
#    25067221 (7.44%) aligned concordantly exactly 1 time
#    6031014 (1.79%) aligned concordantly >1 times
#    ----
#    305886631 pairs aligned concordantly 0 times; of these:
#      1628319 (0.53%) aligned discordantly 1 time
#    ----
#    304258312 pairs aligned 0 times concordantly or discordantly; of these:
#      608516624 mates make up the pairs; of these:
#        578474789 (95.06%) aligned 0 times
#        22549276 (3.71%) aligned exactly 1 time
#        7492559 (1.23%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    10000449 (87.14%) aligned 0 times
#    1311901 (11.43%) aligned exactly 1 time
#    163689 (1.43%) aligned >1 times
#14.15% overall alignment rate

bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1combunalignedGananPleucotricha.sam \
-S THeavenDRCT72020_1combalignedGananPleucotricha.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    327590292 (91.13%) aligned concordantly 0 times
#    25716119 (7.15%) aligned concordantly exactly 1 time
#    6161234 (1.71%) aligned concordantly >1 times
#    ----
#    327590292 pairs aligned concordantly 0 times; of these:
#      1692948 (0.52%) aligned discordantly 1 time
#    ----
#    325897344 pairs aligned 0 times concordantly or discordantly; of these:
#      651794688 mates make up the pairs; of these:
#        621110892 (95.29%) aligned 0 times
#        23043657 (3.54%) aligned exactly 1 time
#        7640139 (1.17%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    11099458 (87.77%) aligned 0 times
#    1369374 (10.83%) aligned exactly 1 time
#    177353 (1.40%) aligned >1 times
#13.58% overall alignment rate

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

cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta cockerton_P_aphanis_index
bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_allP_aphanis.sam \
-S THeavenDRCT72020_1alignedcockerton_allP_aphanis.sam
echo finished

#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    161627958 (47.96%) aligned concordantly 0 times
#    154355233 (45.80%) aligned concordantly exactly 1 time
#    21001675 (6.23%) aligned concordantly >1 times
#   ----
#    161627958 pairs aligned concordantly 0 times; of these:
#      6223831 (3.85%) aligned discordantly 1 time
#    ----
#    155404127 pairs aligned 0 times concordantly or discordantly; of these:
#      310808254 mates make up the pairs; of these:
#        276561423 (88.98%) aligned 0 times
#        15752895 (5.07%) aligned exactly 1 time
#        18493936 (5.95%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    3342939 (29.13%) aligned 0 times
#    6937600 (60.45%) aligned exactly 1 time
#    1195500 (10.42%) aligned >1 times
#59.16% overall alignment rate

bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_combP_aphanis.sam \
-S THeavenDRCT72020_1alignedcockerton_combP_aphanis.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    180078260 (50.10%) aligned concordantly 0 times
#    157878176 (43.92%) aligned concordantly exactly 1 time
#    21511209 (5.98%) aligned concordantly >1 times
#    ----
#    180078260 pairs aligned concordantly 0 times; of these:
#      6514087 (3.62%) aligned discordantly 1 time
#    ----
#    173564173 pairs aligned 0 times concordantly or discordantly; of these:
#      347128346 mates make up the pairs; of these:
#        312189289 (89.93%) aligned 0 times
#        16032540 (4.62%) aligned exactly 1 time
#        18906517 (5.45%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    4180541 (33.06%) aligned 0 times
#    7198262 (56.92%) aligned exactly 1 time
#    1267382 (10.02%) aligned >1 times
#56.76% overall alignment rate

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

cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/P_graminis
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/P_graminis
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna P_graminis_index
bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedP_graminis_allP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedP_graminis_allP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedP_graminis_allP_aphanis_fr.fq.gz \
--met-file THeavenDRCT72020_1unalignedP_graminis_allP_aphanis.txt \
-S THeavenDRCT72020_1alignedP_graminis_allP_aphanis.sam
echo finished
#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    331700418 (98.43%) aligned concordantly 0 times
#    432801 (0.13%) aligned concordantly exactly 1 time
#    4851647 (1.44%) aligned concordantly >1 times
#    ----
#    331700418 pairs aligned concordantly 0 times; of these:
#      19998 (0.01%) aligned discordantly 1 time
#    ----
#    331680420 pairs aligned 0 times concordantly or discordantly; of these:
#      663360840 mates make up the pairs; of these:
#        659421479 (99.41%) aligned 0 times
#        1954210 (0.29%) aligned exactly 1 time
#        1985151 (0.30%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    11297185 (98.44%) aligned 0 times
#    75160 (0.65%) aligned exactly 1 time
#    103694 (0.90%) aligned >1 times
#2.15% overall alignment rate

cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/P_graminis
bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_combP_graminis.sam \
-S THeavenDRCT72020_1alignedcockerton_combP_graminis.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    354086552 (98.50%) aligned concordantly 0 times
#    452528 (0.13%) aligned concordantly exactly 1 time
#    4928565 (1.37%) aligned concordantly >1 times
#    ----
#    354086552 pairs aligned concordantly 0 times; of these:
#      21608 (0.01%) aligned discordantly 1 time
#    ----
#    354064944 pairs aligned 0 times concordantly or discordantly; of these:
#      708129888 mates make up the pairs; of these:
#        704070367 (99.43%) aligned 0 times
#        2007745 (0.28%) aligned exactly 1 time
#        2051776 (0.29%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    12456667 (98.50%) aligned 0 times
#    79048 (0.63%) aligned exactly 1 time
#    110470 (0.87%) aligned >1 times
#2.06% overall alignment rate


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

cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/E_necator
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/E_necator
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna E_necator_index
bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedE_necator_allP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedE_necator_allP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedE_necator_allP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedE_necator_allP_aphanis.sam
echo finished
#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    328152471 (97.38%) aligned concordantly 0 times
#    7392156 (2.19%) aligned concordantly exactly 1 time
#    1440239 (0.43%) aligned concordantly >1 times
#    ----
#    328152471 pairs aligned concordantly 0 times; of these:
#      170767 (0.05%) aligned discordantly 1 time
#    ----
#    327981704 pairs aligned 0 times concordantly or discordantly; of these:
#      655963408 mates make up the pairs; of these:
#        648095461 (98.80%) aligned 0 times
#        6795974 (1.04%) aligned exactly 1 time
#        1071973 (0.16%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    10927928 (95.22%) aligned 0 times
#    305860 (2.67%) aligned exactly 1 time
#    242251 (2.11%) aligned >1 times
#3.79% overall alignment rate

cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/E_necator
bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_combE_necator_allP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedcockerton_combE_necator_allP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedcockerton_combE_necator_allP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedcockerton_combE_necator_allP_aphanis.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    350422960 (97.48%) aligned concordantly 0 times
#    7582038 (2.11%) aligned concordantly exactly 1 time
#    1462647 (0.41%) aligned concordantly >1 times
#    ----
#    350422960 pairs aligned concordantly 0 times; of these:
#      185540 (0.05%) aligned discordantly 1 time
#    ----
#    350237420 pairs aligned 0 times concordantly or discordantly; of these:
#      700474840 mates make up the pairs; of these:
#        692385524 (98.85%) aligned 0 times
#        6985193 (1.00%) aligned exactly 1 time
#        1104123 (0.16%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    12078750 (95.51%) aligned 0 times
#    321843 (2.54%) aligned exactly 1 time
#    245592 (1.94%) aligned >1 times
#3.71% overall alignment rate


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

cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Angelini_P_xanthii
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Angelini_P_xanthii
bowtie2-build /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta Angelini_P_xanthii_index
bowtie2 \
-x Angelini_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedAngelini_P_xanthii_allP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_allP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_allP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedAngelini_P_xanthii_allP_aphanis.sam
echo finished
#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    309818161 (91.94%) aligned concordantly 0 times
#    19302237 (5.73%) aligned concordantly exactly 1 time
#    7864468 (2.33%) aligned concordantly >1 times
#    ----
#    309818161 pairs aligned concordantly 0 times; of these:
#      1348947 (0.44%) aligned discordantly 1 time
#    ----
#    308469214 pairs aligned 0 times concordantly or discordantly; of these:
#      616938428 mates make up the pairs; of these:
#        593855586 (96.26%) aligned 0 times
#        13096652 (2.12%) aligned exactly 1 time
#        9986190 (1.62%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    10737048 (93.56%) aligned 0 times
#    463152 (4.04%) aligned exactly 1 time
#    275839 (2.40%) aligned >1 times
#11.80% overall alignment rate

bowtie2 \
-x Angelini_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedAngelini_P_xanthii_cockerton_combP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_cockerton_combP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedAngelini_P_xanthii_cockerton_combP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedAngelini_P_xanthii_cockerton_combP_aphanis.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    331740757 (92.29%) aligned concordantly 0 times
#    19690547 (5.48%) aligned concordantly exactly 1 time
#    8036341 (2.24%) aligned concordantly >1 times
#    ----
#    331740757 pairs aligned concordantly 0 times; of these:
#      1395044 (0.42%) aligned discordantly 1 time
#    ----
#    330345713 pairs aligned 0 times concordantly or discordantly; of these:
#      660691426 mates make up the pairs; of these:
#        637101873 (96.43%) aligned 0 times
#        13405523 (2.03%) aligned exactly 1 time
#        10184030 (1.54%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    11859852 (93.78%) aligned 0 times
#    493258 (3.90%) aligned exactly 1 time
#    293075 (2.32%) aligned >1 times
#11.29% overall alignment rate

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

cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Fonseca_P_pannosa
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Fonseca_P_pannosa
bowtie2-build /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt Fonseca_P_pannosa_index
bowtie2 \
-x Fonseca_P_pannosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedFonseca_P_pannosa_allP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_allP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_allP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedFonseca_P_pannosa_allP_aphanis.sam
echo finished
#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    322977656 (95.84%) aligned concordantly 0 times
#    8587047 (2.55%) aligned concordantly exactly 1 time
#    5420163 (1.61%) aligned concordantly >1 times
#    ----
#    322977656 pairs aligned concordantly 0 times; of these:
#      657077 (0.20%) aligned discordantly 1 time
#    ----
#    322320579 pairs aligned 0 times concordantly or discordantly; of these:
#      644641158 mates make up the pairs; of these:
#        631423994 (97.95%) aligned 0 times
#        7932259 (1.23%) aligned exactly 1 time
#        5284905 (0.82%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    11156612 (97.22%) aligned 0 times
#    155698 (1.36%) aligned exactly 1 time
#    163729 (1.43%) aligned >1 times
#6.25% overall alignment rate

cd /projects/nano_diagnostics
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Fonseca_P_pannosa
bowtie2 \
-x Fonseca_P_pannosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedFonseca_P_pannosa_comballP_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_comballP_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedFonseca_P_pannosa_comballP_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedFonseca_P_pannosa_comballP_aphanis.sam
echo finished
#372113830 reads; of these:
#  359467645 (96.60%) were paired; of these:
#    345178813 (96.03%) aligned concordantly 0 times
#    8756253 (2.44%) aligned concordantly exactly 1 time
#    5532579 (1.54%) aligned concordantly >1 times
#    ----
#    345178813 pairs aligned concordantly 0 times; of these:
#      674031 (0.20%) aligned discordantly 1 time
#    ----
#    344504782 pairs aligned 0 times concordantly or discordantly; of these:
#      689009564 mates make up the pairs; of these:
#        675558378 (98.05%) aligned 0 times
#        8068948 (1.17%) aligned exactly 1 time
#        5382238 (0.78%) aligned >1 times
#  12646185 (3.40%) were unpaired; of these:
#    12305745 (97.31%) aligned 0 times
#    167422 (1.32%) aligned exactly 1 time
#    173018 (1.37%) aligned >1 times
```
Centrifuge was run with trimmed reads to identify what taxa were represented in the metagenome data.
### Centrifuge
```bash
#centrifuge was run with a fungi only database
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/centrifuge/reads/fungi
#change database to /data/scratch/gomeza/prog/centrifuge/
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    echo $F_Read
	echo $R_Read
    Database=fungi
    OutDir=analysis/P_aphanis/THeavenDRCT72020_1/centrifuge/reads/fungi
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
	done
#741416

#centrifuge was run with a broad nt database
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/centrifuge/reads/nt
#change database to /scratch/public_data/nt-centrifuge_12jan2021/
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    echo $F_Read
	echo $R_Read
    Database=nt
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads/nt
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
	done
#741417
```
### Coverage
There is no existing genome to use for estimated coverage.
```bash
#Basic coverage calculation; coverage=(readlength*readnumber)/genomelength
(350bp x 46,189,256 reads)/39,000,000 = 414.5

(350bp x 685,445,771 reads)/60,196,572 = 3,985

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
#720346 - fails

#Coverage of the sequence data was also estimated via alignmnet with the unpublished low coverage P.aphanis assembly.
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
samtools view --threads 8 -bS THeavenDRCT72020_1alignedcockerton_P_aphanis.sam -o THeavenDRCT72020_1alignedcockerton_P_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_P_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedcockerton_P_aphanis_sorted.bam -o coverage.txt
#median depth 58.3, mean depth x136.8 14209/17365 contigs

cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
samtools view --threads 8 -bS THeavenDRCT72020_1alignedcockerton_allP_aphanis.sam -o THeavenDRCT72020_1alignedcockerton_allP_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedcockerton_allP_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_allP_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedcockerton_allP_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_allP_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedcockerton_allP_aphanis_sorted.bam -o allcoverage.txt
#median depth 433, mean depth x1033 14296/17365 contigs

cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/cockerton_P_aphanis
samtools view --threads 8 -bS THeavenDRCT72020_1alignedcockerton_combP_aphanis.sam -o THeavenDRCT72020_1alignedcockerton_comballP_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedcockerton_comballP_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_comballP_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedcockerton_comballP_aphanis_sorted.bam THeavenDRCT72020_1alignedcockerton_comballP_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedcockerton_comballP_aphanis_sorted.bam -o comballcoverage.txt
#median depth 405, mean depth x870 17342/17365 contigs
```
### Kmer analysis toolkit
The quality of the sequencing data was assessed using KAT.
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

screen -S kat
srun -p himem  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the camarosa genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21-main.mx

#Combined reads were compared to the unpublished low coverage P.aphanis genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_cockerton_P_aphanis-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_cockerton_P_aphanis-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_cockerton_P_aphanis-21-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_cockerton_P_aphanis-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_cockerton_P_aphanis-21-main.mx

#All Combined reads were compared to the camarosa genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_camarosa-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_camarosa-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_camarosa-21-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_camarosa-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_camarosa-21-main.mx

#All Combined reads were compared to the unpublished low coverage P.aphanis genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_cockerton_P_aphanis-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_cockerton_P_aphanis-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_cockerton_P_aphanis-21-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_cockerton_P_aphanis-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballreads_v_cockerton_P_aphanis-21-main.mx
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

#Repeated with aditional sequencing data
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr.fq.1.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-f.fq.gz
 
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr.fq.2.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-r.fq.gz

mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_s.fq.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_s-s.fq.gz
#files were unzipped
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-r.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_s-s.fq.gz

#Repeated for cockerton data
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr.fq.1.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr-f.fq.gz
 
mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr.fq.2.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr-r.fq.gz

mv alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_s.fq.gz alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_s-s.fq.gz
#files were unzipped
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_fr-r.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1cockertoncamarosa_s-s.fq.gz

wc -l alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-f.fq
# 1174078904
wc -l alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-r.fq
#1174078904

conda activate spades
fastq_pair -t 1174078904 alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-f.fq alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-r.fq
#terminated
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
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*allunalignedcamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#720338
#720434
#Produced very large genome and duplicated BUSCO results, therefore rerun with --isolate setting and also with a higher coverage cutoff.
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*allunalignedcamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#721950
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*allunalignedcamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 150
  done
#721951
#isolate setting with cuttoff
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*allunalignedcamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 75
  done
#725715

#isolate setting with cuttoff
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*allunalignedcamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*allunalignedcamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 25
  done
#734336

#The cockerton reads were assembled inndependantly
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*cockertoncamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*cockertoncamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*cockertoncamarosa_s-s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/camarosa@SPAdes@g'|sed 's@THeavenDRCT72020_1@Cockerton1@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#740639
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

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/720434/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#721886
    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/721950/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#722308
    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/721951/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#725714
    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#721038
    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/734336/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#740232
    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/740639/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#740704
```
### BUSCO
BUSCO was used to assess the quality of the genome assembly:
```bash
screen -S busco
srun -p himem  --mem 350G --pty bash

#BUSCO analysis was performed of the SPAdes assemblys using three databases.
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/720434/filtered_contigs); do
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/72195*/filtered_contigs); do
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs); do
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/734336/filtered_contigs); do
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/740639/filtered_contigs); do
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

#BUSCO was performed for the low coverage cockerton assembly
for assembly in $(echo assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended); do
	Data=$(ls $assembly/contigs_min_500bp_renamed.fasta) 
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
srun -p himem  --mem 750G --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21-main.mx

#The cockerton reads were compared to the spades assembly and the results plotted: 
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21-main.mx

#The camarosa genome was compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21 'rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21-main.mx
```
### Coverage
```bash
#An alignment of trimmed reads including unpaired reads was made to the assembled genome, this produced a 66% overall alignment rate.
screen -S bowtie
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta Heaven_P_aphanis_index
bowtie2 \
-x Heaven_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_aphanis.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_aphanis.sam
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

samtools view --threads 8 -bS THeavenDRCT72020_1alignedHeaven_P_aphanis.sam -o THeavenDRCT72020_1alignedHeaven_P_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam THeavenDRCT72020_1alignedHeaven_P_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam -o coverage.txt
#median depth = 58.6, mean depth 212

#An alignment of all our reads including unpaired reads was made to the 75 cuttoff assembled genome, this produced a 66.1% overall alignment rate.
screen -S bowtie
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta Heaven_P_aphanis75_index
bowtie2 \
-x Heaven_P_aphanis75_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_aphanis75.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis75_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis75_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_aphanis75.sam
echo finished
#348460905 reads; of these:
#  336984866 (96.71%) were paired; of these:
#    145647053 (43.22%) aligned concordantly 0 times
#    144611056 (42.91%) aligned concordantly exactly 1 time
#    46726757 (13.87%) aligned concordantly >1 times
#    ----
#    145647053 pairs aligned concordantly 0 times; of these:
#      10166996 (6.98%) aligned discordantly 1 time
#    ----
#    135480057 pairs aligned 0 times concordantly or discordantly; of these:
#      270960114 mates make up the pairs; of these:
#        228656173 (84.39%) aligned 0 times
#        23468232 (8.66%) aligned exactly 1 time
#        18835709 (6.95%) aligned >1 times
#  11476039 (3.29%) were unpaired; of these:
#    3704549 (32.28%) aligned 0 times
#    6019197 (52.45%) aligned exactly 1 time
#    1752293 (15.27%) aligned >1 times
#66.10% overall alignment rate
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

cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
samtools view -S -b THeavenDRCT72020_1alignedHeaven_P_aphanis75.sam > THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam 
samtools sort THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam -o THeavenDRCT72020_1alignedHeaven_P_aphanis75.sorted.bam 
samtools index THeavenDRCT72020_1alignedHeaven_P_aphanis75.sorted.bam
cd /projects/nano_diagnostics
cd analysis/P_aphanis/THeavenDRCT72020_1/metabat2
mkdir 2
cd 2
conda activate metabat2
runMetaBat.sh --saveCls --unbinned /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sorted.bam 
```
### Kraken2
```bash
#Build a kraken database:
 screen -S kraken2
srun -p long  --mem 100G --pty bash
for file in $(ls /scratch/public_data/tch/tmp123/archaea/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/bacteria/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/protozoa/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/viral/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/vertebrate_mammalian/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
exit
echo finished 
srun -p himem  --mem 490G --pty bash
kraken2-build --build --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
exit
echo finished 

#Build a fungi only kraken database:
screen -S kraken2
srun -p himem  --mem 100G --pty bash
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
done
exit
echo finished

srun -p himem  --mem 490G --pty bash
kraken2-build --build --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
exit
echo finished 

#Run kraken 2 analysis
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/output.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/unclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/classified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/report.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta
#  1002 sequences classified (7.69%)
#  12024 sequences unclassified (92.31%)
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/output.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/unclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/classified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/report.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta
#  3034 sequences classified (23.29%)
#  9992 sequences unclassified (76.71%)



kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/output2.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/unclassified-out2.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/classified-out2.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi/report2.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta
#  11118 sequences classified (85.35%)
#  1908 sequences unclassified (14.65%)

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/output2.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/unclassified-out2.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/classified-out2.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/report2.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta
#  11656 sequences classified (89.48%)
#  1370 sequences unclassified (10.52%)

#kraken rerunn with database containing all published mildew genomes and strawberry genome
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/output3.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/unclassified-out3.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/classified-out3.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/report3.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta
#  12799 sequences classified (98.26%)
#  227 sequences unclassified (1.74%)
```
Contaminant contigs were removed from the assembly
```bash
touch analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist.txt
nano analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist.txt

#Edited with the following: 

#Animals:
Homo sapiens
#Plants:
Viridiplantae
Embryophyta
Tracheophyta
Magnoliopsida
Mesangiospermae
Pentapetalae
rosids
fabids
Rosaceae
Rosoideae
Fragaria
Rosa chinensis
Rubus
Malus domestica
Pyrus
Prunus
Cannabis
Morus notabilis
Ziziphus jujuba
Glycine
Vigna
Cajanus
Phaseolus
Abrus precatorius
Medicago
Cicer arietinum
Arachis
Lupinus
Prosopis
Quercus
Juglans
Cucumis
Benincasa
Cucurbita
Manihot
Jatropha
Ricinus
Populus
Tripterygium
malvids
Gossypium
Hibiscus
Durio
Byttnerioideae
Theobroma
Herrania
Brassica
Camelina
Carica papaya
Tarenaya
Syzygium
Rhodamnia
Pistacia
Citrus
Vitis vinifera
Vitis riparia
asterids
lamiids
Solanaceae
Nicotiana
Solanoideae
Capsicum
Solanum
Ipomoea
Olea europaea
Sesamum 
Erythranthe
Cynara cardunculus
Coffea
Asteraceae
Helianthus
Lactuca sativa
Cynara cardunculus
Daucus carota
Camellia
Chenopodiaceae
Chenopodium
Beta vulgaris
Petrosaviidae
Poaceae
Panicoideae
Zea mays
Sorghum bicolor
Panicum virgatum
Panicum hallii
Triticinae
Triticum
Aegilops tauschii
Brachypodium
Oryza brachyantha
Ananas comosus
Elaeis guineensis
Phoenix dactylifera
Musa acuminata
Phalaenopsis
Dendrobium
Asparagus
Dioscorea cayenensis
Papaver somniferum
Nelumbo nucifera
Amborella
Nymphaea colorata
Selaginella
Physcomitrium
#Protozoa:
Chlamydomonas
Monoraphidium
Oomycota
Phytophthora
Aphanomyces
Plasmodium
Tetrahymena
Acanthamoeba
Heterostelium 
Guillardia
#Bacteria
Bacteria
Enterobacterales
Lonsdalea
Buchnera
Pantoea agglomerans
Salmonella
Pseudomonas
Acinetobacter
Halomonas
Francisella
Pseudoalteromonas
Rhodobacter
Ketogulonicigenium
Afipia carboxidovorans
Rhizobium
Pelistega
Variovorax
Burkholderia
Rhizobium
Paraburkholderia
Campylobacter
Nautilia
Staphylococcus
Bacillus
Planococcus
Aerococcus
Clostridium
Actinomycetia
Streptomyces
Mycoplasma
Flavobacterium
Cellulophaga
Borrelia
Halopenitus
Haloterrigena
Methanococcus
# These are the taxids identified by kraken2, excluding fungi identifed as these may be misidentifed mildew contigs given the lack of sequencing within the mildew clade.

# Most contaminat contifs are accounted for by Lactuca sativ and Mlaus domestica, a separate file was created for the other minor contaminants.

grep -f analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist.txt analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/output3.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs.txt

nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames.txt

conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminants.fasta
conda deactivate

conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames.txt #322
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta #26052
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta #25408
```
Following the removal of contaminant contigs, kraken2, BUSCO and quast analysis were performed again for the filtered assembly
```bash
screen -S kraken
srun -p long  --mem 160G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredreport.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta
#  10982 sequences classified (88.91%)
#  1370 sequences unclassified (11.09%)

#kraken rerunn with database containing all published mildew genomes and strawberry genome
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredoutput2.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredunclassified-out2.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredclassified-out2.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredreport2.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta
exit
exit
echo finished
#  12477 sequences classified (98.21%)
#  227 sequences unclassified (1.79%)

conda deactivate
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1/filtered
	cd $Input/BUSCO/fungi/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1/filtered
	cd $Input/BUSCO/ascomycota/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
	cd $Input/BUSCO/leotiomycetes/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
exit
exit
echo finished
conda deactivate
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)/filtered
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#764222
```
## NCBI submission

Contigs were renamed in accordance with ncbi recomendations.
```bash
conda activate Biopython
  ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
  touch tmp.csv
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta); do
    OutDir=$(dirname $Assembly|sed 's@assembly/metagenome@genome_submission@g'|sed 's@filtered_contigs@ncbi_edits@g')
    mkdir -p $OutDir
    $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file tmp.csv
  done
  rm tmp.csv
conda deactivate
#number of contigs written:      12704
```
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards.

NCBI reports (FCSreport.txt) were manually downloaded to the following locations:
```bash
mkdir -p genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir
```
These downloaded files were used to correct assemblies:
```bash
conda activate Biopython
for Assembly in $(ls genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed.fasta); do
NCBI_report=$(ls genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir/FCSreport.txt)
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
$ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
#exclude dictionary contains:
#2
#split dictionary contatins:
#13
conda deactivate
conda activate quast

    for Assembly in $(ls genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#764879
conda deactivate
```












































### Mitofinder

```bash
mkdir -p rawdata/P_xanthii/KimS/mitochondrion/
cd rawdata/P_xanthii/KimS/mitochondrion/
#file uploaded of complete podosphaera xanthii mitochondrion from: https://www.ncbi.nlm.nih.gov/nuccore/MK674497.1?report=fasta&log$=seqview
cd /projects/nano_diagnostics

screen -S mito
srun -p long -c 10 --mem 50G --pty bash 
conda activate Mitofinder
mkdir assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/mtDNA_mitofinder

cd assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/mtDNA_mitofinder
mitofinder \
  --seqid P_aphanisTHeavenDRCT72020_1_MtDNA \
  --tRNA-annotation mitfi \
  --adjust-direction \
  --new-genes \
  --max-contig-size 50000 \
  --circular-size 55 \
  --assembly /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta \
  --refseq /projects/nano_diagnostics/rawdata/P_xanthii/KimS/mitochondrion/pxanthiimito.gb \
  --organism 4 \
  --processors 10 \
  --max-memory 49
```
### Repeat Masking
Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/filteredmasked
	mkdir -p $OutDir/rep_modeling
	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
done
#758371
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/filteredmasked
	mkdir -p $OutDir/transposonPSI
	sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI
done
#758374
conda deactivate
```
### Repeat Masking
Repeatmodeler and transposonPSI were run on our assembly.
```bash
#files renamed
conda activate repeatmasking
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
touch tmp.txt
for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta); do
  OutDir=$(dirname $Assembly)
  $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/WT_miniasm_pilon10_renamed.fasta --coord_file tmp.txt > $OutDir/log.txt
done
rm tmp.txt

#repeatmodeler run
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Repeat_masking
BestAssembly=assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/*10_renamed.fasta
OutDir=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/rep_modeling
sbatch $ProgDir/rep_modeling.sh $BestAssembly $OutDir
#615941

#transposonpsi run
screen -r
srun -p long  --mem 350G --pty bash
conda activate transposonpsi
cd /projects/nano_diagnostics
mkdir -p assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI
cd assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta man_contigs_unmasked.fa
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl man_contigs_unmasked.fa nuc

#75 cuttoff files renamed
conda activate repeatmasking
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
touch tmp.txt
for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta); do
  OutDir=$(dirname $Assembly)
  $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/WT_miniasm_pilon10_renamed.fasta --coord_file tmp.txt > $OutDir/log.txt
done
rm tmp.txt

#repeatmodeler run
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Repeat_masking
BestAssembly=assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/*10_renamed.fasta
OutDir=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/rep_modeling
sbatch $ProgDir/rep_modeling.sh $BestAssembly $OutDir
#740809

screen -S PSI
srun -p long  --mem 350G --pty bash
conda activate transposonpsi
cd /projects/nano_diagnostics
mkdir -p assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI
cd assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta man_contigs_unmasked.fa
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl man_contigs_unmasked.fa nuc
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands:
```bash
RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa.TPSI.allHits
printf "P_aphanis/THeavenDRCT72020_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#28,510,709
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#14,533
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#Differing number of GFF fields encountered at line: 100686.  Exiting...

RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa.TPSI.allHits
printf "P_aphanis/THeavenDRCT72020_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#28,812,425
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#14,616
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#Differing number of GFF fields encountered at line: 97499.  Exiting...
#0
```
The TransposonPSI asked bases were used to mask additional bases from the repearmasker softmasked files.
```bash
for File in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 28,812,425 -> the same as just with repeatmasker?
```
## Gene prediction
Trimmed RNASeq reads that did not align to the camarosa genome can be found here:
```bash
ls dna_qc/P_aphanis/RNAexp1/infected/F/*trim.fa
ls dna_qc/P_aphanis/RNAexp1/infected/R/*trim.fa
```
### Aligning
Insert sizes of the RNA seq library were unknown until a draft alignment could be made. To do this tophat and cufflinks were run.

Tophat was used to align the RNAseq data to the masked genome.
```bash
conda activate tophat
for assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
	for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	 Freads=$(ls $RNAdata/F/*trim.fq.gz)
	 Rreads=$(ls $RNAdata/R/*trim.fq.gz)

	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/tophat
	ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
	ls $Freads
	ls $Rreads
	ls $assembly
	ls $OutDir
	sbatch $ProgDir/tophat_alignment.sh $assembly $Freads $Rreads $OutDir
	done
done
#619613

for assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
	for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	 Freads=$(ls $RNAdata/F/*trim.fq.gz)
	 Rreads=$(ls $RNAdata/R/*trim.fq.gz)

	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/tophat
	ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
	ls $Freads
	ls $Rreads
	ls $assembly
	ls $OutDir
	sbatch $ProgDir/tophat_alignment.sh $assembly $Freads $Rreads $OutDir
	done
done
#741289
cp -r 741289 alignment/P_aphanis/THeavenDRCT72020_1/tophat
rm -r 741289
```
Cufflinks assembles transcripts, estimates their abundances, and tests for differential expression and regulation in RNA-Seq samples.

Alignments should be concatenated prior to running cufflinks, initially we have only one RNASeq file to align and so this is unecessary. Cufflinks was run to produce fragment length and stdev statistics. Samtools was used to find the average read length.
```bash
conda activate tophat
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/rep_modeling/*_contigs_softmasked.fa); do
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/tophat/619613/619613_tophat/accepted_hits.bam 
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/cufflinks
    mkdir -p $OutDir
    cufflinks -o $OutDir -p 8 --max-intron-length 4000 $AcceptedHits 2>&1 | tee $OutDir/cufflinks/cufflinks.log
  done

#The fragment length and stdev were printed to stdout while cufflinks was running.

#> Processed 36922 loci.                        [*************************] 100%
#> Map Properties:
#>       Normalized Map Mass: 933698.56
#>       Raw Map Mass: 933698.56
#>       Fragment Length Distribution: Empirical (learned)
#>                     Estimated Mean: 248.00
#>                  Estimated Std Dev: 51.22
#[14:10:25] Assembling transcripts and estimating abundances.
#> Processed 36967 loci.                        [*************************] 100%

samtools stats alignment/P_aphanis/THeavenDRCT72020_1/tophat/619613/619613_tophat/accepted_hits.bam
#average length: 149

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/rep_modeling/*_contigs_softmasked.fa); do
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/tophat/741289/741289_tophat/accepted_hits.bam 
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/cufflinks/75
    mkdir -p $OutDir
    cufflinks -o $OutDir -p 8 --max-intron-length 4000 $AcceptedHits 2>&1 | tee $OutDir/cufflinks/cufflinks.log
  done

#The fragment length and stdev were printed to stdout while cufflinks was running.

#> Processed 36907 loci.                        [*************************] 100%
#> Map Properties:
#>       Normalized Map Mass: 896568.31
#>       Raw Map Mass: 896568.31
#>       Fragment Length Distribution: Empirical (learned)
#>                     Estimated Mean: 247.81
#>                  Estimated Std Dev: 52.35
#[16:21:13] Assembling transcripts and estimating abundances.
#> Processed 36951 loci.                        [*************************] 100%

samtools stats alignment/P_aphanis/THeavenDRCT72020_1/tophat/741289/741289_tophat/accepted_hits.bam > stats.txt
#average length: 149
```
The mean insert gap was calculated from the estimated fragment length and read length. This was provided to tophat on a second run (as the -r option) along with the fragment length stdev to increase the accuracy of mapping.

```bash
#The mean insert gap was calculated from the estimated fragment length and read length: 248 - (149 x 2) = -50.

conda activate tophat
for assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
	for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	 Freads=$(ls $RNAdata/F/*trim.fq.gz)
	 Rreads=$(ls $RNAdata/R/*trim.fq.gz)

	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/tophat
	ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
	ls $Freads
	ls $Rreads
	ls $assembly
	ls $OutDir
	sbatch $ProgDir/tophat_alignment.sh $assembly $Freads $Rreads $OutDir -50 51
	done
done
#721872

#The mean insert gap was calculated from the estimated fragment length and read length: 248 - (149 x 2) = -50.

for assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
	for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	 Freads=$(ls $RNAdata/F/*trim.fq.gz)
	 Rreads=$(ls $RNAdata/R/*trim.fq.gz)

	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/tophat
	ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
	ls $Freads
	ls $Rreads
	ls $assembly
	ls $OutDir
	sbatch $ProgDir/tophat_alignment.sh $assembly $Freads $Rreads $OutDir -50 52
	done
done
#741368 - IN PROGRESS
```

A better alignment program is now available - Star - this was used:

```bash
mkdir alignment/P_aphanis/THeavenDRCT72020_1/star
for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	Freads=$RNAdata/F/*trim.fq.gz
	Rreads=$RNAdata/R/*trim.fq.gz
	ls $Freads
	ls $Rreads
	InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa
	ProgDir=~/git_repos/tools/seq_tools/RNAseq
	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/star
	sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#718185

for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	Freads=$RNAdata/F/*trim.fq.gz
	Rreads=$RNAdata/R/*trim.fq.gz
	ls $Freads
	ls $Rreads
	InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa
	echo $InGenome
	ProgDir=~/git_repos/tools/seq_tools/RNAseq
	OutDir=alignment/P_aphanis/THeavenDRCT72020_1/star/75
	sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#741328
```
```bash
conda activate tophat
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/rep_modeling/*_contigs_softmasked.fa); do
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/star_aligmentAligned.sortedByCoord.out.bam
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/cufflinks2
    mkdir -p $OutDir
    cufflinks -o $OutDir -p 8 --max-intron-length 4000 $AcceptedHits 2>&1 | tee $OutDir/cufflinks/cufflinks.log
  done

#The fragment length and stdev were printed to stdout while cufflinks was running.

#> Processed 35122 loci.                        [*************************] 100%
#> Map Properties:
#>       Normalized Map Mass: 1005273.58
#>       Raw Map Mass: 1005273.58
#>       Fragment Length Distribution: Empirical (learned)
#>                     Estimated Mean: 247.70
#>                  Estimated Std Dev: 52.81
#[13:48:28] Assembling transcripts and estimating abundances.
#> Processed 35133 loci.                        [*************************] 100%

samtools stats alignment/P_aphanis/THeavenDRCT72020_1/star/star_aligmentAligned.sortedByCoord.out.bam
#average length: 148
```
The mean insert gap was calculated from the estimated fragment length and read length: 248 - (148 x 2) = -48. 

### Braker prediction
Genes were predited using the program Braker1
```bash
#Before braker predictiction is performed, double check that the genemark key is in user area and copy it over from the genemark install directory:
conda activate braker
cp /home/gomeza/miniconda3/envs/gene_pred/bin/filterGenesIn_mRNAname.pl /home/heavet/miniconda3/envs/braker/bin
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction/braker_fungi.sh /home/heavet/git_repos/tools/gene_prediction/braker1/gom_braker_fungi.sh
cp /home/gomeza/prog/genemark/gm_key_Nov2020/gm_key_64 ~/.gm_key

for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/braker
AcceptedHits=$(ls alignment/P_aphanis/THeavenDRCT72020_1/star/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=P_aphanis_braker
ProgDir=/home/heavet/git_repos/tools/gene_prediction/braker1
sbatch $ProgDir/gom_braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#721053

rm -r /home/heavet/miniconda3/envs/braker/config//species/P_aphanis_braker
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/braker/75
AcceptedHits=$(ls alignment/P_aphanis/THeavenDRCT72020_1/star/75/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=P_aphanis_braker
ProgDir=/home/heavet/git_repos/tools/gene_prediction/braker1
sbatch $ProgDir/gom_braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#741363
```
Fasta and gff files were extracted from the Braker1 output.
```bash
for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/braker/P_aphanis_braker/augustus.gff); do
getAnnoFasta.pl $File
OutDir=$(dirname $File)
echo "##gff-version 3" > $OutDir/augustus_extracted.gff
cat $File | grep -v '#' >> $OutDir/augustus_extracted.gff
done

for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/braker/75/P_aphanis_braker/augustus.gff); do
getAnnoFasta.pl $File
OutDir=$(dirname $File)
echo "##gff-version 3" > $OutDir/augustus_extracted.gff
cat $File | grep -v '#' >> $OutDir/augustus_extracted.gff
done
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. 

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate Stringtie
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#721477

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/75
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/75/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#741645 
```
This step was also performed using cufflinks.
```bash
conda activate tophat
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/cufflinks/concatenated_prelim
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/sub_cufflinks.sh $AcceptedHits $OutDir
  done
#741643 - Warning: Could not connect to update server to verify current version.

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/75
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/75/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/sub_cufflinks.sh $AcceptedHits $OutDir
   done
#741644 - Warning: Could not connect to update server to verify current version. 
```
```bash
conda activate codingquary
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/615827/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/1
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#721871 - /home/heavet/git_repos/tools/gene_prediction/codingquary/run_CQ-PM_stranded.sh: line 35: signalp: command not found
#721885 - signalp: error while loading shared libraries: libtensorflow.so: cannot open shared object file: No such f
find -maxdepth 1000 -name libtensorflow.so -print > findlog.txt
ls ~/git_repos/tools/gene_prediction/signalp-5.0b/signalp-5.0b/lib/libtensorflow.so
cp ~/git_repos/tools/gene_prediction/signalp-5.0b/signalp-5.0b/lib/libtensorflow.so ~/git_repos/tools/gene_prediction/signalp-5.0b/signalp-5.0b/bin/libtensorflow.so
#721952
#There are only 499 secreted genes
#to train from. Pathogen mode cannot run with less
#than 500 secreted genes.

conda activate codingquary
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/transposonPSI/man_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/75
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/75/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#742025
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl
#Building and testing Bio-DB-NCBIHelper-1.7.6 ... FAIL
#! Installing Bio::DB::GenPept failed. See /home/heavet/.cpanm/work/1622640779.4676/build.log for details. Retry with --force to force install it.
#! Installing the dependencies failed: Module 'Bio::DB::GenPept' is not installed, Module 'Bio::DB::GenBank' is not installed
#! Bailing out the installation for Bio-Procedural-1.7.4.

for BrakerGff in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/braker/75/P_aphanis_braker/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/masked/rep_modeling/*_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/75/742025/out/PredictedPass.gff3
PGNGff=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/75/742025/out/PGN_predictedPass.gff3
AddDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/75/742025/additional
FinalDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/75/742025/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir

bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList
bedtools intersect -v -a $PGNGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' >> $AddGenesList
ProgDir=/projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/feature_annotation
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff
$ProgDir/gene_list_to_gff.pl $AddGenesList $PGNGff PGNCodingQuarry_v2.0 ID CodingQuary >> $AddGenesGff
ProgDir=/projects/oldhome/armita/git_repos/emr_repos/tools/gene_prediction/codingquary

$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done
#ERROR Can't locate Bio/Seq.pm in @INC
```




































Accepted hits .bam file were concatenated and indexed for use for gene model training:
```bash
for OutDir in $(ls -d alignment/star/v.inaequalis/172); do
  Strain=$(echo 172)
  Organism=$(echo v.inaequalis)
  echo "$Organism - $Strain"
  # For all alignments
  BamFiles=$(ls alignment/star/v.inaequalis/172/*/SRR*/star/*sortedByCoord.out.bam | tr -d '\n' | sed 's/.bam/.bam /g')
  mkdir -p $OutDir/concatenated
  samtools merge -@ 4 -f $OutDir/concatenated/concatenated.bam $BamFiles
done
```



























```bash
For genome coverage, I would map reads back to the contigs, then use samtools depth to get the coverage counts - you can divide by the total length of all your contigs to get the mean coverage.  To determine duplicates, use picard-tools 's MapDuplicates on the aligned bam, followed by samtools flagstat to get numbers. 
```