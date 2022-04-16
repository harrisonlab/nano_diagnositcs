
# Blumeria graminis secalis genome assembly pipeline

Documentation of analysis and commands used to assemble Blumeria graminis samples infecting Rye.

Blumeria graminis isolates infecting rye plants were sequenced by Menardo et al., published in nature genetics (doi:10.1038/ng.3485), SRA data are publicly available from the NCBI database however assembled genomes for these five isolaes are not. The addition of five genomes would increase our mildew dataset by 17%, raw sequencing data was therefore downloaded and assembled following our pipeline established previously for Podosphaera species.

All the following commands were executed on the Crop Diversity HPC from the folder /home/theaven/scratch unless stated otherwise.

## Data collection

SRA data weas initially downloaded to the NIAB HPC, this was subsequently moved to the Crop Diversity HPC.
```bash
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR2153120/SRR2153120.1
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis/.  https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR2153119/SRR2153119.1
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR2153118/SRR2153118.1
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR2153117/SRR2153117.1
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis/. https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR2153116/SRR2153116.1

cd /data/scratch/heavet/assembly/genome/Blumeria/graminis

mv SRR2153116.1 SRR2153116.1.gz
mv SRR2153117.1 SRR2153117.1.gz
mv SRR2153118.1 SRR2153118.1.gz
mv SRR2153119.1 SRR2153119.1.gz
mv SRR2153120.1 SRR2153120.1.gz

mkdir -p rawdata/B_graminis_secalis/MiSeq/S_1459
mkdir -p rawdata/B_graminis_secalis/MiSeq/S_1201
mkdir -p rawdata/B_graminis_secalis/MiSeq/S_1203
mkdir -p rawdata/B_graminis_secalis/MiSeq/S_1391
mkdir -p rawdata/B_graminis_secalis/MiSeq/S_1400

ln -s /data/scratch/heavet/assembly/genome/Blumeria/graminis/SRR2153116.1.gz rawdata/B_graminis_secalis/MiSeq/S_1459/.
ln -s /data/scratch/heavet/assembly/genome/Blumeria/graminis/SRR2153117.1.gz rawdata/B_graminis_secalis/MiSeq/S_1201/.
ln -s /data/scratch/heavet/assembly/genome/Blumeria/graminis/SRR2153118.1.gz rawdata/B_graminis_secalis/MiSeq/S_1203/.
ln -s /data/scratch/heavet/assembly/genome/Blumeria/graminis/SRR2153119.1.gz rawdata/B_graminis_secalis/MiSeq/S_1391/.
ln -s /data/scratch/heavet/assembly/genome/Blumeria/graminis/SRR2153120.1.gz rawdata/B_graminis_secalis/MiSeq/S_1400/.

fastq-dump --split-files --gzip -O rawdata/B_graminis_secalis/MiSeq/S_1459 SRR2153116.1
fastq-dump --split-files --gzip -O rawdata/B_graminis_secalis/MiSeq/S_1201 SRR2153117.1
fastq-dump --split-files --gzip -O rawdata/B_graminis_secalis/MiSeq/S_1203 SRR2153118.1
fastq-dump --split-files --gzip -O rawdata/B_graminis_secalis/MiSeq/S_1391 SRR2153119.1
fastq-dump --split-files --gzip -O rawdata/B_graminis_secalis/MiSeq/S_1400 SRR2153120.1
```
```bash
for RawData in $(ls rawdata/B_graminis_secalis/MiSeq/*/*fastq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#17802-17806
```
```bash
scp -r /projects/nano_diagnostics/rawdata/B_graminis_secalis/MiSeq theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/projects/niab/theaven/raw_data/DNA/blumeria/graminis/secalis/ 
```
## Data QC
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
conda activate trimmomatic
for ReadDir in $(ls -d /home/theaven/projects/niab/theaven/raw_data/DNA/blumeria/graminis/secalis/MiSeq/S_1*);
do
# mkdir $ReadDir/F
# mkdir $ReadDir/R
 Fread=$(ls $ReadDir/F/*_1.fastq.gz)
 Rread=$(ls $ReadDir/R/*_2.fastq.gz)
#mv $Fread $ReadDir/F/.
#mv $Rread $ReadDir/R/.
Adapters=~/scratch/apps/trimmomatic/ncbi_adapters.fa
ProgDir=~/scratch/apps/trimmomatic
OutDir=$(echo $ReadDir|sed 's@/home/theaven/projects/niab/theaven/raw_data/DNA/blumeria/graminis/secalis@/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic@g')
Prefix=$(echo $ReadDir|rev|cut -f1,3,4,5 -d '/' --output-delimiter '-'|rev)
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#2462668-2462672
conda deactivate
```
```bash
conda activate fastqc
for RawData in $(ls dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1*/*/*.fq.gz); do
echo $RawData
ProgDir=~/scratch/apps/fastqc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#2463123-2463142
conda deactivate
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available ryw genome downloaded from NCBI.

The following were performed with the first round of sequencing data.
```bash
conda activate bowtie2
mkdir -p alignment/blumeria/graminis/secalis/S_1201/bowtie2/rye
mkdir -p alignment/blumeria/graminis/secalis/S_1203/bowtie2/rye
mkdir -p alignment/blumeria/graminis/secalis/S_1391/bowtie2/rye
mkdir -p alignment/blumeria/graminis/secalis/S_1400/bowtie2/rye
mkdir -p alignment/blumeria/graminis/secalis/S_1459/bowtie2/rye
mkdir -p alignment/blumeria/graminis/secalis/all/bowtie2/rye

screen -S bowtie
srun -p long -J bowtie --mem 200G --pty bash
cd alignment/blumeria/graminis/secalis/all/bowtie2/rye
bowtie2-build /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna rye_index
conda deactivate
exit
exit
echo complete

srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim_unpaired.fq.gz \
--un B_graminis_secalis-rye_unaligned.sam \
--un-gz B_graminis_secalis-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis-rye.sam 2>&1 | tee -a report.txt
#0.29% overall alignment rate

screen -S bowtie2
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /home/theaven/scratch
cd alignment/blumeria/graminis/secalis/S_1201/bowtie2/rye
cp /home/theaven/scratch/alignment/blumeria/graminis/secalis/all/bowtie2/rye/*.bt2l .
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim_unpaired.fq.gz \
--un B_graminis_secalis_S1201-rye_unaligned.sam \
--un-gz B_graminis_secalis_S1201-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis_S1201-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis_S1201-rye.sam 2>&1 | tee -a report.txt
#0.29% overall alignment rate

cd /home/theaven/scratch
cd alignment/blumeria/graminis/secalis/S_1203/bowtie2/rye
cp /home/theaven/scratch/alignment/blumeria/graminis/secalis/all/bowtie2/rye/*.bt2l .
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim_unpaired.fq.gz \
--un B_graminis_secalis_S1203-rye_unaligned.sam \
--un-gz B_graminis_secalis_S1203-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis_S1203-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis_S1203-rye.sam 2>&1 | tee -a report.txt
#0.31% overall alignment rate

cd /home/theaven/scratch
cd alignment/blumeria/graminis/secalis/S_1391/bowtie2/rye
cp /home/theaven/scratch/alignment/blumeria/graminis/secalis/all/bowtie2/rye/*.bt2l .
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim_unpaired.fq.gz \
--un B_graminis_secalis_S1391-rye_unaligned.sam \
--un-gz B_graminis_secalis_S1391-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis_S1391-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis_S1391-rye.sam 2>&1 | tee -a report.txt
#0.35% overall alignment rate

cd /home/theaven/scratch
cd alignment/blumeria/graminis/secalis/S_1400/bowtie2/rye
cp /home/theaven/scratch/alignment/blumeria/graminis/secalis/all/bowtie2/rye/*.bt2l .
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim_unpaired.fq.gz \
--un B_graminis_secalis_S1400-rye_unaligned.sam \
--un-gz B_graminis_secalis_S1400-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis_S1400-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis_S1400-rye.sam 2>&1 | tee -a report.txt
#0.20% overall alignment rate

cd /home/theaven/scratch
cd alignment/blumeria/graminis/secalis/S_1459/bowtie2/rye
cp /home/theaven/scratch/alignment/blumeria/graminis/secalis/all/bowtie2/rye/*.bt2l .
bowtie2 \
-x rye_index \
-1 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim.fq.gz \
-2 /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim.fq.gz \
-U /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim_unpaired.fq.gz, /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim_unpaired.fq.gz \
--un B_graminis_secalis_S1459-rye_unaligned.sam \
--un-gz B_graminis_secalis_S1459-rye_unaligned_s.fq.gz \
--un-conc-gz B_graminis_secalis_S1459-rye_unaligned_fr.fq.gz \
-S B_graminis_secalis_S1459-rye.sam 2>&1 | tee -a report.txt
#0.29% overall alignment rate

conda deactivate
exit
exit
echo finished
```
### Kmer analysis toolkit
The quality of the sequencing data was assessed using KAT.
```bash
screen -S kat
srun -p long --mem-per-cpu 10G --cpus-per-task 24 --pty bash
conda activate kat
cd /home/theaven/scratch

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S/kat/reads_v_secalecereale-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S_1201/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/F/blumeria-graminis-secalis-S_1201_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1201/R/blumeria-graminis-secalis-S_1201_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S_1201/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S_1201/kat/reads_v_secalecereale-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S_1203/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/F/blumeria-graminis-secalis-S_1203_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1203/R/blumeria-graminis-secalis-S_1203_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S_1203/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S_1203/kat/reads_v_secalecereale-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S_1391/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/F/blumeria-graminis-secalis-S_1391_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1391/R/blumeria-graminis-secalis-S_1391_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S_1391/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S_1391/kat/reads_v_secalecereale-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S_1400/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/F/blumeria-graminis-secalis-S_1400_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1400/R/blumeria-graminis-secalis-S_1400_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S_1400/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S_1400/kat/reads_v_secalecereale-21-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/blumeria/graminis/secalis/S_1459/kat/reads_v_secalecereale-21 '/home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/F/blumeria-graminis-secalis-S_1459_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/blumeria/graminis/secalis/trimmomatic/MiSeq/S_1459/R/blumeria-graminis-secalis-S_1459_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/secale/cereale/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna

kat plot spectra-cn -x 300 -o alignment/blumeria/graminis/secalis/S_1459/kat/reads_v_secalecereale-21-plot300 alignment/blumeria/graminis/secalis/S_1459/kat/reads_v_secalecereale-21-main.mx

conda deactivate
exit
exit
echo finished
```
## Assembly
Trimmed reads that did not align to the camarosa genome were taken as raw data for assembly.
```bash
#files were renamed to correct extensions for spades
for data in $(ls alignment/blumeria/graminis/secalis/*/bowtie2/rye/*.gz); do
  new=$(echo $data|sed 's@fr.fq.1.gz@fr-f.fq.gz@g'|sed 's@fr.fq.2.gz@fr-r.fq.gz@g'|sed 's@_s.fq.gz@_s-s.fq.gz@g')
mv $data $new
done
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss. Initial runs produced assemblies much larger than expected with duplication of BUSCOs, further iterations of assembly were therefore performed varying the settings of SPAdes.
```bash
conda activate spades

  for ReadDir in $(ls -d alignment/blumeria/graminis/secalis/*/bowtie2/rye); do
    ProgDir=/home/theaven/scratch/apps/spades
    F_Read=$(ls $ReadDir/*f.fq.gz)
    R_Read=$(ls $ReadDir/*r.fq.gz)
    S_Read=$(ls $ReadDir/*s.fq.gz)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rye@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#2474997-2475002
conda deactivate
```
```bash
conda activate quast
    for Assembly in $(ls assembly/metagenome/blumeria/graminis/secalis/*/SPAdes/*/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#
conda deactivate
```
### Kraken2
Kraken2 was used to screen the assembly for contaminant contigs.
```bash
#kraken was run with a general database containing all erysiphales genomes published on NCBI and the red and black raspberry genomes.
screen -S kraken
srun -p himem -J kraken2 --mem 550G --pty bash

mkdir /home/theaven/scratch/apps/kraken2/nt
scp -r /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/kraken2/nt 

 for Assembly in $(ls -d assembly/metagenome/blumeria/graminis/secalis/*/SPAdes/*/filtered_contigs); do
  OutDir=$(echo $Assembly|sed 's@assembly/metagenome@analysis@g'|sed 's@SPAdes@kraken2/nt@g'|sed 's@filtered_contigs@@g')
  kraken2 \
  --db /home/theaven/scratch/apps/kraken2/nt/nt \
  --output $OutDir/output.txt \
  --unclassified-out $OutDir/unclassified-out.txt \
  --classified-out $OutDir/classified-out.txt \
  --report $OutDir/report.txt \
  --use-names \
  $Assembly/contigs_min_500bp.fasta
  echo $Assembly
  echo $OutDir
done

exit
exit
echo finished

scp -r /home/theaven/scratch/assembly/metagenome/blumeria/graminis/secalis/S_1459/SPAdes/2475002/filtered_contigs/contigs_min_500bp.fasta heavet@10.2.20.1:/projects/nano_diagnostics/assembly/metagenome/blumeria/graminis/secalis/S_1459/SPAdes/1/filtered_contigs


screen -S kraken2
#Genomes were downloaded:
mkdir ~/scratch/apps/kraken2/nt2
cd ~/scratch/apps/kraken2/nt2
wget https://github.com/R-Wright-1/peptides/archive/refs/heads/master.zip
unzip master.zip
conda create -n biopython
conda activate biopython
conda update -n base conda
conda install -c conda-forge biopython
conda install -c bioconda blast
conda install pandas
mkdir tmp123
cd tmp123
DBNAME=~/scratch/apps/kraken2/nt2
kraken2-build --download-taxonomy --use-ftp --threads 20 --db $DBNAME 
#edit ../peptides-master/download_domain.py to http download
python ../peptides-master/download_domain.py --domain fungi --ext dna
python ../peptides-master/download_domain.py --domain bacteria --complete True --ext dna  # 20032022
python ../peptides-master/download_domain.py --domain plant --ext dna #21032022
python ../peptides-master/download_domain.py --domain vertebrate_mammalian --human True --complete True --ext dna #22032022 - only one genome?
python ../peptides-master/download_domain.py --domain protozoa --ext dna #23032022
python ../peptides-master/download_domain.py --domain archaea --ext dna #23032022
python ../peptides-master/download_domain.py --domain plasmid --complete True --ext dna #unable to open assembly_summary.txt, kraken2-build --download-library is also not working for plasmids #23032022
python ../peptides-master/download_domain.py --domain viral --complete True --ext dna #23032022
python ../peptides-master/download_domain.py --domain human --complete True --ext dna #unable to open assembly_summary.txt #23032022
python ../peptides-master/download_domain.py --domain UniVec_Core --complete True --ext dna #unable to open assembly_summary.txt #23032022
echo complete
python ../peptides-master/download_domain.py --domain nt --ext dna #unable to open assembly_summary.txt #23032022

kraken2-build --download-library nt  --use-ftp --db $DBNAME #Unable to find dustmasker in path, can't mask low-complexity sequences
kraken2-build --download-library human  --use-ftp --db $DBNAME
kraken2-build --download-library UniVec_Core  --use-ftp --db $DBNAME

#Downloaded genomes added to database:
cd ~/scratch
kraken2-build --download-taxonomy  --use-ftp --db ~/scratch/apps/kraken2/nt2 2>&1 | tee ~/scratch/apps/kraken2/nt2/krakenbuild.log

for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/archaea/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
cd ~/scratch/apps/kraken2/nt2/tmp123/bacteria
for file in $(ls *.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
cd ~/scratch
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/plant/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/protozoa/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/viral/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/vertebrate_mammalian/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done

#Missing genomes added to database
for assembly in $(ls data/assembly/genome/*/*/*.mod.fna); do
kraken2-build --add-to-library $assembly --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a 2.log
done

#Databse was built:
kraken2-build --build --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db ~/scratch/apps/kraken2/nt2
exit
exit
echo finished
```
