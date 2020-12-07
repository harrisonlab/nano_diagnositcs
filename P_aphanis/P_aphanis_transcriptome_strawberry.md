# P.aphanis transcriptome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis as part of Nano Diagnistics PhD.

## Collecting raw RNASeq data

A subfolder for strawberry mildew work was created:
```bash
mkdir P_aphanis
```
All following commands were exectuted from this folder.

Raw sequence data from F.anannassa was copied from long term storage in /archives to the working folder /projects/nano_diagnostics/

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

Raw sequence data from F.vesca generated by Jambagi et al. was downloaded.
```bash
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419272/Hawaii0_R1.fq.gz -P rawdata/P_aphanis/Jambagi/ControlHawaii/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419272/Hawaii0_R2.fq.gz -P rawdata/P_aphanis/Jambagi/ControlHawaii/R
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419273/Hawaii1dai_R1.fq.gz -P rawdata/P_aphanis/Jambagi/1DAIHawaii/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419273/Hawaii1dai_R2.fq.gz -P rawdata/P_aphanis/Jambagi/1DAIHawaii/R
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419274/Hawaii8dai_R1.fq.gz -P rawdata/P_aphanis/Jambagi/8DAIHawaii/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR419/ERR419274/Hawaii8dai_R2.fq.gz -P rawdata/P_aphanis/Jambagi/8DAIHawaii/R
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424891/YellowWonder0_R1.fq.gz -P rawdata/P_aphanis/Jambagi/ControlYellowWonder/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424891/YellowWonder0_R2.fq.gz -P rawdata/P_aphanis/Jambagi/ControlYellowWonder/R
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424892/YellowWonder1dai_R1.fq.gz -P rawdata/P_aphanis/Jambagi/1DAIYellowWonder/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424892/YellowWonder1dai_R2.fq.gz -P rawdata/P_aphanis/Jambagi/1DAIYellowWonder/R
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424893/YellowWonder8dai_R1.fq.gz -P rawdata/P_aphanis/Jambagi/8DAIYellowWonder/F
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR424/ERR424893/YellowWonder8dai_R2.fq.gz -P rawdata/P_aphanis/Jambagi/8DAIYellowWonder/R
```

## Quality controlling RNASeq data

Fastqc was installed

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

Trinity was installed.

Trinity runs with sample data demonstrated that using .fq files was resulting in errors. Quality controlled reads were therefore converted from .fq to .fa
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




########!!!!!!!!!!! trancriptome





```bash
#a trinity instance of bioconda was opened
screen -S conda_trinity
conda activate trinity
conda install -c bioconda jellyfish


#Trinity de novo transcriptome assembly was run for all quality controlled reads
for ReadDir in $(ls -d dna_qc/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/F/*trim.fa)
 Rread=$(ls $ReadDir/R/*trim.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir|sed 's@dna_qc@assembly/transcriptome@g')
OutDir2=$(echo $OutDir|sed 's@RNAexp1@RNAexp1/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir2 
done
#346617
#346697
#jellyfish: error while loading shared libraries: libjellyfish-2.0.so.2: cannot open shared object file: No such file or directory

# manually enter the path to manual install of jellyfish in trinity code replacing 'which jellyfish' with /home/heavet/git_repos/tools/prog/jellyfish/jellyfish-2.3.0/bin/jellyfish before line 3880, this did not work and was returned to 'which jellyfish', trinity then worked, I do not understand what fixed the problem.
#Installations of jellyfish now exist here: /home/heavet/git_repos/tools/prog/jellyfish/jellyfish-2.3.0/bin/jellyfish and here: /home/heavet/miniconda3/envs/trinity/bin/jellyfish
# configure and install of manual install jellyfish was repeated
# libjellyfish-2.0.so.2 is located at ~/git_repos/tools/prog/jellyfish/lib and /home/heavet/miniconda3/envs/trinity/bin/jellyfish/lib

#Trinity de novo transcriptome assembly was run for unnmapped reads
for ReadDir in $(ls -d alignment/STAR/P_aphanis/RNAexp1/*); do
 Fread=$(ls $ReadDir/*.F.fa)
 Rread=$(ls $ReadDir/*.R.fa)
ls $Fread
ls $Rread
ProgDir=~/git_repos/tools/seq_tools/RNAseq
OutDir=$(echo $ReadDir/unaligned|sed 's@alignment/STAR@assembly/transcriptome@g')
OutDir2=$(echo $OutDir|sed 's@RNAexp1@RNAexp1/trinity@g')
sbatch $ProgDir/ssub_trinity.sh $Fread $Rread $OutDir2 
done
#346698
#346699
#All trinity assemblies now completed successfully
```
The software rnaQUAST for quality evaluation and assessment of de novo transcriptome assemblies was installed along with dependencies; gffutils, matplotlib, joblib, GMAP, BLASTN.

When a reference genome is unavailable it is recommended to run rnaQUAST with BUSCO and GeneMarkS-T options. This required the additional installation of depedancies; GeneMarkS-T, BUSCO, tblastn, HMMER and transeq.

A profile library for the leotiomycetes was downloaded for use with BUSCO.
```bash
mkdir ~/git_repos/tools/prog/busco/libraries
cd ~/git_repos/tools/prog/busco/libraries
wget https://busco-data.ezlab.org/v4/data/lineages/leotiomycetes_odb10.2019-11-20.tar.gz
tar -zxvf leotiomycetes_odb10.2019-11-20.tar.gz
```
Running rnaQUAST:
```bash
screen -S rnaquast
srun --partition long --time 0-72:00:00 --mem 100G --cpus-per-task 1 --pty bash
conda activate rnaquast

mkdir assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/unaligned/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/unaligned/trinity_out_dir/Trinity.fasta --output_dir assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/unaligned/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/unaligned/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/assembly/assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/unaligned/trinity_out_dir/Trinity.fasta --output_dir assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/unaligned/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/assembly/assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/trinity_out_dir/Trinity.fasta --output_dir assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/trinity_out_dir/Trinity.fasta --output_dir assembly/transcriptome/P_aphanis/RNAexp1/trinity/control/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

exit
#run of all 4 started 3:24, 20/07/2020 in screen 17810.rnaquast
```
The podosphaera xanthii shotgun assembled transcriptome was downloaded - assembled using trinity by Angelini et al.
```bash
mkdir -p rawdata/P_xanthii/AngeliniExp/transcriptome/

cd rawdata/P_xanthii/AngeliniExp/transcriptome/

#no download from ncbi available
wget ftp://ftp.ebi.ac.uk/pub/databases/ena/tsa/public/gh/GHEF01.fasta.gz

gunzip GHEF01.fasta.gz 
```
The podosphaera xanthii epiphytic transcriptome was downloaded - assembled using MIRA3 & euler by D.Corsia
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
The different transcriptomes were moved to a shared folder structure
```bash
cd /projects/nano_diagnostics
mkdir -p assembly/transcriptome/P_pannosa/N_FonsecaExp/trinity/assembly
cp  rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt assembly/transcriptome/P_pannosa/N_FonsecaExp/trinity/assembly

mkdir -p assembly/transcriptome/P_xanthii/D_CorsiaExp/MIRA3/assembly
cp  rawdata/P_xanthii/D_CorsiaExp/transcriptome/GEUO01.1.fsa_nt assembly/transcriptome/P_xanthii/D_CorsiaExp/MIRA3/assembly

mkdir -p assembly/transcriptome/P_xanthii/AngeliniExp/trinity/assembly
cp  rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta assembly/transcriptome/P_xanthii/AngeliniExp/trinity/assembly

mkdir -p assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/assembly
cp  assembly/transcriptome/P_aphanis/RNAexp1/trinity/infected/unaligned/trinity_out_dir/Trinity.fasta assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/assembly
```
Rnaquast was run on each mildew assembly
```bash
srun --partition long --time 0-72:00:00 --mem 100G --cpus-per-task 1 --pty bash
conda activate rnaquast

mkdir -p assembly/transcriptome/P_xanthii/AngeliniExp/trinity/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta --output_dir assembly/transcriptome/P_xanthii/AngeliniExp/trinity/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir -p assembly/transcriptome/P_xanthii/D_CorsiaExp/MIRA3/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_xanthii/D_CorsiaExp/transcriptome/GEUO01.1.fsa_nt --output_dir assembly/transcriptome/P_xanthii/D_CorsiaExp/MIRA3/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir -p assembly/transcriptome/P_pannosa/N_FonsecaExp/trinity/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt --output_dir assembly/transcriptome/P_pannosa/N_FonsecaExp/trinity/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10

mkdir -p assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/rnaquast
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/assembly/Trinity.fasta --output_dir assembly/transcriptome/P_aphanis/HeavenRNAexp1/trinity/rnaquast --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/leotiomycetes_odb10
exit
```

# From here on pipeline is a work in progress

RNAquast produces BUSCO results, the library used during RNAquast analysis was a database for the order leotiomycetes. BUSCO analysis was repeated separately at the level of class, phylum and kingdom with databases for leotiomycetes, ascomycota and fungi respectively.
```bash
conda activate BUSCO

for transcriptome in $(echo assembly/transcriptome/*/*/*/assembly); do
	Data=$(ls $transcriptome/*) 
	Input=$(dirname $transcriptome)
	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m transcriptome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics
done

for transcriptome in $(echo assembly/transcriptome/*/*/*/assembly); do
	Data=$(ls $transcriptome/*) 
	Input=$(dirname $transcriptome)
	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m transcriptome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics
done

for transcriptome in $(echo assembly/transcriptome/*/*/*/assembly); do
	Data=$(ls $transcriptome/*) 
	Input=$(dirname $transcriptome)
	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m transcriptome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
```
A P.aphanis genome assembly was accessed
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
































Erysiphales genome assemblies were downloaded from NCBI, the best of each of the 10 species represented. These were concatenated into a single file for database creation.
```bash
#downloading erysiphales genomes
mkdir -p /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales

ncbi-genome-download --dry-run --species-taxid 5120 fungi
#does not work

wget -P P_leocotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip P_leocotricha/JAATOF01.1.fsa_nt.gz

wget -P B_graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz 
gunzip B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz

wget -P E_necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
gunzip E_necator/GCA_000798715.1_ASM79871v1_genomic.fna.gz

wget -P E_pisi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/208/805/GCA_000208805.1_ASM20880v1/GCA_000208805.1_ASM20880v1_genomic.fna.gz
gunzip E_pisi/GCA_000208805.1_ASM20880v1_genomic.fna.gz

wget -P E_pulchra https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/918/395/GCA_002918395.1_ASM291839v1/GCA_002918395.1_ASM291839v1_genomic.fna.gz
gunzip E_pulchra/GCA_002918395.1_ASM291839v1_genomic.fna.gz

wget -P G_cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/235/GCA_003611235.1_ASM361123v1/GCA_003611235.1_ASM361123v1_genomic.fna.gz 
gunzip G_cichoracearum/GCA_003611235.1_ASM361123v1_genomic.fna.gz

wget -P G_magnicellulatus https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/006/912/115/GCA_006912115.1_ASM691211v1/GCA_006912115.1_ASM691211v1_genomic.fna.gz 
gunzip G_magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.fna.gz

wget -P O_heveae https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/957/845/GCA_003957845.1_ASM395784v1/GCA_003957845.1_ASM395784v1_genomic.fna.gz 
gunzip O_heveae/GCA_003957845.1_ASM395784v1_genomic.fna.gz 

wget -P O_neolycopersici https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/610/855/GCA_003610855.1_ASM361085v1/GCA_003610855.1_ASM361085v1_genomic.fna.gz 
gunzip O_neolycopersici/GCA_003610855.1_ASM361085v1_genomic.fna.gz 

wget -P P_xanthii https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/010/015/925/GCA_010015925.1_POXAN_niab_assembly/GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz 
gunzip P_xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz 

#modifying files to include taxid information
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales

sed 's@>@>P_leucotricha_@g' P_leocotricha/JAATOF01.1.fsa_nt > P_leocotricha/JAATOF01.1.fa

sed 's@>@>P_xanthii_@g' P_xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.fna > P_xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.fa

sed 's@>@>O_neolycopersici_@g' O_neolycopersici/GCA_003610855.1_ASM361085v1_genomic.fna > O_neolycopersici/GCA_003610855.1_ASM361085v1_genomic.fa

sed 's@>@>O_heveae_@g' O_heveae/GCA_003957845.1_ASM395784v1_genomic.fna > O_heveae/GCA_003957845.1_ASM395784v1_genomic.fa

sed 's@>@>G_magnicellulatus_@g' G_magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.fna > G_magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.fa

sed 's@>@>G_cichoracearum_@g' G_cichoracearum/GCA_003611235.1_ASM361123v1_genomic.fna > G_cichoracearum/GCA_003611235.1_ASM361123v1_genomic.fa

sed 's@>@>E_pulchra_@g' E_pulchra/GCA_002918395.1_ASM291839v1_genomic.fna > E_pulchra/GCA_002918395.1_ASM291839v1_genomic.fa

sed 's@>@>E_pisi_@g' E_pisi/GCA_000208805.1_ASM20880v1_genomic.fna > E_pisi/GCA_000208805.1_ASM20880v1_genomic.fa

sed 's@>@>E_necator_@g' E_necator/GCA_000798715.1_ASM79871v1_genomic.fna > E_necator/GCA_000798715.1_ASM79871v1_genomic.fa

sed 's@>@>E_necator_@g' B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna > B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fa

#concatenating into a single file
cat P_leocotricha/JAATOF01.1.fa P_xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.fa O_neolycopersici/GCA_003610855.1_ASM361085v1_genomic.fa O_heveae/GCA_003957845.1_ASM395784v1_genomic.fa G_magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.fa G_cichoracearum/GCA_003611235.1_ASM361123v1_genomic.fa E_pulchra/GCA_002918395.1_ASM291839v1_genomic.fa E_pisi/GCA_000208805.1_ASM20880v1_genomic.fa E_necator/GCA_000798715.1_ASM79871v1_genomic.fa B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fa > myerysiphalesdb.fasta

#creating a blast database
makeblastdb -in myerysiphalesdb.fasta -out myerysiphalesdb -parse_seqids -title "Podosphaera database" -dbtype nucl
```

















































A profile library of conserved fungal orthologs was downloaded for use with BUSCO.
```bash
cd ~/git_repos/tools/prog/busco/libraries
wget https://busco-archive.ezlab.org/v1/files/fungi_buscos.tar.gz
tar -zxvf fungi_buscos.tar.gz
```
```bash
conda activate rnaquast
cd /projects/nano_diagnostics
mkdir -p assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/BUSCO/fungi
cd assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/BUSCO/fungi
python ~/git_repos/tools/prog/busco/busco-3.0.2/scripts/run_BUSCO.py -m transcriptome -i /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt -o . -l ~/git_repos/tools/prog/busco/libraries/fungi
```

/home/heavet/miniconda3/envs/rnaquast/bin/tblastn

RNAquast analysis was repeated with the conserved fungi library insteead of leotiomycetes as this is currently the only way BUSCO is running successfully.
```bash
srun --partition long --time 0-72:00:00 --mem 100G --cpus-per-task 1 --pty bash
conda activate rnaquast
cd /projects/nano_diagnostics

mkdir assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/rnaquast2
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/trinity_out_dir/Trinity.fasta --output_dir assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/rnaquast2 --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/fungi

mkdir -p assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/rnaquast2
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt --output_dir assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/rnaquast2 --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/fungi

mkdir -p assembly/trancriptome/trinity/P_xanthii/D_CorsiaExp/rnaquast2
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_xanthii/D_CorsiaExp/transcriptome/GEUO01.1.fsa_nt --output_dir assembly/trancriptome/trinity/P_xanthii/D_CorsiaExp/rnaquast2 --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/fungi

mkdir -p assembly/trancriptome/trinity/P_xanthii/AngeliniExp/rnaquast2
python ~/git_repos/tools/prog/rnaQUAST/rnaQUAST-2.0.1/rnaQUAST.py --transcripts /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta --output_dir assembly/trancriptome/trinity/P_xanthii/AngeliniExp/rnaquast2 --debug --busco_lineage ~/git_repos/tools/prog/busco/libraries/fungi

echo "complete"

exit
```
```bash

cd /projects/nano_diagnostics
mkdir -p assembly/trancriptome/trinity/P_xanthii/AngeliniExp/BUSCO/fungi/1
cd assembly/trancriptome/trinity/P_xanthii/AngeliniExp/BUSCO/fungi

busco -f -m transcriptome -i /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta -o 1 -l fungi_odb10

        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:94.3%[S:52.0%,D:42.3%],F:1.6%,M:4.1%,n:758     |
        |715    Complete BUSCOs (C)                       |
        |394    Complete and single-copy BUSCOs (S)       |
        |321    Complete and duplicated BUSCOs (D)        |
        |12     Fragmented BUSCOs (F)                     |
        |31     Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------
cd /projects/nano_diagnostics
mkdir -p assembly/trancriptome/trinity/P_xanthii/D_CorsiaExp/BUSCO/fungi/1
cd assembly/trancriptome/trinity/P_xanthii/D_CorsiaExp/BUSCO/fungi

busco -f -m transcriptome -i /projects/nano_diagnostics/rawdata/P_xanthii/D_CorsiaExp/transcriptome/GEUO01.1.fsa_nt -o 1 -l fungi_odb10

        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:65.0%[S:57.3%,D:7.7%],F:17.7%,M:17.3%,n:758    |
        |492    Complete BUSCOs (C)                       |
        |434    Complete and single-copy BUSCOs (S)       |
        |58     Complete and duplicated BUSCOs (D)        |
        |134    Fragmented BUSCOs (F)                     |
        |132    Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------

cd /projects/nano_diagnostics
mkdir -p assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/BUSCO/fungi/1
cd assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/BUSCO/fungi

busco -f -m transcriptome -i /projects/nano_diagnostics/assembly/trancriptome/trinity/P_aphanis/RNAexp1/infected/unaligned/trinity_out_dir/Trinity.fasta -o 1 -l fungi_odb10


        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:56.4%[S:16.4%,D:40.0%],F:23.4%,M:20.2%,n:758   |
        |427    Complete BUSCOs (C)                       |
        |124    Complete and single-copy BUSCOs (S)       |
        |303    Complete and duplicated BUSCOs (D)        |
        |177    Fragmented BUSCOs (F)                     |
        |154    Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------

cd /projects/nano_diagnostics
mkdir -p assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/BUSCO/fungi/1
cd assembly/trancriptome/trinity/P_pannosa/N_FonsecaExp/BUSCO/fungi

busco -f -m transcriptome -i /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt -o 1 -l fungi_odb10

        --------------------------------------------------
        |Results from dataset fungi_odb10                 |
        --------------------------------------------------
        |C:46.6%[S:31.0%,D:15.6%],F:9.9%,M:43.5%,n:758    |
        |353    Complete BUSCOs (C)                       |
        |235    Complete and single-copy BUSCOs (S)       |
        |118    Complete and duplicated BUSCOs (D)        |
        |75     Fragmented BUSCOs (F)                     |
        |330    Missing BUSCOs (M)                        |
        |758    Total BUSCO groups searched               |
        --------------------------------------------------

python BUSCO_v1.1b.py -o NAME -in TRANSCRIPTOME -l LINEAGE -m trans

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
The results of quast were displayed:
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