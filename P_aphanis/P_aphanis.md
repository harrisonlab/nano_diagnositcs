Documentation of analysis and commands used with P.aphanis as part of Nano Diagnistics PhD.

A subfolder for strawberry mildew work was created:
```bash
mkdir P_aphanis
```
All following commands were exectuted from this folder.

Raw sequence data was copied from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
cp -r /archives/2020_niabemr_general/EUUK2019121203GB-EU-UK-NIAB-EMR-2-RNA-WOBI-H204SC19122617/* /projects/nano_diagnostics/P_aphanis/rawdata
```

Tools were copied from the oldhome folder

```bash
mkdir ~/git_repos/tools/

cp /projects/oldhome/heavet/git_repos/tools/* ~/git_repos/tools/
```

The raw sequence reads were subjected to a quality control check using FastQC.


```bash
for RawData in $(ls rawdata/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
sbatch --job-name=my_job_name --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/run_fastqc.sh $RawData
done
```

This only produced error files:

```
/var/spool/slurm-llnl/slurmd/job44110/slurm_script: line 25: fastqc: command not found
cp: cannot stat '/tmp/X204SC19122617-Z01-F001_fastqc/*/': No such file or directory
rm: cannot remove '/tmp/deakig_29315': Operation not permitted
rm: cannot remove '/tmp/.Test-unix': Operation not permitted
rm: cannot remove '/tmp/tmpquast2426/quast.log': Permission denied
rm: cannot remove '/tmp/tmpquast2426/quast_corrected_input': Permission denied
rm: cannot remove '/tmp/deakig_29314': Operation not permitted
rm: cannot remove '/tmp/tmpquast3272/quast.log': Permission denied
rm: cannot remove '/tmp/tmpquast3272/quast_corrected_input': Permission denied
rm: cannot remove '/tmp/RtmpTUwIVL': Operation not permitted
rm: cannot remove '/tmp/.ICE-unix': Operation not permitted
rm: cannot remove '/tmp/.X11-unix': Operation not permitted
rm: cannot remove '/tmp/.font-unix': Operation not permitted
rm: cannot remove '/tmp/.XIM-unix': Operation not permitted
rm: cannot remove '/tmp/deakig_29313': Operation not permitted
rm: cannot remove '/tmp/deakig_29316': Operation not permitted

```

G.Deakin RNA-seq pipeline tool was copied into personal tools folder

```bash
cp /projects/oldhome/deakig/pipelines/RNA-seq/scripts/PIPELINE.sh ~/git_repos/tools/seq_tools/RNAseq

 mv ~/git_repos/tools/seq_tools/RNAseq/PIPELINE.sh ~/git_repos/tools/seq_tools/RNAseq/RNASEQPIPELINE.sh
```
Quality check performed

```bash
mkdir -p analysis/quality

for rawdata in $(ls rawdata/*/*/*.fq.gz); do 
	echo $rawdata
	ProgDir=~/git_repos/tools/seq_tools/RNAseq/
	OutDir=analysis/quality
sbatch --job-name=heavetfastqc --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/RNASEQPIPELINE.sh -c qcheck $FILE $OutDir
done
```
only slurm report files are produced:
```
/var/spool/slurm-llnl/slurmd/job44132/slurm_script: line 69: /var/spool/slurm-llnl/slurmd/job44132/quality.sh: No such file or directory
```
Missing file copied and run
```bash
cp /projects/oldhome/deakig/pipelines/RNA-seq/scripts/quality.sh ~/git_repos/tools/seq_tools/RNAseq

for rawdata in $(ls rawdata/*/*/*.fq.gz); do 
	echo $rawdata
	ProgDir=~/git_repos/tools/seq_tools/RNAseq/
	OutDir=analysis/quality
sbatch --job-name=heavetfastqc --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/quality.sh -c qcheck $FILE $OutDir
done
```
submit_quality.sh not found

missing file copied
```bash
cp /projects/oldhome/deakig/pipelines/RNA-seq/scripts/submit_quality.sh ~/git_repos/tools/seq_tools/RNAseq

# + alter ~/git_repos/tools/seq_tools/RNAseq/quality.sh to point at ~/git_repos/tools/seq_tools/RNAseq/submit_quality.sh file

for rawdata in $(ls rawdata/*/*/*.fq.gz); do 
	echo $rawdata
	ProgDir=~/git_repos/tools/seq_tools/RNAseq/
	OutDir=analysis/quality
sbatch --job-name=heavetfastqc --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/quality.sh -c qcheck $FILE $OutDir
done
```

which results in fastqc command not being found... a wrapper within a wrapper within a wrapper
```
var/spool/slurm-llnl/slurmd/job44148/slurm_script: line 11: fastqc: command not found
```

Installing programme like fastqc:

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

The raw sequence reads were subjected to a quality control check using FastQC.

```bash
for RawData in $(ls rawdata/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
sbatch --job-name=my_job_name --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/run_fastqc.sh $RawData
done
```
```
Started analysis of s30008509_2.fq.gz
Approx 5% complete for s30008509_2.fq.gz
Approx 10% complete for s30008509_2.fq.gz
Approx 15% complete for s30008509_2.fq.gz
Approx 20% complete for s30008509_2.fq.gz
Approx 25% complete for s30008509_2.fq.gz
Approx 30% complete for s30008509_2.fq.gz
Approx 35% complete for s30008509_2.fq.gz
Approx 40% complete for s30008509_2.fq.gz
Approx 45% complete for s30008509_2.fq.gz
Approx 50% complete for s30008509_2.fq.gz
Approx 55% complete for s30008509_2.fq.gz
Approx 60% complete for s30008509_2.fq.gz
Approx 65% complete for s30008509_2.fq.gz
Approx 70% complete for s30008509_2.fq.gz
Approx 75% complete for s30008509_2.fq.gz
Approx 80% complete for s30008509_2.fq.gz
Approx 85% complete for s30008509_2.fq.gz
Approx 90% complete for s30008509_2.fq.gz
Approx 95% complete for s30008509_2.fq.gz
Analysis complete for s30008509_2.fq.gz
cp: cannot stat '/tmp/X204SC19122617-Z01-F001_fastqc/*/': No such file or directory
rm: cannot remove '/tmp/deakig_29315': Operation not permitted
rm: cannot remove '/tmp/.Test-unix': Operation not permitted
rm: cannot remove '/tmp/tmpquast2426/quast.log': Permission denied
rm: cannot remove '/tmp/tmpquast2426/quast_corrected_input': Permission denied
rm: cannot remove '/tmp/deakig_29314': Operation not permitted
rm: cannot remove '/tmp/tmpquast3272/quast.log': Permission denied
rm: cannot remove '/tmp/tmpquast3272/quast_corrected_input': Permission denied
rm: cannot remove '/tmp/RtmpTUwIVL': Operation not permitted
rm: cannot remove '/tmp/.ICE-unix': Operation not permitted
rm: cannot remove '/tmp/X204SC19122617-Z01-F001_fastqc/s30008508_1.fq.gz': No such fi$
rm: cannot remove '/tmp/.X11-unix': Operation not permitted
rm: cannot remove '/tmp/.font-unix': Operation not permitted
rm: cannot remove '/tmp/.XIM-unix': Operation not permitted
rm: cannot remove '/tmp/deakig_29313': Operation not permitted
rm: cannot remove '/tmp/deakig_29316': Operation not permitted
```
```bash
for rawdata in $(ls rawdata/*/*/*.fq.gz); do 
	echo $rawdata
	ProgDir=~/git_repos/tools/seq_tools/RNAseq/
	OutDir=analysis/quality
sbatch --job-name=heavetfastqc --partition=medium --time=0-20:00:00 --mem=8G --cpus-per-task=8 --workdir=. $ProgDir/quality.sh -c qcheck $FILE $OutDir
done
```
```
Submitted batch job 44197
```
A new fastqc wrapper script was created based upon script from A.Armitage
```bash
for RawData in $(ls rawdata/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
sbatch $ProgDir/srun_fastqc.sh $RawData analysis/quality/
done
```
```
mkdir: cannot create directory '/mnt/beegfs/scratch': Permission denied
/var/spool/slurm-llnl/slurmd/job44205/slurm_script: line 20: cd: /mnt/beegfs/scratch/heavet/44205: No such file or directory
Started analysis of s30008509_2.fq.gz
Approx 5% complete for s30008509_2.fq.gz
Approx 10% complete for s30008509_2.fq.gz
Approx 15% complete for s30008509_2.fq.gz
Approx 20% complete for s30008509_2.fq.gz
Approx 25% complete for s30008509_2.fq.gz
Approx 30% complete for s30008509_2.fq.gz
Approx 35% complete for s30008509_2.fq.gz
Approx 40% complete for s30008509_2.fq.gz
Approx 45% complete for s30008509_2.fq.gz
Approx 50% complete for s30008509_2.fq.gz
Approx 55% complete for s30008509_2.fq.gz
Approx 60% complete for s30008509_2.fq.gz
Approx 65% complete for s30008509_2.fq.gz
Approx 70% complete for s30008509_2.fq.gz
Approx 75% complete for s30008509_2.fq.gz
Approx 80% complete for s30008509_2.fq.gz
Approx 85% complete for s30008509_2.fq.gz
Approx 90% complete for s30008509_2.fq.gz
Approx 95% complete for s30008509_2.fq.gz
Analysis complete for s30008509_2.fq.gz
cp: cannot stat '/mnt/beegfs/scratch/heavet/44205/*/': No such file or directory
rm: cannot remove '/mnt/beegfs/scratch/heavet/44205': No such file or directory
```
Fastqc files did not output to analysis/quality/ as expected and so were moved to this locaton manually
```bash
mv s3* analysis/quality/
```
Viewing srun_fastqc.sh, the programme is not executable, but then how did it run as far as it did prevously? Made executable now.
```bash
chmod +x ~/git_repos/tools/seq_tools/dna_qc/srun_fastqc.sh
```
Script rerun
```bash
for RawData in $(ls rawdata/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
sbatch $ProgDir/srun_fastqc.sh $RawData analysis/quality/2/
done
```
The result was the same as previous to chmod files were output to the pwd and not analysis/quality/2/. As before run report file shows permission was denied to create + manipulate files in /mnt/beegfs/scratch. Produced file were deleted.

```bash
rm s3*
```


A new trimmomatic wrapper script was created based upon script from A.Armitage at ~/git_repos/tools/seq_tools/dna_qc/srun_trimmomatic.sh and made executable
```bash
chmod +x ~/git_repos/tools/seq_tools/dna_qc/srun_trimmomatic.sh
```
Trimming was performed
```bash
for Fread in $(ls rawdata/*/*/*1.fq.gz); do
 Rread=$(echo $Fread|sed 's/1.fq.gz/2.fq.gz/')
echo $Fread
echo $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=analysis/trimmed/
Prefix=P_aphanis_"Fread"_trimmed
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
```
no output produced
```

qc_trimmomatic.sh <F_reads.fq/fq.gz> <R_reads.fq/fq.gz> <Illumina_adapters.fa> <Outpu$

mkdir: cannot create directory ‘/mnt/beegfs/scratch’: Permission denied
/var/spool/slurm-llnl/slurmd/job44223/slurm_script: line 22: cd: /mnt/beegfs/scratch/$
Error: Unable to access jarfile /mnt/beegfs/home/aa0377h/prog/trimmomatic/Trimmomatic$
cp: cannot stat 'P_aphanis_Fread_trimmed_F_trim.fq.gz': No such file or directory
cp: cannot stat 'P_aphanis_Fread_trimmed_F_trim_unpaired.fq.gz': No such file or dire$
cp: cannot stat 'P_aphanis_Fread_trimmed_R_trim.fq.gz': No such file or directory
cp: cannot stat 'P_aphanis_Fread_trimmed_R_trim_unpaired.fq.gz': No such file or dire$
cp: cannot stat 'P_aphanis_Fread_trimmed_trim_log.txt': No such file or directory
rm: cannot remove '/mnt/beegfs/scratch/heavet/44223': No such file or directory

```
srun_trimmomatic.sh file was edited to point at the jar file at /projects/oldhome/armita/prog/trimmomatic/Trimmomatic-0.39 and the script rerun.
```bash
for Fread in $(ls rawdata/*/*/*1.fq.gz); do
 Rread=$(echo $Fread|sed 's/1.fq.gz/2.fq.gz/')
echo $Fread
echo $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=analysis/trimmed/
Prefix=P_aphanis_trimmed
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
```
I suspect that the files are overwritting each other as the prefix will be the same for each Fread, however changing the Prefix, below, breaks the whole script. Files are not all output to the output directory.
```bash
for Fread in $(ls rawdata/*/*/*1.fq.gz); do
 Rread=$(echo $Fread|sed 's/1.fq.gz/2.fq.gz/')
echo $Fread
echo $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=analysis/trimmed/
Prefix=$Fread
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
```
```bash
for Fread in $(ls rawdata/*/*/*1.fq.gz); do
Rread=$(echo $Fread|sed 's/1.fq.gz/2.fq.gz/')
echo $Fread
echo $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=analysis/trimmed/
Prefix= ( echo $Fread | cut -f3 -d '/' | rev | cut -f2 -d '.' | rev )
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
```
