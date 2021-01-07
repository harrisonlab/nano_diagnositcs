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
The yeast reference genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/S.cerevisiae
cd assembly/genome/NCBI/S.cerevisiae
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.fna.gz
gunzip GCF_000146045.2_R64_genomic.fna.gz
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
--un-gz THeavenp11_1unalignedapple1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedapple1+2fr.fq.gz \
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
### Coverage
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
### Kmer analysis toolkit
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

screen -r
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the available apple genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21 '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21plot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21-main.mx
```

# from here work in progress





































## Assembly
Trimmed read that did not align to the apple genome were taken as raw data for assembly.

```bash
#files were renamed to correct extensions for spades
mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.fq.1.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq.gz

mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.fq.2.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq.gz

mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2s.fq.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq.gz
#files needed to be unzipped for use with megahit
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq.gz
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq.gz
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades
# himem, --careful flag used for mismatch correction, max memory 250gb, max threads 20
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
# Submitted batch job 580029  -250gb long
# Completed with warnings - (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 3

# himem, max memory 250gb, --isolate flag (recommended for high >100 coverage data), --careful therefore unavailable
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
# Submitted batch job 580030  -250gb long
# Completed with warnings - (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 3

```
A conda installation of quast was performed.

Quast was used to assess the quality of genome assemblys:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
```
### metaSPAdes
metaSPAdes is included in the SPAdes toolkit. metaSPAdes supports only a single short read-read library which has to be paired-end. Mismatch correction is not available and coverage cuttoff cannot be specified.

Trimmed paired MiSeq reads were assembled using the program metaSPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades
# max memory 58gb, max threads 20
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@metaSPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $OutDir
    sbatch $ProgDir/submit_metaSPAdes.sh $F_Read $R_Read $OutDir 
  done
# Submitted batch job 578642 -58gb long anything higher will not run
# Completed
```
Quast was used to assess the quality of genome assembly:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/metaSPAdes/*/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
```

Deconseq 



### MEGAHIT
A conda installation of megahit was performed

Trimmed paired MiSeq reads were assembled using the program megahit, contigs <500bp filtered out with --min-contig-len flag
```bash
conda activate megahit
# max memory 30,000,000,000 bytes, max threads 20, klist specified the same as with spades: 21,33,55,77,99,127
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@megahit@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_megahit.sh $F_Read $R_Read $S_Read $OutDir 
  done
# Submitted batch job 578644 -58gb long
# no output
# Submitted batch job 580031  -250gb long
# no output

mkdir assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/1
megahit -1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq -2 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq -o assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/2

megahit --verbose --k-list 21,33,55,77,99,127 --min-contig-len 500 -1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq -2 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq -r alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq -o assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/4

```
### Coverage
```bash
#An alignment of trimmed reads including unpaired reads was made to the assembled genome, this produced a ######% overall alignment rate.
screen -S kat
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_leucotricha
cd alignment/P_aphanis/THeavenDRCT72020_1/bowtie2/Heaven_P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/metaSPAdes/*/filtered_contigs/contigs_min_500bp.fasta Heaven_P_leucotricha_index
bowtie2 \
-x Heaven_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenDRCT72020_1unalignedHeaven_P_leucotricha.sam \
--un-gz THeavenDRCT72020_1unalignedHeaven_P_leucotricha_s.fq.gz \
--un-conc-gz THeavenDRCT72020_1unalignedHeaven_P_leucotricha_fr.fq.gz \
-S THeavenDRCT72020_1alignedHeaven_P_leucotricha.sam
echo finished

#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    12699983 (22.32%) aligned concordantly 0 times
#    37238409 (65.44%) aligned concordantly exactly 1 time
#    6969656 (12.25%) aligned concordantly >1 times
#    ----
#    12699983 pairs aligned concordantly 0 times; of these:
#      1126918 (8.87%) aligned discordantly 1 time
#    ----
#    11573065 pairs aligned 0 times concordantly or discordantly; of these:
#      23146130 mates make up the pairs; of these:
#        17418276 (75.25%) aligned 0 times
#        3450880 (14.91%) aligned exactly 1 time
#        2276974 (9.84%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    472044 (13.89%) aligned 0 times
#    2592309 (76.28%) aligned exactly 1 time
#    334044 (9.83%) aligned >1 times


samtools view --threads 8 -bS THeavenDRCT72020_1alignedHeaven_P_leucotricha.sam -o THeavenDRCT72020_1alignedHeaven_P_leucotricha.bam
samtools sort --threads 8 -o THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam THeavenDRCT72020_1alignedHeaven_P_leucotricha.bam
samtools index -@ 8 THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam.index
samtools coverage THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam -o coverage.txt

#Mean depth per contig: 42.42
#Median depth per contig: 3.22

samtools depth THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam -o depth.txt

#IN PROGRESS

#A conda installation of picard was performed
conda activate Picard
java -jar picard.jar MarkDuplicates \
      I=THeavenDRCT72020_1alignedHeaven_P_leucotricha_sorted.bam \
      O=marked_duplicates.bam \
      M=marked_dup_metrics.txt
#Error: Unable to access jarfile picard.jar
```
```bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/metaSPAdes/*/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics
done

#metaspades:
	--------------------------------------------------
	|Results from dataset fungi_odb10                 |
	--------------------------------------------------
	|C:96.3%[S:95.6%,D:0.7%],F:0.7%,M:3.0%,n:758      |
	|730	Complete BUSCOs (C)                       |
	|725	Complete and single-copy BUSCOs (S)       |
	|5	Complete and duplicated BUSCOs (D)        |
	|5	Fragmented BUSCOs (F)                     |
	|23	Missing BUSCOs (M)                        |
	|758	Total BUSCO groups searched               |
	--------------------------------------------------
#spades: 580029:
        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:96.5%[S:96.2%,D:0.3%],F:0.5%,M:3.0%,n:758      |
        |731    Complete BUSCOs (C)                       |
        |729    Complete and single-copy BUSCOs (S)       |
        |2      Complete and duplicated BUSCOs (D)        |
        |4      Fragmented BUSCOs (F)                     |
        |23     Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------

#spades -isolate: 580030:
        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:96.3%[S:96.0%,D:0.3%],F:0.7%,M:3.0%,n:758      |
        |730    Complete BUSCOs (C)                       |
        |728    Complete and single-copy BUSCOs (S)       |
        |2      Complete and duplicated BUSCOs (D)        |
        |5      Fragmented BUSCOs (F)                     |
        |23     Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------
#no output files being produced

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics
done
#metaspades:
	--------------------------------------------------
	|Results from dataset ascomycota_odb10            |
	--------------------------------------------------
	|C:93.9%[S:93.3%,D:0.6%],F:0.5%,M:5.6%,n:1706     |
	|1601	Complete BUSCOs (C)                       |
	|1591	Complete and single-copy BUSCOs (S)       |
	|10	Complete and duplicated BUSCOs (D)        |
	|8	Fragmented BUSCOs (F)                     |
	|97	Missing BUSCOs (M)                        |
	|1706	Total BUSCO groups searched               |
	--------------------------------------------------
#spades:
	--------------------------------------------------
	|Results from dataset ascomycota_odb10            |
	--------------------------------------------------
	|C:93.7%[S:93.5%,D:0.2%],F:0.4%,M:5.9%,n:1706     |
	|1598	Complete BUSCOs (C)                       |
	|1595	Complete and single-copy BUSCOs (S)       |
	|3	Complete and duplicated BUSCOs (D)        |
	|6	Fragmented BUSCOs (F)                     |
	|102	Missing BUSCOs (M)                        |
	|1706	Total BUSCO groups searched               |
	--------------------------------------------------

#spades -isolate:
        --------------------------------------------------
        |Results from dataset ascomycota_odb10            |
        --------------------------------------------------
        |C:93.9%[S:93.7%,D:0.2%],F:0.5%,M:5.6%,n:1706     |
        |1601   Complete BUSCOs (C)                       |
        |1598   Complete and single-copy BUSCOs (S)       |
        |3      Complete and duplicated BUSCOs (D)        |
        |8      Fragmented BUSCOs (F)                     |
        |97     Missing BUSCOs (M)                        |
        |1706   Total BUSCO groups searched               |
        --------------------------------------------------

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done

#metaspades:
	--------------------------------------------------
	|Results from dataset leotiomycetes_odb10         |
	--------------------------------------------------
	|C:77.0%[S:76.6%,D:0.4%],F:3.5%,M:19.5%,n:3234    |
	|2491	Complete BUSCOs (C)                       |
	|2477	Complete and single-copy BUSCOs (S)       |
	|14	Complete and duplicated BUSCOs (D)        |
	|112	Fragmented BUSCOs (F)                     |
	|631	Missing BUSCOs (M)                        |
	|3234	Total BUSCO groups searched               |
	--------------------------------------------------
#spades:
	--------------------------------------------------
	|Results from dataset leotiomycetes_odb10         |
	--------------------------------------------------
	|C:88.7%[S:88.3%,D:0.4%],F:1.4%,M:9.9%,n:3234     |
	|2870	Complete BUSCOs (C)                       |
	|2857	Complete and single-copy BUSCOs (S)       |
	|13	Complete and duplicated BUSCOs (D)        |
	|44	Fragmented BUSCOs (F)                     |
	|320	Missing BUSCOs (M)                        |
	|3234	Total BUSCO groups searched               |
	--------------------------------------------------


#spades -isolate:
        --------------------------------------------------
        |Results from dataset leotiomycetes_odb10         |
        --------------------------------------------------
        |C:88.6%[S:88.3%,D:0.3%],F:1.4%,M:10.0%,n:3234    |
        |2867   Complete BUSCOs (C)                       |
        |2857   Complete and single-copy BUSCOs (S)       |
        |10     Complete and duplicated BUSCOs (D)        |
        |46     Fragmented BUSCOs (F)                     |
        |321    Missing BUSCOs (M)                        |
        |3234   Total BUSCO groups searched               |
        --------------------------------------------------

```
```bash
conda activate BUSCO
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
```
```bash
conda activate BUSCO
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
	Data=$(ls $assembly) 
	Input=$(dirname $assembly)
	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
echo fin
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

### BBAP
### Genovo
### IDBA-UD
### IVA
### MAP
### MegaGTA
### MEGAHIT
### MetaVelvet
### MetaVelvet-SL
### Omega
### PRICE
### Ray Meta
### SAVAGE
### Snowball
### VICUNA
### Xander
### BBAP
### Genovo
### IDBA-UD
### IVA
### MAP
### MegaGTA
### MetaVelvet
### MetaVelvet-SL
### Omega
### PRICE
### Ray Meta
### SAVAGE
### Snowball

try BWA alignment instead of bowtie, get back to ATLAS, run through andys pipeline for strawberry mildew, busco of assemblies, kraken?, identify species in metagenome, mask/hard mask assemblies?, kat, busco, megahit example datasets --test, specify memory for megahit
```bash
screen -r
srun -p himem --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Combined reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades 'assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#15206.123

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades2 'assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/gdel_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades2-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades3 'assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -y 50000000 -x 10 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spadesplot100-1 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades3-main.mx
```

The existing Podosphaera leucotricha genome raw reads were downloaded.
```bash
mkdir /projects/nano_diagnostics/rawdata/P_leucotricha/ganan
pip install osfclient
osf -p reh8b clone rawdata/P_leucotricha/ganan

srun -p himem --pty bash
conda activate kat
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spades '/projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R2_001.fastq.gz' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#30797.asco

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spades-main.mx
#our reads vs our assembly
screen -r
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/myreads_v_spades '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/myreads_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/myreads_v_spades-main.mx

#their reads vs their assembly
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_ganan '/projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R2_001.fastq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/gananreads_v_gananplot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/gananreads_v_ganan-main.mx
```
A conda innstallation of Kraken2 was performed and a standard database created.
```bash
#A kraken2 standard database was built for binning - had to repeat several times before taxo.k2d file was successfully downloaded
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/1
srun -p long  --mem 350G --pty bash
conda activate kraken2
kraken2-build --standard --db analysis/P_leucotricha/THeavenp11_1/kraken2/1

#Kraken2 analysis was performed
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report.txt \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

#7860 sequences (51.51 Mbp) processed in 6.616s (71.3 Kseq/m, 467.14 Mbp/m).
#  2429 sequences classified (30.90%)
#  5431 sequences unclassified (69.10%)
```

A conda installation of metabat2 was performed
```bash
#metabat requires assembled contigs and a BAM file with the mapping of reads to the contigs as an input. Therefore trimmed reads were aligned to our metagenome assembly and formatted appropriately:
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew
conda activate bowtie2
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta myapplemildew_index
bowtie2 \
-x myapplemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unalignedmyapplemildew1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedmyapplemildew1+2fr.fq.gz \
-S THeavenp11_1alignedmyapplemildew1+2.sam
samtools view -S -b THeavenp11_1alignedmyapplemildew1+2.sam > THeavenp11_1alignedmyapplemildew1+2.bam
samtools sort THeavenp11_1alignedmyapplemildew1+2.bam -o THeavenp11_1alignedmyapplemildew1+2.sorted.bam
samtools index THeavenp11_1alignedmyapplemildew1+2.sorted.bam
conda deactivate

#metabat2 was run
cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/metabat2
cd analysis/P_leucotricha/THeavenp11_1/metabat2
conda activate metabat2
runMetaBat.sh --saveCls --unbinned /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew/THeavenp11_1alignedmyapplemildew1+2.sorted.bam 
#Output 3 bins; size 262 (9 sequences), 2586 (106 sequences) and 35577kB (1743 sequences) + unbinned 11993 (3177 sequences) 7860 contigs - 2825 contigs missing?

#checkM was installed in the metabat2 conda environment
conda install checkm-genome

#focus was installed and run
pip3 install metagenomics-focus
pip3 install numpy
pip3 install scipy 
cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/focus
focus -q /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs --list_output -o analysis/P_leucotricha/THeavenp11_1/focus

#metaphlan was installed
conda create -n metaphlan
conda activate metaphlan
conda install metaphlan=3.0=pyh5ca1d4c_2 --no-channel-priority
screen -r
srun -p short --mem 350G --pty bash
mkdir -p analysis/P_leucotricha/THeavenp11_1/metaphlan
metaphlan /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta --bowtie2out /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_bowtie2.bz2 --nproc 5 --input_type fasta -o /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_profile.txt

#KeyError: 'mpa_mpa_v30_CHOCOPhlAn_201901.tar'
```
A conda installation of CONCOCT was performed.
```bash
#CONCOCT also requires assembled contigs and a BAM file with the mapping of reads to the contigs as an input. 

# adapted from https://github.com/BinPro/CONCOCT/tree/1.1.0

cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/concoct
cd analysis/P_leucotricha/THeavenp11_1/concoct 
conda activate concoct
# Slice contigs into smaller sequences
cut_up_fasta.py /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta -c 10000 -o 0 --merge_last -b contigs_10K.bed > contigs_10K.fa
 
# Generate coverage depth 
concoct_coverage_table.py contigs_10K.bed /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew/THeavenp11_1alignedmyapplemildew1+2.sorted.bam > coverage_table.tsv
 
# Execute CONCOCT
concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/
#ImportError: libmkl_rt.so: cannot open shared object file: No such file or directory
pip install dlib
 
# Merge sub-contig clustering into original contig clustering
merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv
 
# Create output folder for bins
mkdir concoct_output/fasta_bins
 
# Parse bins into different files
extract_fasta_bins.py /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins
```
https://onestopdataanalysis.com/binning/

## Ganan raw data
```bash
#Quality control:

for RawData in $(ls rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/*.fastq.gz); do
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

#Trimming:
for ReadDir in $(ls -d rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/);
do
 Fread=$(ls $ReadDir*R1_001.fastq.gz)
 Rread=$(ls $ReadDir*R2_001.fastq.gz)
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



mkdir
ln -s 

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
```

## Repeat Masking
Conda installations of repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/masked
	mkdir -p $OutDir/rep_modeling
#	mkdir -p $OutDir/transposonPSI
	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
#	sbatch $ProgDir/transposonPSI.sh $Assembly $OutDir/transposonPSI
done
#603016
#603017
#603056
#603057
#603058
#606127
#606137
#606140
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
touch tmp.txt
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
  OutDir=$(dirname $Assembly)
  $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/WT_miniasm_pilon10_renamed.fasta --coord_file tmp.txt > $OutDir/log.txt
done
rm tmp.txt

ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Repeat_masking
BestAssembly=assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/*10_renamed.fasta
OutDir=assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/rep_modeling
sbatch $ProgDir/rep_modeling.sh $BestAssembly $OutDir
#614096





conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/masked
#	mkdir -p $OutDir/rep_modeling
	mkdir -p $OutDir/transposonPSI
#	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
	sbatch $ProgDir/transposonPSI.sh $Assembly $OutDir/transposonPSI
done
#603118
#606136
#606144
#606147
#606148
conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/masked
#	mkdir -p $OutDir/rep_modeling
	mkdir -p $OutDir/transposonPSI
#	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
	sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI/2
done
echo Finished
#615884

mkdir assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/transposonPSI/3
cd assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/transposonPSI/3
cp /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta man_contigs_unmasked.fa
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl man_contigs_unmasked.fa nuc
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands:
```bash
RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/transposonPSI/3/*_contigs_unmasked.fa.TPSI.allHits
printf "P_leucotricha\tTHeavenp11_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#22,190,306
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#14,182
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#Differing number of GFF fields encountered at line: 77884.  Exiting...
```
### Aligning
Insert sizes of the RNA seq library were unknown until a draft alignment could be made. To do this tophat and cufflinks were run, aligning the reads against a single genome. The fragment length and stdev were printed to stdout while cufflinks was running.


```bash
#in the abscence of apple mildew rnaseq data P.aphanis read were used
for assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/masked/transposonPSI/3/man_contigs_unmasked.fa); do
	for RNAdata in $(ls -d dna_qc/P_aphanis/RNAexp1/infected); do
	 Freads=$(ls $RNAdata/F/*trim.fq.gz)
	 Rreads=$(ls $RNAdata/R/*trim.fq.gz)

	OutDir=alignment/P_leucotricha/THeavenp11_1/tophat
	ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
	ls $Freads
	ls $Rreads
	ls $assembly
	ls $OutDir
	sbatch $ProgDir/tophat_alignment.sh $assembly $Freads $Rreads $OutDir
	done
done
echo finished
#620250
```