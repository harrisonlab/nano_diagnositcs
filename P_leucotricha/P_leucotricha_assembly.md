# P.leucotricha genome assembly and annotation pipeline

Documentation of analysis and commands used with P.leucotricha as part of Nano Diagnistics PhD.

## Collecting data

All following commands were exectuted from the folder:
```bash
/projects/nano_diagnostics
```
Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/F/p11_1_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/R/p11_1_r.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_f.fq.gz

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_r.fq.gz

```
The golden delicious apple genome was linked from an existing download location within the cluster. Originally downloaded from https://iris.angers.inra.fr/gddh13/the-apple-genome-downloads.html
```bash
mkdir -p assembly/genome/NCBI/rosales

ln -s /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
```
The phiX genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/phix
cd assembly/genome/NCBI/phix
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/enterobacteria_phage_phix174_sensu_lato_uid14015/NC_001422.fna

```
The human genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/primate/H.sapiens
cd assembly/genome/NCBI/primate/H.sapiens
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GCA_000001405.15_GRCh38_genomic.fna.gz
gunzip GCA_000001405.15_GRCh38_genomic.fna.gz
```
The existing Podosphaera leucotricha was downloaded.
```bash
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales
wget -P P_leocotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip P_leocotricha/JAATOF01.1.fsa_nt.gz
cd /projects/nano_diagnostics

samtools faidx assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 

```

## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_leucotricha/*/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done

#The number of raw reads were counted:

cat rawdata/P_leucotricha/THeavenp11_1/paired/001/F/p11_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#20,886,394
cat rawdata/P_leucotricha/THeavenp11_1/paired/001/R/p11_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#20,886,394
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. 
```bash
for ReadDir in $(ls -d rawdata/P_leucotricha/*/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done

#The number of trimmed reads were counted:
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#19,638,648
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#966.121
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#19,638,648
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#188,865
```
The data was visualised following trimming.
```bash
for RawData in $(ls dna_qc/P_leucotricha/*/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
```
Sequencing coverage was estimated:
```bash
for TrimData in $(ls dna_qc/P_leucotricha/*/*/*/*/*.fq.gz); do
ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc;
echo $TrimData;
GenomeSz=43
OutDir=$(dirname $TrimData)
sbatch $ProgDir/ssub_count_nuc.sh $GenomeSz $TrimData $OutDir
done

tail -n1 -q qc_dna/paired/v.inaequalis/*/*/*_cov.txt | cat 
```

Find predicted coverage for these isolates:
```bash
for StrainDir in $(ls -d qc_dna/paired/*/*); do
Strain=$(basename $StrainDir)
printf "$Strain\t"
for File in $(ls qc_dna/paired/*/"$Strain"/*/*.txt); do
echo $(basename $File);
cat $File | tail -n1 | rev | cut -f2 -d ' ' | rev;
done | grep -v '.txt' | awk '{ SUM += $1} END { print SUM }'
done
```
Output of predicted coverage was:
## Alignment

### bowtie2
A bioconda installation of bowtie was performed
```bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index

bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple.sam \
-S THeavenp11_1alignedapple.sam

#20793634 reads; of these:
#  19638648 (94.45%) were paired; of these:
#    17103073 (87.09%) aligned concordantly 0 times
#    1219963 (6.21%) aligned concordantly exactly 1 time
#    1315612 (6.70%) aligned concordantly >1 times
#    ----
#    17103073 pairs aligned concordantly 0 times; of these:
#      17915 (0.10%) aligned discordantly 1 time
#    ----
#    17085158 pairs aligned 0 times concordantly or discordantly; of these:
#      34170316 mates make up the pairs; of these:
#        33816721 (98.97%) aligned 0 times
#        155389 (0.45%) aligned exactly 1 time
#        198206 (0.58%) aligned >1 times
#  1154986 (5.55%) were unpaired; of these:
#    1100724 (95.30%) aligned 0 times
#    19749 (1.71%) aligned exactly 1 time
#    34513 (2.99%) aligned >1 times
#13.64% overall alignment rate

screen -r #17810.rnaquast
bowtie2 -x apple_index -1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz -2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz -S THeavenp11_1alignedapplepairedonly.sam

#19638648 reads; of these:                                                     19638648 (100.00%) were paired; of these:                                                 17103073 (87.09%) aligned concordantly 0 times
#    1219963 (6.21%) aligned concordantly exactly 1 time
#    1315612 (6.70%) aligned concordantly >1 times
#    ----
#    17103073 pairs aligned concordantly 0 times; of these:
#      17915 (0.10%) aligned discordantly 1 time
#    ----
#    17085158 pairs aligned 0 times concordantly or discordantly; of these:
#      34170316 mates make up the pairs; of these:
#        33816721 (98.97%) aligned 0 times
#        155389 (0.45%) aligned exactly 1 time
#        198206 (0.58%) aligned >1 times
#13.90% overall alignment rate


for ReadDir in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/*/*);
do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
echo $Fread
echo $Rread
Assembly=assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
OutDir=alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/batch
ProgDir=~/git_repos/tools/seq_tools/genome_alignment/bowtie
sbatch $ProgDir/sub_bowtie_unaligned.sh $Assembly $Fread $Rread $OutDir
done
#19638648 reads; of these:
#  19638648 (100.00%) were paired; of these:
#    17077860 (86.96%) aligned concordantly 0 times
#    1226824 (6.25%) aligned concordantly exactly 1 time
#    1333964 (6.79%) aligned concordantly >1 times
#    ----
#    17077860 pairs aligned concordantly 0 times; of these:
#      1302 (0.01%) aligned discordantly 1 time
#13.05% overall alignment rate


cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa applemildew_index
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha.sam \
-S THeavenp11_1alignedGananPleucotricha.sam

#20793634 reads; of these:
#  19638648 (94.45%) were paired; of these:
#    8775394 (44.68%) aligned concordantly 0 times
#    9994860 (50.89%) aligned concordantly exactly 1 time
#    868394 (4.42%) aligned concordantly >1 times
#    ----
#    8775394 pairs aligned concordantly 0 times; of these:
#      450264 (5.13%) aligned discordantly 1 time
#    ----
#    8325130 pairs aligned 0 times concordantly or discordantly; of these:
#      16650260 mates make up the pairs; of these:
#        14070451 (84.51%) aligned 0 times
#        1732933 (10.41%) aligned exactly 1 time
#        846876 (5.09%) aligned >1 times
#  1154986 (5.55%) were unpaired; of these:
#    414137 (35.86%) aligned 0 times
#    691531 (59.87%) aligned exactly 1 time
#    49318 (4.27%) aligned >1 times
#64.18% overall alignment rate


for ReadDir in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/*/*);
do
 Fread=$(ls $ReadDir/F/*trim.fq.gz)
 Rread=$(ls $ReadDir/R/*trim.fq.gz)
echo $Fread
echo $Rread
Assembly=assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa
OutDir=alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch
ProgDir=~/git_repos/tools/seq_tools/genome_alignment/bowtie
sbatch $ProgDir/sub_bowtie_unaligned.sh $Assembly $Fread $Rread $OutDir
done
#19638648 reads; of these:
#  19638648 (100.00%) were paired; of these:
#    8685128 (44.22%) aligned concordantly 0 times
#    10074700 (51.30%) aligned concordantly exactly 1 time
#    878820 (4.47%) aligned concordantly >1 times
#    ----
#    8685128 pairs aligned concordantly 0 times; of these:
#      15257 (0.18%) aligned discordantly 1 time
#55.85% overall alignment rate

#an index file was created for the aligned p.leucotricha reads
samtools index -b alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch/JAATOF01.1.fa_aligned_sorted.bam 
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch
samtools coverage JAATOF01.1.fa_aligned_sorted.bam -o coverage.txt

```







KAT was used to assess the completeness of the SPAdes assembly:
```bash
for Assembly in $(ls assembly/spades/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f4 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f5 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/spades/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/assemblers/assembly_qc/kat
  qsub $ProgDir/sub_kat.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
done
```

###ATLAS
A bioconda installation of ATLAS was performed

```bash
cd /projects/nano_diagnostics
mkdir -p assembly/genome/P_leucotricha/THeavenp11_1/ATLAS

atlas init -w assembly/genome/P_leucotricha/THeavenp11_1/ATLAS --db-dir assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/test_reads
# bins corrected
nano assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/samples.tsv
# contaminant genomes to be removed added to database directory
#phiX
ln -s /projects/nano_diagnostics/assembly/genome/NCBI/phix/NC_001422.fa assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/NC_001422.fa
#Human
ln -s /projects/nano_diagnostics/assembly/genome/NCBI/primate/H.sapiens/GCA_000001405.15_GRCh38_genomic.fa assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/GCA_000001405.15_GRCh38_genomic.fa
#Apple
ln -s /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/databases/GDDH13_1-1_formatted.fasta
# config file edited to remove contaminants
nano assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml

cookiecutter --output-dir ~/.config/snakemake https://github.com/metagenome-atlas/clusterprofile.git
#profile_name [cluster]: cluster
#cluster_system [slurm]: slurm

nano ~/.config/snakemake/cluster/cluster_config.yaml
#left unaltered

screen -r
conda activate ATLAS
atlas run all -w assembly/genome/P_leucotricha/THeavenp11_1/ATLAS -c assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml --profile cluster
```