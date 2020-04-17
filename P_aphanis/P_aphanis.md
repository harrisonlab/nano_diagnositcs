# P.aphanis transcriptome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis as part of Nano Diagnistics PhD.

## Collecting raw RNASeq data

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

## Quality controlling RNASeq data

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
The number of reads were counted
```bash
cat dna_qc/P_aphanis/RNAexp1/infected/F/P_aphanis-RNAexp1-infected_F_trim.fq.gz | gunzip -cf | wc -l
#88,436,408

cat dna_qc/P_aphanis/RNAexp1/infected/R/P_aphanis-RNAexp1-infected_R_trim.fq.gz | gunzip -cf | wc -l
#88,436,408

cat dna_qc/P_aphanis/RNAexp1/control/R/P_aphanis-RNAexp1-control_R_trim.fq.gz | gunzip -cf | wc -l
#79,689,604

cat dna_qc/P_aphanis/RNAexp1/control/F/P_aphanis-RNAexp1-control_F_trim.fq.gz | gunzip -cf | wc -l
#79,689,604
```

## Alignment

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
### STAR

The programme Star was installed for fast RNAseq data alignment

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
. ~/.profile
```

A new STAR wrapper script was created based upon script from A.Armitage 

The trimmed reads were aligned to genome of F.ananassa 'camarosa' using STAR, annotations were used to extract splice junctions and improve the accuracy of mapping.

The STAR wrapper script was changed to save unaligned read information and to accept .gff annotation files using the following settings: --sjdbGTFtagExonParentTranscript Parent, --sjdbOverhang 149, --outReadsUnmapped Fastx, --outSAMunmapped Within

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
## Transcriptome Assembly

### Trinity

The first method tried to generate a denovo P.aphanis transcriptome was using the assembler trinity.

Due to the difficulties installing and running trinity a bioconda installation route was used:

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
```
Trinity runs with sample data demonstrated that using .fq files was resulting in erros. Quality controlled reads were therefore converted from .fq to .fa
```bash
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
```
Reads that did not align to the strawberry genome were also converted to .fa
```bash
#for unaligned reads
for Unaligned in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*/); do
 Fread=$(ls $Unaligned*.mate1)
 Rread=$(ls $Unaligned*.mate2)
ls $Fread
ls $Rread
sed -n '1~4s/^@/>/p;2~4p' $Fread > $(echo $Fread|sed 's@mate1@.F.fa@g')
sed -n '1~4s/^@/>/p;2~4p' $Rread > $(echo $Rread|sed 's@mate2@.R.fa@g')
done
```
De novo transcriptome assembly was performed for combined quality controlled reads and unaligned reads. Trinity can be memory intensive, the settings used for these runs were as follows; #SBATCH --partition=long, #SBATCH --nodes=1, #SBATCH --ntasks=1, #SBATCH --cpus-per-task=10, #SBATCH --mem=450G,  --CPU 10 \,  --max_memory 350G \,  --seqType fa \,  --SS_lib_type FR \,  --left $InReadF \,  --right $InReadR 

The following were not used here but may help reduce memory requirements; --min_kmer_cov 2, --bflyCalculateCPU
More details at; http://trinityrnaseq.github.io/performance/mem.html and https://github.com/trinityrnaseq/trinityrnaseq/wiki
```bash
#a trinity innstance of bioconda was opened
screen -S conda_trinity
conda activate trinity
#Trinity de novo transcriptome assembly was run for all quality controlled reads
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

#Trinity de novo transcriptome assembly was run for unnmapped reads
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

# From here on pipeline is a work in progress

The software rnaQUAST for quality evaluation and assessment of de novo transcriptome assemblies was installed.

```bash
#a new environment was created to install rnaQUAST
conda create -n rnaquast
conda activate rnaquast
conda install -c bioconda rnaquast
python rnaQUAST.py --test #failed therefore manual install pursued

#ranQUAST was installed
mkdir -p ~/git_repos/tools/prog/rnaQUAST
cd ~/git_repos/tools/prog/rnaQUAST
wget http://cab.spbu.ru/files/rnaquast/release2.0.1/rnaQUAST-2.0.1.tar.gz
tar -xzf rnaQUAST-2.0.1.tar.gz
cd rnaQUAST-2.0.1
chmod 777 rnaQUAST.py
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1:${PATH}
. ~/.profile
python rnaQUAST.py --test
#rnaQUAST requires the following to run; Python, gffutils, matplotlib and joblib. Also either GMAP or BLAT and BLASTN added to the $PATH variable.
#test indicated some of these were not yet installed
#required programmes were installed;
python -m pip install -U pip
python -m pip install -U matplotlib
python -m pip install -U joblib
python -m pip install -U gffutils

mkdir -p ~/git_repos/tools/prog/GMAP
cd ~/git_repos/tools/prog/GMAP
wget http://research-pub.gene.com/gmap/src/gmap-gsnap-2020-03-12.tar.gz
tar -xzf gmap-gsnap-2020-03-12.tar.gz
cd gmap-2020-03-12
./configure
make
make install
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/GMAP/gmap-2020-03-12/src:${PATH}
#PATH=$HOME/git_repos/tools/prog/GMAP/gmap-2020-03-12/util:${PATH}
. ~/.profile

conda activate rnaquast
conda install -c bioconda gmap

mkdir -p ~/git_repos/tools/prog/blast
cd ~/git_repos/tools/prog/blast
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz
tar -zxvf ncbi-blast-2.10.0+-x64-linux.tar.gz
cd ncbi-blast-2.10.0+/
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/blast/ncbi-blast-2.10.0+/bin:${PATH}
. ~/.profile

python rnaQUAST.py --test #test is now successful

#When a reference genome is unavailable it is recommended to run rnaQUAST with BUSCO and GeneMarkS-T options. This requires GeneMarkS-T, BUSCO, tblastn, HMMER and transeq to be installed and added to the $PATH variable;

conda activate rnaquast
conda install busco # failed
conda install -c bioconda -c conda-forge busco=3.0.2 python=2.7.13 #failed

mkdir ~/git_repos/tools/prog/busco
  cd ~/git_repos/tools/prog/busco
  wget https://gitlab.com/ezlab/busco/-/archive/3.0.2/busco-3.0.2.tar.gz
 # wget https://gitlab.com/ezlab/busco/-/archive/4.0.0/busco-4.0.0.tar.gz
  tar -zxvf busco-3.0.2.tar.gz
  cd busco-3.0.2
  export PYTHONPATH="/home/heavet/.local/lib/python3.5/site-packages"
  python setup.py install --user
  nano ~/.profile
  #edited with:
  #PATH=$HOME/git_repos/tools/prog/busco/busco-3.0.2/scripts:${PATH}
  . ~/.profile

ls /projects/oldhome/armita/prog/
cp -r -n /projects/oldhome/armita/prog/ ~/git_repos/tools/prog/
  nano ~/.profile
  #edited with:
  #PATH=$HOME/git_repos/tools/prog/blast/ncbi-blast-2.2.31+/bin:${PATH}
  #PATH=$HOME/git_repos/tools/prog/hmmer/hmmer_3.1/hmmer-3.1b2-linux-intel-x86_64/binaries:${PATH}
  #PATH=$HOME/git_repos/tools/prog/emboss/EMBOSS-4.0.0/bin:${PATH}
  . ~/.profile

nano ~/git_repos/tools/prog/busco/busco-3.0.2/config/config.ini.default
#Edited to contain:
#[tblastn]
#path = /home/heavet/git_repos/prog/blast/ncbi-blast-2.2.31+/bin
#command = tblastn

#[makeblastdb]
#path = /home/heavet/git_repos/prog/blast/ncbi-blast-2.2.31+/bin            
#command = makeblastdb

#[augustus]
#path = /home/heavet/git_repos/prog/augustus-3.1/bin         
#command = augustus

#[etraining]
#path = /home/heavet/git_repos/prog/augustus-3.1/bin         
#command = etraining

#[gff2gbSmallDNA.pl]
#path = /home/heavet/git_repos/prog/augustus-3.1/scripts     
#command = gff2gbSmallDNA.pl

#[new_species.pl]
#path = /home/heavet/git_repos/prog/augustus-3.1/scripts   
#command = new_species.pl

#[optimize_augustus.pl]
#path = /home/heavet/git_repos/prog/augustus-3.1/scripts   
#command = optimize_augustus.pl

#[hmmsearch]
#path = /home/heavet/git_repos/prog/hmmer/hmmer_3.1/hmmer-3.1b2-linux-intel-x86_64/binaries          
#command = hmmsearch

#[prodigal]
#path = /home/heavet/git_repos/prog/prodigal
#command = prodigal

export BUSCO_CONFIG_FILE=/home/heavet/git_repos/tools/prog/busco/busco-3.0.2/config/config.ini

mkdir -p ~/git_repos/tools/prog/genemark/2020
  cd ~/git_repos/tools/prog/genemark/2020
  wget http://topaz.gatech.edu/GeneMark/tmp/GMtool__soAM/gmst_linux_64.tar.gz
  tar -zxvf gmst_linux_64.tar.gz
  wget http://topaz.gatech.edu/GeneMark/tmp/GMtool__soAM/gm_key_64.gz
  gunzip gm_key_64.gz
  cp ~/git_repos/tools/prog/genemark/2020/gm_key_64 ~/.gm_key
  nano ~/.profile
  #edited with:
  #PATH=$HOME/git_repos/tools/prog/genemark/2020:${PATH}
  . ~/.profile
```

Quast was used to assess the quality of genome assembly:
```bash
  ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    for Assembly in $(ls assembly/spades/*/*/filtered_contigs/contigs_min_500bp.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/spades/$Organism/$Strain/filtered_contigs
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
  done
```
The results of quast were desplayed:
```bash
  for Assembly in $(ls assembly/spades/*/*/filtered_contigs/report.txt); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev);
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev);
    echo;
    echo $Organism;
    echo $Strain;
    cat $Assembly;
  done > assembly/quast_results.txt
```

The podosphaera xanthii transcriptome was downloaded - assembled using MIRA3 & euler by D.Corsia
```bash
mkdir -p rawdata/P_xanthii/D_CorsiaExp/transcriptome/

srun -p long --pty bash

cd rawdata/P_xanthii/D_CorsiaExp/transcriptome/

wget https://sra-download.ncbi.nlm.nih.gov/traces/wgs03/wgs_aux/GE/UO/GEUO01/GEUO01.1.gbff.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/wgs03/wgs_aux/GE/UO/GEUO01/GEUO01.1.fsa_nt.gz

gunzip GEUO01.1.fsa_nt.gz # fasta file

gunzip GEUO01.1.gbff.gz #Genebank file
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
```bash
#a new environment was created to install MIRA
conda create -n MIRA
conda activate MIRA
conda install -c bioconda mira
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



A partial genome assembly for P.aphanis genertaed by H.Cockerton was collected.

```bash
mkdir -p /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/

cp -s -r /projects/oldhome/groups/harrisonlab/project_files/podosphaera/assembly/spades/P.aphanis/ /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/

ls /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta
```
STAR was used to align trimmed reads that did not align to F.ananassa to the P.aphanis genome

```bash
for ReadDir in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/*.F.fa)
 Rread=$(ls $ReadDir/*.R.fa)
ls $Fread
ls $Rread
InGenome=assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta 
#InGff=
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir/P_aphanis)
sbatch $ProgDir/ssub_star.sh $InGenome $Fread $Rread $OutDir
done
#318140
#318141
```