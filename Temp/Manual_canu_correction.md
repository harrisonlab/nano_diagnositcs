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
  -d assembly-0.039 \
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