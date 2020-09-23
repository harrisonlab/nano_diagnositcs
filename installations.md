# Installations

Documenting the process of downloading and installing programmes within project pipelines was over complicating pipelines therefore installations are now documented here.

##Bioconda
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
```

##samtools
```bash
conda create -n samtools
conda activate samtools
conda install -c bioconda samtools
conda install -c conda-forge openssl=1.0.2p=h14c3975_1002
#version 1.7 only, therefore:

mkdir -p ~/git_repos/tools/prog/samtools
cd ~/git_repos/tools/prog/samtools
wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
tar -jxvf samtools-1.10.tar.bz2
cd samtools-1.10
./configure --prefix=/home/heavet/git_repos/tools/prog/samtools/current
make
make install

cd ~/git_repos/tools/prog/samtools
git clone git://github.com/samtools/htslib.git
git clone git://github.com/samtools/bcftools.git
cd bcftools
make

nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/samtools/samtools-1.10:${PATH}
. ~/.profile
```
##FastQC
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
## kat
```bash
conda create -n kat
conda activate kat
conda install kat
conda install -c anaconda python
```
##SPAdes
```
conda create -n spades
conda activate spades
conda install -c bioconda spades
```
##ATLAS
```bash
conda create -n ATLAS
conda activate ATLAS
conda install metagenome-atlas
conda install mamba
```
##bowtie2
```bash
conda create -n bowtie2
conda activate bowtie2
conda install -c bioconda bowtie2
```
##rnaQUAST
```bash
#a new environment was created to install rnaQUAST
conda create -n rnaquast
conda activate rnaquast
conda install -c bioconda rnaquast
python rnaQUAST.py --test #failed therefore manual install pursued
conda deactivate

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
python rnaQUAST.py --test #test is now successful

#retry conda test from this directory
conda activate rnaquast
python rnaQUAST.py --test #still fails, python version inside conda is different from outside therefore:
python -m pip install -U pip
python -m pip install -U matplotlib
python -m pip install -U joblib
python -m pip install -U gffutils
python rnaQUAST.py --test # conda test now successful also

conda install -c conda-forge pympler
```
retry RNAquast conda install:


conda config --set allow_conda_downgrades true
conda install conda=4.6.14


```bash
conda create --name rnaquast2 -c bioconda rnaquast
```






RNAquast - Transcriptome validation
  conda create --name rnaquast -c bioconda rnaquast
  conda activate rnaquast
Install dependancy Genemark E/S
mkdir -p ~/prog/genemark
cd ~/prog/genemark
wget http://topaz.gatech.edu/GeneMark/tmp/GMtool_fwRQI/gmst_linux_64.tar.gz
tar -zxvf gmst_linux_64.tar.gz
./gmst.pl test.fa
# wget http://topaz.gatech.edu/GeneMark/tmp/GMtool_fwRQI/gm_key_64.gz
Add genemarkES to your PATH:
PATH=$HOME/prog/genemark:${PATH} (edited) 
16:26
^ my install instructions so far for the greenwich cluster
16:27
i am getting an error with gmap - i will post instructions when i get it sorted
16:28
rnaQUAST.py --test
...lots of output output... 
2020-05-05 16:23:07
Creating genome index by gmap_build...
  logs can be found in /mnt/beegfs/home/aa0377h/progs/anaconda2/envs/rnaquast/bin/rnaQUAST_test_output/logs/gmap_build.out.log and /mnt/beegfs/home/aa0377h/progs/anaconda2/envs/rnaquast/bin/rnaQUAST_test_output/logs/gmap_build.err.log.
ERROR! gmap_build failed!
In case you have troubles running rnaQUAST, you can write to rnaquast_support@ablab.spbau.ru
Please provide us with rnaQUAST.log file from the output directory.

```bash
. ~/.profile
rnaQUAST.py --test
```
Correct a gmap build error with a bad perl shebang
```bash
which gmap_build
# ~/progs/anaconda2/envs/rnaquast/bin/gmap_build
which perl
# ~/progs/anaconda2/envs/rnaquast/bin/perl
echo $HOME
for File in $(ls -p /mnt/beegfs/home/aa0377h/progs/anaconda2/envs/rnaquast/bin/*); do
  # echo $File;
  if head -n5 $File | grep -q "/opt/conda/conda-bld/gmap_1530905053430/_build_env/bin/perl"; then
    echo $File
    echo "replacing shebang"
    sed -i "s@/opt/conda/conda-bld/gmap_1530905053430/_build_env/bin/perl@/mnt/beegfs/home/aa0377h/progs/anaconda2/envs/rnaquast/bin/perl@g" $File
  fi
done
```
^ you will need to change the '/mnt/beegfs/home/aa0377h/progs/anaconda2/envs/rnaquast/bin/perl' to your $HOME and conda-installed perl location - run after doing conda activate to have the conda perl location in your path
17:11
aha, my tblastn isnt using the conda install
17:12
## Install Blast
A local install of BLAST >2.8.1 was installed, which has a bug fix for widely reported "feature"/bug where the first blast hit, rather than the top blast hit was reported.
```bash
mkdir ~/prog/blast
cd ~/prog/blast
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz
tar -zxvf ncbi-blast-2.10.0+-x64-linux.tar.gz
```
prepend this to your ~/.profile









```
##GMAP
```bash
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
```
##Blast
```bash
mkdir -p ~/git_repos/tools/prog/blast
cd ~/git_repos/tools/prog/blast
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz
tar -zxvf ncbi-blast-2.10.0+-x64-linux.tar.gz
cd ncbi-blast-2.10.0+/
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/blast/ncbi-blast-2.10.0+/bin:${PATH}
. ~/.profile

conda activate rnaquast 
conda install blast
```
##BUSCO 
```bash
#BUSCO innstallation:
conda create -n oldBUSCO
conda activate oldBUSCO
conda install -c bioconda -c conda-forge busco=1.2.0

#BUSCO innstallation:
conda create -n BUSCO
conda activate BUSCO
conda install -c bioconda -c conda-forge busco=4.0.6

#BUSCO installation to work with RNAquast:
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

#The config file needs to be edited to the following, obviously these programmes must be installed; blast, augustus, hmmer, prodigal

nano ~/git_repos/tools/prog/busco/busco-3.0.2/config/config.ini.default
#Edited to contain:

#[tblastn]
#path = /home/heavet/git_repos/tools/prog/blast/ncbi-blast-2.2.31+/bin
#command = tblastn

#[makeblastdb]
#path = /home/heavet/git_repos/tools/prog/blast/ncbi-blast-2.2.31+/bin            
#command = makeblastdb

#[augustus]
#path = /home/heavet/git_repos/tools/prog/augustus-3.1/bin         
#command = augustus

#[etraining]
#path = /home/heavet/git_repos/tools/prog/augustus-3.1/bin         
#command = etraining

#[gff2gbSmallDNA.pl]
#path = /home/heavet/git_repos/tools/prog/augustus-3.1/scripts     
#command = gff2gbSmallDNA.pl

#[new_species.pl]
#path = /home/heavet/git_repos/tools/prog/augustus-3.1/scripts   
#command = new_species.pl

#[optimize_augustus.pl]
#path = /home/heavet/git_repos/tools/prog/augustus-3.1/scripts   
#command = optimize_augustus.pl

#[hmmsearch]
#path = home/heavet/git_repos/tools/prog/hmmer/hmmer-3.3/src          
#command = hmmsearch

#[prodigal]
#path = /home/heavet/git_repos/tools/prog/prodigal
#command = prodigal

export BUSCO_CONFIG_FILE=/home/heavet/git_repos/tools/prog/busco/busco-3.0.2/config/config.ini

conda activate rnaquast 
conda install busco
```
##Genewise
```bash
#still does not install correctly


mkdir ~/git_repos/tools/prog/genewise
cd ~/git_repos/tools/prog/genewise
wget http://ftp-stud.hs-esslingen.de/ubuntu/pool/universe/w/wise/wise_2.4.1.orig.tar.gz
tar -zxvf wise_2.4.1.orig.tar.gz
cd wise-2.4.1/src
nano makefile
# edit to change line reading 'CC = cc' to 'CC = gcc'
#CFLAGS = -c -O3  `glib-config --cflags` to 
nano dyc/makefile
# edit to change line reading 'CC = cc' to 'CC = gcc'
export WISECONFIGDIR=/home/heavet/git_repos/tools/prog/genewise/wise-2.4.1/wisecfg
cd HMMer2
sed 's/getline/getline_new/' sqio.c > a && mv a sqio.c
cd ../
nano models/phasemodel.c
# edit to change line 23 from 'if( !isnumber(line[0]) ) {' to 'if( !isdigit(line[0]) ) {'
make all
make bin

#apt-get install libgtk1.2-dev

nano ~/.profile
#PATH=$HOME/git_repos/tools/prog/genewise/wise-2.4.1/src/dyc:${PATH}
#PATH=$HOME/git_repos/tools/prog/genewise/wise-2.4.1/src:${PATH}
. ~/.profile
```
##EMBOSS
```bash
ls /projects/oldhome/armita/prog/
srun -p long --pty bash
cd ~/git_repos/tools/prog/
cp -r /projects/oldhome/armita/prog/emboss/* .
cd ~/git_repos/tools/prog/emboss/
rm EMBOSS-4.0.0
#version 6.5.7 is current howver download website is down atm
tar -zxvf EMBOSS-latest.tar.gz
rm EMBOSS-latest.tar.gz
cd EMBOSS-4.0.0 
./configure
make
nano ~/.profile
#edited with: 
#PATH=$HOME/git_repos/tools/prog/emboss/EMBOSS-4.0.0/emboss:${PATH}
. ~/.profile
```
##Prodigal
```bash
cd ~/git_repos/tools/prog/
git clone https://github.com/hyattpd/Prodigal.git
cd Prodigal
make
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/Prodigal:${PATH}
. ~/.profile
```
##HMMer
```bash
cd ~/git_repos/tools/prog/
mkdir hmmer
cd hmmer
wget http://eddylab.org/software/hmmer/hmmer.tar.gz
tar -zxvf hmmer.tar.gz
cd hmmer-3.3
./configure
make
make check
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/hmmer/hmmer-3.3/src:${PATH}
. ~/.profile
```
##Augustus
```bash
cd ~/git_repos/tools/prog/
mkdir augustus
cd augustus
wget http://bioinf.uni-greifswald.de/augustus/binaries/augustus.current.tar.gz
tar -zxvf augustus.current.tar.gz
cd augustus-3.3.3
export AUGUSTUS_CONFIG_PATH=/home/heavet/git_repos/tools/prog/augustus/augustus-3.3.3/config
#error with bam2wig ;
#ls/bcftools -c bam2wig.c -o bam2wig.o
#bam2wig.c:18:17: fatal error: sam.h: No such file or directory
 #include "sam.h"
                 ^
#compilation terminated.
#Makefile:33: recipe for target 'bam2wig.o' failed
#make[2]: *** [bam2wig.o] Error 1
#make[2]: Leaving directory '/home/heavet/git_repos/tools/prog/augustus/augustus/auxprogs/bam2wig'
#Makefile:7: recipe for target 'all' failed
#make[1]: *** [all] Error 2
#make[1]: Leaving directory '/home/heavet/git_repos/tools/prog/augustus/augustus/auxprogs'
#Makefile:7: recipe for target 'all' failed
#make: *** [all] Error 2
#therefore;
make clean
sed -i 's/cd bam2wig; make/#cd bam2wig; make/g' ~/git_repos/tools/prog/augustus/augustus-3.3.3/auxprogs/Makefile
make
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/augustus/augustus-3.3.3/bin:${PATH}
#PATH=$HOME/git_repos/tools/prog/augustus/augustus-3.3.3/scripts:${PATH}
. ~/.profile

#also
conda activate rnaquast
conda install -c bioconda augustus
#conda install is successfull however now all programmes with augustus as a dependancy will have to run in this environment?
```
##Bamtools
```bash
git clone git://github.com/pezmaster31/bamtools.git
cd bamtools
mkdir build
cd build
cmake -D CMAKE_INSTALL_PREFIX=~/git_repos/tools/prog/bamtools/ ..
make
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/bamtools/build/src/toolkit/:${PATH}
. ~/.profile
#libbamtools.* files are not symlinked into /usr/lib/ 
```
##GenemarkS-T
```bash
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

  gmst.pl --test #fails
```
##STAR
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

##Trinity
```bash
#Due to the difficulties installing and running trinity a bioconda installation route was used:

#a new environment was created to install trinity
conda create -n trinity
conda activate trinity
conda install -c bioconda trinity
```
###jellyfish
```bash
#both conda install in the trinity environment and manual download performed from http://www.genome.umd.edu/jellyfish.html

mkdir ~/git_repos/tools/prog/jellyfish/
cd ~/git_repos/tools/prog/jellyfish/
wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.5/jellyfish-2.2.5.tar.gz
tar -xzf jellyfish-2.2.5.tar.gz
 ./configure --prefix=$HOME/git_repos/tools/prog/jellyfish/
 make
 make install
```
##MIRA
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
##NCBI download
```bash
pip install ncbi-genome-download
nano ~/.profile
#PATH=$HOME/.local/bin:${PATH}
~/.local/bin
. ~/.profile
```