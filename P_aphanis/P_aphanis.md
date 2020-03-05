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