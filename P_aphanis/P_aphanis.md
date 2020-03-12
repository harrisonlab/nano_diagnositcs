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

Annotated transcripts .gtf format for InGff highly recommended -> have yet to find these for strawberry