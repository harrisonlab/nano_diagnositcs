# P.leucotricha genome assembly and annotation pipeline

Documentation of analysis and commands used with P.leucotricha as part of Nano Diagnistics PhD.

## Collecting data

All following commands were exectuted from the folder:
```bash
/projects/nano_diagnostics
```
Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/F/p11_1_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/R/p11_1_r.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_r.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/F/p11_2_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/R/p11_2_r.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all/p11_2_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all/p11_2_r.fq.gz
```
The golden delicious apple genome was linked from an existing download location within the cluster. Originally downloaded from https://iris.angers.inra.fr/gddh13/the-apple-genome-downloads.html
```bash
mkdir -p assembly/genome/NCBI/rosales

ln -s /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
```
The phiX genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/phix
cd assembly/genome/NCBI/phix
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/enterobacteria_phage_phix174_sensu_lato_uid14015/NC_001422.fna

```
The human genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/primate/H.sapiens
cd assembly/genome/NCBI/primate/H.sapiens
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GCA_000001405.15_GRCh38_genomic.fna.gz
gunzip GCA_000001405.15_GRCh38_genomic.fna.gz
```
The existing Podosphaera leucotricha was downloaded.
```bash
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales
wget -P P_leocotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip P_leocotricha/JAATOF01.1.fsa_nt.gz
cd /projects/nano_diagnostics

samtools faidx assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 

```

## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_leucotricha/*/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done

#The number of raw reads were counted:

cat rawdata/P_leucotricha/THeavenp11_1/paired/001/F/p11_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#20,886,394
cat rawdata/P_leucotricha/THeavenp11_1/paired/001/R/p11_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#20,886,394
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/F/p11_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/R/p11_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. 
```bash
for ReadDir in $(ls -d rawdata/P_leucotricha/*/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done

#The number of trimmed reads were counted:
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#19,638,648
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#966.121
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#19,638,648
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#188,865

zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz | echo $((`wc -l`/4))
#37,269,400
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,867,698
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz | echo $((`wc -l`/4))
#37,269,400
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#375,713
```
The data was visualised following trimming.
```bash
for RawData in $(ls dna_qc/P_leucotricha/*/*/002/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available apple apple and apple powdey mildew genomes downloaded from NCBI.

The following were performed with the first round of sequencing data.
```bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.64% overall alignment rate.
bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple.sam \
-S THeavenp11_1alignedapple.sam
#20793634 reads; of these:
#  19638648 (94.45%) were paired; of these:
#    17103073 (87.09%) aligned concordantly 0 times
#    1219963 (6.21%) aligned concordantly exactly 1 time
#    1315612 (6.70%) aligned concordantly >1 times
#    ----
#    17103073 pairs aligned concordantly 0 times; of these:
#      17915 (0.10%) aligned discordantly 1 time
#    ----
#    17085158 pairs aligned 0 times concordantly or discordantly; of these:
#      34170316 mates make up the pairs; of these:
#        33816721 (98.97%) aligned 0 times
#        155389 (0.45%) aligned exactly 1 time
#        198206 (0.58%) aligned >1 times
#  1154986 (5.55%) were unpaired; of these:
#    1100724 (95.30%) aligned 0 times
#    19749 (1.71%) aligned exactly 1 time
#    34513 (2.99%) aligned >1 times
#13.64% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the apple genome, this produced a 13.9% overall alignment rate.
screen -r #17810.rnaquast
bowtie2 -x apple_index -1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz -2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz -S THeavenp11_1alignedapplepairedonly.sam
#19638648 reads; of these:                                                     19638648 (100.00%) were paired; of these:                                                 17103073 (87.09%) aligned concordantly 0 times
#    1219963 (6.21%) aligned concordantly exactly 1 time
#    1315612 (6.70%) aligned concordantly >1 times
#    ----
#    17103073 pairs aligned concordantly 0 times; of these:
#      17915 (0.10%) aligned discordantly 1 time
#    ----
#    17085158 pairs aligned 0 times concordantly or discordantly; of these:
#      34170316 mates make up the pairs; of these:
#        33816721 (98.97%) aligned 0 times
#        155389 (0.45%) aligned exactly 1 time
#        198206 (0.58%) aligned >1 times
#13.90% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the apple genome using a wrapper script, this produced a 13.05% overall alignment rate.
for ReadDir in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/*/*);
do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
echo $Fread
echo $Rread
Assembly=assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
OutDir=alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/batch
ProgDir=~/git_repos/tools/seq_tools/genome_alignment/bowtie
sbatch $ProgDir/sub_bowtie_unaligned.sh $Assembly $Fread $Rread $OutDir
done
#19638648 reads; of these:
#  19638648 (100.00%) were paired; of these:
#    17077860 (86.96%) aligned concordantly 0 times
#    1226824 (6.25%) aligned concordantly exactly 1 time
#    1333964 (6.79%) aligned concordantly >1 times
#    ----
#    17077860 pairs aligned concordantly 0 times; of these:
#      1302 (0.01%) aligned discordantly 1 time
#13.05% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.18% overall alignment rate.
cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa applemildew_index
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha.sam \
-S THeavenp11_1alignedGananPleucotricha.sam
#20793634 reads; of these:
#  19638648 (94.45%) were paired; of these:
#    8775394 (44.68%) aligned concordantly 0 times
#    9994860 (50.89%) aligned concordantly exactly 1 time
#    868394 (4.42%) aligned concordantly >1 times
#    ----
#    8775394 pairs aligned concordantly 0 times; of these:
#      450264 (5.13%) aligned discordantly 1 time
#    ----
#    8325130 pairs aligned 0 times concordantly or discordantly; of these:
#      16650260 mates make up the pairs; of these:
#        14070451 (84.51%) aligned 0 times
#        1732933 (10.41%) aligned exactly 1 time
#        846876 (5.09%) aligned >1 times
#  1154986 (5.55%) were unpaired; of these:
#    414137 (35.86%) aligned 0 times
#    691531 (59.87%) aligned exactly 1 time
#    49318 (4.27%) aligned >1 times
#64.18% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the mildew genome using a wrapper script, this produced a 55.85% overall alignment rate.
for ReadDir in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/*/*);
do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
echo $Fread
echo $Rread
Assembly=assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa
OutDir=alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch
ProgDir=~/git_repos/tools/seq_tools/genome_alignment/bowtie
sbatch $ProgDir/sub_bowtie_unaligned.sh $Assembly $Fread $Rread $OutDir
done
#19638648 reads; of these:
#  19638648 (100.00%) were paired; of these:
#    8685128 (44.22%) aligned concordantly 0 times
#    10074700 (51.30%) aligned concordantly exactly 1 time
#    878820 (4.47%) aligned concordantly >1 times
#    ----
#    8685128 pairs aligned concordantly 0 times; of these:
#      15257 (0.18%) aligned discordantly 1 time
#55.85% overall alignment rate
```
Alignments were also made with the second round of sequence data.
```bash
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.68% overall alignment rate.
bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple2.sam \
-S THeavenp11_1alignedapple2.sam
#39512811 reads; of these:
#  37269400 (94.32%) were paired; of these:
#    32441138 (87.04%) aligned concordantly 0 times
#    2323774 (6.24%) aligned concordantly exactly 1 time
#    2504488 (6.72%) aligned concordantly >1 times
#    ----
#    32441138 pairs aligned concordantly 0 times; of these:
#      34816 (0.11%) aligned discordantly 1 time
#    ----
#    32406322 pairs aligned 0 times concordantly or discordantly; of these:
#      64812644 mates make up the pairs; of these:
#        64135816 (98.96%) aligned 0 times
#        298878 (0.46%) aligned exactly 1 time
#        377950 (0.58%) aligned >1 times
#  2243411 (5.68%) were unpaired; of these:
#    2140666 (95.42%) aligned 0 times
#    37460 (1.67%) aligned exactly 1 time
#    65285 (2.91%) aligned >1 times
#13.68% overall alignment rate


#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.14% overall alignment rate.
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha2.sam \
-S THeavenp11_1alignedGananPleucotricha2.sam
#39512811 reads; of these:
#  37269400 (94.32%) were paired; of these:
#    16686730 (44.77%) aligned concordantly 0 times
#    18936527 (50.81%) aligned concordantly exactly 1 time
#    1646143 (4.42%) aligned concordantly >1 times
#    ----
#    16686730 pairs aligned concordantly 0 times; of these:
#      863106 (5.17%) aligned discordantly 1 time
#    ----
#    15823624 pairs aligned 0 times concordantly or discordantly; of these:
#      31647248 mates make up the pairs; of these:
#        26733740 (84.47%) aligned 0 times
#        3286517 (10.38%) aligned exactly 1 time
#        1626991 (5.14%) aligned >1 times
#  2243411 (5.68%) were unpaired; of these:
#    798299 (35.58%) aligned 0 times
#    1350241 (60.19%) aligned exactly 1 time
#    94871 (4.23%) aligned >1 times
#64.14% overall alignment rate

```
Alignments were then made using the combined first and second rounds of sequencing data.
```bash
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.67% overall alignment rate.
bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple1+2.sam \
-S THeavenp11_1alignedapple1+2.sam
#60306445 reads; of these:
# 56908048 (94.36%) were paired; of these:
#    49544211 (87.06%) aligned concordantly 0 times
#    3543737 (6.23%) aligned concordantly exactly 1 time
#    3820100 (6.71%) aligned concordantly >1 times
#    ----
#    49544211 pairs aligned concordantly 0 times; of these:
#      52731 (0.11%) aligned discordantly 1 time
#    ----
#    49491480 pairs aligned 0 times concordantly or discordantly; of these:
#      98982960 mates make up the pairs; of these:
#        97952537 (98.96%) aligned 0 times
#        454267 (0.46%) aligned exactly 1 time
#        576156 (0.58%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3241390 (95.38%) aligned 0 times
#    57209 (1.68%) aligned exactly 1 time
#    99798 (2.94%) aligned >1 times
#13.67% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.18% overall alignment rate.
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha1+2.sam \
-S THeavenp11_1alignedGananPleucotricha1+2.sam
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    25462124 (44.74%) aligned concordantly 0 times
#    28931387 (50.84%) aligned concordantly exactly 1 time
#    2514537 (4.42%) aligned concordantly >1 times
#    ----
#    25462124 pairs aligned concordantly 0 times; of these:
#      1313370 (5.16%) aligned discordantly 1 time
#    ----
#    24148754 pairs aligned 0 times concordantly or discordantly; of these:
#      48297508 mates make up the pairs; of these:
#        40804191 (84.49%) aligned 0 times
#        5019450 (10.39%) aligned exactly 1 time
#        2473867 (5.12%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    1212436 (35.68%) aligned 0 times
#    2041772 (60.08%) aligned exactly 1 time
#    144189 (4.24%) aligned >1 times
#64.15% overall alignment rate
```
###Coverage
```bash
#Coverage with the first round of sequencing data was estimated.
samtools index -b alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch/JAATOF01.1.fa_aligned_sorted.bam 
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch
samtools coverage JAATOF01.1.fa_aligned_sorted.bam -o coverage.txt
#NOTE: to get samtools coverage to work run not in a screen and outside the samtools conda environment

#Coverage of the second round of sequencing data was estimated.
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenp11_1alignedGananPleucotricha2.sam -o THeavenp11_1alignedGananPleucotricha2.bam
samtools sort --threads 8 -o THeavenp11_1alignedGananPleucotricha2_sorted.bam THeavenp11_1alignedGananPleucotricha2.bam
samtools index -@ 8 THeavenp11_1alignedGananPleucotricha2_sorted.bam THeavenp11_1alignedGananPleucotricha2_sorted.bam.index
samtools coverage THeavenp11_1alignedGananPleucotricha2_sorted.bam -o coverage2.txt

#Coverage of the combined data was estimated.
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenp11_1alignedGananPleucotricha1+2.sam -o THeavenp11_1alignedGananPleucotricha1+2.bam
samtools sort --threads 8 -o THeavenp11_1alignedGananPleucotricha1+2_sorted.bam THeavenp11_1alignedGananPleucotricha1+2.bam
samtools index -@ 8 THeavenp11_1alignedGananPleucotricha1+2_sorted.bam THeavenp11_1alignedGananPleucotricha1+2_sorted.bam.index
samtools coverage THeavenp11_1alignedGananPleucotricha1+2_sorted.bam -o coverage1+2.txt
```
###Kmer analysis toolkit
The quality of the first round of sequencing data was assessed using KAT.
```bash
#Sequencing reads were compared with the available apple powdery mildew genome, results were plotted with various settings
srun -p himem --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 100 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot100 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx

kat plot spectra-cn -x 1100 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot1100 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx

kat plot spectra-cn -u -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot2000u alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx

kat plot spectra-cn -m 10000 -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot9000 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx

#Sequencing reads were compared with the available apple genome, results were plotted with various settings
mkdir -p alignment/P_leucotricha/THeavenp11_1/kat/apple
kat comp -m 21 -v -H 800000000 -I 800000000 -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz' assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -x 100 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx

kat plot spectra-cn -x 1100 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot1100 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx

kat plot spectra-cn -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot2000 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx
```
The quality of the combined sequencing data was later assessed using KAT.
```bash
screen -r
srun -p himem --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Combined reads were compared to the available mildew genome and results plotted:
kat comp -m 15 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2 '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2plot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2-main.mx

#Combined reads were compared to the available apple genome and results plotted:
kat comp -m 15 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2 '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
#kmers reduced to 10 still exceeds memory

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2plot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-main.mx
```

#from here work in progress





































## Assembly
Trimmed read that did not align to the apple genome were taken as raw data for assembly.

```bash
#unaligned reads were converted to sorted .bam format
samtools view --threads 8 -bS alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2.sam -o alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2.bam

#get all unpaired reads
samtools view --threads 8 -F 1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2.bam > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2s.bam

#get all paired reads
samtools view --threads 8 -f 1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2.bam > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.bam

#paired reads separated into forward and reverse reads
samtools view -F 0x10  -h alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.bam | samtools view -bS - > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2f.bam

samtools view -f 0x10  -h alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.bam | samtools view -bS - > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2r.bam

#these files were sorted
samtools sort -n --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2f.bam -o alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.bam

samtools sort -n --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2r.bam -o alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.bam

samtools sort -n --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2s.bam -o alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.bam

#these files were converted to  fastq format
samtools fastq --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.bam > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq.gz

samtools fastq --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.bam > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq.gz

samtools fastq --threads 8 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.bam > alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq.gz
```
###SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes:
```bash
conda activate spades
#spades assembly was performed --meta flag for metagenome data was not selected
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $StrainPath/*-f.fq.gz)
    R_Read=$(ls $StrainPath/*-r.fq.gz)
    S_Read=$(ls $StrainPath/*-s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
```

















### ATLAS
A bioconda installation of ATLAS was performed

```bash
cd /projects/nano_diagnostics
mkdir -p assembly/genome/P_leucotricha/THeavenp11_1/ATLAS

atlas init -w assembly/genome/P_leucotricha/THeavenp11_1/ATLAS --db-dir assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/test_reads
# bins corrected
nano assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/samples.tsv
# contaminant genomes to be removed added to database directory
#phiX
ln -s /projects/nano_diagnostics/assembly/genome/NCBI/phix/NC_001422.fa assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/NC_001422.fa
#Human
ln -s /projects/nano_diagnostics/assembly/genome/NCBI/primate/H.sapiens/GCA_000001405.15_GRCh38_genomic.fa assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/GCA_000001405.15_GRCh38_genomic.fa
#Apple
ln -s /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/GDDH13_1-1_formatted.fasta
# config file edited to remove contaminants
nano assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml

cookiecutter --output-dir ~/.config/snakemake https://github.com/metagenome-atlas/clusterprofile.git
#profile_name [cluster]: cluster
#cluster_system [slurm]: slurm

nano ~/.config/snakemake/cluster/cluster_config.yaml
#left unaltered

screen -r
conda activate ATLAS
atlas run all -w assembly/genome/P_leucotricha/THeavenp11_1/ATLAS -c assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml --profile cluster
#Finished job 108.
#1 of 146 steps (0.68%) done
#Error submitting jobscript (exit code 1):



config=assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml
workdir=assembly/genome/P_leucotricha/THeavenp11_1/ATLAS
ProgDir=~/git_repos/tools/seq_tools/assemblers
sbatch $ProgDir/sub_atlas.sh $config $workdir
#569879
```






###BBAP
###Genovo
###IDBA-UD
###IVA
###MAP
###MegaGTA
###MEGAHIT
###MetaVelvet
###MetaVelvet-SL
###Omega
###PRICE
###Ray Meta
###SAVAGE
###Snowball

###MEGAHIT
###metaSPAdes
###VICUNA
###Xander
###BBAP
###Genovo
###IDBA-UD
###IVA
###MAP
###MegaGTA
###MetaVelvet
###MetaVelvet-SL
###Omega
###PRICE
###Ray Meta
###SAVAGE
###Snowball