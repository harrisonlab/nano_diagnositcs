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
#fungap was downloaded:
mkdir ~/git_repos/tools/prog/fungap
cd ~/git_repos/tools/prog/fungap
git clone https://github.com/CompSynBioLab-KoreaUniv/FunGAP.git

#trinity was downloaded:
mkdir ~/git_repos/tools/prog/fungap/FunGAP/external
cd ~/git_repos/tools/prog/fungap/FunGAP/external
git clone https://github.com/trinityrnaseq/trinityrnaseq.git

#Inchworm needed to be manually installed:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq
rm -r -f Inchworm
git clone https://github.com/trinityrnaseq/Inchworm
cd Inchworm
make
#Chrysalis needed to be manually installed:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq
rm -r -f Chrysalis
git clone https://github.com/trinityrnaseq/Chrysalis
cd Chrysalis
make
# seqtk needed to be manually installed and moved into a correctly named subdirectory for the trinty installation to function:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq
cd trinity-plugins
git clone https://github.com/lh3/seqtk.git
cp -r seqtk/ seqtk-trinity
rm -r -f seqtk
cd seqtk-trinity
make
cd ..
mkdir seqtk-trinity/seqtk-trinity/
cp seqtk-trinity/* seqtk-trinity/seqtk-trinity/

#parafly needed to be manually installed:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins
tar -zxvf ParaFly-0.1.0.tar.gz
cd ParaFly-0.1.0
make

#trinity was installed:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq
make
#make moves seqtk from previous location to ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins/BIN/seqtk-trinity and will therefore not run a second time without doing the following:
#cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins
#mkdir seqtk-trinity/seqtk-trinity/
#cp seqtk-trinity/* seqtk-trinity/seqtk-trinity/
#cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins/BIN$
#rm -r seqtk-trinity/

#trinity added to PATH
nano ~/.profile
#PATH=$HOME/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq:${PATH}
. ~/.profile

#maker was downloaded:
cd ~/git_repos/tools/prog/fungap/FunGAP/external
cp /projects/oldhome/armita/prog/maker/maker-2.31.9.tgz .
tar -zxvf maker-2.31.9.tgz
cd maker/src
#maker was installed:
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

#repeatmasker was manually installed:
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

#SNAP requires manual installation:
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
#seqtk location and filename following make install are wrong for the running of trinity therefore:
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins
cp BIN/seqtk-trinity/* BIN/
cd ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/trinity-plugins/BIN
rm -r seqtk-trinity
mv seqtk seqtk-trinity

#Trinity requires jellyfish to be installed on the system:
http://www.genome.umd.edu/jellyfish.html
cd ~/git_repos/tools/prog/
mkdir jellyfish
cd jellyfish
wget https://github.com/gmarcais/Jellyfish/releases/download/v2.3.0/jellyfish-2.3.0.tar.gz
tar -zxvf jellyfish-2.3.0.tar.gz
cd jellyfish-2.3.0
./configure
make
#jellyfish added to PATH
nano ~/.profile
#PATH=$HOME/git_repos/tools/prog/jellyfish/jellyfish-2.3.0/bin:${PATH}
. ~/.profile

#Running trinity:
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

Due to the difficulties installing and running trinity a bioconda installation route was attepted instead:

```bash
cd ~/git_repos/tools/
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
#miniconda3 was installed at the location: /home/heavet/miniconda3
conda config --set auto_activate_base false
conda deactivate
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda update -n base -c defaults conda

#a new environment was created to install trinity
conda create -n trinity
conda activate trinity
conda install -c bioconda trinity

#Running trinity:
#SeqType set to fa
screen -S conda_trinity
conda activate trinity
cd /projects/nano_diagnostics/
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

Run with more ram
#!/bin/bash
#SBATCH --partition=himem
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=500G
166469
166470
illegal division by zero - error line 793

Run with all reads before alignment:
```bash
screen -S conda_trinity
conda activate trinity
#seqType changed to fq

for ReadDir in $(ls -d dna_qc/*/*/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#166471
#166472
#leads to invalid option --'R'

#seqType changed to fa
for ReadDir in $(ls -d dna_qc/*/*/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#166475  std::bad_alloc
#166476 - exceed memory (infected)

#different error -> job exceeded memory limit

for ReadDir in $(ls -d dna_qc/*/*/infected); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done

#166477
#job still exceeded memory limit with 1000GB 

#run with --min_kmer_cov 2
for ReadDir in $(ls -d dna_qc/*/*/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#166494 - still exceeded memory limit with 1000GB 
#166494 - still exceeded memory limit with 1000GB 

cat dna_qc/P_aphanis/RNAexp1/infected/F/P_aphanis-RNAexp1-infected_F_trim.fq.gz | gunzip -cf | wc -l
#88,436,408

cat dna_qc/P_aphanis/RNAexp1/infected/R/P_aphanis-RNAexp1-infected_R_trim.fq.gz | gunzip -cf | wc -l
#88,436,408

cat dna_qc/P_aphanis/RNAexp1/control/R/P_aphanis-RNAexp1-control_R_trim.fq.gz | gunzip -cf | wc -l
#79,689,604

cat dna_qc/P_aphanis/RNAexp1/control/F/P_aphanis-RNAexp1-control_F_trim.fq.gz | gunzip -cf | wc -l
#79,689,604


#run with --max_memory 1000G
#run with --min_kmer_cov 25
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity2@g')
sbatch $ProgDir/ssub_trinity2.sh $Fread $Rread $OutDir 
done
#168714 - jellyfish: error while loading shared libraries: libjellyfish-2.0.so.2: cannot open shared object file: No such file or directory
#168715 - jellyfish: error while loading shared libraries: libjellyfish-2.0.so.2: cannot open shared object file: No such file or directory


#run with --max_memory 450G
#run with --min_kmer_cov 25
#!/bin/bash
#SBATCH --partition=medium
#SBATCH --mem=450G
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity3@g')
sbatch $ProgDir/ssub_trinity3.sh $Fread $Rread $OutDir 
done
#168716 - bad alloc in jellyfish
#168717 - bad alloc in jellyfish
#terminate called after throwing an instance of 'std::bad_alloc'
#  what(): std::bad_alloc bash: line 1: 256334 Aborted /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/..//Inchworm/bin/fastaToKmerCoverageStats --reads right.fa --kmers jellyfish.K25.min2.kmers.fa
#--kmer_size 25 --num_threads 35 > right.fa.K25.stats Thread 4 terminated abnormally: Error, cmd: /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/..//Inchworm/bin/fastaToKmerCoverageStats --reads
#right.fa --kmers jellyfish.K25.min2.kmers.fa --kmer_size 25 --num_threads 35 > right.fa.K25.stats died with ret 34304 at
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl line 793. Error, thread exited with error Error, cmd:
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/..//Inchworm/bin/fastaToKmerCoverageStats --reads right.fa --kmers jellyfish.K25.min2.kmers.fa --kmer_size 25 --num_threads 35 > right.fa.K25.stats
#died with ret 34304 at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl line 793.

#Error, 1 threads errored out at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl line 997. Error, cmd:
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl --seqType fa --JM 450G --max_cov 200 --min_cov 25 --CPU 70 --output /tmp/168716/trinity_out_dir/norm_for_read_set_1
#--max_CV 10000 --SS_lib_type FR --no_cleanup --left /tmp/168716/P_aphanis-RNAexp1-control_F_trim.fq.gz --right /tmp/168716/P_aphanis-RNAexp1-control_R_trim.fq.gz --pairs_together --PARALLEL_STATS died with ret 6400 at
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 2798.
#        main::process_cmd("/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trin"...) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 3348
#        main::normalize("/tmp/168716/trinity_out_dir/norm_for_read_set_1", 200, ARRAY(0x55d6a7dd8598), ARRAY(0x55d6a7dcee70)) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 3268
#        main::run_normalization(200, ARRAY(0x55d6a7b77c28), ARRAY(0x55d6a7b77c58)) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 1351
#TERMINATING COLLECTL, PID = 255640


#use fq setting
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity3@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#168720
#CMD: seqtk-trinity seq -r -A -R 2  <(gunzip -c /tmp/168720/P_aphanis-RNAexp1-control_R_trim.fq.gz) >> right.fa
#seq: invalid option -- 'R'
#seq: invalid option -- 'R'
#[E::stk_seq] failed to open the input file/stream.
#[E::stk_seq] failed to open the input file/stream.
#Thread 2 terminated abnormally: Error, cmd: seqtk-trinity seq -r -A -R 2  <(gunzip -c /tmp/168720/P_aphanis-RNAexp1-control_R_trim.fq.gz) >> right.fa died with ret 256 at /home/heavet/git_repos/$
#Thread 1 terminated abnormally: Error, cmd: seqtk-trinity seq -A -R 1  <(gunzip -c /tmp/168720/P_aphanis-RNAexp1-control_F_trim.fq.gz) >> left.fa died with ret 256 at /home/heavet/git_repos/tool$
#Error, conversion thread failed at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl line 336.
#Error, cmd: /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read

#fq setting
#FR setting
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity3@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#238258 - jellyfish: error while loading shared libraries: libjellyfish-2.0.so.2: cannot open shared object file: No such file or directory
#238259
# jellyfish error fixed by hashing out PATH=$HOME/git_repos/tools/prog_master:${PATH} in the profile file
# changing SS_lib_type does not help

#fa setting
#FR setting
#Cpu to 10
#mem=450gb
#maxmem=350gb
# --min_kmer_cov 25 
#--bflyCalculateCPU introduced
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $Fread|sed 's@dna_qc@assembly/trancriptome/trinity3@g')
sbatch $ProgDir/ssub_trinity3.sh $Fread $Rread $OutDir 
done
#238289 - bad_alloc
#238290 - bad_alloc

#as above but with read --no_normalize_reads
#238340
#238341

PATH=$HOME/git_repos/tools/prog/fastqc/FastQC:${PATH}
PATH=$HOME/git_repos/tools/prog/STAR/STAR-2.7.3a/bin/Linux_x86_64:${PATH}
PATH=$HOME/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq:${PATH}
PATH=$HOME/git_repos/tools/prog/jellyfish/jellyfish-2.3.0/bin:${PATH}
PATH=$HOME/git_repos/tools/prog_master:${PATH}
PATH=$HOME/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/s/util:${PATH}

```

run using sample data bundled with trinity
```bash

cp -r ~/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/sample_data/ .

#!/bin/bash
#SBATCH --partition=medium
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=450G
#maxmem=350gb
#seqtype=fa
for ReadDir in $(ls -d sample_data/test_Trinity_Assembly/); do
 Fread=$(ls $ReadDir*2.left.fq.gz)
 Rread=$(ls $ReadDir*2.right.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo assembly/trancriptome/trinity/testdata1)
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309643
#10725 lines
#Illegal division by zero at
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/..//util/support_scripts//nbkc_normalize.pl line 116. Error, cmd:
#/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/..//util/support_scripts//nbkc_normalize.pl --stats_file pairs.K25.stats --max_cov 200 --min_cov 1 --max_CV
#10000 > pairs.K25.stats.C200.maxCV10000.accs died with ret 65280 at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl line 793.
#Error, cmd: /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/util/insilico_read_normalization.pl --seqType fa --JM 350G --max_cov 200 --min_cov 1 --CPU 10 --output
#/tmp/309643/trinity_out_dir/insilico_read_normalization --max_CV 10000 --SS_lib_type FR --left /tmp/309643/reads2.left.fq.gz --right /tmp/309643/reads2.right.fq.gz --pairs_together
#--PARALLEL_STATS died with ret 512 at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 2798.
#        main::process_cmd("/home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trin"...) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 3348
#        main::normalize("/tmp/309643/trinity_out_dir/insilico_read_normalization", 200, ARRAY(0x5636bf06ffc8), ARRAY(0x5636bf06ffb0)) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/ex$
#        main::run_normalization(200, ARRAY(0x5636bf06ffc8), ARRAY(0x5636bf06ffb0)) called at /home/heavet/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/Trinity line 1351



for ReadDir in $(ls -d sample_data/test_Trinity_Assembly/); do
 Fread=$(ls $ReadDir*.left.fa.gz)
 Rread=$(ls $ReadDir*.right.fa.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo assembly/trancriptome/trinity/testdata2)
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309644
#successfull

#seqtype=fq
for ReadDir in $(ls -d sample_data/test_Trinity_Assembly/); do
 Fread=$(ls $ReadDir*2.left.fq.gz)
 Rread=$(ls $ReadDir*2.right.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo assembly/trancriptome/trinity/testdata3)
sbatch $ProgDir/ssub_trinity2.sh $Fread $Rread $OutDir 
done
#309642
#invalid option -- 'R'

gunzip -c sample_data/test_Trinity_Assembly/reads2.left.fq.gz | paste - - - -  | cut -f 1,2 | sed 's/^/>/'  | tr "\t" "\n" > sample_data/test_Trinity_Assembly/reads2.left.fa
gunzip -c sample_data/test_Trinity_Assembly/reads2.right.fq.gz | paste - - - -  | cut -f 1,2 | sed 's/^/>/'  | tr "\t" "\n" > sample_data/test_Trinity_Assembly/reads2.right.fa

for ReadDir in $(ls -d sample_data/test_Trinity_Assembly/); do
 Fread=$(ls $ReadDir*.left.fa)
 Rread=$(ls $ReadDir*.right.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo assembly/trancriptome/trinity/testdata4)
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309669
#error failed

gunzip -c sample_data/test_Trinity_Assembly/reads2.left.fq.gz > sample_data/test_Trinity_Assembly/reads2.left.fq
gunzip -c sample_data/test_Trinity_Assembly/reads2.right.fq.gz > sample_data/test_Trinity_Assembly/reads2.right.fq

sed -n '1~4s/^@/>/p;2~4p' sample_data/test_Trinity_Assembly/reads2.left.fq > sample_data/test_Trinity_Assembly/reads2.2.left.fa
sed -n '1~4s/^@/>/p;2~4p' sample_data/test_Trinity_Assembly/reads2.right.fq > sample_data/test_Trinity_Assembly/reads2.2.right.fa

for ReadDir in $(ls -d sample_data/test_Trinity_Assembly/); do
 Fread=$(ls $ReadDir*2.2.left.fa)
 Rread=$(ls $ReadDir*2.2.right.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo assembly/trancriptome/trinity/testdata4)
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309670
#Successful!
```

Run converting data to fa.
```bash
gunzip -c sample_data/test_Trinity_Assembly/reads2.left.fq.gz > sample_data/test_Trinity_Assembly/reads2.left.fq
gunzip -c sample_data/test_Trinity_Assembly/reads2.right.fq.gz > sample_data/test_Trinity_Assembly/reads2.right.fq

sed -n '1~4s/^@/>/p;2~4p' sample_data/test_Trinity_Assembly/reads2.left.fq > sample_data/test_Trinity_Assembly/reads2.2.left.fa
sed -n '1~4s/^@/>/p;2~4p' sample_data/test_Trinity_Assembly/reads2.right.fq > sample_data/test_Trinity_Assembly/reads2.2.right.fa

#Files were uncompressed
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
gunzip -c $Fread > $(echo $Fread|sed 's@fq.gz@fastq@g')
gunzip -c $Rread > $(echo $Rread|sed 's@fq.gz@fastq@g')
done

#Files were converted to fa format
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fastq)
 Rread=$(ls $ReadDir/R/*trim.fastq)
ls $Fread
ls $Rread
sed -n '1~4s/^@/>/p;2~4p' $Fread > $(echo $Fread|sed 's@fastq@fa@g')
sed -n '1~4s/^@/>/p;2~4p' $Rread > $(echo $Rread|sed 's@fastq@fa@g')
done

#Trinity de novo transcriptome assembly was run
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fa)
 Rread=$(ls $ReadDir/R/*trim.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir|sed 's@dna_qc@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309671 - control (medium partion)
#309674 - infected (long partion)

#for unaligned reads
for Unaligned in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*/); do
 Fread=$(ls $Unaligned*.mate1)
 Rread=$(ls $Unaligned*.mate2)
ls $Fread
ls $Rread
sed -n '1~4s/^@/>/p;2~4p' $Fread > $(echo $Fread|sed 's@mate1@.F.fa@g')
sed -n '1~4s/^@/>/p;2~4p' $Rread > $(echo $Rread|sed 's@mate2@.R.fa@g')
done

for ReadDir in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/*.F.fa)
 Rread=$(ls $ReadDir/*.R.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir/unaligned|sed 's@alignment/STAR@assembly/trancriptome/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir 
done
#309675 - control (himem)
#309676 - infected (himem)
```

different node - himem + medium
fq vs. fa

seperate in silico normalization
```bash
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(dirname $Fread|sed 's@F@normalized@g')
echo $OutDir "= output directory"
sbatch $ProgDir/ssub_trinityinsilico.sh $Fread $Rread $OutDir 
done
#nano ~/.profile
#PATH=$HOME/git_repos/tools/prog/fungap/FunGAP/external/trinityrnaseq/s/util:${PATH}
#. ~/.profile

#176185 - Error, cannot mkdir /tmp/176185/dna_qc/P_aphanis/RNAexp1/control/normalized/P_aphanis-RNAexp1-control_normalized_trim.fq.gz at /home/heavet/miniconda3/envs/trinity/bin/insilico_read_normalization.pl line 282.
#176186 - Error, cannot mkdir /tmp/176185/dna_qc/P_aphanis/RNAexp1/control/normalized/P_aphanis-RNAexp1-control_normalized_trim.fq.gz at /home/heavet/miniconda3/envs/trinity/bin/insilico_read_normalization.pl line 282.
#238333
#238334

#238338
#238339

#238349
#238350
```

HOME/git_repos/tools/prog/jellyfish/jellyfish-2.3.0/bin/