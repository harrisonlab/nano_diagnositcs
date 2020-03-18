Documentation of analysis and commands used with P.aphanis as part of Nano Diagnistics PhD.

A subfolder for strawberry mildew work was created:
```bash
mkdir P_aphanis
```
All following commands were exectuted from this folder.

Raw sequence data was copied from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_aphanis/RNAexp1/infected/F
mkdir -p rawdata/P_aphanis/RNAexp1/infected/R
mkdir -p rawdata/P_aphanis/RNAexp1/control/F
mkdir -p rawdata/P_aphanis/RNAexp1/control/R

cp -s /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008508_1.fq.gz rawdata/P_aphanis/RNAexp1/infected/F

cp -s /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008508_2.fq.gz rawdata/P_aphanis/RNAexp1/infected/R

cp -s /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008509_1.fq.gz rawdata/P_aphanis/RNAexp1/control/F

cp -s /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/X204SC19122617-Z01-F001/raw_data/s30008509_2.fq.gz rawdata/P_aphanis/RNAexp1/control/R

```

Fastqc was installed:

```bash
mkdir -p ~/git_repos/tools/prog/fastqc
cd ~/git_repos/tools/prog/fastqc
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
unzip fastqc_v0.11.9.zip
cd FastQC
chmod +x fastqc

nano ~/.profile
#edited with:
## set PATH and other variables so it includes user's local settings
#if [ -f "$HOME/.profile2" ] ; then
#    . "$HOME/.profile2"
#fi
## Prepend exectutable locations to PATH
#PATH=$HOME/git_repos/tools/prog/fastqc/FastQC:${PATH}

. ~/.profile
```

A new fastqc wrapper script was created based upon script from A.Armitage

The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/*/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir
done
```

A new trimmomatic wrapper script was created based upon script from A.Armitage 

Raw sequence reads were trimmed using trimmomatic

```bash
for ReadDir in $(ls -d rawdata/*/*/*); do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5 -d '/' --output-delimiter '-')
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
```
The trimmed reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls dna_qc/*/*/*/*/*trim.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir
done
```

## 06.1 STAR
Star is used for fast RNAseq data alignment
```bash
mkdir -p ~/git_repos/tools/prog/STAR
cd ~/git_repos/tools/prog/STAR
# Get latest STAR source from releases
wget https://github.com/alexdobin/STAR/archive/2.7.3a.tar.gz
tar -xzf 2.7.3a.tar.gz
cd STAR-2.7.3a
#compile
cd source
make STAR
chmod +x STAR

nano ~/.profile
#star added to PATH
#PATH=$HOME/git_repos/tools/prog/STAR/STAR-2.7.3a/bin/Linux_x86_64:${PATH}
```
A new STAR wrapper script was created based upon script from A.Armitage 

The trimmed reads were aligned to genome of F.ananassa 'camarosa' using STAR, in this run unmapped reads were not kept. Annotated transcripts in hte .gtf format for the reference genome are highly recommended for calulating splicing by STAR (the InGff input) -> I have yet to find these for strawberry

```bash
mkdir -p rawdata/F_ananassa/camarosa/genome

cp -s /home/hejoe/Data/Everbearer/Raw/F_ana_Camarosa_6-28-17_hardmasked.fasta rawdata/F_ananassa/camarosa/genome

for ReadDir in $(ls -d dna_qc/*/*/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
InGenome=rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17_hardmasked.fasta
#InGff=
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir|sed 's@dna_qc@alignment/STAR/alignedonly@g')
#sjdbOverhang changed to 149 (read length -1)
sbatch $ProgDir/ssub_star.sh $InGenome $Fread $Rread $OutDir 
done
```

The most up to date version of the camarosa genome was downloaded as well as annotation information.

```bash
srun -p long --pty bash

cd /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome

wget ftp://ftp.bioinfo.wsu.edu/species/Fragia_x_ananassa/Fragaria_x_ananassa_Camarosa_Genome_v1.0.a1/assembly/F_ana_Camarosa_6-28-1fasta.gz

gunzip F_ana_Camarosa_6-28-17.fasta.gz

mkdir -p /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/annotations

cd /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/annotations

wget ftp://ftp.bioinfo.wsu.edu/species/Fragaria_x_ananassa/Fragaria_x_ananassa_Camarosa_Genome_v1.0.a1/genes/Fxa_v1.2_makerStandard_MakerGenes_woTposases.gff.gz

gunzip Fxa_v1.2_makerStandard_MakerGenes_woTposases.gff.gz
```

Settings in the STAR script were changed to save unaligned read information and to accept .gff annotation files:
--sjdbGTFtagExonParentTranscript Parent
--sjdbOverhang 149
--outReadsUnmapped Fastx 
--outSAMunmapped Within

Trimmed reads were aligned to the F.ananassa 'Camarosa' genome, annotations were used to extract splice junctions and improve the accuracy of mapping.

```bash
for ReadDir in $(ls -d dna_qc/*/*/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
InGenome=rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta 
InGff=rawdata/F_ananassa/camarosa/annotations/Fxa_v1.2_makerStandard_MakerGenes_woTposases.gff
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir|sed 's@dna_qc@alignment/STAR@g')
sbatch $ProgDir/ssub_star.sh $InGenome $Fread $Rread $OutDir $InGff
done
```

The fungal gene prediction software FunGAP was installed along with the transcriptome assembler trinity and gene prediction software MAKER :

```bash
mkdir ~/git_repos/tools/prog/fungap
cd ~/git_repos/tools/prog/fungap
git clone https://github.com/CompSynBioLab-KoreaUniv/FunGAP.git

mkdir ~/git_repos/tools/prog/fungap/FunGAP/external
cd ~/git_repos/tools/prog/fungap/FunGAP/external
git clone https://github.com/trinityrnaseq/trinityrnaseq.git
cd trinityrnaseq
make
#Using gnu compiler for Inchworm and Chrysalis
#cd Inchworm && make
#make[1]: Entering directory '/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Inchworm'
#make[1]: *** No targets specified and no makefile found.  Stop.
#make[1]: Leaving directory '/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Inchworm'
#Makefile:28: recipe for target 'inchworm_target' failed
#make: *** [inchworm_target] Error 2

nano ~/.profile
#trinity added to PATH
#PATH=$HOME/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq:${PATH}
. ~/.profile

cd ~/git_repos/tools/prog/fungap/FunGAP/external
cp /projects/oldhome/armita/prog/maker/maker-2.31.9.tgz .
tar -zxvf maker-2.31.9.tgz
cd maker/src
perl Build.PL
./Build installdeps
./Build installexes
./Build install
./Build status
#PERL Dependencies:      VERIFIED
#External Programs:      MISSING
#                  !  RepeatMasker
#                  !  SNAP
#
#External C Libraries:   VERIFIED
#MPI SUPPORT:            DISABLED
#MWAS Web Interface:     DISABLED
#MAKER PACKAGE:          MISSING PREREQUISITES


mkdir -p ~/git_repos/tools/prog/fungap/FunGAP/external/maker/exe/RepeatMasker
cd ~/git_repos/tools/prog/fungap/FunGAP/external/maker/exe/RepeatMasker
# The repeatmasker database was downloaded locally and transferred to the cluster
# from: http://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20170127.tar.gz
# above was not done
wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-2.0.1.tar.gz
wget http://www.repeatmasker.org/RepeatMasker-4.1.0.tar.gz

cd ~/git_repos/tools/prog/fungap/FunGAP/external
wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-2.0.1.tar.gz
tar -zxvf RepeatModeler-2.0.1.tar.gz
cd RepeatModeler-2.0.1/
perl ./configure
# The following perl modules required by RepeatModeler are missing from
#your system.  Please install these first:
#    JSON
#    File::Which
```

A wrapper script for running trinity for denovo transcriptome assembly was created.

```bash
#!/bin/bash
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=50G
. ~/.profile
# Assemble de novo transcriptome using trinity
Usage="ssub_trinity.sh InReadF.fq.gz InReadR.fq.gz Output_directory"
echo $Usage
# ---------------
# Step 1
# Collect inputs
# ---------------
InReadF=$(basename $1)
InReadR=$(basename $2)
OutDir=$3
# Set working directory
CurDir=$PWD
WorkDir=/tmp/${SLURM_JOB_ID}
#WorkDir=/mnt/beegfs/scratch/$USER/${SLURM_JOB_ID}_star
GenomeDir=$WorkDir/index
mkdir -p $GenomeDir
# Copy over input files
cd $WorkDir
cp $CurDir/$1 $InReadF
cp $CurDir/$2 $InReadR
# ---------------
# Step 2
# Run trinity
# ---------------
echo "Assembling transcriptome"
 Trinity \
 --CPU 6 \
 --max_memory 50G \
 --seqType fq \
 --SS_lib_type FR \
 --left $InReadF \
 --right $InReadR 

rm $InReadF
rm $InReadR
mkdir -p $CurDir/$OutDir
cp -r $WorkDir/* $CurDir/$OutDir/.
rm -r $WorkDir
exit
```

A denovo transcriptome assebly was performed using trinity for the unaligned reads from the control and infected sample.

```bash
for Unaligned in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*/); do
 Fread=$(ls $Unaligned*.mate1)
 Rread=$(ls $Unaligned*.mate2)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Unaligned|sed 's@alignment/STAR@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
```
