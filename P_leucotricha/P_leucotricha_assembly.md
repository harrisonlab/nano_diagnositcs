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

screen -S graminis
srun -p long  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P_graminis
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_graminis
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna P_graminis_index
(bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedP_graminisPleucotricha1+2.sam \
-S THeavenp11_1alignedP_graminisPleucotricha1+2.sam) 2> log.txt
echo finished
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    55941726 (98.30%) aligned concordantly 0 times
#    101264 (0.18%) aligned concordantly exactly 1 time
#    865058 (1.52%) aligned concordantly >1 times
#    ----
#    55941726 pairs aligned concordantly 0 times; of these:
#      2658 (0.00%) aligned discordantly 1 time
#    ----
#    55939068 pairs aligned 0 times concordantly or discordantly; of these:
#      111878136 mates make up the pairs; of these:
#        111042703 (99.25%) aligned 0 times
#        450493 (0.40%) aligned exactly 1 time
#        384940 (0.34%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3339962 (98.28%) aligned 0 times
#    28376 (0.83%) aligned exactly 1 time
#    30059 (0.88%) aligned >1 times

screen -S caphanis
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/cockerton_P_aphanis
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/cockerton_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta cockerton_P_aphanis_index
(bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedcockerton_P_aphanisPleucotricha1+2.sam \
-S THeavenp11_1alignedcockerton_P_aphanisPleucotricha1+2.sam) 2> log.txt
echo finished
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    49521451 (87.02%) aligned concordantly 0 times
#    6013382 (10.57%) aligned concordantly exactly 1 time
#    1373215 (2.41%) aligned concordantly >1 times
#    ----
#    49521451 pairs aligned concordantly 0 times; of these:
#      279751 (0.56%) aligned discordantly 1 time
#    ----
#    49241700 pairs aligned 0 times concordantly or discordantly; of these:
#      98483400 mates make up the pairs; of these:
#        92882507 (94.31%) aligned 0 times
#        4284005 (4.35%) aligned exactly 1 time
#        1316888 (1.34%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    2905961 (85.51%) aligned 0 times
#    414012 (12.18%) aligned exactly 1 time
#    78424 (2.31%) aligned >1 times

screen -S E_necator
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/E_necator
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/E_necator
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna E_necator_index
(bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedE_necatorPleucotricha1+2.sam \
-S THeavenp11_1alignedE_necatorPleucotricha1+2.sam) 2> log.txt
echo finished
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    54979096 (96.61%) aligned concordantly 0 times
#    1675611 (2.94%) aligned concordantly exactly 1 time
#    253341 (0.45%) aligned concordantly >1 times
#    ----
#    54979096 pairs aligned concordantly 0 times; of these:
#      38058 (0.07%) aligned discordantly 1 time
#    ----
#    54941038 pairs aligned 0 times concordantly or discordantly; of these:
#      109882076 mates make up the pairs; of these:
#        108080332 (98.36%) aligned 0 times
#        1527793 (1.39%) aligned exactly 1 time
#        273951 (0.25%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3128303 (92.05%) aligned 0 times
#    103020 (3.03%) aligned exactly 1 time
#    167074 (4.92%) aligned >1 times

screen -S P_xanthii
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/Angelini_P_xanthii
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/Angelini_P_xanthii
bowtie2-build /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta Angelini_P_xanthii_index
(bowtie2 \
-x Angelini_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedAngelini_P_xanthiiPleucotricha1+2.sam \
-S THeavenp11_1alignedAngelini_P_xanthiiPleucotricha1+2.sam) 2> log.txt
echo finished
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    52696845 (92.60%) aligned concordantly 0 times
#    3226316 (5.67%) aligned concordantly exactly 1 time
#    984887 (1.73%) aligned concordantly >1 times
#    ----
#    52696845 pairs aligned concordantly 0 times; of these:
#      184262 (0.35%) aligned discordantly 1 time
#    ----
#    52512583 pairs aligned 0 times concordantly or discordantly; of these:
#      105025166 mates make up the pairs; of these:
#        101059955 (96.22%) aligned 0 times
#        2575018 (2.45%) aligned exactly 1 time
#        1390193 (1.32%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3212828 (94.54%) aligned 0 times
#    139920 (4.12%) aligned exactly 1 time
#    45649 (1.34%) aligned >1 times

screen -S P_pannosa
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/Fonseca_P_pannosa
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/Fonseca_P_pannosa
bowtie2-build /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt Fonseca_P_pannosa_index
(bowtie2 \
-x Fonseca_P_pannosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedFonseca_P_pannosaPleucotricha1+2.sam \
-S THeavenp11_1alignedFonseca_P_pannosaPleucotricha1+2.sam) 2> log.txt
echo finished
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    56067033 (98.52%) aligned concordantly 0 times
#    566366 (1.00%) aligned concordantly exactly 1 time
#    274649 (0.48%) aligned concordantly >1 times
#    ----
#    56067033 pairs aligned concordantly 0 times; of these:
#      54637 (0.10%) aligned discordantly 1 time
#    ----
#    56012396 pairs aligned 0 times concordantly or discordantly; of these:
#      112024792 mates make up the pairs; of these:
#        110896333 (98.99%) aligned 0 times
#        745913 (0.67%) aligned exactly 1 time
#        382546 (0.34%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3368354 (99.12%) aligned 0 times
#    18215 (0.54%) aligned exactly 1 time
#    11828 (0.35%) aligned >1 times

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

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
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

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs); do 
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	; Input=$(dirname $assembly);  
	mkdir -p $Input/BUSCO/fungi/1/2; 
	cd $Input/BUSCO/fungi/1;
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l fungi_odb10; 
	cd /projects/nano_diagnostics; 
	mkdir -p $Input/BUSCO/ascomycota/1/2; 
	cd $Input/BUSCO/ascomycota/1; 
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l ascomycota_odb10; 
	cd /projects/nano_diagnostics;  
	mkdir -p $Input/BUSCO/leotiomycetes/1/2; 
	cd $Input/BUSCO/leotiomycetes/1; 
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l leotiomycetes_odb10; 
	cd /projects/nano_diagnostics; done
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
A conda installation of Kraken2 was performed and a standard database created.
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
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

#7860 sequences (51.51 Mbp) processed in 6.616s (71.3 Kseq/m, 467.14 Mbp/m).
#  2429 sequences classified (30.90%)
#  5431 sequences unclassified (69.10%)
#  19.4% return as human
```
The kraken2 standard database contains NCBI taxonomic information, as well as the complete genomes in RefSeq for the bacterial, archaeal, and viral domains, along with the human genome and a collection of known vectors (UniVec_Core). We are investigating a fungal plant pathogen and so the reference libraries for plants and fungi were also used.
```bash
#additional libraries were added to the standard database
screen -S krakenfungi
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2-build --download-library fungi --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library plant --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library protozoa --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library UniVec --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
#Kraken2 analysis was performed
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#7860 sequences (51.51 Mbp) processed in 13.487s (35.0 Kseq/m, 229.17 Mbp/m).
#2429 sequences classified (30.90%)
#5431 sequences unclassified (69.10%)

#A fungi only database was created
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-library fungi --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
#taxo.k2d was again not downloaded properly by these commands the first time and so all was deleted and commands repeated, file downloaded successfully the second time
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#7860 sequences (51.51 Mbp) processed in 6.524s (72.3 Kseq/m, 473.75 Mbp/m).
#700 sequences classified (8.91%)
#7160 sequences unclassified (91.09%)
#detects zero fungi but 75 viruses despite the virus library not being used?
```
An alternative library download was tried sent by A.Armitage
```bash
#Alternative download scripts were downloaded from a git repo:
#* from https://github.com/R-Wright-1/peptides
#* following the discussion at https://github.com/DerrickWood/kraken2/issues/272
screen -S kraken
srun -p long  --mem 50G --pty bash
mkdir /scratch/public_data/tch
cd /scratch/public_data/tch
wget https://github.com/R-Wright-1/peptides/archive/refs/heads/master.zip
unzip master.zip
conda create -n biopython
conda activate biopython
conda update -n base conda
conda install -c conda-forge biopython
conda install pandas
mkdir tmp123
cd tmp123
DBNAME=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/kraken2/custom_kraken_db
kraken2-build --download-taxonomy --use-ftp --threads 20 --db $DBNAME 
#edit ../peptides-master/download_domain.py to http download
python ../peptides-master/download_domain.py --domain fungi --ext dna # 04052021
python ../peptides-master/download_domain.py --domain bacteria --complete True --ext dna 
python ../peptides-master/download_domain.py --domain plant --ext dna
python ../peptides-master/download_domain.py --domain vertebrate_mammalian --human True --complete True --ext dna
python ../peptides-master/download_domain.py --domain protozoa --ext dna 
python ../peptides-master/download_domain.py --domain archaea --ext dna 

python ../peptides-master/download_domain.py --domain plasmid --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain viral --complete True --ext dna
python ../peptides-master/download_domain.py --domain human --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain UniVec_Core --complete True --ext dna #unable to open assembly_summary.txt
echo complete
python ../peptides-master/download_domain.py --domain nt --ext dna #unable to open assembly_summary.txt

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
#Run kraken with updated fungi only database
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#8.91% classified

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
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#2429 sequences classified (30.90%)

kraken2-build --add-to-library assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi #scan_fasta_file.pl: unable to determine taxonomy ID 
kraken2-build --add-to-library assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa  --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi #scan_fasta_file.pl: unable to determine taxonomy ID 

#Additional tools were downloaded to extract reads associated with each kraken2-identified taxon (https://github.com/jenniferlu717/KrakenTools)
srun --partition=short --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=1G --pty bash
cd ~/git_repos/tools/prog/kraken2/2
wget https://github.com/jenniferlu717/KrakenTools/archive/refs/tags/v1.0.1.tar.gz
exit
cd ~/git_repos/tools/prog/kraken2/2
tar -zxvf v1.0.1.tar.gz
chmod +x KrakenTools-1.0.1/*.py
chmod +x KrakenTools-1.0.1/*/*.py
#Added to PATH in ~/.profile
PATH=$HOME/git_repos/tools/prog/kraken2/KrakenTools-1.0.1:${PATH}
PATH=$HOME/git_repos/tools/prog/kraken2/KrakenTools-1.0.1/DiversityTools:${PATH}

#constructed databses were used with the published yeast genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputyeast.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outyeast.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outyeast.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportyeast.txt \
--use-names \
assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna
#  17 sequences classified (100.00%)
# 0 sequences unclassified (0.00%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputyeast.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outyeast.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outyeast.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportyeast.txt \
--use-names \
assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna
#  17 sequences classified (100.00%)
# 0 sequences unclassified (0.00%)

#constructed databses were used with the published P.leucotricha genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  632 sequences classified (7.08%)
#  8289 sequences unclassified (92.92%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  2415 sequences classified (27.07%)
#  6506 sequences unclassified (72.93%)

#constructed databses were used with the published V.inaequalis genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#    135 sequences classified (56.72%)
#  103 sequences unclassified (43.28%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
#    228 sequences classified (95.80%)
#  10 sequences unclassified (4.20%)
```
The published P.leucotricha genome was added to the databases.
```bash
sed 's/ Podosphaera/|kraken:taxid|79249 Podosphaera/g' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa > /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa
grep "^>" /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa

3750
grep "^>" assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta


conda activate kraken2
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-taxonomy --use-ftp --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputganan2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outganan2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outganan2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportganan2.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  632 sequences classified (7.08%)
#  8289 sequences unclassified (92.92%)

kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-taxonomy --use-ftp --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 2>&1 | tee krakenfungioutput.log

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputganan2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outganan2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outganan2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportganan2.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  2415 sequences classified (27.07%)
#  6506 sequences unclassified (72.93%)

screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputscab2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outscab2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outscab2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportscab2.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  135 sequences classified (56.72%)
#  103 sequences unclassified (43.28%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputscab2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outscab2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outscab2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportscab2.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
#  228 sequences classified (95.80%)
#  10 sequences unclassified (4.20%)
```
Kraken again
```bash
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee 1.log
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
done
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3
exit
exit
echo finished

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  8921 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  222 sequences classified (93.28%)
#  16 sequences unclassified (6.72%)

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  6723 sequences classified (85.53%)
#  1137 sequences unclassified (14.47%)
```

```bash
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/nt2
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee 3.log
for file in $(ls /scratch/public_data/tch/tmp123/archaea/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/bacteria/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/protozoa/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/viral/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/vertebrate_mammalian/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log
grep "|3750" /scratch/public_data/tch/tmp123/plant/*.fna # confirms that apple is in the plant database
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2
exit
exit
echo finished # taxo.k2d file missing >:()

#line 143:  2372 Exit 141                list_sequence_files
#      2373 Exit 125                | xargs -0 cat
#      2374 Killed                  | build_db -k $KRAKEN2_KMER_LEN -l $KRAKEN2_MINIMIZER_LEN -S $KRAKEN2_SEED_TEMPLATE $KRAKEN2XFLAG -H hash.k2d.tmp -t taxo.k2d.tmp -o opts.k2d.tmp -n taxonomy/ -m $seqid2taxid_map_file -c $required_capacity -p $KRAKEN2_THREAD_CT $max_db_flag -B $KRAKEN2_BLOCK_SIZE -b $KRAKEN2_SUBBLOCK_SIZE -r $KRAKEN2_MIN_TAXID_BITS $fast_build_flag


kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
# 8921 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)


kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  238 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  7416 sequences classified (94.35%)
#  444 sequences unclassified (5.65%)

#kraken rerunn with database containing all published mildew genomes and strawberry genome
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  7550 sequences classified (96.06%)
#  310 sequences unclassified (3.94%)

```
Kraken2 suggested a larger number of reads in our assembly are of human origin, to investigate this further unassembled trimmed reads were aligned to the human genome.
```bash
screen -S bowtie2
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/human
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/human
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/primate/H.sapiens/GCA_000001405.15_GRCh38_genomic.fa Human_index
bowtie2 \
-x Human_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unalignedhuman1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedhuman1+2fr.fq.gz \
-S THeavenp11_1alignedhuman1+2.sam
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    56876068 (99.94%) aligned concordantly 0 times
#    6911 (0.01%) aligned concordantly exactly 1 time
#    25069 (0.04%) aligned concordantly >1 times
#    ----
#    56876068 pairs aligned concordantly 0 times; of these:
#      84 (0.00%) aligned discordantly 1 time
#    ----
#    56875984 pairs aligned 0 times concordantly or discordantly; of these:
#      113751968 mates make up the pairs; of these:
#        113393452 (99.68%) aligned 0 times
#        6153 (0.01%) aligned exactly 1 time
#        352363 (0.31%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3253868 (95.75%) aligned 0 times
#    1285 (0.04%) aligned exactly 1 time
#    143244 (4.22%) aligned >1 times
#0.48% overall alignment rate
```
Contaminant contigs were removed from the assembly
```bash
touch analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt
nano analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt

#Edited with the following: 

#Bacteria:
Buchnera 
Acinetobacter
Candidatus
Avibacterium
Vibrio
Campylobacter
Halarcobacter
Sphingobium
Clostridium
Cellulosilyticum
Staphylococcus
Paenibacillus
Streptomyces
Nocardiopsis
Pedobacter
#Archaea:
Methanosarcina
#Animals:
Homo sapiens
#Plants:
Embryophyta
Magnoliopsida
Mesangiospermae
Pentapetalae
rosids
fabids
Maleae
Malus
Pyrus
Cannabis
Ziziphus
inversion
Phaseoleae
Vigna
Cajanus
Phaseolus
Glycine
Abrus
Medicago
Arachis
Lupinus
Prosopis
Quercus
Juglans
Hevea
Manihot
Jatropha
Ricinus
Populus
Cucurbitaceae
Benincasa
Cucumis
Cucurbita
Tripterygium
malvids
Malvoideae
Gossypium
Hibiscus
Durio
Brassica
Raphanus
Camelina
Arabidopsis
Rhodamnia
Eucalyptus
Syzygium
Punica
Pistacia
Citrus
asterids
Asteraceae
Lactuca
Helianthus
Cynara
Daucus
lamiids
Capsicum
Solanum
Nicotiana
Ipomoea
Olea europaea
Sesamum
Erythranthe
Coffea
Camellia
Chenopodium
Spinacia
Beta vulgaris
Petrosaviidae
Triticum
Panicum
Setaria
Zea mays
Ananas comosus
Arecaceae
Elaeis guineensis
Phoenix dactylifera
Dendrobium
Phalaenopsis
Dioscorea
Papaver
Nelumbo
Amborella
#Protists:
Plasmodium 
Theileria
Eimeria acervulina
#Algae:
Paramecium
Saprolegnia
#Amoeba:
Entamoeba
Dictyostelium
Trypanosoma
# These are the taxids identified by kraken2, excluding fungi identifed as these may be misidentifed mildew contigs given the lack of sequencing within the mildew clade.

# Most contaminat contifs are accounted for by Lactuca sativ and Mlaus domestica, a separate file was created for the other minor contaminants.
touch analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt
nano analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt

grep -f analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontigs.txt
grep -f analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontigs.txt


nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontigs.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontigs.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontignames.txt

conda activate seqtk
seqtk subseq assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminants.fasta
seqtk subseq assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontignames.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminants.fasta
conda deactivate

/home/heavet/git_repos/tools/DIY/filter.py assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt > assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp.fasta
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp.fasta > assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt #802
wc -l assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta #15720
wc -l assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta #14116
```
Following the removal of contaminant contigs, kraken2, BUSCO and quast analysis were performed again for the filtered assembly
```bash
screen -S kraken2
srun -p long  --mem 160G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredoutput.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredunclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredclassified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredreport.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
#  6614 sequences classified (93.71%)
#  444 sequences unclassified (6.29%)

#kraken rerunn with database containing all published mildew genomes and strawberry genome
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredoutput2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredunclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredclassified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredreport2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
#  6749 sequences classified (95.62%)
#  309 sequences unclassified (4.38%)

conda deactive
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs); do
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
echo finished
conda deactivate
#busco scores higher now that some contigs removed? retest unfiltered in /2
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)/filtered
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#756881
```
## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines.

Any contaminants detected by NCBI can be removed via the following:
```bash
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
  OutDir=$(dirname $Assembly)
  $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/WT_miniasm_pilon10_renamed.fasta --coord_file tmp.txt > $OutDir/log.txt
done
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

Centrifuge has already been installed on slurm in the /scratch area.
```bash
# The following commands have been used to create a database with all fungal genomes on NCBI:
centrifuge-download -o library -m -a Any -d "fungi" genbank > seqid2taxid.map
centrifuge-download -o taxonomy taxonomy
cat library/fungi/*.fna > input-fungal-sequences.fna
centrifuge-build -p 4 --conversion-table seqid2taxid.map --taxonomy-tree taxonomy/nodes.dmp --name-table taxonomy/names.dmp input-fungal-sequences.fna fungi

#There is a database of fungi only at /data/scratch/gomeza/prog/centrifuge/
#There is a nucleotide database at /scratch/public_data/nt-centrifuge_12jan2021/nt

mkdir ~/git_repos/tools/seq_tools/metagenomics
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Metagenomics/centrifuge.sh ~/git_repos/tools/seq_tools/metagenomics/centrifuge.sh
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Metagenomics/centrifuge.sh ~/git_repos/tools/seq_tools/metagenomics/ag_centrifuge.sh
```
Centrifuge was run with a Fungi only database:
```bash
mkdir -p analysis/P_leucotricha/THeavenp11_1/centrifuge

#Centrifuge appears to run, at least by default, on reads rather than assembled contigs. This will be performed first for our filtered reads. -q flag used.
  for ReadDir in $(ls -d /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    echo $F_Read
	echo $R_Read
	echo $S_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/centrifuge.sh $Database $OutDir $F_Read $R_Read $S_Read
	done
#731047 - ERROR

#attempted with unedited version of a.gomez wrapper script.
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    echo $F_Read
	echo $R_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
	done
#737390 

#Following this a run with assembled contigs was attempted. -f flag used.
  for ReadDir in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
    F_Read=$ReadDir
    echo $F_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/contigs
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read
	done
#740029 - unsuccessful
```
Centrifuge was run with nt database.
```bash
#change database to /scratch/public_data/nt-centrifuge_12jan2021/
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    echo $F_Read
	echo $R_Read
    Database=nt
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads/nt
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
	done
#740638
```
###  Conterminator
```bash
head /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm this is fasta file
grep "^>" /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm this has many sequences
head /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm this is mapping file in correct format
grep -m 10 "X52703.1" /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm mapping file has example sequence from database file
grep "\s79249" /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm that Ganan P.leucotricha reads are in the mapping file
grep -m 10 "JAATOF010" /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm that Ganan P.leucotricha reads are in the sequence file - cannot confirm, file is not writable and ~350GB in size
sed 's/>P_leucotricha_/>/g' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa > /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa
#cat /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa  /scratch/public_data/nt-centrifuge_12jan2021/nt.fa #cannot perform this step without write permissions
mkdir -p analysis/P_leucotricha/THeavenp11_1/conterminator/nt/
screen -S conterminator
srun -p himem  --mem 350G --pty bash
conda activate conterminator 
conterminator dna /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map analysis/P_leucotricha/THeavenp11_1/conterminator/nt/nt.result /scratch/public_data/tch
```
### Mitofinder

```bash
mkdir -p rawdata/P_xanthii/KimS/mitochondrion/
cd rawdata/P_xanthii/KimS/mitochondrion/

#file uploaded of complete podosphaera xanthii mitochondrion from: https://www.ncbi.nlm.nih.gov/nuccore/MK674497.1?report=fasta&log$=seqview

conda activate Mitofinder
RefMtGb=$(ls rawdata/P_xanthii/KimS/mitochondrion)
NCBI_Code="4"
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
  Prefix=P_leucotrichaTHeavenp11_1_MtDNA
  OutDir=$(dirname $Assembly)/mtDNA_mitofinder
  mkdir -p $OutDir
  ProgDir=~/git_repos/tools/seq_tools/assemblers
  echo $Prefix
  sbatch $ProgDir/sub_mitofinder.sh $Prefix $Assembly $RefMtGb $NCBI_Code $OutDir
done
#757975 - basic command not working, argument list too long

screen -S mito
srun -p long -c 10 --mem 50G --pty bash 
conda activate spades
ls /home/heavet/miniconda3/envs/Mitofinder/bin/mitofinder

cd assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/mtDNA_mitofinder
mitofinder \
  --seqid P_leucotrichaTHeavenp11_1_MtDNA \
  --tRNA-annotation mitfi \
  --adjust-direction \
  --new-genes \
  --max-contig-size 50000 \
  --circular-size 55 \
  --assembly /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta \
  --refseq /projects/nano_diagnostics/rawdata/P_xanthii/KimS/mitochondrion/pxanthiimito.gb \
  --organism 4 \
  --processors 10 \
  --max-memory 49
```
## Repeat Masking
Conda installations of repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
	ProgDir=~/git_repos/tools/seq_tools/repeat_masking
	OutDir=$(dirname $Assembly)/filteredmasked
	mkdir -p $OutDir/rep_modeling
	sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling
done
#758296
conda deactivate

screen -S psi
srun -p long -c 4 --mem 10G --pty bash 
conda activate transposonpsi
mkdir assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filteredmasked/transposonPSI
cd assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filteredmasked/transposonPSI
cp /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta man_contigs_unmasked_filtered.fa
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl contigs_min_500bp_filtered.fa nuc
conda deactivate
exit
exit
```
















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