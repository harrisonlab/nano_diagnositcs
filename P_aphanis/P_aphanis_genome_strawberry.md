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
### Coverage
### KAT
KAT was used to re-estimate the coverage of our raw reads vs our draft assemblies.
```bash
screen -S kat
srun -p himem  --mem 750G --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/THeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 1000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21plot1000 alignment/P_aphanis/THeavenDRCT72020_1/kat/allTHeavenDRCT72020_1_v_spades-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/001/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/002/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-002_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/003/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-003_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/F/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/004/R/P_aphanis-MiSeq-THeavenDRCT72020_1-paired-004_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/comballTHeavenDRCT72020_1_v_spades-21-main.mx

#The cockerton reads were compared to the spades assembly and the results plotted: 
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/F/P_aphanis-MiSeq-H_Cockerton2018-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/H_Cockerton2018/paired/001/R/P_aphanis-MiSeq-H_Cockerton2018-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/725715/filtered_contigs/contigs_min_500bp.fasta 

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21plot2000 alignment/P_aphanis/THeavenDRCT72020_1/kat/cockerton_v_spades-21-main.mx

#The camarosa genome was compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21 'rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta' assembly/metagenome/P_aphanis/*/SPAdes/615827/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21plot300 alignment/P_aphanis/THeavenDRCT72020_1/kat/camarosa_v_spades-21-main.mx
```
### Bowtie
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
#66.10% overall alignment rate

samtools view --threads 8 -bS THeavenDRCT72020_1alignedHeaven_P_aphanis75.sam -o THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam THeavenDRCT72020_1alignedHeaven_P_aphanis75.bam
samtools index -@ 8 THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam.index
samtools coverage THeavenDRCT72020_1alignedHeaven_P_aphanis_sorted75.bam -o coverage75.txt
#median depth = 432, mean depth = 1033
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

## Gene prediction

### Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/filteredmasked
	mkdir -p $OutDir/rep_modeling
	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
done
#784844
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/filteredmasked
	mkdir -p $OutDir/transposonPSI
	sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI
done
#780369
conda deactivate
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands:
```bash
RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/filteredmasked/transposonPSI/heavet_contigs_unmasked.fa.TPSI.allHits
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
```
The total length of the genome given by quast is 56,244,531bp if 28,609,425bp have been masked as repetative then 50.87% of the genome is made up of repeats.

The TransposonPSI asked bases were used to mask additional bases from the repearmasker softmasked files.
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
#Number of masked bases: 29,988,800
```
The total length of the genome given by quast is 56,244,531bp if 29,988,800bp have been masked as repetative then 53.32% of the genome is made up of repeats.

### RNA Alignment

# ERROR

Trimmed RNASeq reads that did not align to the camarosa genome can be found here:
```bash
ls dna_qc/P_aphanis/RNAexp1/infected/F/*trim.fa
ls dna_qc/P_aphanis/RNAexp1/infected/R/*trim.fa
```
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
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence.
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
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. 

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
Duplicate genes were removed and genes renamed
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
## Genome annotation

### Interproscan
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
### Genome submission
Submisison of annotations with an assembly appears to be a complex process. If a genome is to be submitted without annotation then all that is needed is the fasta file containing the assembled contigs. If an annotated genome is to be submitted then a number of processing steps are required before submission. The fasta file of contigs and the gff file of annotations must be combined to form a .asn file. The program that does this conversion (tbl2asn) requires the fasta files and gff files to be formatted correctly. In the case of the gff file, this means parsing it to a .tbl file.

### Generating .tbl file (GAG)

The Genome Annotation Generator (GAG.py) can be used to convert gff files into .tbl format, for use by tbl2asn.

It can also add annotations to features as provided by Annie the Annotation extractor.

#### Annie

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
#### GAG
Gag was run using the modified gff file as well as the annie annotation file. Gag was noted to output database references incorrectly, so these were modified.
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

/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_tophit_parsed.tbl #swissprot records found in output
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/787033/NRI/P.aphanis_interproscan.tsv #interproscan - there are pfam and go annotations inn the output
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/out/PredictedPass.gff3 #codingquarry
/projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/braker/725715_softmasked_TPSI_appended/augustus.gff3 #braker records found in output

grep -o 'gene' $OutDir/gag_log1.txt
```
### Error correction
#### tbl2asn

A template was created at https://submit.ncbi.nlm.nih.gov/genbank/template/submission/ and downloaded

tbl2asn round 1
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
#### ncbi tbl corrector
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
#### Final run of tbl2asn
Following correction of the GAG .tbl file, tbl2asn was re-run to provide the final genbank submission file.

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
```












































### Signal-P
```bash
conda activate Java11

  for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do
  ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
  SplitDir=$(dirname $Proteome | sed 's/final/final_genes_split/g')
  mkdir -p $SplitDir
  $ProgDir/splitfile_500.py --inp_fasta $Proteome --out_dir $SplitDir --out_base P_aphanis_THeavenDRCT72020_1_final_preds # Splits input fasta in 500 genes files
  done
  for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/*_final_preds_*); do
  InName=$(echo $File | rev | cut -d "/" -f1 | rev)
  echo $InName
  OutFile=$(echo $InName | sed s/.fa//)
  echo $OutFile
  signalp-4.1 -t euk -f summary -c 70 $File > "$OutFile"_sp.txt
  echo '----------------------------------------------------------------------' >> "$OutFile"_sp.txt
  done
  mv P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/.


  for OutFile in $(ls P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt); do
  /home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation/sigP_4.1_parser.py --inp_fasta gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta --inp_sigP "$OutFile"_sp.txt --out_tab "$OutFile"_sp.tab --out_fasta "$OutFile"_sp.aa --out_neg "$OutFile"_sp_neg.aa
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-4.1 # Recommended for fungi
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-5.0
  done
#788728-788763

OutDir=$(dirname $Proteome | sed 's/codingquarry/signalp/g'| sed 's/final/split/g')

Change output directory name to "final_genes_signalp-4.1" mv gene_pred/F.oxysporum_fsp_fragariae_signalp-4.1 gene_pred/final_genes_signalp-4.1

Need to combine the output of the first signal-P run

for Strain in DSA14_003; do for SplitDir in $(ls -d gene_pred/final_genes_split/F.oxysporum_fsp_fragariae/$Strain/flye); do Strain=$(echo $SplitDir | rev |cut -d '/' -f2 | rev) Organism=$(echo $SplitDir | rev |cut -d '/' -f3 | rev) InStringAA='' InStringNeg='' InStringTab='' InStringTxt='' SigpDir=final_genes_signalp-4.1 for GRP in $(ls -l $SplitDir/final_preds.fa | rev | cut -d '' -f1 | rev | sort -n); do InStringAA="$InStringAA gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp.aa"; InStringNeg="$InStringNeg gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp_neg.aa"; InStringTab="$InStringTab gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp.tab"; InStringTxt="$InStringTxt gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""_sp.txt"; done cat $InStringAA > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.aa cat $InStringNeg > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_neg_sp.aa tail -n +2 -q $InStringTab > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.tab cat $InStringTxt > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.txt done done

Having flye in directory path caused small issues therefore I stopped including it from here Things may be in the wrong directory - use "mv" command to change directory names


  signalp-4.1 -t euk -f summary -c 70 $File > "$OutFile"_sp.txt
  echo '----------------------------------------------------------------------' >> "$OutFile"_sp.txt
  PathToAnnotateSigP=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
  $PathToAnnotateSigP/sigP_4.1_parser.py --inp_sigP "$OutFile"_sp.txt --out_tab "$OutFile"_sp.tab --out_fasta "$OutFile"_sp.aa --out_neg "$OutFile"_sp_neg.aa -$

```

### TMHMM
Identify transmembrane proteins
```bash
for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do 
	ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
	OutDir=$(dirname $Proteome | sed 's/codingquarry/TMHMM/g')
	sbatch $ProgDir/TMHMM.sh $Proteome $OutDir
done 
#788768

Proteins with transmembrane domains were removed from lists of Signal peptide containing proteins

for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/TMHMM/rep_modeling/787033/final/TM_genes_neg.txt); do
TmHeaders=$(echo "$File" | sed 's/neg.txt/neg_headers.txt/g')
cat $File | cut -f1 > $TmHeaders
SigP=$(ls gene_pred/final_genes_signalp-4.1/$Organism/$Strain/*_final_sp.aa)
OutDir=$(dirname $SigP)
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
$ProgDir/extract_from_fasta.py --fasta $SigP --headers $TmHeaders > $OutDir/"$Strain"_final_sp_no_trans_mem.aa
cat $OutDir/"$Strain"_final_sp_no_trans_mem.aa | grep '>' | wc -l
done
```

















### Effector-P
```bash
mkdir -p gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P
srun -p short  --mem 100G --pty bash
EffectorP.py -o gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.txt -E gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.fa -i gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta

for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.txt); do
  Headers=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_headers.txt/g')
  cat $File | grep 'Effector' | cut -f1 > $Headers
  Secretome=$(ls gene_pred/final_genes_signalp-4.1/F.oxysporum_fsp_fragariae/DSA14_003/DSA14_003_final_sp_no_trans_mem.aa)
  OutFile=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted.aa/g')
  ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
  $ProgDir/extract_from_fasta.py --fasta $Secretome --headers $Headers > $OutFile
  OutFileHeaders=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted_headers.txt/g')
  cat $OutFile | grep '>' | tr -d '>' > $OutFileHeaders
  cat $OutFileHeaders | wc -l
  Gff=$(ls gene_pred/codingquary/F.oxysporum_fsp_fragariae/DSA14_003/flye/final/final_genes_appended_renamed.gff3)
  EffectorP_Gff=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted.gff/g')
  $ProgDir/extract_gff_for_sigP_hits.pl $OutFileHeaders $Gff effectorP ID > $EffectorP_Gff
  cat $EffectorP_Gff | grep -w 'gene' | wc -l
done > tmp.txt
```






















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
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/camarosa); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*cockertoncamarosa_fr-f.fq)
    R_Read=$(ls $ReadDir/*cockertoncamarosa_fr-r.fq)
    S_Read=$(ls $ReadDir/*cockertoncamarosa_s-s.fq)
    OutDir=/scratch/projects/heavet/test
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#5865

for QCData in $(ls dna_qc/P_aphanis/MiSeq/*/*/*/*/*.fq.gz); do
echo $QCData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=/scratch/projects/heavet/test
echo $OutDir
Outfile=$(basename -a $QCData)_fastqc
echo $Outfile
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#5866-5893






gag, ani TSI vnn
















```bash
For genome coverage, I would map reads back to the contigs, then use samtools depth to get the coverage counts - you can divide by the total length of all your contigs to get the mean coverage.  To determine duplicates, use picard-tools 's MapDuplicates on the aligned bam, followed by samtools flagstat to get numbers. 
```
```bash
STAR was used to align RNAseq data for P.aphanis to our genome assembly.
```bash
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715
for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
    Freads=$RNAdata/*.F.fa
    Rreads=$RNAdata/*.R.fa
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta
    ProgDir=~/git_repos/tools/seq_tools/RNAseq
    OutDir=alignment/P_aphanis/THeavenDRCT72020_1/star/RNA/725715
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#785289
``` 
```