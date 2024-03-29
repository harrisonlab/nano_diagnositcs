# Installations

Documenting the process of downloading and installing programmes within project pipelines was over complicating pipelines therefore installations are now documented here.

## Bioconda
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
### dendropy
```bash
conda create -n dendropy
conda activate dendropy
conda install -c bioconda dendropy
```
### blobtools2
```bash
#https://blobtoolkit.genomehubs.org/install/

conda create -n blobtools2 -y python=3.6 docopt pyyaml ujson pysam tqdm nodejs seqtk
conda activate blobtools2
mkdir -p apps/blobtools2/taxdump
cd apps/blobtools2/taxdump
curl -L ftp://ftp.ncbi.nih.gov/pub/taxonomy/new_taxdump/new_taxdump.tar.gz | tar xzf -
cd ..
git clone https://github.com/blobtoolkit/blobtools2
git clone https://github.com/blobtoolkit/viewer
cd viewer
npm install
cd ..
conda install -c bioconda -y psutil
conda install -c conda-forge -y geckodriver selenium pyvirtualdisplay
pip install fastjsonschema
git clone https://github.com/blobtoolkit/specification
git clone https://github.com/blobtoolkit/insdc-pipeline
mkdir -p nt
wget "ftp://ftp.ncbi.nlm.nih.gov/blast/db/nt.??.tar.gz" -P nt/ && \
        for file in nt/*.tar.gz; \
            do tar xf $file -C nt && rm $file; \
        done
conda install -c bioconda diamond
mkdir -p uniprot
newest=$(curl -vs ftp.ebi.ac.uk/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/ 2>&1 | awk '/tar.gz/ {print $9}')
wget -q -O uniprot/reference_proteomes.tar.gz ftp.ebi.ac.uk/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/$newest

cd uniprot
tar xf reference_proteomes.tar.gz

touch reference_proteomes.fasta.gz
find . -mindepth 2 | grep "fasta.gz" | grep -v 'DNA' | grep -v 'additional' | xargs cat >> reference_proteomes.fasta.gz

echo -e "accession\taccession.version\ttaxid\tgi" > reference_proteomes.taxid_map
zcat */*/*.idmapping.gz | grep "NCBI_TaxID" | awk '{print $1 "\t" $1 "\t" $3 "\t" 0}' >> reference_proteomes.taxid_map

diamond makedb -p 16 --in reference_proteomes.fasta.gz --taxonmap reference_proteomes.taxid_map --taxonnodes ../taxdump/nodes.dmp -d reference_proteomes.dmnd
cd -
```
### blobtools
```bash
conda create -n blobtools
conda activate blobtools
conda install -c bioconda blobtools
```
### jellyfish
```bash
conda create -n jellyfish
conda activate jellyfish
conda install -c conda-forge jellyfish
conda install jellyfish=2.2.3
```
### blast
```bash
conda create -n blast+
conda activate blast+
conda install blast 
```
## eDIRECT
```bash
conda create -n eDIRECT
conda activate eDIRECT
conda install -y -c conda-forge -c bioconda -c defaults entrez-direct
```
## SRA toolkit
```bash
conda create -n sratoolkit
conda activate sratoolkit
conda install -c daler sratoolkit
```

## Conterminator
```bash
conda create -n conterminator
conda activate conterminator
conda install -c bioconda conterminator
```
## Stringtie
```bash
conda create -n Stringtie
conda activate Stringtie
conda install stringtie 
```
## megahit
```bash
conda create -n megahit
conda activate megahit
conda install -c bioconda megahit
```
## kmc
```bash
conda create -n kmc
conda activate kmc
conda install kmc
```
## tophat
```bash
conda create -n tophat
conda activate tophat
conda install tophat
```
## samtools
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
## repeatmodeler
```bash
conda create -n repeatmasking
conda activate repeatmasking
conda install -c bioconda repeatmodeler
```
## bwa
```bash
conda create -n 
conda activate bwa
conda install -c bioconda bwa
```
## transposonPSI
```bash
conda create -n transposonpsi
conda activate transposonpsi
conda install -c bioconda transposonpsi
```
## GATK
```bash
conda activate Picard
conda install -c bioconda gatk
conda install gatk4
```
## concoct
```bash
conda create -n concoct
conda activate concoct
conda install concoct
```
## vcflib
```bash
conda create -n vcflib
conda activate vcflib
conda install -c bioconda vcflib
```
## vcftools
```bash
conda activate vcflib
conda install -c bioconda vcftools
```
## bcftools
```bash
conda activate Picard
conda install -c bioconda bcftools
```
##metabat2
```bash
conda create -n metabat2
conda activate metabat2
conda install -c bioconda metabat2
```
##kraken
```bash
mkdir -p ~/git_repos/tools/prog/kraken2/1
cd ~/git_repos/tools/prog/kraken2
git clone https://github.com/DerrickWood/kraken2.git
cd kraken2
./install_kraken2.sh ~/git_repos/tools/prog/kraken2/1
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/kraken2/1:${PATH}
#PATH=$HOME/git_repos/tools/prog/kraken2/1/kraken2:${PATH}
#PATH=$HOME/git_repos/tools/prog/kraken2/1/kraken2-build:${PATH}
#PATH=$HOME/git_repos/tools/prog/kraken2/1/kraken2-inspect:${PATH}
. ~/.profile

mkdir -p apps/kraken2/1
cd apps/kraken2
git clone https://github.com/DerrickWood/kraken2.git
cd kraken2
./install_kraken2.sh ~/scratch/apps/kraken2/1
nano ~/.bash_profile
#edited with:
#PATH=$HOME/scratch/apps/kraken2/1:${PATH}
#PATH=$HOME/scratch/apps/kraken2/1/kraken2:${PATH}
#PATH=$HOME/scratch/apps/kraken2/1/kraken2-build:${PATH}
#PATH=$HOME/scratch/apps/kraken2/1/kraken2-inspect:${PATH}
. ~/.bash_profile
```
## assembly stats
```bash
mkdir -p /scratch/projects/heavet/prog/assemblystats
cd /scratch/projects/heavet/prog/assemblystats
git clone https://github.com/rjchallis/assembly-stats
cd assembly-stats

conda create -n assembly-stats
conda activate assembly-stats
conda install -c bioconda assembly-stats
conda install -c conda-forge jq

mkdir apps/assemblystats
cd apps/assemblystats
git clone https://github.com/rjchallis/assembly-stats
cd assembly-stats

conda create -n assembly-stats
conda activate assembly-stats
conda install -c bioconda assembly-stats
conda install -c conda-forge jq
```
##vt
```bash
mkdir -p ~/git_repos/tools/prog/vt
cd ~/git_repos/tools/prog/vt
git clone https://github.com/atks/vt.git
cd vt
git submodule update --init --recursive
make 
make test
nano ~/.profile
#edited with:
#PATH=$HOME/git_repos/tools/prog/vt/vt:${PATH}
. ~/.profile
```
```bash
conda create -n kraken2
conda activate kraken2
conda install -c bioconda kraken2
conda install libiconv
```
##ragtag
```bash
conda create --name ragtag
conda activate ragtag
conda install -c bioconda ragtag
```
## codingquary
```bash
conda create --name codingquary python=2.7
conda activate codingquary
conda install codingquarry

nano ~/.profile
#PATH=$HOME/miniconda3/envs/codingquary/opt/codingquarry-2.0/QuarryFiles:${PATH}
. ~/.profile
```
## EffectorP
```bash
conda create -n effectorP
conda activate effectorP
conda install -c hcc effector-p

nano ~/.profile
#PATH=${PATH}:/scratch/software/EffectorP-2.0/Scripts:${PATH}
. ~/.profile
```
## TMHMM
```bash
nano ~/.profile
#PATH=${PATH}:/data/scratch/gomeza/prog/tmhmm-2.0c/bin:${PATH}
. ~/.profile
```
## secretomep
SecretomeP was obtained from https://services.healthtech.dtu.dk/cgi-bin/sw_request
```bash
conda activate jellyfish
conda install -c conda-forge netpbmfile
conda install -c bioconda gnuplot
conda install -c conda-forge netpbm

#Prerequisite programs downloaded according to secretomep README, paths changed as appropriate:
#    /mnt/shared/scratch/theaven/apps/conda/envs/jellyfish/bin/tcsh
#   setenv AWK /home/theaven/scratch/apps/conda/envs/predector/bin/awk
#   setenv ECHO /home/theaven/scratch/apps/conda/envs/predector/bin/echo
#   setenv GNUPLOT /mnt/shared/scratch/theaven/apps/conda/envs/jellyfish/bin/gnuplot            
#   setenv PPM2GIF /mnt/shared/scratch/theaven/apps/conda/envs/jellyfish/bin/ppmtogif
#   setenv SIGNALP /home/theaven/scratch/apps/conda/envs/predector/bin/signalp3
#   setenv PERL  /home/theaven/scratch/apps/conda/envs/predector/bin/perl
#    set prop     = /home/theaven/scratch/apps/secretomep/prop1/prop-1.0c/prop
#   set psort    = /home/theaven/scratch/apps/secretomep/psort/psort
#   set seg      = /home/theaven/scratch/apps/secretomep/seg
#   set tmhmm    = /home/theaven/scratch/apps/conda/envs/predector/bin/tmhmm
```
## signalp
```bash
#download links expire after 4 hours
#https://services.healthtech.dtu.dk/service.php?SignalP
mkdir /home/heavet/git_repos/tools/gene_prediction/signalp-5.0b
cd /home/heavet/git_repos/tools/gene_prediction/signalp-5.0b
wget https://services.healthtech.dtu.dk/download/6e5220c3-8c8b-44ec-8835-f9184061d75b/signalp-5.0b.Linux.tar.gz
tar -xvzf signalp-5.0b.Linux.tar.gz
nano ~/.profile
#PATH=${PATH}:$HOME/git_repos/tools/gene_prediction/signalp-5.0b/signalp-5.0b/bin:${PATH}
#PATH=${PATH}:/data/scratch/gomeza/prog/signalp/signalp-4.1:${PATH}
. ~/.profile

mkdir /home/theaven/scratch/apps/signalp
cd /home/theaven/scratch/apps/signalp
wget https://services.healthtech.dtu.dk/download/4ab221bd-33f6-4702-87c4-240027ee4ea1/signalp-5.0b.Linux.tar.gz
tar -xvzf signalp-5.0b.Linux.tar.gz
#/home/theaven/scratch/apps/signalp/signalp-5.0b/bin
```
## hmmscan
```bash
conda create -n cazy
conda activate cazy
conda install -c bioconda hmmer
```
## trimal
```bash
conda create -n trimal
conda activate trimal
conda install -c bioconda trimal
```
## predector
```bash
#download dependancies
cp /home/theaven/scratch/apps/predector/signalp_3.0/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/signalp_4.1g/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/signalp_5.0b/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/signalp_6.0g/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/targetp_2.0/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/deeploc_1.0/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/tmhmm_2.0c/*tar* /home/theaven/scratch/apps/predector/predector
cp /home/theaven/scratch/apps/predector/phobius_1.01/*tar* /home/theaven/scratch/apps/predector/predector
cd /home/theaven/scratch/apps/predector/predector
ENVIRONMENT=conda
curl -s "https://raw.githubusercontent.com/ccdmb/predector/1.2.6/install.sh" \
| bash -s "${ENVIRONMENT}" \
    -3 signalp-3.0.Linux.tar.Z \
    -4 signalp-4.1g.Linux.tar.gz \
    -5 signalp-5.0b.Linux.tar.gz \
    -6 signalp-6.0g.fast.tar.gz \
    -t targetp-2.0.Linux.tar.gz \
    -d deeploc-1.0.All.tar.gz \
    -m tmhmm-2.0c.Linux.tar.gz \
    -p phobius101_linux.tar.gz
#creates conda environment: predector

conda activate predector
conda install -c bioconda nextflow>=21
pip install Keras
pip install Tensorflow
nextflow run -profile test -with-conda /mnt/shared/scratch/theaven/apps/conda/envs/predector -resume -r 1.2.6 ccdmb/predector
conda install -c anaconda cudatoolkit
find /mnt/shared/scratch/theaven -name 'libcudart.so.11.0'
#/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib/libcudart.so.11.0
#/mnt/shared/scratch/theaven/apps/conda/pkgs/cudatoolkit-11.3.1-h2bc3f7f_2/lib/libcudart.so.11.0
#existing LD_LIBRARY_PATH = /opt/slurm/latest/lib64
cd /mnt/shared/scratch/theaven/apps/conda/envs/predector/lib
ln -s /opt/slurm/latest/lib64/libnss_slurm.so.2 libnss_slurm.so.2
ln -s /opt/slurm/latest/lib64/libpmi2.so libpmi2.so
ln -s /opt/slurm/latest/lib64/libpmi2.so.0 libpmi2.so.0
ln -s /opt/slurm/latest/lib64/libpmi2.so.0.0.0 libpmi2.so.0.0.0
ln -s /opt/slurm/latest/lib64/libpmi.so libpmi.so
ln -s /opt/slurm/latest/lib64/libpmi.so.0 libpmi.so.0
ln -s /opt/slurm/latest/lib64/libpmi.so.0.0.0 libpmi.so.0.0.0
ln -s /opt/slurm/latest/lib64/libslurm.so libslurm.so
ln -s /opt/slurm/latest/lib64/libslurm.so.38 libslurm.so.38
ln -s /opt/slurm/latest/lib64/libslurm.so.38.0.0 libslurm.so.38.0.0
ln -s /opt/slurm/latest/lib64/perl5 perl5
ln -s /opt/slurm/latest/lib64/pkgconfig pkgconfig
ln -s /opt/slurm/latest/lib64/slurm slurm


export PATH=/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib' >> ~/.bash_profile

chmod a+r /usr/lib/x86_64-linux-gnu/libcuda*

export PATH=/opt/slurm/latest/lib64${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/opt/slurm/latest/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
nano ~/.bash_profile
/mnt/shared/scratch/theaven/apps/conda/envs/braker/bin
###############################################################################################
When you run the pipeline, please supply the parameter:
'-with-singularity "predector.sif"'
You can test the pipeline now with:
'nextflow run -profile test -with-singularity "predector.sif" -resume -r 1.2.6 ccdmb/predector'
```
## signlap
```bash
conda create -n predector2.7 python=2.7
conda activate predector2.7
mkdir /apps/predector
#Follow readmes to install dependancies:

#SignalP version 3.0
conda install -c conda-forge gnuplot

cd /home/theaven/scratch/apps/predector/signalp_3.0/signalp-3.0
pip install PyGnuplot
pip install ghostscript
conda install -c conda-forge netpbm
./signalp -t euk test/test.seq          (1) text
./signalp -g -t euk test/test.seq       (2) text and graphics #doesnt work
./signalp -G -t euk test/test.seq       (3) text and graphics, display #doesnt work
./signalp -g -t euk test/test5.seq      (4) several sequences #doesnt work
cp /home/theaven/scratch/apps/predector/signalp_3.0/*tar* /home/theaven/scratch/apps/predector/predector

#SignalP version 4.1g
cd /home/theaven/scratch/apps/predector/signalp_4.1g/signalp-4.1
./signalp -t euk -f short test/euk10.fsa > euk10.fsa.short_out
./signalp -t euk -f long test/euk10.fsa > euk10.fsa.long_out
./signalp -t euk -f all test/euk10.fsa > euk10.fsa.all_out
./signalp -t euk -f summary test/euk10.fsa > euk10.fsa.summary_out
cp /home/theaven/scratch/apps/predector/signalp_4.1g/*tar* /home/theaven/scratch/apps/predector/predector

#SignalP version 5.0b
cd /home/theaven/scratch/apps/predector/signalp_5.0b/signalp-5.0b/bin
./signalp -fasta ../test/euk10.fsa -org euk -format short -prefix euk_10_short
./signalp -fasta ../test/euk10.fsa -org euk -format long -prefix euk_10_long
cp /home/theaven/scratch/apps/predector/signalp_5.0b/*tar* /home/theaven/scratch/apps/predector/predector

#SignalP version 6.0g "fast" *currently optional
cd /home/theaven/scratch/apps/predector/signalp_6.0g/signalp6_fast
pip3 install signalp-6-package/
conda install -c pytorch pytorch
SIGNALP_DIR=$(python3 -c "import signalp; import os; print(os.path.dirname(signalp.__file__))" )
cp -r signalp-6-package/models/* $SIGNALP_DIR/model_weights/
cp /home/theaven/scratch/apps/predector/signalp_6.0g/*tar* /home/theaven/scratch/apps/predector/predector
conda deactivate
```
## taregt p
```bash
#TargetP version 2.0
cd /home/theaven/scratch/apps/predector/targetp_2.0/targetp-2.0
bin/targetp -fasta test/example.fsa -org non-pl -format short -prefix example_short
bin/targetp -fasta test/example.fsa -org non-pl -format long -prefix example_long
cp /home/theaven/scratch/apps/predector/targetp_2.0/*tar* /home/theaven/scratch/apps/predector/predector

```
## deeploc
```bash

#DeepLoc version 1.0
cd /home/theaven/scratch/apps/predector/deeploc_1.0/deeploc-1.0
pip install -r requirements.txt
python setup.py install --user
deeploc -f test.fasta
cp /home/theaven/scratch/apps/predector/deeploc_1.0/*tar* /home/theaven/scratch/apps/predector/predector
```
## tmhmm
```bash
#TMHMM version 2.0c
cd /home/theaven/scratch/apps/predector/tmhmm_2.0c/tmhmm-2.0c
nano bin/tmhmmformat.pl
##!/usr/bin/perl -w
nano bin/tmhmm
##!/usr/bin/perl
nano ~/.bash_profile
#PATH=$HOME/scratch/apps/predector/tmhmm_2.0c/tmhmm-2.0c/bin:${PATH}
cp /home/theaven/scratch/apps/predector/tmhmm_2.0c/*tar* /home/theaven/scratch/apps/predector/predector

```
## phobius
```bash
#Phobius version 1.01
cd /home/theaven/scratch/apps/predector/phobius_1.01/tmp/tmpCKVzkK/phobius
nano ~/.bash_profile
#PATH=$HOME/scratch/apps/predector/phobius_1.01/tmp/tmpCKVzkK/phobius:${PATH}
. ~/.bash_profile
cp /home/theaven/scratch/apps/predector/phobius_1.01/*tar* /home/theaven/scratch/apps/predector/predector
```
## centrifuge
```bash
nano ~/.profile
PATH=${PATH}:/scratch/software/centrifuge:${PATH}
. ~/.profile
```
## cufflinks
```bash
conda activate tophat
conda install cufflinks
```
## Braker
```bash
#https://github.com/Gaius-Augustus/BRAKER#installation
conda create -n braker
conda activate braker
conda install -c bioconda braker
conda install YAML
conda install -c bioconda perl-hash-merge
conda install -c bioconda perl-logger-simple
conda install augustus
conda install -c bioconda perl-parallel-forkmanager
conda update perl-parallel-forkmanager
conda install numpy

git clone https://github.com/Gaius-Augustus/Augustus.git
cd Augustus
singularity build augustus.sif Singularity.def

#gmes.cfg min_contig set from 50000 to 500 for genemark

cd /mnt/shared/scratch/theaven/apps/genemarkES/gmes_linux_64_4/
for file in $(ls *.pl); do
sed -i 's@#!/usr/bin/perl@#!/home/theaven/scratch/apps/conda/envs/braker/bin/perl@g' $file
sed -i 's@#!/usr/bin/env perl@#!/home/theaven/scratch/apps/conda/envs/braker/bin/perl@g' $file
done
cd ~/scratch
```
## FastQC
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
## SPAdes
```
conda create -n spades
conda activate spades
conda install -c bioconda spades
```
## ATLAS
```bash
conda create -n ATLAS
conda activate ATLAS
conda install metagenome-atlas
conda install mamba
```
## bowtie2
```bash
conda create -n bowtie2
conda activate bowtie2
conda install -c bioconda bowtie2
```
## QUAST
```bash
conda create -n quast python=2.7
conda activate quast
conda install python=2.7
conda install -c bioconda quast

#conda install does not work on crop diversity hpc
wget https://downloads.sourceforge.net/project/quast/quast-5.0.2.tar.gz
tar -xzf quast-5.0.2.tar.gz
 cd quast-5.0.2
./setup.py install_full
```
## tbl2asn
```bash
conda create -n tbl2asn
conda activate tbl2asn
conda install -c bioconda tbl2asn
```
## rnaQUAST
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

## orthofinder
```bash
conda create -n orthofinder
conda activate orthofinder
conda install -c bioconda orthofinder
conda install -c anaconda scipy
conda install numpy

conda create -n orthofinder2.7 python=2.7
conda activate orthofinder
conda install -c bioconda orthofinder
conda install -c anaconda scipy
conda install numpy
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
## Blast
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
## BUSCO 
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
conda install -c bioconda -c conda-forge busco=4.1.4 augustus=3.3.3
```
## Genewise
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
## EMBOSS
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
## Prodigal
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
## HMMer
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
## Augustus
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
## Bamtools
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
## Java
```bash
#this is a python 2.7 environment
conda create -n Java11
conda activate Java11
conda install -c conda-forge openjdk
pip install numpy
```
## perl
```bash
conda create -n perl
conda activate perl
conda install -c anaconda perl
```
## GenemarkS-T
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
## STAR
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

conda create -n STAR
conda activate STAR
conda install -c bioconda star
```
## Picard
```bash
conda create -n Picard
conda activate Picard
conda install -c bioconda picard
```
## Trinity
```bash
#Due to the difficulties installing and running trinity a bioconda installation route was used:

#a new environment was created to install trinity
conda create -n trinity
conda activate trinity
conda install -c bioconda trinity
```
### jellyfish
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
## seqtk
```bash
conda create -n seqtk
conda activate seqtk
conda install -c bioconda seqtk
```
### interproscan
```bash
mkdir ~/git_repos/tools/prog/Interproscan
cd ~/git_repos/tools/prog/Interproscan
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.52-86.0/interproscan-5.52-86.0-64-bit.tar.gz    
tar -xzf interproscan-5.52-86.0-64-bit.tar.gz 
#~ area full
cd /projects/nano_diagnostics
mkdir tools
cd tools
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.52-86.0/interproscan-5.52-86.0-64-bit.tar.gz    
tar -xzf interproscan-5.52-86.0-64-bit.tar.gz 
cd interproscan-5.52-86.0/
python3 initial_setup.py

#############################################################################
conda create -n interproscan
conda activate interproscan
conda install -c bioconda interproscan
conda install -c bioconda bioconductor-panther.db

cd /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan
python3 initial_setup.py
./interproscan.sh -i test_all_appl.fasta -f tsv -dp
./interproscan.sh -i test_all_appl.fasta -f tsv
cd ~/scratch
######################################
# First time usage please README !!! #
######################################

The databases are huge and consequently not shiped within this installation.
Please download and install the Databases manually by following the commands below:
!!! /!\ Edit the 2 first lines to match the wished version of the DB /!\ !!!

Commands:
=========
# See here for latest db available: https://github.com/ebi-pf-team/interproscan or http://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/
# Set version
version_major=5.54
version_minor=87.0

# get the md5 of the databases
wget http://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${version_major}-${version_minor}/interproscan-${version_major}-${version_minor}-64-bit.tar.gz.md5
# get the databases (with core because much faster to download)
wget http://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/${version_major}-${version_minor}/interproscan-${version_major}-${version_minor}-64-bit.tar.gz
# checksum
md5sum -c interproscan-${version_major}-${version_minor}-64-bit.tar.gz.md5
# untar gz
tar xvzf interproscan-${version_major}-${version_minor}-64-bit.tar.gz
# remove old DB
mv /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan/data /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan/old_data
# copy past the new db
cp -r interproscan-${version_major}-${version_minor}/data /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan/
rm  interproscan-${version_major}-${version_minor}-64-bit.tar.gz
rm  interproscan-${version_major}-${version_minor}-64-bit.tar.gz.md5
rm -r interproscan-${version_major}-${version_minor}

cd /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan
rm test_all_appl.fasta.tsv
rm test_all_appl.fasta_1.tsv
python3 initial_setup.py
./interproscan.sh -i test_all_appl.fasta -f tsv -dp
./interproscan.sh -i test_all_appl.fasta -f tsv
cd ~/scratch

INFO:
====
Phobius (licensed software), SignalP, SMART (licensed components) and TMHMM use
licensed code and data provided by third parties. If you wish to run these
analyses it will be necessary for you to obtain a licence from the vendor and
configure your local InterProScan installation to use them.
(see more information in /mnt/shared/scratch/theaven/apps/conda/envs/interproscan/share/InterProScan/data/<db>)

/mnt/shared/scratch/jconnell/apps/miniconda3/envs/interproscan_env/share/InterProScan/interproscan.sh -i /mnt/shared/scratch/jconnell/apps/miniconda3/envs/interproscan_env/share/InterProScan/test_all_appl.fasta -f tsv -dp
/mnt/shared/scratch/jconnell/apps/miniconda3/envs/interproscan_env/bin/interproscan.sh -i /mnt/shared/scratch/jconnell/apps/miniconda3/envs/interproscan_env/share/InterProScan/test_all_appl.fasta -f tsv -dp


```
## MIRA
```bash
#a new environment was created to install MIRA
conda create -n MIRA
conda activate MIRA
conda install -c bioconda mira
```
## R
```bash
conda create -n Rstat
conda activate Rstat
#conda install -c r r
conda install -c r r-essentials
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
## NCBI download
```bash
pip install ncbi-genome-download
nano ~/.profile
#PATH=$HOME/.local/bin:${PATH}
~/.local/bin
. ~/.profile
```
## Biopython
```bash
conda create -n Biopython
conda activate Biopython
conda install -c anaconda biopython

conda create -n biopython2.7
conda activate biopython2.7
python2.7 -m pip install biopython==1.76

```

## Mitofinder
```bash
conda create -n Mitofinder
conda activate Mitofinder
conda install mitofinder
conda install -c bioconda mitofinder

mkdir -p ~/git_repos/tools/prog/mitofinder
cd ~/git_repos/tools/prog/mitofinder
wget https://github.com/RemiAllio/MitoFinder/archive/master.zip
unzip master.zip
mv MitoFinder-master MitoFinder
cd MitoFinder
./install.sh
exit

nano ~/.profile
#PATH=$HOME/git_repos/tools/prog/mitofinder/MitoFinder/:${PATH}
. ~/.profile
```

