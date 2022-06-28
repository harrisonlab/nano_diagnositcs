DR# P.aphanis genome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis sampled from strawberry as part of Nano Diagnistics PhD.

All following commands were execited on the NIAB HPC from the folder /projects/nano_diagnostics.

All bowtie2 folders have been subsequently deleted to save space.

All genomes that were stored in /data/scratch/heavet/assembly/genome have been moved to the crop diversity hpc to save space

## Collecting data

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
### FastQC
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
### Trimmomatic
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
for QCData in $(ls dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/*/*/R/*m.fq.gz); do
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
```bash
mkdir -p dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#18877
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the Fragaria ananassa 'camarosa' genome and to existing powdery mildew assemblies for comparison. Alignments were made with our first round of sequencinng data, then our first and second round of sequencing data, then our first and second round of sequencing data plus previous sequencing data generated by H.Cockerton and finally for the H.Cockerton data alone.
```bash
screen -r
srun -p long  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa
bowtie2-build /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta camarosa_index

#Alignments to the Camarosa host genome:
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
#14.04% overall alignment rate
grep -c '@' alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-f.fq #293,519,726
grep -c '@' alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_fr-r.fq #293,519,726
grep -c '@' alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa/THeavenDRCT72020_1allunalignedcamarosa_s-s.fq #10,747,404

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
#17.37% overall alignment rate

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
#71.17% overall alignment rate

#Alignments to the ganan apple powdery mildew genome:
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
#14.37% overall alignment rate

bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1allunalignedGananPleucotricha.sam \
-S THeavenDRCT72020_1allalignedGananPleucotricha.sam
echo finished
#14.15% overall alignment rate

bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1combunalignedGananPleucotricha.sam \
-S THeavenDRCT72020_1combalignedGananPleucotricha.sam
echo finished
#13.58% overall alignment rate

#Alignments to the H.Cockerton draft P.aphanis assembly:
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
#59.16% overall alignment rate

bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedcockerton_combP_aphanis.sam \
-S THeavenDRCT72020_1alignedcockerton_combP_aphanis.sam
echo finished
#56.76% overall alignment rate

#Alignments to the wheat powdery mildew genome:
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
#2.06% overall alignment rate

#Alignments to the grape powdery mildew genome:
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
#3.71% overall alignment rate


#Alignments to the P.xanthii transcriptome:
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
#11.29% overall alignment rate

#Alignments to the P.pannosa transcriptome:
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
#6.03% overall alignment rate
```
## Coverage
### Samtools
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

#all reads compared to the P.cerasii genome from ncbi
mkdir alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii/allTHeavenDRCT72020_1_v_cerasii-21 '/home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.c.fna

kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii/allTHeavenDRCT72020_1_v_cerasii-21plot1000 alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii/allTHeavenDRCT72020_1_v_cerasii-21-main.mx

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii/allTHeavenDRCT72020_1_v_cerasii-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/pcerasii/allTHeavenDRCT72020_1_v_cerasii-21-main.mx

conda deactivate
exit
exit

screen -S kat
srun -p himem  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the camarosa genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21-main.mx
kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21plot1000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allreads_v_camarosa-21-main.mx

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
## kraken2
```bash
screen -S kraken2_2
srun -p short -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /projects/nano_diagnostics
mkdir -p dna_qc/P_aphanis/THeavenDRCT72020_1/kraken
gunzip -k dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/00*/*/*.fq.gz
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_aphanis/THeavenDRCT72020_1/kraken/ntoutput_#.txt \
--unclassified-out dna_qc/P_aphanis/THeavenDRCT72020_1/kraken/ntunclassified_#.txt \
--classified-out dna_qc/P_aphanis/THeavenDRCT72020_1/kraken/ntclassified_#.txt \
--report dna_qc/P_aphanis/THeavenDRCT72020_1/kraken/ntreport_#.txt \
--use-names \
/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq
# 
# 
rm dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/00*/*/*.fq
conda deactivate
exit
exit
echo finished
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

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss. Initial runs produced assemblies much larger than expected with duplication of BUSCOs, further iterations of assembly were therefore performed varying the settings of SPAdes.
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
#isolate setting with cuttoff of 150
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
#isolate setting with cuttoff of 75
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

#isolate setting with cuttoff of 25
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
### Quast
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
BUSCO was used to assess the quality of the genome assemblies:
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
## Coverage
### KAT
KAT was used to re-estimate the coverage of our raw reads vs our draft assemblies.
```bash
#trimmed reads vs the final assembled genome assembly filtered for all but leotiomycetes
screen -S kat
srun -p himem -J kat  --mem 1000G --pty bash
conda activate kat
cd /projects/nano_diagnostics

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades_1-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta

kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades_1-21plot1000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades_1-21-main.mx

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades_1-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades_1-21-main.mx

conda deactivate
exit
exit
echo finished

#Reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21plot1000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21-main.mx

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21-main.mx

#The cockerton reads were compared to the spades assembly and the results plotted: 
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21-main.mx

#The camarosa genome was compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21 'rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21-main.mx
```
### Samtools
```bash
#An alignment of all our reads including unpaired reads was made to the 75 cuttoff assembled genome, this produced a 66.1% overall alignment rate.
screen -S bowtie
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta Heaven_P_aphanis75_index
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
#66.10% overall alignment rate

samtools view --threads 8 -bS THeavenDRCT72020_1alignedHeaven_P_aphanis75.sam -o THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam
samtools index -@ 8 THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam.index
samtools coverage THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam -o coverage75.txt
#median depth = 432, mean depth = 1033

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
#65.98% overall alignment rate

samtools view --threads 8 -bS THeavenDRCT72020_1alignedHeaven_P_aphanis.sam -o THeavenDRCT72020_1alignedHeaven_P_aphanis.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam THeavenDRCT72020_1alignedHeaven_P_aphanis.bam
samtools index -@ 8 THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted.bam -o coverage.txt
#median depth = 58.6, mean depth 212
```
Size estimation
```bash
screen -S jellyfish
srun -J jellyfish -p long  --ntasks-per-node 12 --mem-per-cpu 20G --pty bash
conda activate jellyfish
jellyfish count -t 8 -C -m 19 -s 5G -o dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/jellyfish/19mer_out --min-qual-char=? <(zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_R_trim_unpaired.fq.gz) <(zcat dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-all_F_trim_unpaired.fq.gz)
jellyfish histo -o dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/jellyfish/19mer.histo dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/all/jellyfish/19mer_out
```
## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. The metagenomic classification tools centrifuge, metabat2 and kraken2 were used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample.
### Centrifuge
Centrifuge was run with trimmed reads to identify what taxa were represented in the metagenome data.
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
This is the program ultimately used for filtering our contigs. kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample. Database creation detailed in https://github.com/harrisonlab/nano_diagnositcs/blob/master/P_leucotricha/P_leucotricha_assembly.md and https://github.com/harrisonlab/nano_diagnositcs/blob/master/P_aphanis/P_aphanis_genome_raspberry.md

```bash
#kraken run with fungal only database
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

#kraken run with general database
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

#kraken rerun with database containing all published mildew genomes and strawberry genome
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
Following feedback from reviews all contigs not identified as Leotiomycetes were removed.
```bash
screen -S kraken4
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntreport.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta
#   12476 sequences classified (98.22%)
#   226 sequences unclassified (1.78%) 
conda deactivate
exit
exit
echo finished

touch analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist2.txt
nano analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist2.txt #edited to contain all taxa identified that were not leotiomycetes
grep -f analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist2.txt analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt  > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs2.txt

nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs2.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames2.txt

conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames2.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminants2.fasta
conda deactivate

conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames2.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp2.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp2.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta
wc -l analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames2.txt #343
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta #25404
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta #24718

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)/filtered_2
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19132
conda deactivate

screen -S busco
srun -p long  --mem 350G --pty bash
conda activate BUSCO
for assembly in $(echo assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits); do
    Data=$(ls $assembly/contigs_min_500bp_renamed22.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/2/filtered
    cd $Input/BUSCO/fungi/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/ascomycota/2/filtered
    cd $Input/BUSCO/ascomycota/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/leotiomycetes/2/filtered
    cd $Input/BUSCO/leotiomycetes/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
conda deactivate
exit
exit
echo finished
```























































### Blobtools

```bash
#An alignment of all our reads including unpaired reads was made to the 75 cuttoff assembled genome filtered for leotiomycetes, this produced a 66.1% overall alignment rate.
screen -S bowtie
srun -J bowtie -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis22
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis22
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta Heaven_P_aphanis22_index
bowtie2 \
-x Heaven_P_aphanis22_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_aphanis22.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis22_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis22_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_aphanis22.sam
exit
exit
echo finished
#62.43% overall alignment rate
samtools view -S -b /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis22/THeavenDRCT72020_1alignedHeaven_P_aphanis22.sam > /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis22/THeavenDRCT72020_1alignedHeaven_P_aphanis22.bam


screen -S blastn
srun -J blast -p long --mem 100G --pty bash
cd /scratch/public_data/NCBI_database/nt
blastn \
-task megablast \
-query /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis22/THeavenDRCT72020_1alignedHeaven_P_aphanis22.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn_2/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19065, 19164
conda deactivate

scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed22.fasta 

screen -S blastn
srun -p long --mem 100G --pty bash
conda activate blast+
cd apps/blobtools2/nt
blastn \
-task megablast \
-query /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed22.fasta  \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /home/theaven/scratch/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
conda deactivate
exit
exit
echo finished

blobtools plot -r superkingdom -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/plot/
blobtools plot -r order -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/plot/
blobtools plot -r family -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/plot/
blobtools plot -r genus -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/plot/
blobtools plot -r species -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/plot/

#blobtools identified a large number of contigs as oomycetes, these were extracted and investigated
grep 'Oomycota' /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.blobDB.summary.txt > /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs.txt
while read line; do echo $line | cut -f1 -d ' ' >> /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs2.txt ; done < /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs.txt
rm /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs2.txt > /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs.fasta
conda deactivate
screen -S busco
srun -p long -J busco --mem 350G --pty bash
conda activate BUSCO
for assembly in $(echo analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB); do
    Data=$(ls $assembly/contigs_min_500bp_renamed22.oomycotacontigs.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/alveolata/2/filtered
    cd $Input/BUSCO/alveolata/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l alveolata_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/stramenopiles/2/filtered
    cd $Input/BUSCO/stramenopiles/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l stramenopiles_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/fungi/2/filtered
    cd $Input/BUSCO/fungi/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/ascomycota/2/filtered
    cd $Input/BUSCO/ascomycota/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/leotiomycetes/2/filtered
    cd $Input/BUSCO/leotiomycetes/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
conda deactivate
exit
exit
echo finished
screen -S busco2
srun -p long -J busco --mem 350G --pty bash
conda activate BUSCO
for assembly in $(echo assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits); do
    Data=$(ls $assembly/contigs_min_500bp_renamed22.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/alveolata/2/filtered
    cd $Input/BUSCO/alveolata/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l alveolata_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/stramenopiles/2/filtered
    cd $Input/BUSCO/stramenopiles/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l stramenopiles_odb10
    cd /projects/nano_diagnostics
done
conda deactivate
exit
exit
echo finished
screen -S kraken
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/kraken-oomycota
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/kraken-oomycota/ntoutput.txt \
--unclassified-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/kraken-oomycota/ntunclassified-out.txt \
--classified-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/kraken-oomycota/ntclassified-out.txt \
--report /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/kraken-oomycota/ntreport.txt \
--use-names \
/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2/blobDB/contigs_min_500bp_renamed22.oomycotacontigs.fasta
#
#
conda deactivate
exit
exit
echo finished

##############################################################################
conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/JAATOF01.c.fna); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.c.fna@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2647700, 2673217

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii/*.c.fna); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.c.fna@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2647750, 2673218
#Submitted batch job 2647751, 2673219

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.c.fna); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.c.fna@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2647839, 2673221

srun -p long -J fastq-dump --mem 200G --pty bash
conda activate ncbi
wget -P /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/GananJAATOF01/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-19/SRR11471384/SRR11471384.1
fastq-dump --split-files --gzip -O /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/GananJAATOF01/. /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/GananJAATOF01/SRR11471384.1
wget -P /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/KimJAAAXZ0 #raw data not available
wget -P /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-20/SRR12260826/SRR12260826.1
wget -P /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos3/sra-pub-run-21/SRR12260825/SRR12260825.1
fastq-dump --split-files --gzip -O /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/. /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260825.1 
fastq-dump --split-files --gzip -O /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/. /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260826.1 
wget -P /home/theaven/projects/niab/theaven/raw_data/DNA/blumeria/graminis/MullerCAJHIT01 #raw data not available
conda deactivate

screen -S bowtie
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
mkdir -p alignment/Podosphaera/xanthii/PolonioJACSEY0/illumina/bowtie2/polonio
cd alignment/Podosphaera/xanthii/PolonioJACSEY0/illumina/bowtie2/polonio
bowtie2-build /home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii/GCA_014884795.1_ASM1488479v1_genomic.c.fna polonio_index
bowtie2 \
-x polonio_index \
-1 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260825.1_1.fastq.gz \
-2 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260825.1_2.fastq.gz \
-U /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260826.1_1.fastq.gz \
-S P_xanthiipolonioreads.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished
#% overall alignment rate - runs for over 5 days

screen -S bowtie3
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd alignment/Podosphaera/xanthii/PolonioJACSEY0/illumina/bowtie2/polonio
bowtie2 \
-x polonio_index \
-1 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260825.1_1.fastq.gz \
-2 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/xanthii/PolonioJACSEY0/SRR12260825.1_2.fastq.gz \
-S P_xanthiipolonioreads_short.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished
#% overall alignment rate

screen -S bowtie2
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
mkdir -p alignment/Podosphaera/leucotricha/GananJAATOF01/illumina/bowtie2/ganan
cd alignment/Podosphaera/leucotricha/GananJAATOF01/illumina/bowtie2/ganan
bowtie2-build /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/JAATOF01.c.fna ganan_index
bowtie2 \
-x ganan_index \
-1 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/GananJAATOF01/SRR11471384.1_1.fastq.gz \
-2 /home/theaven/projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/GananJAATOF01/SRR11471384.1_2.fastq.gz \
-S P_leucotrichagananreads.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished
#% overall alignment rate

scp -r ~/git_repos/tools/prog/blobtools/blobtools/data/names.dmp theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/blobtools/.
scp -r ~/git_repos/tools/prog/blobtools/blobtools/data/nodes.dmp theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/blobtools/.

conda activate blobtools
ProgDir=/home/theaven/scratch/apps/blobtools
Assembly=/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/JAATOF01.c.fna
Coverage=/home/theaven/scratch/alignment/Podosphaera/leucotricha/GananJAATOF01/illumina/bowtie2/ganan/P_leucotrichagananreads.sam
OutDir=/home/theaven/scratch/analysis/Podosphaera/leucotricha/GananJAATOF01/blobtools
Hitfile=/home/theaven/scratch/analysis/blastn/Podosphaera/leucotricha/JAATOF01/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#2742728
conda deactivate

conda activate blobtools
ProgDir=/home/theaven/scratch/apps/blobtools
Assembly=/home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii/GCA_014884795.1_ASM1488479v1_genomic.c.fna
Coverage=/home/theaven/scratch/alignment/Podosphaera/xanthii/PolonioJACSEY0/illumina/bowtie2/polonio/P_xanthiipolonioreads_short.sam
OutDir=/home/theaven/scratch/analysis/Podosphaera/xanthii/PolonioJACSEY0/blobtools
Hitfile=/home/theaven/scratch/analysis/blastn/Podosphaera/xanthii/GCA_014884795.1_ASM1488479v1_genomic/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#2742729
conda deactivate
##############################################################################

#Filtered for fungi:
screen -S bowtie
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta Heaven_P_aphanis75_index
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
#66.10% overall alignment rate



screen -S blastn
srun -p long --mem 100G --pty bash
mkdir -p /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn
cd /scratch/public_data/NCBI_database/nt
scp -r /scratch/public_data/NCBI_database theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data

blastdb_aliastool -gilist /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/fungigilist.gi -db nt -out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/nt_fungi -title nt_fungi

blastn -task megablast -query /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta -db nt -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle' -max_target_seqs 25 -culling_limit 2 -num_threads 16 -evalue 1e-25 -out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast---.out

blastn \
-task megablast \
-query /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast.out

conda activate blast+
cd apps/blobtools2/nt
blastn \
-task megablast \
-query /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.mmod.fna \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /home/theaven/scratch/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
conda deactivate
#Warning: [blastn] Examining 5 or more matches is recommended

#-window_masker_taxid 4751 \
#-gilist /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/fungigilist.gi \
#gilist is exactly 20000 long >:(

screen -S blobtools
srun -J blobtools -p long --mem 100G --pty bash
conda activate blobtools
cd /projects/nano_diagnostics
samtools view -S -b /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sam > /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam
samtools sort /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam > /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam
cp /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam.bai /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.index.bam
samtools index -@ 8 /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam 
samtools quickcheck /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam #no output = file passes checks

/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam.index
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
mkdir -p OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1

blobtools create -i $Assembly -b $Coverage -t $Hitfile -o $OutDir  --names ~/git_repos/tools/prog/blobtools/blobtools/taxdump/names.dmp --nodes ~/git_repos/tools/prog/blobtools/blobtools/taxdump/nodes.dmp
blobtools view -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/
grep '^##' /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1.blobDB.table.txt ; \
 grep -v '^##' /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1.blobDB.table.txt | \
 column -t -s $'\t' > /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1.blobDB.summary.txt
 mkdir /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/contigs_min_500bp_renamed2
blobtools plot -r superkingdom -i /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/1.blobDB.json -o /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/contigs_min_500bp_renamed2/
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis75/THeavenDRCT72020_1alignedHeaven_P_aphanis75.sort.bam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn_2/assembly.vs.nt.mts1.hsp1.1e25.megablast_1.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19155, 19160, 19165
conda deactivate

#testrun:
cd ~/git_repos/tools/prog/blobtools/blobtools/
samtools sort example/mapping_1.bam > example/mapping_2.bam
blobtools create \
 -i ~/git_repos/tools/prog/blobtools/blobtools/example/assembly.fna \
 -b ~/git_repos/tools/prog/blobtools/blobtools/example/mapping_2.bam \
 -t ~/git_repos/tools/prog/blobtools/blobtools/example/blast.out \
 -o ~/git_repos/tools/prog/blobtools/blobtools/example/my_first_blobplot \
 --names ~/git_repos/tools/prog/blobtools/blobtools/data/names.dmp \
 --nodes ~/git_repos/tools/prog/blobtools/blobtools/data/nodes.dmp

#unfiltered
screen -S bowtie2
srun -J bowtie -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis0
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis0
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta Heaven_P_aphanis0_index
bowtie2 \
-x Heaven_P_aphanis0_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_aphanis0.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis0_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis0_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_aphanis0.sam
exit
exit
echo finished
#66.10% overall alignment rate

screen -S blastn
srun -J blast -p long --mem 100G --pty bash
cd /scratch/public_data/NCBI_database/nt
blastn \
-task megablast \
-query /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out

scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_0.fasta
screen -S blastn2
srun -J blast -p long --mem 100G --pty bash
conda activate blast+
cd apps/blobtools2/nt
blastn \
-task megablast \
-query /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_0.fasta \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /home/theaven/scratch/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
conda deactivate
exit
exit

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis0/THeavenDRCT72020_1alignedHeaven_P_aphanis0.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19107
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/725715/*/contigs_min_500bp.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis0/THeavenDRCT72020_1alignedHeaven_P_aphanis0.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn_2/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19156, 19166
conda deactivate

#Podosphaera
cp analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist2.txt analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist22.txt
nano analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist22.txt #edited to contain all taxa identified that were not podosphaera
grep -f analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantlist22.txt analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt  > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs22.txt

nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontigs22.txt > analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames22.txt

conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames22.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp22.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/filtered_contigs_min_500bp22.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta
wc -l analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/contaminantcontignames22.txt #628
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta #25404
wc -l assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta #24148

screen -S bowtie3
srun -J bowtie -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis222
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis222
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta Heaven_P_aphanis222_index
bowtie2 \
-x Heaven_P_aphanis222_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_aphanis222.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis222_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_aphanis222_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_aphanis222.sam
exit
exit
echo finished
#% overall alignment rate

screen -S blastn2
srun -J blast -p long --mem 100G --pty bash
cd /scratch/public_data/NCBI_database/nt
blastn \
-task megablast \
-query /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_3.out

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta
Coverage=/projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_aphanis222/THeavenDRCT72020_1alignedHeaven_P_aphanis222.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blobtools/2
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72020_1/blastn_2/assembly.vs.nt.mts1.hsp1.1e25.megablast_3.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19106, 19167
conda deactivate

scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed222.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed222.fasta 

screen -S blastn2
srun -p long --mem 100G --pty bash
conda activate blast+
cd apps/blobtools2/nt
blastn \
-task megablast \
-query /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed222.fasta  \
-db nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 16 \
-evalue 1e-25 \
-out /home/theaven/scratch/analysis/P_aphanis/THeavenDRCT72020_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_3.out
conda deactivate
exit
exit
echo finished
```
## NCBI submission

### Mitofinder
Mitofinder was used to identify contigs in the assembly that belong to the mitochondrial genome.
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

### NCBI submission

Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI reports (FCSreport.txt) were manually downloaded to the following locations:
```bash
mkdir -p genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir
mv genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir/Contaminatio*.txt genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir/FCSreport.txt
```
These downloaded files were used to correct assemblies:
```bash
conda activate biopython2.7
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls genome_submission/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/NCBI_report_dir/FCSreport.txt)
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed2.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#780140
conda deactivate
```
Raw reads were submitted to the NCBI SRA
```bash
screen -S ftp
conda activate ftp
lftp ftp-private.ncbi.nlm.nih.gov
login subftp
w4pYB9VQ
cd uploads/tcheaven_googlemail.com_mCkezA8U
mkdir SAMN20669290
cd SAMN20669290
put /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008508_1.fq.gz
put /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008508_2.fq.gz
put /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008509_1.fq.gz
put /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008509_2.fq.gz
put /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_1.fq.gz
put /archives/2020_niab_general/20201203_X204SC20110698-Z01-F001/X204SC20110698-Z01-F001/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HKFFGDSXY_L4_2.fq.gz
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_1.fq.gz 
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNLV2DSXY_L2_2.fq.gz 
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_1.fq.gz 
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HTTWTDSXY_L3_2.fq.gz
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_1.fq.gz
put /archives/2021_eastmall_general/H204SC20110698-X204SC20110698-Z01-F003/X204SC20110698-Z01-F003/raw_data/D3009202001/D3009202001_FDSW202589165-1r_HNTVMDSXY_L4_2.fq.gz
exit
conda deactivate
exit
```
Identifying ITS regions:
```bash
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 
touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its12.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its12.fasta
grep -B 1 'CGCAGGTTCACCTACGGA' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its12.fasta

touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its42.fasta
grep -B 1 'TCCTCCGCTTATTGATATGC' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its42.fasta
grep -B 1 'GCATATCAATAAGCGGAGGA' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its42.fasta

touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its142.fasta
grep -A 1 '2731\|4275\|4920\|7211\|7365' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its12.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its142.fasta

grep -A 1 'contig_7365\|contig_2731' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta >> itss.fasta

grep 'contig_7365' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt
#contig 7365 is assigned to Golovinomyces as expected from blast, contains golovinomyces its
grep 'contig_2731' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt
#contig 2731, which contains ITS blasting to bacteria as well as B.graminis was assigned to P.cerasii by kraken

awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.c.fna > data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna

grep -B 1 'TCCGTAGGTGAACCTGCG' data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits1.fasta
grep -B 1 'CGCAGGTTCACCTACGGA' data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits1.fasta

grep -B 1 'TCCTCCGCTTATTGATATGC' data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits4.fasta
grep -B 1 'GCATATCAATAAGCGGAGGA' data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits4.fasta

grep -A 1 'JAGTUB010000036.1 \|JAGTUB010000459.1\|JAGTUB010000840.1' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits4.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/cerasiiits14.fasta

#kraken was run on the assembly using a database without all mildews added
screen -S kraken2
srun -p long -J kraken2 --mem 300G --pty bash
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi3/output.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi3/unclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi3/classified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/fungi3/report.txt \
--use-names \
assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta 

grep -A 1 'Golovinomyces' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/golovino_contigs.txt
nawk -F"\\t" '{print $2}' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/golovino_contigs.txt > assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/golovino_contignames.txt

conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/golovino_contignames.txt > assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/golovino_contigs.fasta
conda deactivate

grep -A 1 'Blumeria' analysis/P_aphanis/THeavenDRCT72020_1/kraken2/nt/725715/ntoutput.txt >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/bg_contigs.txt
nawk -F"\\t" '{print $2}' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/bg_contigs.txt > assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/bg_contignames.txt

conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/bg_contignames.txt > assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/bg_contigs.fasta
conda deactivate


#before all but leotiomycetes were removed:
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 
touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its1.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its1.fasta
grep -B 1 'CGCAGGTTCACCTACGGA' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its1.fasta

touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its4.fasta
grep -B 1 'TCCTCCGCTTATTGATATGC' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its4.fasta
grep -B 1 'GCATATCAATAAGCGGAGGA' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its4.fasta

touch assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its14.fasta
grep -A 1 '2412\|4220\|6243\|6688\|7436\|7439\|4920\|5877' assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its4.fasta >> assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its14.fasta

#contig 4920 contains the p.aphanis ITS region

screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredoutput-its.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredunclassified-out-its.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredclassified-out2.txt \
--report analysis/P_aphanis/THeavenDRCT72020_1/kraken2/1/filteredreport-its.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/its14.fasta
exit
exit
echo finished
#  8 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

```
Investigating its region in other published mildews
```bash
#P. xanthii
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna > data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa

cat data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=TCCTCCGCTTATTGATATGC)' > now.fasta
cat data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=GCATATCAATAAGCGGAGGA)' >> now.fasta # give some
cat data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=GCATATCAATAAGCGGAGGA)' > now.fasta
cat data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=TCCTCCGCTTATTGATATGC)' > now.fasta # gives some
grep -B 1 -f now.fasta data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fa >> then.fasta
#many its sequences

#P.leucotricha
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < data/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fna > data/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fa
assembly=data/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fa
cat $assembly | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=TCCTCCGCTTATTGATATGC)' >> now2.fasta
cat $assembly | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=GCATATCAATAAGCGGAGGA)' >> now2.fasta 
cat $assembly | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=GCATATCAATAAGCGGAGGA)' >> now2.fasta
cat $assembly | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=TCCTCCGCTTATTGATATGC)' >> now2.fasta
grep -B 1 -f now2.fasta $assembly >> then2.fasta
#no its sequences

#B.graminis
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < data/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.mod.fna > data/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.mod.fa
assembly=data/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.mod.fa
cat $assembly | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=TCCTCCGCTTATTGATATGC)' >> now3.fasta
cat $assembly | grep -oP '(?<=TCCGTAGGTGAACCTGCG).*?(?=GCATATCAATAAGCGGAGGA)' >> now3.fasta 
cat $assembly | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=GCATATCAATAAGCGGAGGA)' >> now3.fasta
cat $assembly | grep -oP '(?<=CGCAGGTTCACCTACGGA).*?(?=TCCTCCGCTTATTGATATGC)' >> now3.fasta
grep -B 1 -f now3.fasta $assembly >> then3.fasta
#many its sequences
```
```bash
screen -S kraken
srun -p himem -J kraken2 --mem 350G --pty bash

 for Assembly in $(ls -d assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits); do
  OutDir=$(echo $Assembly|sed 's@assembly/metagenome@analysis@g'|sed 's@SPAdes@kraken2/mildew@g'|sed 's@filtered_contigs@@g')
  mkdir -p $OutDir
  kraken2 \
  --db /home/theaven/scratch/apps/kraken2/mildew \
  --output $OutDir/output.txt \
  --unclassified-out $OutDir/unclassified-out.txt \
  --classified-out $OutDir/classified-out.txt \
  --report $OutDir/report.txt \
  --use-names \
  $Assembly/contigs_min_500bp_renamed22.fasta
  echo $Assembly
  echo $OutDir
done
#  11868 sequences classified (96.03%)
#  491 sequences unclassified (3.97%)
exit
exit
echo finished

ls analysis/P_aphanis/THeavenDRCT72020_1/kraken2/mildew/725715/ncbi_edits/unclassified-out.txt
```

## Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta); do
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked/3
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
done
#784844, 19268, 19273
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta); do
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI
done
#780369, 19269
conda deactivate
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands:
```bash
RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/3/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/transposonPSI/heavet_contigs_unmasked.fa.TPSI.allHits.chains.gff3
printf "P_aphanis/THeavenDRCT72020_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#28,609,425
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#8,660,295
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#30000951
```
```bash
for File in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 29,901,792
```
The total length of the genome given by quast is 55,613,046bp if 29,901,792bp have been masked as repetative then 53.77% of the genome is made up of repeats.

```bash
scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/.

scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/3/rep_modeling/Assembled_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/.
```

## Gene prediction
RNAseq was performed on P. aphanis to guide gene prediction. Gene prediction was performed using braker supplimented by additon predctions from codingquarry. Duplicated predictions were removed.

### RNA Alignment

Trimmed RNASeq reads can be found here:
```bash
ls dna_qc/P_aphanis/RNAexp1/infected/F/*trim.fa
ls dna_qc/P_aphanis/RNAexp1/infected/R/*trim.fa
```
These will be a mix of strawberry and strawberry powdery mildew RNASeq reads.

STAR was used to align RNAseq data for P.aphanis to our genome assembly.
```bash
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715
for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta
    ProgDir=~/git_repos/tools/seq_tools/RNAseq
    OutDir=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#785289

scp -r /projects/nano_diagnostics/dna_qc/P_aphanis/RNAexp1/infectedtheaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/dna_qc/P_aphanis/RNAexp1/.

mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715_2
for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715_2
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#2741696
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence. BRAKER is a gene prediction pipeine using genomic and RNA-Seq data to automatically generate full gene structure annotations in novel genome. It combines two major tools: GeneMark-ES/ET and AUGUSTUS. These both use generalized hidden Markov model, a probabilistic model of a sequence and its gene structure.
```bash
#Before braker predictiction is performed, double check that the genemark key is in user area and copy it over from the genemark install directory:
conda activate braker
cp /home/gomeza/miniconda3/envs/gene_pred/bin/filterGenesIn_mRNAname.pl /home/heavet/miniconda3/envs/braker/bin/filterGenesIn_mRNAname.pl
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction/braker_fungi.sh /home/heavet/git_repos/tools/gene_prediction/braker1/gom_braker_fungi.sh
cp /home/gomeza/prog/genemark/gm_key_Nov2020/gm_key_64 ~/.gm_key #new key downloaded, unzipped and copied to ~/.gm_key

for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/braker
AcceptedHits=$(ls alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=725715_softmasked_TPSI_appended
ProgDir=/home/heavet/git_repos/tools/gene_prediction/braker1
sbatch $ProgDir/gom_braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#786319

conda activate braker
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/braker1.9
AcceptedHits=$(ls alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715_2/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=725715_softmasked_TPSI_appended
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2742537
conda deactivate
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. Codingquarry also uses hidden Markov models for prediction.

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate Stringtie
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#7863992

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/transposonPSI/heavet_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/transposonPSI
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#786993

conda activate stringtie
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715_2/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=~/scratch/apps/stringtie
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#2742540
```
CodingQuarry was used to predict genes in regions of the genome not containing Braker gene models.
```bash
conda activate codingquary
  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#787033

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/transposonPSI/heavet_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/TransposonPSI
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/transposonPSI/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#787034

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/TransposonPSI
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=~/scratch/apps/codingquarry
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#2739713

#segmentation fault on crop diversity server therefore back over to niab hpc >:(

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/3/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling_2
    GTF=gene_pred/P_aphanis/THeavenDRCT72020_1/stringtie/concatenated_prelim/rep_modeling_2/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#19295
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/braker/725715_softmasked_TPSI_appended/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/out/PredictedPass.gff3
PGNGff=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/out/PGN_predictedPass.gff3 # no PGN predicted pass file
AddDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/additional
FinalDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList
#bedtools intersect -v -a $PGNGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' >> $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff
#$ProgDir/gene_list_to_gff.pl $AddGenesList $PGNGff PGNCodingQuarry_v2.0 ID CodingQuary >> $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final
#Braker genes: 15766
#Coding quarry: 1799
#Combined: 17565
```
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/2/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling_2/19295/out/PredictedPass.gff3
AddDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/additional
FinalDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir
#Duplicate genes were removed and genes renamed

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
#Braker genes: 16192
#Coding quarry: 1397
#Combined: 17589
```
```bash
GffAppended=$(ls -d gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended.gff3)
FinalDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
rm $GffFiltered

#Create renamed fasta files from each gene feature 
Assembly=$(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa) 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>'
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
```
```bash
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/*/*/SPAdes/*/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
ID=$(echo $Assembly | rev |cut -f8,9 -d '/'| rev )
GffAppended=gene_pred/$ID/codingquarry/rep_modeling/final/final_genes_appended.gff3
FinalDir=gene_pred/$ID/codingquarry/rep_modeling/final
echo $ID

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
rm $GffFiltered

#Create renamed fasta files from each gene feature 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>'
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
done
```
## Genome annotation
Predicted gene features were annotated using two datahases, the swissprot database and the interpro database.

### Interproscan
InterPro is a database of protein families, domains and functional sites in which identifiable features found in known proteins can be applied to new protein sequences in order to functionally characterise them. The contents of InterPro consist of diagnostic signatures and the proteins that they significantly match.
```bash
for Genes in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do
    InterproDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
    SplitDir=$(dirname $Genes|sed 's@codingquarry/rep_modeling@interproscan@g'|sed 's@final@ @g')
    echo $Genes
    echo $SplitDir
    InName=$(basename $Genes)
    echo $InName
    mkdir -p $SplitDir
    $InterproDir/splitfile_500.py --inp_fasta $Genes --out_dir $SplitDir --out_base "$InName"_split
done 2>&1 | tee -a interproscan_submission.log

conda activate Java11
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/*_split_*); do
    InterproDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    OutDir=$(dirname $file)
    echo $OutDir
    sbatch $InterproDir/run_interproscan.sh $file $OutDir
done
#788558-788593
#788596-788631 shorter fasta path
#2084-2119
# Note - the latest version of interproscan doesnt work on the cluster
# because of GLIBC cant be updated.
conda deactivate

conda activate Java11
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/*_split_*); do
    InterproDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    OutDir=$(echo gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/intout1)
    echo $OutDir
    sbatch $InterproDir/run_interproscanold.sh $file $OutDir
done
#790958-790993 - slurm says successful but no output?, 1829-1864, 1904-1939, 1974-2009, 2212-2247, 4615-4650
#older version of interproscan was released may 5th 2020, lookup service disabled

for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/*_split_*); do
    InterproDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    OutDir=$(echo gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/intout2)
    echo $OutDir
    sbatch $InterproDir/run_interproscanold-prosite.sh $file $OutDir
done #4579-4614
conda deactivate

cp /data/scratch/gomeza/prog/Interproscan/interproscan-5.44-79.0/interproscan.sh /home/heavet/git_repos/tools/seq_tools/Feature_annotation/prog/Interproscan/interproscan-5.44-79.0/interproscan.sh

/data/scratch/gomeza/prog/Interproscan/interproscan-5.44-79.0/interproscan.sh -appl CDD,COILS,Gene3D,HAMAP,MobiDBLite,PANTHER,Pfam,PIRSF,PRINTS,SFLD,SMART,SUPERFAMILY,TIGRFAM -dp -goterms -iprlookup -pa -i $IN_NAME

mkdir gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI
#interproscan output run by A.Armitage on NRI HPC uploaded to gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI
wc gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv
#59829  891409 8391847 = 59,829 protein domains identified
grep Pfam gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc
#7312 135652 1241033 = 7,312 PFAM domains annotated
grep SMART gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #2547   39246  352964
grep PANTHER gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #9627  123909 1159333
grep ProSite gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #4603   89346  843116
grep MobiDBLite gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #14763  191919 1795570
grep Gene3D gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #7456  105715 1013130
grep SUPERFAMILY gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #5592   92831  929519
grep Coils gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #1910   21010  162345
grep CDD gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #2988   35759  339112
grep TIGRFAM gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #384    7516   78132
grep SFLD gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #49     667    5887
grep Hamap gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #189    3772   38321
grep PIRSF gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #281    4496   46463
grep PRINTS gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | wc #2142   39797  389155
```

### Swissprot

SWISS-PROT is a curated protein sequence database which strives to provide a high level of annotation, a minimal level of redundancy and a high level of integration with other databases. Swissprot Uniprot databases were downloaded
```bash
mkdir -p /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
cd /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz -o wgetlog.txt
gunzip uniprot_sprot.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot.xsd -o wgetlog.txt
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.dat.gz -o wgetlog.txt
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.xml.gz -o wgetlog.txt
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot_varsplic.fasta.gz -o wgetlog.txt
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.dat.gz -o wgetlog.txt
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz -o wgetlog.txt
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.xml.gz -o wgetlog.txt
gunzip uniprot_sprot.dat.gz
gunzip uniprot_sprot_varsplic.fasta.gz
gunzip uniprot_sprot.xml.gz
```
Intructions to create a database
```bash
dbFasta=$(ls /projects/dbUniprot/swissprot_2020_June/uniprot_sprot.fasta) 
dbType="prot" 
Prefix="June2020_uniprot_sprot" 
OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot
makeblastdb -in $dbFasta -input_type fasta -dbtype $dbType -title $Prefix.db -parse_seqids -out $OutDir/$Prefix.db 

cd ../../scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
dbFasta=$(ls /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot.fasta) 
dbType="prot" 
Prefix="uniprot_sprot" 
OutDir=.
makeblastdb -in $dbFasta -input_type fasta -dbtype $dbType -title $Prefix -parse_seqids -out $OutDir/$Prefix 
cd /projects/nano_diagnostics
```
Run swissprot
```bash
for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033 
    SwissDbDir=../dbUniprot/swissprot_2020_June
    SwissDbName=uniprot_sprot
    ProgDir=/home/akinya/git_repos/fusarium_ex_strawberry/ProgScripts/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#788639

for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033
    SwissDbDir=../../scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
    SwissDbName=uniprot_sprot
    ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#788653
wc gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
#10,919 131028 638001
```
## Genome submission
Submisison of annotations with an assembly appears to be a complex process. If a genome is to be submitted without annotation then all that is needed is the fasta file containing the assembled contigs. If an annotated genome is to be submitted then a number of processing steps are required before submission. The fasta file of contigs and the gff file of annotations must be combined to form a .asn file. The program that does this conversion (tbl2asn) requires the fasta files and gff files to be formatted correctly. In the case of the gff file, this means parsing it to a .tbl file. The program Annie parses interproscan, swissprot, blast hits etc. into a feature table file (.tbl) which is compatible with GAG. Genome annotation generator (GAG) parses annotations into a table format compatible with tbl2asn. tble2asn is NCBI's program which generates an annotated assembly including metadata, gene models, annotations and locus tag prefixes.

### Annie

Interproscan and Swissprot annotations were extracted using annie, the ANNotation Information Extractor. The output of Annie was filtered to keep only annotations with references to ncbi approved databases. Note - It is important that transcripts have been re-labelled as mRNA by this point.

```bash
#The gff3 file had invisible : and spaces at the end of some lines, these needed to be removed for the program to work
sed -e "s/;$//g" /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.gff3 > final_genes_appended_renamed2.gff3
#The swissprot database headers had to be edited for the proramme to work
cat /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot.fasta | while read line 
do
    if echo $line | grep '>' ;then
       gene=$(echo $line |cut -f 2 -d '|')
       func() {
   echo "${@:1:$#-1}";
}
linerev=$(func $(echo $line | rev))
trimline=$(echo $linerev | rev)
echo '>' $gene $trimline >> /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot2.fasta
    else
        echo $line >> /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot2.fasta
    fi
done
sed -e "s/> />/g" /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot2.fasta > /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot3.fasta

for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
  OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
  GffFile=$(ls final_genes_appended_renamed2.gff3)
  InterProTab=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv)  
  SwissProtBlast=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_tophit_parsed.tbl)
  SwissProtFasta=$(ls /scratch/public_data/tch/dbUniprot/swissprot_2021_Sept/uniprot_sprot3.fasta)
  AnnieDir=~/git_repos/tools/prog/annie/genomeannotation-annie-c1e848b
  python3 $AnnieDir/annie.py -ipr $InterProTab -g $GffFile -b $SwissProtBlast -db $SwissProtFasta -o $OutDir/annie_output.csv --fix_bad_products 
done

ProgDir=~/git_repos/tools/prog/genbank_submission
python3 $ProgDir/edit_tbl_file/annie_corrector.py --inp_csv $OutDir/annie_output.csv --out_csv $OutDir/annie_corrected_output.csv 
```
### GAG
Gag was run using the modified gff file as well as the annie annotation file. The Genome Annotation Generator (GAG.py) can be used to convert gff files into .tbl format, for use by tbl2asn. It can also add annotations to features as provided by Annie the Annotation extractor. Gag was noted to output database references incorrectly, so these were modified.
GAG requires; assembly fasta (contig lengths), gene gff (gene feature locations), annotations csv (product names, blast hit accession, database accessions)
```bash
conda activate quast
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
GffFile=$(ls final_genes_appended_renamed2.gff3)
mkdir -p $OutDir/gag/round1
python ~/git_repos/tools/prog/GAG/genomeannotation-GAG-98da78e/gag.py -f $Assembly -g $GffFile -a $OutDir/annie_corrected_output.csv --fix_start_stop -o $OutDir/gag/round1 2>&1 | tee $OutDir/gag_log1.txt
#python3 ~/git_repos/tools/prog/GAG/genomeannotation-GAG-732ac78/gag.py -f $Assembly -g $GffFile -a $OutDir/annie_corrected_output.csv --fix_start_stop -o $OutDir/gag/round1 2>&1 | tee $OutDir/gag_log1.txt
done
conda deactivatae

sed -i 's/Dbxref/db_xref/g' $OutDir/gag/round1/genome.tbl

#We checked that genes from each annotation step were included
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_tophit_parsed.tbl #swissprot records found in output
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv #interproscan - there are pfam and go annotations inn the output
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.gff3  #codingquarry - records found in output
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/braker/725715_softmasked_TPSI_appended/augustus.gff3 #braker records found in output

grep -o 'gene' $OutDir/gag_log1.txt
```
### First run of tbl2asn

A template was created at https://submit.ncbi.nlm.nih.gov/genbank/template/submission/ and downloaded

tbl2asn was run to generate an annotated genome. tbl2asn requires; template file (.sbt), fasta file for nucleotide sequence data (.fa), feature table file (.tbl).
```bash
conda activate tbl2asn
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
Organism=P_aphanis
strain=THeavenDRCT72020_1
cp $Assembly $OutDir/gag/round1/genome.fsa
SbtFile=$(ls /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/template.sbt)
cp $SbtFile $OutDir/gag/round1/genome.sbt
mkdir -p $OutDir/tbl2asn/round1
tbl2asn -p $OutDir/gag/round1/. -t $OutDir/gag/round1/genome.sbt -r $OutDir/tbl2asn/round1 -M n -X E -Z $OutDir/gag/round1/discrep.txt -j "[organism=$Organism] [strain=$Strain]"
done
conda deactivate
```

### Error correction

The first run of tbl2asn reported errors in the annotated genome, these will need to be corrected before submission to NCBI.

### ncbi tbl corrector
Editing .tbl file

This program allows automated correction of proteins in .tbl file after tbl2asn has identified errors. Instuctions are taken from the .val outfile on which genes / features should be modified.
Currently this program allows two types of corection:
1) Marking of genes with internal stop codons as pseudogenes
2) Correction of gene boundaries when they don't match minimum and maximum CDS boundaries. (This is responsible for errors in tbl2asn describing no stop codon)

```bash
conda activate quast
  for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
        Organism=P_aphanis
        Strain=SAMN20669290
        LabID="NIAB-EMR"
    OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
    LocusTag=K3495
    echo $LocusTag
    mkdir -p $OutDir/gag/edited
    ProgDir=~/git_repos/tools/genbank_submission
    python $ProgDir/edit_tbl_file/ncbi_tbl_corrector.py --inp_tbl $OutDir/gag/round1/genome.tbl --inp_val $OutDir/tbl2asn/round1/genome.val --locus_tag $LocusTag --lab_id $LabID --gene_id "remove" --edits stop pseudo unknown_UTR correct_partial --remove_product_locus_tags "True" --del_name_from_prod "True" --out_tbl $OutDir/gag/edited/genome.tbl
  done
  conda deactivate

```
Generating a structured comment detailing annotation methods
```bash
  for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
        Organism=P_aphanis
        Strain=SAMN20669290
        LabID="NIAB-EMR"
    OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
    printf "StructuredCommentPrefix\t##Genome-Annotation-Data-START##
    Annotation Provider\tNIAB-EMR
    Annotation Date\tDEC-2021
    Annotation Version\tRelease 1.01
    Annotation Method\tAb initio gene prediction: Braker 1.9 and CodingQuary 2.0; Functional annotation: Swissprot (Sept 2021 release) and Interproscan 5.46-81.0" \
    > $OutDir/gag/edited/annotation_methods.strcmt.txt
  done
```
### Second run of tbl2asn
Following correction of the GAG .tbl file, tbl2asn was re-run.

The options -l paired-ends -a r10k inform how to handle runs of Ns in the sequence, these options show that paired-ends have been used to estimate gaps and that runs of N's longer than 10 bp should be labelled as gaps.
```bash
conda activate tbl2asn
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    Organism=P_aphanis
    Strain=SAMN20669290
    SbtFile=$(ls /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/template.sbt)
  OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
  FinalName="$Organism"_"$Strain"_Heaven2022
  cp $Assembly $OutDir/gag/edited/genome.fsa
  cp $SbtFile $OutDir/gag/edited/genome.sbt
  mkdir $OutDir/tbl2asn/final
  tbl2asn -p $OutDir/gag/edited/. -t $OutDir/gag/edited/genome.sbt -r $OutDir/tbl2asn/final -M n -X E -Z $OutDir/tbl2asn/final/discrep.txt -j "[organism=$Organism] [strain=$Strain]" -l paired-ends -a r10k -w $OutDir/gag/edited/annotation_methods.strcmt.txt
  cat $OutDir/tbl2asn/final/genome.sqn | sed 's/title "Saccharopine dehydrogenase.*/title "Saccharopine dehydrogenase/g' | sed 's/"Saccharopine dehydrogenase.*"/"Saccharopine dehydrogenase"/g' > $OutDir/tbl2asn/final/$FinalName.sqn
done
conda deactivate

#Output of /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/errorsummary.val:
#    4 ERROR:   SEQ_FEAT.BadTrailingCharacter
#    32 ERROR:   SEQ_FEAT.MissingGeneXref
#     9 WARNING: SEQ_FEAT.DuplicateFeat
#     4 WARNING: SEQ_FEAT.NotSpliceConsensusDonor
#    64 WARNING: SEQ_FEAT.PartialProblem
#     7 WARNING: SEQ_FEAT.ProteinNameEndsInBracket
#    86 WARNING: SEQ_FEAT.ShortExon
#     1 INFO:    SEQ_FEAT.PartialProblem
#   484 INFO:    SEQ_FEAT.RareSpliceConsensusDonor
mkdir /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2
cp /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited/genome.tbl /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome.tbl
```
The second run of tbl2asn still reports some errors in the annotated assembly, these will need to be fixed manually.

BadTrailingCharacter error:
```bash
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'BadTrailingCharacter' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/BadTrailingCharacter.txt
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited/manualgenome2.tbl | sed 's/Saccharopine dehydrogenase.*/Saccharopine dehydrogenase/g' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl
```
MissingGeneXref error:
```bash
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'MissingGeneXref' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/MissingGeneXref.txt
#All hypothetical proteins, appears to be 4 proteins total wth 8 overlap/repeats each, 4 CDS, 4 mRNA
nano /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/MissingGeneXref.txt

#contig 140, geneious does not predict an ORF in this region, some hits, this is a codinguarry feature
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_140:7726-7785, 7913-8080)] [lcl|contig_140: raw, dna len= 30469] -> [gnl|NIAB-EMR|K3495_g1595a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_140:7726-7785, 7913-8017, 8070-8093)] [lcl|contig_140: raw, dna len= 30469] -> [gnl|NIAB-EMR|K3495_g1598a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_140:7726-7785, 7913-8080)] [lcl|contig_140: raw, dna len= 30469] -> [gnl|NIAB-EMR|K3495_g1597a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_140:7726-7785, 7913-8017, 8070-8093)] [lcl|contig_140: raw, dna len= 30469] -> [gnl|NIAB-EMR|K3495_g1596a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_140:<7726-7785, 7913->8080)] [lcl|contig_140: raw, dna len= 30469]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_140:<7726-7785, 7913-8017, 8070->8093)] [lcl|contig_140: raw, dna len= 30469]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_140:<7726-7785, 7913->8080)] [lcl|contig_140: raw, dna len= 30469]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_140:<7726-7785, 7913-8017, 8070->8093)] [lcl|contig_140: raw, dna len= 30469]

#contig 1376, geneious does not predict an ORF in this region, some blast hits, this is a codinguarry feature
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_1376:4689-4691, 4790-4867, 4917-4991)] [lcl|contig_1376: raw, dna len= 11661] -> [gnl|NIAB-EMR|K3495_g7911a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_1376:4689-4691, 4790-4867, 4917-4991)] [lcl|contig_1376: raw, dna len= 11661] -> [gnl|NIAB-EMR|K3495_g7913a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_1376:4689-4739, 4790-4867, 4917-4991)] [lcl|contig_1376: raw, dna len= 11661] -> [gnl|NIAB-EMR|K3495_g7912a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_1376:4689-4739, 4790-4867, 4917-4991)] [lcl|contig_1376: raw, dna len= 11661] -> [gnl|NIAB-EMR|K3495_g7910a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_1376:<4689-4691, 4790-4867, 4917->4991)] [lcl|contig_1376: raw, dna len= 11661]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_1376:<4689-4691, 4790-4867, 4917->4991)] [lcl|contig_1376: raw, dna len= 11661]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_1376:<4689-4739, 4790-4867, 4917->4991)] [lcl|contig_1376: raw, dna len= 11661]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 4 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_1376:<4689-4739, 4790-4867, 4917->4991)] [lcl|contig_1376: raw, dna len= 11661]

#contig 2429, geneious does not predict an ORF in this region, blast hits with low identity, this is a codinguarry feature
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_2429:6204-6324, 6372-6469)] [lcl|contig_2429: raw, dna len= 7209] -> [gnl|NIAB-EMR|K3495_g10836a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_2429:6204-6324, 6374-6396)] [lcl|contig_2429: raw, dna len= 7209] -> [gnl|NIAB-EMR|K3495_g10839a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_2429:6204-6324, 6372-6469)] [lcl|contig_2429: raw, dna len= 7209] -> [gnl|NIAB-EMR|K3495_g10838a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_2429:6204-6324, 6374-6396)] [lcl|contig_2429: raw, dna len= 7209] -> [gnl|NIAB-EMR|K3495_g10837a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_2429:<6204-6324, 6372->6469)] [lcl|contig_2429: raw, dna len= 7209]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_2429:<6204-6324, 6374->6396)] [lcl|contig_2429: raw, dna len= 7209]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_2429:<6204-6324, 6372->6469)] [lcl|contig_2429: raw, dna len= 7209]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_2429:<6204-6324, 6374->6396)] [lcl|contig_2429: raw, dna len= 7209]

#contig 3502, geneious predicts ORF from 2551-2988, no blast results from region, this is a codinguarry feature
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [lcl|contig_3502:2551-2988] [lcl|contig_3502: raw, dna len= 4487] -> [gnl|NIAB-EMR|K3495_g12794a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_3502:2551-2893, 2944-3059)] [lcl|contig_3502: raw, dna len= 4487] -> [gnl|NIAB-EMR|K3495_g12795a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [lcl|contig_3502:2551-2988] [lcl|contig_3502: raw, dna len= 4487] -> [gnl|NIAB-EMR|K3495_g12792a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: CDS: hypothetical protein [(lcl|contig_3502:2551-2893, 2944-3059)] [lcl|contig_3502: raw, dna len= 4487] -> [gnl|NIAB-EMR|K3495_g12793a]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [lcl|contig_3502:<2551->2988] [lcl|contig_3502: raw, dna len= 4487]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_3502:<2551-2893, 2944->3059)] [lcl|contig_3502: raw, dna len= 4487]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [lcl|contig_3502:<2551->2988] [lcl|contig_3502: raw, dna len= 4487]
ERROR: valid [SEQ_FEAT.MissingGeneXref] Feature overlapped by 2 identical-length genes but has no cross-reference FEATURE: mRNA: hypothetical protein [(lcl|contig_3502:<2551-2893, 2944->3059)] [lcl|contig_3502: raw, dna len= 4487]

#Overlapping of predicted gene features was confirmeed following download of affected contigs and gff to geneious
cat /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa | grep -w -A 1 'contig_140' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_140.fa
cat /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa | grep -w -A 1 'contig_1376' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_1376.fa
cat /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa | grep -w -A 1 'contig_2429' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_2429.fa
cat /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa | grep -w -A 1 'contig_3502' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_3502.fa
cat final_genes_appended_renamed2.gff3 | grep -w 'contig_140' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_140.gff3
cat final_genes_appended_renamed2.gff3 | grep -w 'contig_1376' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_1376.gff3
cat final_genes_appended_renamed2.gff3 | grep -w 'contig_2429' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_2429.gff3
cat final_genes_appended_renamed2.gff3 | grep -w 'contig_3502' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/contig_3502.gff3

#Lines containing MissingGeneXref errors were reomved, one iteration left
#grep -n -w -B 1 -A 13 'locus_tag   K3495_g1595' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 15 'locus_tag    K3495_g1596' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 13 'locus_tag    K3495_g1597' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 15 'locus_tag    K3495_g1598' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
#grep -n -w -B 1 -A 14 'locus_tag   K3495_g7910' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 14 'locus_tag    K3495_g7911' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 14 'locus_tag    K3495_g7912' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 14 'locus_tag    K3495_g7913' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
#grep -n -w -B 1 -A 11 'locus_tag   K3495_g10836' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 11 'locus_tag    K3495_g10837' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 11 'locus_tag    K3495_g10838' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 11 'locus_tag    K3495_g10839' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
#grep -n -w -B 1 -A 9 'locus_tag    K3495_g12792' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 11 'locus_tag    K3495_g12793' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 9 'locus_tag K3495_g12794' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
grep -n -w -B 1 -A 11 'locus_tag    K3495_g12795' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt
sed 's/-.*//' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXrefs.txt | sed 's/:.*//' | sed -e 's/$/d/' >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXreflines.txt 
sed -f /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/MissingGeneXreflines.txt /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome3.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome4.tbl

#features removed from the .tbl file were alse removed from the .gff3 file
cp final_genes_appended_renamed2.gff3 final_genes_appended_renamed3.gff3
cat final_genes_appended_renamed3.gff3 | grep -w -v 'g1596' | grep -w -v 'g1597' | grep -w -v 'g1598' | grep -w -v 'g7911' | grep -w -v 'g7912' | grep -w -v 'g7913' | grep -w -v 'g10837' | grep -w -v 'g10838' | grep -w -v 'g10839' | grep -w -v 'g12793' | grep -w -v 'g12794' | grep -w -v 'g12795' >> final_genes_appended_renamed4.gff3

#none of these features were found in the swissprot output
grep -w -E "g1596|g1597|g1598|g7911|g7912|g7913|g10837|g10838|g10839|g12793|g12794|g12795" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
grep -w -E "g1596|g1597|g1598|g7911|g7912|g7913|g10837|g10838|g10839|g12793|g12794|g12795" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_tophit_parsed.tbl

#contig 140 and 1376 features found in the interproscan output, these were removed from the gff3 file
grep -w -E "g1596|g1597|g1598|g7911|g7912|g7913|g10837|g10838|g10839|g12793|g12794|g12795" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.gff3 
grep -w -E "g1596|g1597|g1598|g7911|g7912|g7913|g10837|g10838|g10839|g12793|g12794|g12795" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv
grep -w -E "g1596|g1597|g1598|g7911|g7912|g7913|g10837|g10838|g10839|g12793|g12794|g12795" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.xml
cat /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.gff3 | grep -w -v 'g1596' | grep -w -v 'g1597' | grep -w -v 'g1598' | grep -w -v 'g7911' | grep -w -v 'g7912' | grep -w -v 'g7913' | grep -w -v 'g10837' | grep -w -v 'g10838' | grep -w -v 'g10839' | grep -w -v 'g12793' | grep -w -v 'g12794' | grep -w -v 'g12795' >> /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan2.gff3
cat /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv | grep -w -v 'g1596' | grep -w -v 'g1597' | grep -w -v 'g1598' | grep -w -v 'g7911' | grep -w -v 'g7912' | grep -w -v 'g7913' | grep -w -v 'g10837' | grep -w -v 'g10838' | grep -w -v 'g10839' | grep -w -v 'g12793' | grep -w -v 'g12794' | grep -w -v 'g12795' >> /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan2.tsv
#HOW TO REMOVE FROM xml file?

#features removed from the .tbl file were alse removed from the .cdna.fasta file
awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.cdna.fasta > gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta
grep -n -w -A 1 '>g1596' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g1597' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g1598' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g7911' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g7912' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g7913' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g10837' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g10838' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g10839' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g12793' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g12794' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
grep -n -w -A 1 '>g12795' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt
sed 's/-.*//' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs.txt | sed 's/:.*//' | sed -e 's/$/d/' >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXreflines.txt
sed -f gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXreflines.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.cdna.fasta

#features removed from the .tbl file were alse removed from the .pep.fasta file
awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta > gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta
grep -n -w -A 1 '>g1596' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g1597' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g1598' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g7911' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g7912' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g7913' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g10837' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g10838' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g10839' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g12793' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g12794' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
grep -n -w -A 1 '>g12795' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt
sed 's/-.*//' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXrefs1.txt | sed 's/:.*//' | sed -e 's/$/d/' >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXreflines1.txt
sed -f gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/MissingGeneXreflines1.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed1.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.pep.fasta
```
ProteinNameEndsInBracket warning:
```bash
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'ProteinNameEndsInBracket' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/ProteinNameEndsInBracket.txt
nano /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/ProteinNameEndsInBracket.txt
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: GMP synthase [glutamine-hydrolyzing] [gnl|NIAB-EMR|K3495_g501a:1-558] [gnl|NIAB-EMR|K3495_g501a: raw, aa len= 558]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: putative asparagine synthetase [glutamine-hydrolyzing] [gnl|NIAB-EMR|K3495_g2889a:1-582] [gnl|NIAB-EMR|K3495_g2889a: raw, aa len= 582]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: D-lactate dehydrogenase [cytochrome] [gnl|NIAB-EMR|K3495_g3561a:1-600] [gnl|NIAB-EMR|K3495_g3561a: raw, aa len= 600]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: Nicotinate-nucleotide pyrophosphorylase [carboxylating] [gnl|NIAB-EMR|K3495_g4207a:1-295] [gnl|NIAB-EMR|K3495_g4207a: raw, aa len= 295]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: Glutamine--fructose-6-phosphate aminotransferase [isomerizing] [gnl|NIAB-EMR|K3495_g4434a:1-701] [gnl|NIAB-EMR|K3495_g4434a: raw, aa len= 701]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: Alpha,alpha-trehalose-phosphate synthase [UDP-forming] [gnl|NIAB-EMR|K3495_g4839a:1-496] [gnl|NIAB-EMR|K3495_g4839a: raw, aa len= 496]
#WARNING: valid [SEQ_FEAT.ProteinNameEndsInBracket] Protein name ends with bracket and may contain organism name FEATURE: Prot: Methylmalonate-semialdehyde dehydrogenase [acylating] [gnl|NIAB-EMR|K3495_g14203a:1-565] [gnl|NIAB-EMR|K3495_g14203a: raw, aa len= 565]
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/P_aphanis_SAMN20669290_Heaven2022.sqn | grep -F '[' >> qwerty.txt #Warning entries all have [][P_aphanis] pattern

cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome.tbl | sed 's/\[glutamine\-hydrolyzing\]//g' | sed 's/\[cytochrome\]//g' | sed 's/\[carboxylating\]//g' | sed 's/\[isomerizing\]//g' | sed 's/\[UDP\-forming\]//g' | sed 's/\[acylating\]//g' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome2.tbl 
```
Other warnings:
```bash
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'DuplicateFeat' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/DuplicateFeat.txt
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'NotSpliceConsensusDonor' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/NotSpliceConsensusDonor.txt
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'PartialProblem' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/PartialProblem.txt
cat /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/genome.val | grep 'ShortExon' > /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/tbl2asn/final/ShortExon.txt
```
### Third run of tbl2asn
tbl2asn was run a third time to generate an annotated genome for submission to NCBI.
```bash
cp /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome4.tbl /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/genome.tbl
conda activate tbl2asn
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    Organism=P_aphanis
    Strain=SAMN20669290
    SbtFile=$(ls /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/template.sbt)
  OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
  FinalName="$Organism"_"$Strain"_Heaven2022
  cp $Assembly $OutDir/gag/edited2/genome.fsa
  cp $SbtFile $OutDir/gag/edited2/genome.sbt
  mkdir $OutDir/tbl2asn/final2
  tbl2asn -p $OutDir/gag/edited2/. -t $OutDir/gag/edited2/genome.sbt -r $OutDir/tbl2asn/final2 -M n -X E -Z $OutDir/tbl2asn/final2/discrep.txt -j "[organism=$Organism] [strain=$Strain]" -l paired-ends -a r10k -w $OutDir/gag/edited/annotation_methods.strcmt.txt
done
conda deactivate
#     2 WARNING: SEQ_FEAT.NotSpliceConsensusDonor
#    64 WARNING: SEQ_FEAT.PartialProblem
#    86 WARNING: SEQ_FEAT.ShortExon
#     1 INFO:    SEQ_FEAT.PartialProblem
#   478 INFO:    SEQ_FEAT.RareSpliceConsensusDonor
```
The remaining warning are considered minor and so we proceeded with submission to NCBI.

Three errors were reported by NCBI.
1.) FIND_OVERLAPPED_GENES: 2 genes completely overlapped by other genes
Gene    K3495_g3912     lcl|contig_476:<4337->4610      K3495_g3912
Gene    K3495_g14194    lcl|contig_4713:<1881->2006     K3495_g14194
```bash
#Lines containing FIND_OVERLAPPED_GENES errors were reomved.
grep -n -w -B 1 -A 15 'locus_tag    K3495_g3912' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome4.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/FIND_OVERLAPPED_GENES.txt
grep -n -w -B 1 -A 9 'locus_tag K3495_g14194' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome4.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/FIND_OVERLAPPED_GENES.txt
sed 's/-.*//' /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/FIND_OVERLAPPED_GENES.txt | sed 's/:.*//' | sed -e 's/$/d/' >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/FIND_OVERLAPPED_GENES2.txt 
sed -f /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/FIND_OVERLAPPED_GENES2.txt /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome4.tbl >> /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome5.tbl

#features removed from the .tbl file were alse removed from the .gff3 file
cat final_genes_appended_renamed4.gff3 | grep -w -v 'g3912' | grep -w -v 'g14194' >> final_genes_appended_renamed5.gff3

#none of these features were found in the swissprot output
grep -w -E "g3912|g14194" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
grep -w -E "g3912|g14194" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_tophit_parsed.tbl

#contig g3912 and g14194 features found in the interproscan output, these were removed from the gff3 file
grep -w -E "g3912|g14194" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.gff3 
grep -w -E "g3912|g14194" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv
grep -w -E "g3912|g14194" /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.xml
cat /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan2.gff3 | grep -w -v 'g3912' | grep -w -v 'g14194' >> /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan3.gff3
cat /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan2.tsv | grep -w -v 'g3912' | grep -w -v 'g14194' >> /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan3.tsv
#HOW TO REMOVE FROM xml file?

#features removed from the .tbl file were alse removed from the .cdna.fasta file
grep -n -w -A 1 '>g3912' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES.txt
grep -n -w -A 1 '>g14194' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES.txt
sed 's/-.*//' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES.txt | sed 's/:.*//' | sed -e 's/$/d/' >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES2.txt
sed -f gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES2.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.cdna.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed3.cdna.fasta

#features removed from the .tbl file were alse removed from the .pep.fasta file
grep -n -w -A 1 '>g3912' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES1.txt
grep -n -w -A 1 '>g14194' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES1.txt
sed 's/-.*//' gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES1.txt | sed 's/:.*//' | sed -e 's/$/d/' >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES12.txt
sed -f gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/FIND_OVERLAPPED_GENES12.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed2.pep.fasta >> gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed3.pep.fasta
```
2.) The .sqn file used the organism name P_aphanis. Please include the correct organism name Podosphaera aphanis. either in the fasta header or using the -j argument in table2asn. 
```bash
mkdir /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited3
cp /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited2/manualgenome5.tbl /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/gag/edited3/genome.tbl
conda activate tbl2asn
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    SbtFile=$(ls /scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1/template.sbt)
  OutDir=/scratch/projects/heavet/genome_submission/P_aphanis/THeavenDRCT72020_1
  FinalName=P_aphanis_DRCT72020_Heaven2022
  cp $Assembly $OutDir/gag/edited3/genome.fsa
  cp $SbtFile $OutDir/gag/edited3/genome.sbt
  mkdir $OutDir/tbl2asn/final3
  tbl2asn -p $OutDir/gag/edited3/. -t $OutDir/gag/edited3/genome.sbt -r $OutDir/tbl2asn/final3 -M n -X E -Z $OutDir/tbl2asn/final3/discrep.txt -j "[organism=Podosphaera aphanis] [strain=DRCT72020]" -l paired-ends -a r10k -w $OutDir/gag/edited/annotation_methods.strcmt.txt
done
conda deactivate
#     2 WARNING: SEQ_FEAT.NotSpliceConsensusDonor
#    64 WARNING: SEQ_FEAT.PartialProblem
#    86 WARNING: SEQ_FEAT.ShortExon
#     1 INFO:    SEQ_FEAT.PartialProblem
#   478 INFO:    SEQ_FEAT.RareSpliceConsensusDonor
```
3.) LONG_NO_ANNOTATION: 66 bioseqs are longer than 5000nt and have no features

We proceeded with resubmission to NCBI.







```bash
scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis

mv /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed22.fasta /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_2.c.fna
cat /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_2.c.fna | sed -e "s/>.*/&|kraken:taxid|79252/g" > /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_2.mod.fna
cp data/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_2.mod.fna assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/.

conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta); do
    ID=$(echo $Assembly| rev |cut -f2 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling $ID
done
#2542024, 18997
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta); do
    ID=$(echo $Assembly| rev |cut -f2 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI $ID
done
#2542021, 18998
conda deactivate

conda activate bedtools
RepMaskGff=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filteredmasked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits
printf "P_aphanis/THeavenDRCT72020_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#28,609,425
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#14,616
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#Differing number of GFF fields encountered at line: 96078.  Exiting...
conda deactivate bedtools
```






























































































# P.aphanis genome assembly and annotation pipeline - 2021 sample

Documentation of analysis and commands used with P.aphanis 2021 sample as part of Nano Diagnistics PhD.

Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /scratch/projects/heavet

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all

ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/THeavenDRCT72021_1_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/THeavenDRCT72021_1_r.fq.gz

ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_1_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_1_r.fq.gz

ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_HG7Y2DSX3_L3_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/THeavenDRCT72021_2_f.fq.gz
ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_HG7Y2DSX3_L3_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/THeavenDRCT72021_2_r.fq.gz

ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/THeavenDRCT72021_3_f.fq.gz
ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/THeavenDRCT72021_3_r.fq.gz

ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_HG7Y2DSX3_L3_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_2_f.fq.gz
ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_HG7Y2DSX3_L3_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_2_r.fq.gz

ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_3_f.fq.gz
ln -s /archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F002/X204SC22010737-Z01-F002/raw_data/THMLST21/THMLST21_ESFP220001653-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/1/all/THeavenDRCT72021_3_r.fq.gz
```
## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#16846
#16847
#18844-18849

cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/THeavenDRCT72021_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,410,266
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/THeavenDRCT72021_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,410,266
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/THeavenDRCT72021_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#117,044,389
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/THeavenDRCT72021_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#117,044,389
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/THeavenDRCT72021_3_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,410,266
cat rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/THeavenDRCT72021_3_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,410,266
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
for ReadDir in $(ls -d rawdata/P_aphanis/MiSeq/THeavenDRCT72021_1/*/*3);
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
#16848 - f'd
#17268
#18850
#18851
```
The data was visualised following trimming using FastQC.
```bash
for RawData in $(ls dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData .fq.gz)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#16864
#16865
#16866
#16867
#18852-18859

cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,316,705
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#65,934
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,316,705
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#22,715
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#114,797,904
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#1,500,329
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#114,797,904
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#593,967
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,316,705
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#65,934
4
#4,316,705
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#22,715
```

```bash
mkdir -p dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/all/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#18876
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the strawberry genome and our first P aphanis assembly from 2020.

```bash
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry
cd alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry
bowtie2-build /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta camarosa_index
bowtie2 \
-x camarosa_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_allvsunalignedstrawberry.sam \
--un-gz THeavenDRCT72021_allvsunalignedstrawberry_s.fq.gz \
--un-conc-gz THeavenDRCT72021_allvsunalignedstrawberry_fr.fq.gz \
-S THeavenDRCT72021_allvsunalignedstrawberry.sam 2>&1 | tee -a report2.txt
#10.82% overall alignment rate
conda deactivate
exit
exit

screen -S bowtie2
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
cd /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta paphanis_index
bowtie2 \
-x paphanis_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_allvsunalignedpaphanis.sam \
--un-gz THeavenDRCT72021_allvsunalignedpaphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72021_allvsunalignedpaphanis_fr.fq.gz \
-S THeavenDRCT72021_allvsalignedpaphanis.sam 2>&1 | tee -a report2.txt
#27.62% overall alignment rate
conda deactivate
exit
exit

#Initial low coverage sequencing run:
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry
cd alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry
bowtie2-build /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta camarosa_index
bowtie2 \
-x camarosa_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_1unalignedstrawberry.sam \
--un-gz THeavenDRCT72021_1unalignedstrawberry_s.fq.gz \
--un-conc-gz THeavenDRCT72021_1unalignedstrawberry_fr.fq.gz \
-S THeavenDRCT72021_1unalignedstrawberry.sam 2>&1 | tee -a report.txt
#11.05% overall alignment rate
conda deactivate
exit
exit

screen -S bowtie2
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
cd /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta paphanis_index
bowtie2 \
-x paphanis_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_1unalignedpaphanis.sam \
--un-gz THeavenDRCT72021_1unalignedpaphanis_s.fq.gz \
--un-conc-gz THeavenDRCT72021_1unalignedpaphanis_fr.fq.gz \
-S THeavenDRCT72021_1alignedpaphanis.sam 2>&1 | tee -a report.txt
#27.36%
conda deactivate
exit
exit
```
## Coverage
Coverage of data was estimated and the quality of sequencing data assessed using KAT comparison to our P.aphanis genome.
```bash
#trimmed reads vs the final assembly filtered for all but leotiomycetes
screen -S KAT3
srun -p himem --mem 1000G --pty bash
conda activate kat
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2021 '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/filtered_contigs/18996/contigs_min_500bp_filtered.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanisplot300_2021 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2021-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanisplot2000_2021 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2021-main.mx
conda deactivate
exit
exit
echo finished

#KAT of trimmed reads vs the previous p.aphanis assembly:
screen -S KAT
srun -p himem -J kat --mem 1000G --pty bash
conda activate kat
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2 '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanisplot300_2 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanisplot2000_2 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/allreads_v_paphanis_2-main.mx
conda deactivate
exit
exit
echo finished

#combined reads vs the P.cerasii genome from ncbi
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii/allreads_v_pcerasii '/home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz /home/theaven/projects/niab/theaven/qc_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.c.fna

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii/allreads_v_pcerasiiplot300 alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii/allreads_v_pcerasii-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii/allreads_v_pcerasiiplot2000 alignment/P_aphanis/THeavenDRCT72021_1/kat/pcerasii/allreads_v_pcerasii-main.mx
conda deactivate
exit
exit
echo finished

screen -S kat
srun -p long  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the camarosa genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/allreads_v_camarosa-21 '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/allreads_v_camarosa-21plot300_2021 alignment/P_aphanis/THeavenDRCT72021_1/kat/allreads_v_camarosa-21-main.mx
kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/allreads_v_camarosa-21plot1000 alignment/P_aphanis/THeavenDRCT72021_1/kat/allreads_v_camarosa-21-main.mx

conda deactivate
exit
exit
echo finished

screen -S KAT_2
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/kat/spades
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/spades/reads_v_spades '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/spades/reads_v_spadesplot300 alignment/P_aphanis/THeavenDRCT72021_1/kat/spades/reads_v_spades-main.mx
conda deactivate
exit
exit
echo finished

#Initial low coverage sequencing run:
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/reads_v_paphanis '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/reads_v_paphanisplot300 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/reads_v_paphanis-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/reads_v_paphanisplot2000 alignment/P_aphanis/THeavenDRCT72021_1/kat/paphanis/reads_v_paphanis-main.mx
conda deactivate
exit
exit
echo finished
```
## kraken2
```bash
screen -S kraken2_3
srun -p himem -J kraken2 --mem 250G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p dna_qc/P_aphanis/THeavenDRCT72021_1/kraken
gunzip -k dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/00*/*/*.fq.gz
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntoutput_#.txt \
--unclassified-out dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntunclassified_#.txt \
--classified-out dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntclassified_#.txt \
--report dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntreport_#.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq
# 
# 
rm dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/00*/*/*.fq
conda deactivate
exit
exit
echo finished
```

```bash
#Coverage of the sequence data was also estimated via alignmnet with our unpublished low P.aphanis assembly.
screen -S paphanis_coverage
srun -p long --mem 50G --pty bash
cd /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
samtools view --threads 8 -bS THeavenDRCT72021_allvsalignedpaphanis.sam -o THeavenDRCT72021_allvsalignedpaphanis.bam
samtools sort --threads 8 -o THeavenDRCT72021_allvsalignedpaphanis_sorted.bam THeavenDRCT72021_allvsalignedpaphanis.bam
samtools index -@ 8 THeavenDRCT72021_allvsalignedpaphanis_sorted.bam THeavenDRCT72021_allvsalignedpaphanis_sorted.bam.index
samtools coverage THeavenDRCT72021_allvsalignedpaphanis_sorted.bam -o coverage.txt
exit
exit
echo finished
#median depth 74.37, mean depth x367.07 12633/12702 contigs

#Initial low coverage sequencing run:
cd /projects/nano_diagnostics/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/paphanis
samtools view --threads 8 -bS THeavenDRCT72021_1alignedpaphanis.sam -o THeavenDRCT72021_1alignedpaphanis.bam
samtools sort --threads 8 -o THeavenDRCT72021_1alignedpaphanis_sorted.bam THeavenDRCT72021_1alignedpaphanis.bam
samtools index -@ 8 THeavenDRCT72021_1alignedpaphanis_sorted.bam THeavenDRCT72021_1alignedpaphanis_sorted.bam.index
samtools coverage THeavenDRCT72021_1alignedpaphanis_sorted.bam -o coverage.txt
#median depth 2.84, mean depth x12.64 12460/12702 contigs
```
Attempt kraken with reads
```bash
mkdir /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/THeavenDRCT72021_1/kraken
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntreport.txt \
--unclassified-out dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntunclassified.txt \
--classified-out dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntclassified.txt \
--report dna_qc/P_aphanis/THeavenDRCT72021_1/kraken/ntreport.txt \
--use-names \
krakentest/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq krakentest/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq
#  2376731 sequences classified (55.06%)
#  1939974 sequences unclassified (44.94%)
conda deactivate
exit
exit
echo finished

#Initial low coverage sequencing run:
mkdir krakentest
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz krakentest/.
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz krakentest/.
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz krakentest/.
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz krakentest/.
gunzip krakentest/*

screen -S kraken2
srun -p long -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir -p krakentest/out
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output krakentest/out/ntreport.txt \
--unclassified-out krakentest/out/ntunclassified#.txt \
--classified-out krakentest/out/ntclassified#.txt \
--report krakentest/out/ntreport.txt \
--use-names \
krakentest/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq krakentest/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq
#  2376731 sequences classified (55.06%)
#  1939974 sequences unclassified (44.94%)
conda deactivate
exit
exit
echo finished
mkdir /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/kraken
mv krakentest/out/* /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/kraken/.
rm -r krakentest
```
## Assembly
Trimmed reads that did not align to the apple genome were taken as raw data for assembly. Reads were renamed for input into SPAdes.
```bash
#files were renamed to correct extensions for spades
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_fr.fq.1.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_fr-f.fq.gz
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_fr.fq.2.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_fr-r.fq.gz
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_s.fq.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_allvsunalignedstrawberry_s-s.fq.gz

#Initial low coverage sequencing run:
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr.fq.1.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr-f.fq.gz
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr.fq.2.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr-r.fq.gz
mv alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_s.fq.gz alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_s-s.fq.gz

gunzip alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_fr-r.fq.gz
gunzip alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry/THeavenDRCT72021_1unalignedstrawberry_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss.
```bash
conda activate spades
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#18867
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18867/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18867/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18867/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18943
conda deactivate


  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#18868
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18868/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18868/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18868/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18944
conda deactivate


  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 30
  done
#18869
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18869/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18869/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18869/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18945
conda deactivate

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 40
  done
#18870
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18870/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18870/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18870/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18946
conda deactivate

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 50
  done
#18871
conda deactivate
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18871/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18871/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18871/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18947
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 60
  done
#18994
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19006
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 70
  done
#18995
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18995/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18995/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18995/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19009
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 80
  done
#18996
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18996/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18996/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18996/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19007
conda deactivate

#Initial low coverage sequencing run:
conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/strawberry); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/strawberry@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#17260
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/17260/scaffolds.fasta 500 > assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/17260/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/17260/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#17264
conda deactivate
```
```bash
screen -S kraken
srun -p long -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta
#     10328 sequences classified (94.17%)
#     639 sequences unclassified (5.83%)  
conda deactivate
exit
exit
echo finished

screen -S kraken
srun -p long -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18995/contigs_min_500bp.fasta
#    8288 sequences classified (94.43%)
#    489 sequences unclassified (5.57%)
conda deactivate
exit
exit
echo finished

screen -S kraken2
srun -p long -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18996/contigs_min_500bp.fasta
#     3670 sequences classified (88.88%)
#     459 sequences unclassified (11.12%)    
conda deactivate
exit
exit
echo finished

screen -S kraken
srun -p long -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18868/contigs_min_500bp.fasta
#    14769 sequences classified (83.35%)
#    2951 sequences unclassified (16.65%) 
conda deactivate
exit
exit
echo finished

screen -S kraken2
srun -p long -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18869/contigs_min_500bp.fasta
#    11125 sequences classified (89.79%)
#    1265 sequences unclassified (10.21%)
conda deactivate
exit
exit
echo finished

screen -S kraken3
srun -p himem -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18870/contigs_min_500bp.fasta
#    10466 sequences classified (93.93%)
#    676 sequences unclassified (6.07%)
conda deactivate
exit
exit
echo finished

screen -S kraken
srun -p himem -J kraken2 --mem 350G --pty bash
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/ntreport.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18871/contigs_min_500bp.fasta   
#  10614 sequences classified (92.84%)
#  819 sequences unclassified (7.16%)   
conda deactivate
exit
exit
echo finished

#Initial low coverage sequencing run:

screen -S kraken
srun -p long -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/1
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/1/ntoutput17260.txt \
--unclassified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/1/ntunclassified-out17260.txt \
--classified-out analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/1/ntclassified-out17260.txt \
--report analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/1/ntreport17260.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/17260/contigs_min_500bp.fasta
#  1176 sequences classified (91.66%)
#  107 sequences unclassified (8.34%)
conda deactivate
exit
exit
echo finished
```
```bash
touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/contaminantlist18868.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18868/contaminantlist18868.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/contaminantlist18869.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18869/contaminantlist18869.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/contaminantlist18870.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18870/contaminantlist18870.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/contaminantlist18870.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18871/contaminantlist18870.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/contaminantlist18994.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18994/contaminantlist18994.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/contaminantlist18995.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18995/contaminantlist18995.txt ##edited to include all taxonomic hits not leotiomycetes

touch analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/contaminantlist18996.txt
nano analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/18996/contaminantlist18996.txt ##edited to include all taxonomic hits not leotiomycetes

for assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/*99*/contigs_min_500bp.fasta); do
    ID=$(echo $assembly| rev |cut -f2 -d '/'| rev | cut -f1 -d '/'  )
    intermediate=$(echo $assembly | sed 's@SPAdes@SPAdes/filtered_contigs@g' | sed 's@contigs_min_500bp.fasta@filtered_contigs_min_500bp.fasta@g')
    output=$(echo $assembly | sed 's@SPAdes@SPAdes/filtered_contigs@g' | sed 's@contigs_min_500bp.fasta@contigs_min_500bp_filtered.fasta@g')
    OutDir=$(dirname $output)
    mkdir -p $OutDir
    conlist=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantlist*)
grep -f $conlist analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/ntoutput.txt > analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontigs.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontigs.txt > analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontignames.txt
conda activate seqtk
seqtk subseq $assembly analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontignames.txt > analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminants.fasta
conda deactivate
conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py $assembly analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontignames.txt > $intermediate
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' $intermediate > $output
wc -l $conlist # 
wc -l analysis/P_aphanis/THeavenDRCT72021_1/kraken2/nt/$ID/contaminantcontignames.txt #8268, 4002, 2806, 3118, 2769, 2197, 1897
wc -l $assembly #35440, 24780, 22284, 22866, 21934, 17554, 8258
wc -l $output #18904, 16776, 16672, 16630, 16396, 13160, 4464
done

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/filtered_contigs/*99*/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18954-59, 19011-13
conda deactivate



screen -S BUSCO3
srun -p himem -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(echo /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/filtered_contigs/18996); do
    Data=$(ls ${assembly}/contigs_min_500bp_filtered.fasta) 

    mkdir -p $assembly/BUSCO/fungi/1/filtered
    cd $assembly/BUSCO/fungi/1
    busco -f -m genome -i $Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $assembly/BUSCO/ascomycota/1/filtered
    cd $assembly/BUSCO/ascomycota/1
    busco -f -m genome -i $Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $assembly/BUSCO/leotiomycetes/1/filtered
    cd $assembly/BUSCO/leotiomycetes/1
    busco -f -m genome -i $Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done
conda deactivate
exit
exit
echo finished

#/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/filtered_contigs/18994/contigs_min_500bp_filtered.fasta selected as the best assembly - contains some duplication however higher cuttoffs than this start to be missing buscos
```
### blobtools
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_renamed2021.fasta 

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/contigs_min_500bp_2021.fasta

#alignment of reads to unfiltered assembly
screen -S bowtie
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021
cd alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta DRCT72021_0_index
bowtie2 \
-x DRCT72021_0_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_allvs_DRCT72021_0.sam \
--un-gz THeavenDRCT72021_allvs_DRCT72021_0_s.fq.gz \
--un-conc-gz THeavenDRCT72021_allvs_DRCT72021_0_fr.fq.gz \
-S THeavenDRCT72021_allvs_DRCT72021_0.sam 2>&1 | tee -a report_0.txt
conda deactivate
exit
exit
echo finished

#alignment of reads to final assembly
screen -S bowtie
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021
cd alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta DRCT72021_index
bowtie2 \
-x DRCT72021_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenDRCT72021_allvs_DRCT72021.sam \
--un-gz THeavenDRCT72021_allvs_DRCT72021_s.fq.gz \
--un-conc-gz THeavenDRCT72021_allvs_DRCT72021_fr.fq.gz \
-S THeavenDRCT72021_allvs_DRCT72021.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis/*2021.fasta); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.fasta@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2643208
#Submitted batch job 2643209

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021/THeavenDRCT72021_allvs_DRCT72021.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72021_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72021_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19192
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/contigs_min_500bp.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_aphanis/THeavenDRCT72021_1/bowtie2/DRCT72021/THeavenDRCT72021_allvs_DRCT72021_0.sam
OutDir=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72021_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_aphanis/THeavenDRCT72021_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19204
conda deactivate
```
## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI have assigned an assession number and finished processing the genome without reporting any fixes for this assembly or enabling the fix button to add gene prediction as requested. This is suspicious.

```bash
mkdir /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/NCBI_report_dir
touch /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/NCBI_report_dir/FCSreport.txt

conda activate biopython
for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/filtered_contigs/18994/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/NCBI_report_dir/FCSreport.txt) #As no report file has been provided a blank file was created
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python2.7 $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19181
conda deactivate
```

Identifying ITS regions:
```bash
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 

Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta
its1=$(dirname $Assembly)/its1.fasta
its4=$(dirname $Assembly)/its4.fasta
its14=$(dirname $Assembly)/its14.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' $Assembly >> $its1
grep -B 1 'CGCAGGTTCACCTACGGA' $Assembly >> $its1
grep -B 1 'TCCTCCGCTTATTGATATGC' $Assembly >> $its4
grep -B 1 'GCATATCAATAAGCGGAGGA' $Assembly >> $its4
grep -f $its1 $its4 >> $its14
rm $its1
rm $its4
#Three contigs return hits for both its1 and its4 primers; contig_2814, 1042 & 4299
#4299 - blasts to penicillium, aspergillus as well as one hit for blumeria graminis, appears to be the same as contig 2731 from the 2020 strawberry p.aphanis sample
#1042 - blasts to sporisorium, botrytis, articulospora, tetracladium etc.
#2814 - blasts to blumeria graminis, various podosphaera as well as other species, no P.aphanis blast hits
exit
exit
```
### Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f5 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling $ID
done
#19272
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f5 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI $ID
done
#19271
conda deactivate
```
```bash
RepMaskGff=assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
printf "P_aphanis/THeavenDRCT72021_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#23,735,158
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#7,811,725
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#25,154,001
```
The TransposonPSI asked bases were used to mask additional bases from the repeatmasker softmasked files.
```bash
for File in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 25,154,001
```
The total length of the genome given by quast is 54,152,750bp if 25,154,001bp have been masked as repetative then 46.45% of the genome is made up of repeats.

```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/.
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/.
```

## Gene prediction
RNAseq was performed on P. leucotricha to guide gene prediction. Gene prediction was performed using braker supplimented by additon predctions from codingquarry. Duplicated predictions were removed.

### RNA Alignment
STAR was used to align RNAseq data for P.leucotricha to our genome assembly.
```bash
mkdir -p alignment/P_aphanis/THeavenDRCT72021_1/star/RNA/18994
conda activate STAR
for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/ncbi_edits/contigs_min_500bp_renamed.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_aphanis/THeavenDRCT72021_1/star/RNA/18994
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
# 2739671
conda deactivate    
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence. BRAKER is a gene prediction pipeine using genomic and RNA-Seq data to automatically generate full gene structure annotations in novel genome. It combines two major tools: GeneMark-ES/ET and AUGUSTUS. These both use generalized hidden Markov model, a probabilistic model of a sequence and its gene structure.
```bash
conda activate braker
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_aphanis/THeavenDRCT72021_1/braker1.9
AcceptedHits=$(ls alignment/P_aphanis/THeavenDRCT72021_1/star/RNA/18994/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=18994_softmasked_TPSI_appended
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2741684
conda deactivate
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. Codingquarry also uses hidden Markov models for prediction.

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate stringtie

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72021_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_aphanis/THeavenDRCT72021_1/star/RNA/18994/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=~/scratch/apps/stringtie
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#2742055
conda deactivate
```
CodingQuarry was used to predict genes in regions of the genome not containing Braker gene models.
```bash
conda activate codingquary
#segmentation fault on crop diversity server therefore back over to niab hpc >:(

  for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling
    GTF=gene_pred/P_aphanis/THeavenDRCT72021_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#19294
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/ncbi_edits/filteredmasked/rep_modeling/2/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/19294/out/PredictedPass.gff3
AddDir=gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/additional
FinalDir=gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir
#Duplicate genes were removed and genes renamed

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
#Braker genes: 15230
#Coding quarry: 1077
#Combined: 16307
```
```bash
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/*/*/SPAdes/*/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
ID=$(echo $Assembly | rev |cut -f8,9 -d '/'| rev )
GffAppended=gene_pred/$ID/codingquarry/rep_modeling/final/final_genes_appended.gff3
FinalDir=gene_pred/$ID/codingquarry/rep_modeling/final
echo $ID

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
rm $GffFiltered

#Create renamed fasta files from each gene feature 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>'
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
done
```