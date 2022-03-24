# Manual_canu_correction
Documentation of analyses and commands used in a trial to run canu correction without the use of a wrapper program.
Note - all this work was performed within a /tmp area of a worker node of the cluster.

## Script written by A.Armitage:
```bash
#!/bin/bash

# Assemble PacBio data using Canu

#$ -S /bin/bash
#$ -cwd
#$ -pe smp 24
#$ -l virtual_free=15.5G
#$ -l h=blacklace11.blacklace




Usage="sub_canu_correction.sh <reads.fq> <Genome_size[e.g.45m]> <outfile_prefix> <output_directory> [<specification_file.txt>]"
echo "$Usage"

# ---------------
# Step 1
# Collect inputs
# ---------------

FastqIn=$1
Size=$2
Prefix=$3
OutDir=$4
AdditionalCommands=""
if [ $5 ]; then
  SpecFile=$5
  AdditionalCommands="-s $SpecFile"
fi
echo  "Running Canu with the following inputs:"
echo "FastqIn - $FastqIn"
echo "Size - $Size"
echo "Prefix - $Prefix"
echo "OutDir - $OutDir"

CurPath=$PWD
WorkDir="$TMPDIR"/canu

# ---------------
# Step 2
# Run Canu
# ---------------

mkdir -p $WorkDir
cd $WorkDir
Fastq=$(basename $FastqIn)
cp $CurPath/$FastqIn $Fastq

canu \
  -correct \
  -useGrid=false \
  $AdditionalCommands \
  -overlapper=mhap \
  -utgReAlign=true \
  -d $WorkDir/assembly \
  -p $Prefix \
  genomeSize="$Size" \
  -nanopore-raw $Fastq \
  2>&1 | tee canu_run_log.txt

canu \
  -trim \
  -useGrid=false \
  $AdditionalCommands \
  -overlapper=mhap \
  -utgReAlign=true \
  -d $WorkDir/assembly \
  -p $Prefix \
  genomeSize="$Size" \
  -nanopore-corrected assembly/$Prefix.correctedReads.fasta.gz \
  2>&1 | tee canu_run_log.txt

  # canu \
  #   -correct \
  #   -useGrid=false \
  #   $AdditionalCommands \
  #   -overlapper=mhap \
  #   -utgReAlign=true \
  #   -d $WorkDir/assembly \
  #   -p $Prefix \
  #   genomeSize="$Size" \
  #   -pacbio-raw $Fastq \
  #   2>&1 | tee canu_run_log.txt
  #
  # canu \
  #   -trim \
  #   -useGrid=false \
  #   $AdditionalCommands \
  #   -overlapper=mhap \
  #   -utgReAlign=true \
  #   -d $WorkDir/assembly \
  #   -p $Prefix \
  #   genomeSize="$Size" \
  #   -pacbio-corrected assembly/$Prefix.correctedReads.fasta.gz \
  #   2>&1 | tee canu_run_log.txt

mkdir -p $CurPath/$OutDir
cp canu_run_log.txt $CurPath/$OutDir/.
cp $WorkDir/assembly/* $CurPath/$OutDir/.
```
## correction and trimming, wrapper script as primary guide
```bash


#qlogin -pe = login + parallel environment
# -l = resouce value

qlogin -pe smp 8 -l virtual_free=15.5G -l h=blacklace11.blacklace

cd ..
cd ..
cd tmp
mkdir canu_correction
cp /home/groups/harrisonlab/project_files/nano_diagnostics/raw_dna/pacbio/v.inaequalis/172/extracted/concatenated_pacbio.fastq canu_correction/

WorkDir=/tmp/canu_correction

# correct raw reads

canu -correct \
  -useGrid=false \
#why dont we want to use the grid? this will take us of the single chosen worker node? - local machine
  -overlapper=mhap \
  -utgReAlign=true \
 # -cor.report \
#gives report of the process, including no. of reads and coverage
#cor = correction
#obt = trimming
#utg = assembly, pointless for correcting and trimming steps?
#realign = Compute actual alignments from mhap overlaps. uses either obtErrorRate or ovlErrorRate, depending on which overlaps are computed)
#Two overlap algorithms are in use. One, mhap, is typically applied to raw uncorrected reads and returns alignment-free overlaps with imprecise extents. The other, the original overlapper algorithm ‘ovl’, returns alignments but is much more expensive.
#obv = bucketizing = reads the outputs of the overlap tasks (ovb files in 1-overlapper), duplicates each overlap, and writes these to intermediate files.
#ovs = sorting = Sorting tasks load these intermediate file into memory, sorts the overlaps, then writes the sorted overlaps back to disk. 
# -utgOvlMerThreshold 10 \
  -p testcorrection \
  -d canu_correction \
  genomeSize=72m \
  -pacbio-raw  canu_correction/concatenated_pacbio.fastq
  #   2>&1 | tee canu_run_log.txt?


# trim the output of the correction

canu -trim \
  -useGrid=false \
  -overlapper=mhap \
 # -obt.report \
  #default is to use ovl for trimming, why use mhap instead?
  -utgReAlign=true \
  -p scab172 \
  -d canu_correction \
  genomeSize=72m \
  -pacbio-corrected testcorrection.correctedReads.fasta.gz
  #   2>&1 | tee canu_run_log.txt?

cp -r /tmp/canu_correction /home/groups/harrisonlab/project_files/nano_diagnostics/
```
## correction and trimming, manual as primary guide
```bash
qlogin -pe smp 8 -l virtual_free=15.5G -l h=blacklace11.blacklace

cd /tmp
mkdir canu_correction2
cd canu_correction2
cp /home/groups/harrisonlab/project_files/nano_diagnostics/raw_dna/pacbio/v.inaequalis/172/extracted/concatenated_pacbio.fastq canu_correction2/

# correct raw reads

canu -correct \
  -p 172 \
  -d /tmp/canu_correction2\
  genomeSize=72m \
  -useGrid=false \
  -overlapper=mhap \
  -pacbio-raw concatenated_pacbio.fastq

# trim the output of the correction

canu -trim \
  -p 172 \
  -d canu_correction2 \
  genomeSize=72m \
  -useGrid=false \
  -overlapper=ovl \
  -pacbio-corrected 172.correctedReads.fasta.gz
echo "correct and trim complete"

cp -r /tmp/canu_correction2 /home/groups/harrisonlab/project_files/nano_diagnostics/
```

# Assembly

## assembly with manual as primary guide
```bash
qlogin -pe smp 8 -l virtual_free=15.5G -l h=blacklace11.blacklace


#default corrected error rate for nanopore is 0.144 and for pacbio is 0.045, the correctedErrorRate is overiding this

canu -assemble \
  -p 172 \
  -d canu_correction/assembly-0.039 \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.039 \
  -utgoverlapper=ovl \
  -pacbio-corrected canu_correction2/canu_correction2/172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.039.txt

  echo "assembly complete"

canu -assemble \
  -p 172 -d canu_correction/assembly-0.075 \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.075 \
  -utgoverlapper=ovl \
  -pacbio-corrected canu_correction2/canu_correction2/172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.075.txt

  echo "assembly complete"
```

## Assembly as script:
A script was created for this assembly using the wrapper of A.Armitage as a base:
```bash
#!/bin/bash

# Assemble PacBio data using Canu

#$ -S /bin/bash
#$ -cwd
#$ -pe smp 16
#$ -l virtual_free=1.9G
#$ -l h=blacklace02.blacklace|blacklace06.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace


Usage="sub_canu_correction.sh <reads.fa> <Genome_size[e.g.45m]> <outfile_prefix> <output_directory> [<specification_file.txt>]"
echo "$Usage"

# ---------------
# Step 1
# Collect inputs
# ---------------

FastaIn=$1
GenomeSize=$2
Prefix=$3
OutDir=$4
AdditionalCommands=""
if [ $5 ]; then
  SpecFile=$5
  AdditionalCommands="-s $SpecFile"
fi
echo "Running Canu with the following inputs:"
echo "Input fasta file - $FastaIn"
echo "Genome Size - $GenomeSize"
echo "Output file name - $Prefix"
echo "Output file path - $OutDir"

CurPath=$PWD
WorkDir="$TMPDIR"/canu

# ---------------
# Step 2
# Run Canu
# ---------------

mkdir -p $WorkDir
cd $WorkDir
Fasta=$(basename $FastaIn)
cp $CurPath/$FastaIn $Fasta

canu \
  -assemble \
  -d $WorkDir/assembly-0.039 \
  -p $Prefix \
  genomeSize="$GenomeSize" \
  -useGrid=false \
  correctedErrorRate=0.039 \
  -utgoverlapper=ovl \
  -pacbio-corrected $Fasta \
  $AdditionalCommands \
  2>&1 | tee canu_run_log-0.039.txt

canu \
  -assemble \
  -d $WorkDir/assembly-0.075 \
  -p $Prefix \
  genomeSize="$GenomeSize" \
  -useGrid=false \
  correctedErrorRate=0.075 \
  -utgoverlapper=ovl \
  -pacbio-corrected $Fasta \
  $AdditionalCommands \
  2>&1 | tee canu_run_log-0.075.txt

mkdir -p $CurPath/$OutDir
cp -r canu_run_log-*.txt $CurPath/$OutDir/.
cp -r $WorkDir/assembly-*/* $CurPath/$OutDir/.

echo "assembly complete"

```
This script was saved in a new directory "DIY" within tools within gitrepos.

##Script submitted:

```bash
cd /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction

chmod 764 /home/heavet/git_repos/tools/DIY/CanuPacBioAssemblert.sh

qsub /home/heavet/git_repos/tools/DIY/CanuPacBioAssemblert.sh canu_correction/scab172.trimmedReads.fasta.gz 72m wrappera22embly a22embly
```
Fails therefore,

Attempt with direct copy of AA wrapper, changing only node and cores to be used :

 #$ -S /bin/bash
 #$ -cwd
 #$ -pe smp 1
 #$ -l virtual_free=1.9G
 #$ -l h=blacklace11.blacklace

```bash
cd /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction

chmod 764 /home/heavet/git_repos/tools/DIY/CanuPacBioAssembler3.sh

qsub /home/heavet/git_repos/tools/DIY/CanuPacBioAssembler3.sh canu_correction/scab172.trimmedReads.fasta.gz 72m wrappera33embly a33embly
```
Fails therefore:
```bash
qlogin -pe smp 15 -l virtual_free=1.9G -l h=blacklace01.blacklace
mkdir canu
cd canu
Fasta=$(basename canu_correction/scab172.trimmedReads.fasta.gz)
cp /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/canu_correction/scab172.trimmedReads.fasta.gz $Fasta

canu -assemble \
 -d canu/assembly-0.039 \
 -p wrapperassembly \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.039 \
  -utgoverlapper=ovl \
  -pacbio-corrected scab172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.039.txt

mkdir -p /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/assembly
cp -r canu_run_log-*.txt /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/assembly
cp -r canu/assembly-* /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/assembly

cd ..
rm -r canu/
rm -r Canu*

echo "assembly complete"

mkdir canu
cd canu
Fasta=$(basename canu_correction/scab172.trimmedReads.fasta.gz)
cp /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/canu_correction/scab172.trimmedReads.fasta.gz $Fasta

canu -assemble \
 -d canu/assembly-0.075 \
 -p wrapperassembly \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.075 \
  -utgoverlapper=ovl \
  -pacbio-corrected scab172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.075.txt

#canu_run_log-0.039.txt accidentally overwritten with canu_run_log-0.075.txt

cp -r canu_run_log-*.txt /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/assembly
cp -r canu/assembly-* /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction/assembly

  echo "assembly complete"

  cd ..
  rm -r canu/
  ```


Asseblies for canu_correction2 missing therefore:
  ```bash
qlogin -pe smp 15 -l virtual_free=1.9G -l h=blacklace01.blacklace
mkdir canu
cd canu
Fasta=$(basename canu_correction2/canu_correction2/172.trimmedReads.fasta.gz)
cp /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/canu_correction2/172.trimmedReads.fasta.gz $Fasta

canu -assemble \
 -d canu/assembly-0.039 \
 -p manualassembly \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.039 \
  -utgoverlapper=ovl \
  -pacbio-corrected 172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.039.txt

mkdir -p /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/assembly
cp -r canu_run_log-*.txt /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/assembly
cp -r canu/assembly-* /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/assembly

cd ..
rm -r canu/
rm -r Canu*

echo "assembly complete"



#above run 08/03/2019, below not yet run

qlogin -pe smp 15 -l virtual_free=1.9G -l h=blacklace05.blacklace
mkdir canu
cd canu
Fasta=$(basename canu_correction2/canu_correction2/172.trimmedReads.fasta.gz)
cp /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/canu_correction2/172.trimmedReads.fasta.gz $Fasta

canu -assemble \
 -d canu/assembly-0.075 \
 -p manualassembly \
  genomeSize=72m \
  -useGrid=false \
  correctedErrorRate=0.075 \
  -utgoverlapper=ovl \
  -pacbio-corrected 172.trimmedReads.fasta.gz
  2>&1 | tee canu_run_log-0.075.txt

cp -r canu_run_log-*.txt /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/assembly
cp -r canu/assembly-* /home/groups/harrisonlab/project_files/nano_diagnostics/canu_correction2/assembly

cd ..
rm -r canu/
rm -r Canu*

echo "assembly complete"
  ```


  Quast was used to assess the quality of genome assemblies:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls canu_correction/assembly/assembly-0.039/wrapperassembly.contigs.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=canu_correction/assembly/assembly-0.039/Quast
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls canu_correction/assembly/assembly-0.075/wrapperassembly.contigs.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=canu_correction/assembly/assembly-0.075/Quast
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```


As an addition test of assembly quality the program busco was used:
```bash
for Assembly in $(ls canu_correction/assembly/assembly-0.039/wrapperassembly.contigs.fasta); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=canu_correction/assembly/assembly-0.039/Busco
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```
```bash
for Assembly in $(ls canu_correction/assembly/assembly-0.075/wrapperassembly.contigs.fasta); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=canu_correction/assembly/assembly-0.075/Busco
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```

# Blumeria graminis secalis
## Data collection
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
srun -p long -J kraken2 --mem 350G --pty bash

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
for file in $(ls ~/scratch/apps/kraken2/nt2/tmp123/bacteria/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db ~/scratch/apps/kraken2/nt2 2>&1 | tee -a ~/scratch/apps/kraken2/nt2/krakenbuild.log 
done
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
for assembly in $(ls /data/scratch/heavet/assembly/genome/*/*/*.mod.fna); do
kraken2-build --add-to-library $assembly --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 2.log
done

#Databse was built:
kraken2-build --build --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt
exit
exit
echo finished
```























# Phylogeny

Species phylogenetic tree using just the draft genomes (genomes that still don’t have the annotations yet).

Transfering data from NIAB hpc to Crop diversity hpc

Genomes:
```bash
Arabidopsis/    erysiphales/    hevea/          Oidium/         rubus/          Sporidiobolus/
Blumeria/       Erysiphe/       hordeum/        pisum/          Saccharomyces/  Sporobolomyces/
cucumis/        fragaria/       malus/          Podosphaera/    secale/         triticum/
cucurbita/      Golovinomyces/  nicotiana/      prunus/         solanum/        vitus/

mkdir Arabidopsis/
  mkdir thaliana
mkdir hevea/
  mkdir brasiliensis
mkdir Oidium/
  mkdir heveae/
  mkdir neolycopersicim/
mkdir rubus/
  mkdir idaeus
  mkdir occidentalis
mkdir Sporidiobolus/
  mkdir pararoseus/  
  mkdir salmonicolor/
mkdir Blumeria/
  mkdir graminis
mkdir Erysiphe/ 
  mkdir necator
  mkdir pisi
  mkdir pulchra
mkdir hordeum/ 
  mkdir vulgare
mkdir pisum/ 
  mkdir sativum       
mkdir Saccharomyces/ 
  mkdir cerevisiae
mkdir Sporobolomyces/
  mkdir roseus
mkdir cucumis/
  mkdir sativus
mkdir fragaria/  
 mkdir vesca
 mkdir ananassa
mkdir malus/
  mkdir domestica
mkdir Podosphaera/  
  mkdir cerasi
  mkdir leucotricha
  mkdir xanthii
  mkdir aphanis
mkdir secale/
  mkdir cereale
mkdir triticum/
  mkdir aestivum
mkdir cucurbita/
  mkdir pepo
mkdir Golovinomyces/ 
  mkdir cichoracearum 
  mkdir magnicellulatus
mkdir nicotiana/
  mkdir tabacum     
mkdir prunus/ 
  mkdir avium     
mkdir solanum/
  mkdir lycopersicum      
mkdir vitus/
  mkdir vinifera

scp -r /data/scratch/heavet/assembly/genome/vitus/vinifera/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/vitus/vinifera 
scp -r /data/scratch/heavet/assembly/genome/solanum/lycopersicum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/solanum/lycopersicum
scp -r /data/scratch/heavet/assembly/genome/prunus/avium/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/prunus/avium
scp -r /data/scratch/heavet/assembly/genome/nicotiana/tabacum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/nicotiana/tabacum
scp -r /data/scratch/heavet/assembly/genome/triticum/aestivum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/triticum/aestivum 
scp -r /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Saccharomyces/cerevisiae
scp -r /data/scratch/heavet/assembly/genome/pisum/sativum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/pisum/sativum 
scp -r /data/scratch/heavet/assembly/genome/hordeum/vulgare/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hordeum/vulgare
scp -r /data/scratch/heavet/assembly/genome/hevea/brasiliensis/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hevea/brasiliensis
scp -r /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Arabidopsis/thaliana 
scp -r /data/scratch/heavet/assembly/genome/fragaria/ananassa/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/ananassa 
scp -r /data/scratch/heavet/assembly/genome/fragaria/vesca/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/vesca
scp -r /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporobolomyces/roseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/pararoseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/salmonicolor
scp -r /data/scratch/heavet/assembly/genome/rubus/occidentalis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/occidentalis
scp -r /data/scratch/heavet/assembly/genome/rubus/idaeus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/idaeus 
scp -r /data/scratch/heavet/assembly/genome/Oidium/heveae/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/heveae 
scp -r /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/neolycopersicim
scp -r /data/scratch/heavet/assembly/genome/Blumeria/graminis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Blumeria/graminis
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pisi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pisi 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/necator/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/necator 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pulchra
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/cichoracearum
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/magnicellulatus
scp -r /data/scratch/heavet/assembly/genome/secale/cereale/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/secale/cereale
scp -r /data/scratch/heavet/assembly/genome/cucurbita/pepo/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucurbita/pepo
scp -r /data/scratch/heavet/assembly/genome/malus/domestica/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/malus/domestica
scp -r /data/scratch/heavet/assembly/genome/cucumis/sativus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucumis/sativus
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/xanthii/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha
```
Running BUSCO to predict conserved genes
```bash
conda activate BUSCO
for assembly in $(ls data/assembly/genome/Blumeria/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Erysiphe/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Golovinomyces/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Oidium/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Podosphaera/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Sporidiobolus/*/*c.fna); do
for assembly in $(ls data/assembly/genome/Sporobolomyces/*/*c.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2462675-2462728, 2487763-8, 2488333-2488367
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(ls data/assembly/genome/*/*/*c.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463015-2463068,2488280-2488332
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(ls data/assembly/genome/triticum/*/*c.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463069-2463122, 2487770-2487809
conda deactivate
exit
echo finished

#BUSCO has errors when using .mod.fna files due to the | symbol
while read file; do
  echo "$file"
  Out=$(echo $file|sed 's@.mod.fna@.c.fna@g')
  echo $Out
  sed 's/|kraken:taxid|/ /g' $file > $Out
done < piped.txt
```

Copying the short summary files from BUSCo run directories to another directory for getting the BUSCO plots

```bash

mkdir -p gene_pred/busco_summaries/plant
mkdir -p gene_pred/busco_summaries/ascomycota
mkdir -p gene_pred/busco_summaries/leotiomycetes
for file in $(ls gene_pred/*/*/*/BUSCO/viridiplantae_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/plant/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/ascomycota_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/ascomycota/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/leotiomycetes_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/leotiomycetes/.;
done
```
Extracting complete BUSCO genes
```bash
#Mildew BUSCOs:
for file in $(ls gene_pred/Podosphaera/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Erysiphe/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Blumeria/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Golovinomyces/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Oidium/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done

#Host BUSCOs:
for file in $(ls gene_pred/Arabidopsis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/malus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/secale/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/vitus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/fragaria/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/nicotiana/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/solanum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/prunus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucumis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hevea/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/rubus/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucurbita/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hordeum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/pisum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/triticum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
```
Filter out the complete BUSCOs that are only present less than 3 genomes

```bash
#Mildew BUSCOs:
sort analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt
awk '$NF > 2 {print $1}' analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt

#Host BUSCOs:
sort analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt
awk '$NF > 2 {print $1}' analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/host_viridiplantae_final_busco_ids.txt
```
Copy the genes (both nucleotides and amino acids) to different directory. Note that the gene names are just indetified as BUSCO id with either faa or fna extenstions. If you try to cooy them directly to a single directory, you will likely overwrite all the files and end up with only the last set of files. You can give them a unique name and then merge them all together, writing them to a single busco id file. before you do this, you will also need to edit the sequence name (fasta header) so that it includes organism identifier in it.

NOTE:.fna files containing nucleotide information will not be created by busco unless --augustus parameter is used (so far has not been).
```bash
#For pathogen; Blumeria Erysiphe Podosphaera Golovinomyces Oidium and Saccharomyces outgroup 

mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt

for dir in $(ls -d gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}  
#  done
done


#For hosts; Arabidopsis malus secale vitus fragaria nicotiana solanum prunus cucumis hevea rubus cucurbita hordeum pisum triticum

mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_aa
mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_nt

for dir in $(ls -d gene_pred/triticum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}  
#  done
done
```



Arabidopsis/     Erysiphe/        malus/           P_leucotricha/   secale/          vitus/
Blumeria/        fragaria/        nicotiana/       Podosphaera/     solanum/
busco_summaries/ Golovinomyces/   Oidium/          prunus/          Sporidiobolus/
cucumis/         hevea/           P_aphanis/       rubus/           Sporobolomyces/
cucurbita/       hordeum/         pisum/           Saccharomyces/   triticum/
