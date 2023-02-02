# P.leucotricha genome assembly and annotation pipeline

Documentation of analysis and commands used with P.leucotricha as part of Nano Diagnistics PhD.

All following commands were execited on the NIAB HPC from the folder /projects/nano_diagnostics up to gene prediction steps, at this point files were moved to the Crop Diversity HPC and commands were executed from the /home/theaven/scratch directory.

All bowtie2 folders have been subsequently deleted to save space.

All genomes that were stored in /data/scratch/heavet/assembly/genome have been moved to the crop diversity hpc to save space

# 2020 sample

## Collecting data

Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

RNA:
```bash
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/RNA1/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/RNA1/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/RNA2/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/RNA2/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/RNA/1/all

ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP201/THMLAP201_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA1/F/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP201/THMLAP201_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA1/R/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP202/THMLAP202_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA2/F/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP202/THMLAP202_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA2/R/.

ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP201/THMLAP201_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA/1/all/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP201/THMLAP201_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA/1/all/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP202/THMLAP202_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA/1/all/.
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22012893-Z01-F001/X204SC22012893-Z01-F001/raw_data/THMLAP202/THMLAP202_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/RNA/1/all/.
```

DNA:

```bash
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/F
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/R
mkdir -p rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all

ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/F/p11_1_f.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/R/p11_1_r.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_f.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F001/X204SC20072200-Z01-F001/raw_data/TH119062020/TH119062020_EDMS200008152-1a_HCYHHDSXY_L4_2.fq.gz  rawdata/P_leucotricha/THeavenp11_1/paired/001/1/all/p11_1_r.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/F/p11_2_f.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/R/p11_2_r.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all/p11_2_f.fq.gz
ln -s /archives/2020_niabemr_general/X204SC20072200-Z01-F002/X204SC20072200-Z01-F002/raw_data/TH119062020/TH119062020_EDMS200008152-1a_H7HLGDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenp11_1/paired/002/1/all/p11_2_r.fq.gz
```
The golden delicious apple genome was linked from an existing download location within the cluster. Originally downloaded from https://iris.angers.inra.fr/gddh13/the-apple-genome-downloads.html
```bash
mkdir -p /projects/nano_diagnostics/assembly/genome/NCBI/rosales

ln -s /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta
```
The yeast reference genome was downloaded
```bash
mkdir -p assembly/genome/NCBI/S.cerevisiae
cd assembly/genome/NCBI/S.cerevisiae
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.fna.gz
gunzip GCF_000146045.2_R64_genomic.fna.gz
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
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/F/p11_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/R/p11_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854
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

zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz | echo $((`wc -l`/4))
#37,269,400
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,867,698
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz | echo $((`wc -l`/4))
#37,269,400
zcat dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#375,713
```
The data was visualised following trimming.
```bash
for RawData in $(ls dna_qc/P_leucotricha/*/*/002/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
```
```bash
mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/F
touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim.fq.gz

cat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenp11_1THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/R
touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim.fq.gz
cat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenp11_1THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/MiSeq/THeavenp11_1THeavenp11_1/paired/all/F/P_leucotricha-MiSeq-THeavenp11_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenp11_1THeavenp11_1/paired/all/R/P_leucotricha-MiSeq-THeavenp11_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfilpe
done
#19037, 19228

screen -S fastqc
srun -p long  --mem 50G --pty bash 
touch dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired_2.fq.gz
for read in $(ls dna_qc/P_leucotricha/THeavenp11_1/paired/00*/*/*trim*.fq.gz); do
    cat $read >> dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired_2.fq.gz
done
exit
exit

for RawData in $(ls dna_qc/P_leucotricha/MiSeq/THeavenp11_1/paired/all/P_leucotricha-MiSeq-THeavenp11_1-paired-all_trim_unpaired_2.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#19231
```

```bash
for read in $(ls /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/00*/*/*trim*.fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/THeavenp11_1/.
done
for read in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/00*/*/*trim*fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/THeavenOGB2019_1/.
done
for read in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/00*/*/*trim*fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/leucotricha/THeavenOGB2021_1/.
done
for read in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/00*/*/*trim*fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/aphanis/THeavenSCOTT2020_1/.
done
for read in $(ls /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenDRCT72020_1/paired/00*/*/*trim*fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/aphanis/THeavenDRCT72020_1/.
done
for read in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenDRCT72021_1/paired/00*/*/*trim*fq.gz); do
    scp -r $read theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/raw_data/DNA/Podosphaera/aphanis/THeavenDRCT72021_1/.
done

mkdir -p alignment/Malus/domestica/bowtie2
mkdir alignment/Podosphaera/leucotricha/bowtie2
mkdir -p alignment/Podosphaera/cerasii/bowtie2
mkdir -p alignment/Podosphaera/xanthii/bowtie2
mkdir -p alignment/Blumeria/graminis/bowtie2
mkdir -p alignment/Erysiphe/necator/bowtie2
mkdir -p alignment/Fragaria/ananassa/bowtie2

screen -S bowtie4
srun -J bowtie2 -p long --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/malus/domestica/GDDH13_1-1_formatted.fna apple_index
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/JAATOF01.c.fna apple_mildew_index
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.c.fna cherry_mildew_index
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii/GCA_014884795.1_ASM1488479v1_genomic.c.fna curcubit_mildew_index
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.c.fna wheat_mildew_index
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/Erysiphe/necator/GCA_000798715.1_ASM79871v1_genomic.c.fna grape_mildew_index
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.c.fna strawberry_index
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
bowtie2-build /home/theaven/scratch/data/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.c.fna raspberryberry_index

for assembly in $(echo Pleucotricha2019); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2019_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done

for assembly in $(echo Pleucotricha2021); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2021_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done

for assembly in $(echo Pleucotricha2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2020_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done

for assembly in $(echo Paphanis2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis2020_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done

for assembly in $(echo Paphanis2021); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis2021_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done

for assembly in $(echo Paphanis_rasp_2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis_rasp_2020_bowtie2.sh
cd /home/theaven/scratch/alignment/Malus/domestica/bowtie2
sbatch $ProgDir apple_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/leucotricha/bowtie2
sbatch $ProgDir apple_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/cerasii/bowtie2
sbatch $ProgDir cherry_mildew_index $assembly
cd /home/theaven/scratch/alignment/Podosphaera/xanthii/bowtie2
sbatch $ProgDir curcubit_mildew_index $assembly
cd /home/theaven/scratch/alignment/Blumeria/graminis/bowtie2
sbatch $ProgDir wheat_mildew_index $assembly
cd /home/theaven/scratch/alignment/Erysiphe/necator/bowtie2
sbatch $ProgDir grape_mildew_index $assembly
cd /home/theaven/scratch/alignment/Fragaria/ananassa/bowtie2
sbatch $ProgDir strawberry_index $assembly
cd /home/theaven/scratch/alignment/Rubus/idaeus/bowtie2
sbatch $ProgDir raspberryberry_index $assembly
done
#Submitted batch job 2718224-2718271

conda deactivate
exit
exit
```

## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available apple apple and powdey mildew genomes downloaded from NCBI.

The following were performed with the first round of sequencing data.
```bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.64% overall alignment rate.
bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple.sam \
-S THeavenp11_1alignedapple.sam
#13.64% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the apple genome, this produced a 13.9% overall alignment rate.
screen -r #17810.rnaquast
bowtie2 -x apple_index -1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz -2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz -S THeavenp11_1alignedapplepairedonly.sam
#13.90% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the apple genome using a wrapper script, this produced a 13.05% overall alignment rate.
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
#13.05% overall alignment rate

#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.18% overall alignment rate.
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
#64.18% overall alignment rate

#an alignment of trimmed reads using only those reads still paired was made to the mildew genome using a wrapper script, this produced a 55.85% overall alignment rate.
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
#55.85% overall alignment rate
```
Alignments were also made with the second round of sequence data.
```bash
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.68% overall alignment rate.
bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedapple2.sam \
-S THeavenp11_1alignedapple2.sam
#13.68% overall alignment rate


#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.14% overall alignment rate.
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha2.sam \
-S THeavenp11_1alignedGananPleucotricha2.sam
#64.14% overall alignment rate

```
Alignments were then made using the combined first and second rounds of sequencing data.
```bash
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/apple

#An alignment of trimmed reads including unpaired reads was made to the apple genome, this produced a 13.67% overall alignment rate.

bowtie2 \
-x apple_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unalignedapple1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedapple1+2fr.fq.gz \
-S THeavenp11_1alignedapple1+2.sam
#13.67% overall alignment rate

grep -c '@' alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1*f.fq #49,544,211
grep -c '@' alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1*r.fq #49,544,211
grep -c '@' alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1*s.fq #3,241,390

#An alignment of trimmed reads including unpaired reads was made to the mildew genome, this produced a 64.18% overall alignment rate.
cd /projects/nano_diagnostics
conda activate bowtie2
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
bowtie2 \
-x applemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedGananPleucotricha1+2.sam \
-S THeavenp11_1alignedGananPleucotricha1+2.sam
#64.15% overall alignment rate

screen -S graminis
srun -p long  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P_graminis
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_graminis
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna P_graminis_index
(bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedP_graminisPleucotricha1+2.sam \
-S THeavenp11_1alignedP_graminisPleucotricha1+2.sam) 2> log.txt
echo finished
#2.42% overall alignment rate

screen -S caphanis
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/cockerton_P_aphanis
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/cockerton_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/genome/spades/P_aphanis/H_Cockerton/C1_no_strawberry/deconseq_appended/contigs_min_500bp_renamed.fasta cockerton_P_aphanis_index
(bowtie2 \
-x cockerton_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedcockerton_P_aphanisPleucotricha1+2.sam \
-S THeavenp11_1alignedcockerton_P_aphanisPleucotricha1+2.sam) 2> log.txt
echo finished
#18.28% overall alignment rate

screen -S E_necator
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/E_necator
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/E_necator
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna E_necator_index
(bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedE_necatorPleucotricha1+2.sam \
-S THeavenp11_1alignedE_necatorPleucotricha1+2.sam) 2> log.txt
echo finished
#5.12% overall alignment rate

screen -S P_xanthii
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/Angelini_P_xanthii
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/Angelini_P_xanthii
bowtie2-build /projects/nano_diagnostics/rawdata/P_xanthii/AngeliniExp/transcriptome/GHEF01.fasta Angelini_P_xanthii_index
(bowtie2 \
-x Angelini_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedAngelini_P_xanthiiPleucotricha1+2.sam \
-S THeavenp11_1alignedAngelini_P_xanthiiPleucotricha1+2.sam) 2> log.txt
echo finished
#11.04% overall alignment rate

screen -S P_pannosa
srun -p himem  --mem 350G --pty bash
cd /projects/nano_diagnostics
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/Fonseca_P_pannosa
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/Fonseca_P_pannosa
bowtie2-build /projects/nano_diagnostics/rawdata/P_pannosa/N_FonsecaExp/transcriptome/GHDE01.1.fsa_nt Fonseca_P_pannosa_index
(bowtie2 \
-x Fonseca_P_pannosa_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenp11_1unalignedFonseca_P_pannosaPleucotricha1+2.sam \
-S THeavenp11_1alignedFonseca_P_pannosaPleucotricha1+2.sam) 2> log.txt
echo finished
#2.52% overall alignment rate
```
### Coverage
The coverage of the reads was estimated
```bash
#Coverage with the first round of sequencing data was estimated.
samtools index -b alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch/JAATOF01.1.fa_aligned_sorted.bam 
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha/batch
samtools coverage JAATOF01.1.fa_aligned_sorted.bam -o coverage.txt
#NOTE: to get samtools coverage to work run not in a screen and outside the samtools conda environment

#Coverage of the second round of sequencing data was estimated.
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenp11_1alignedGananPleucotricha2.sam -o THeavenp11_1alignedGananPleucotricha2.bam
samtools sort --threads 8 -o THeavenp11_1alignedGananPleucotricha2_sorted.bam THeavenp11_1alignedGananPleucotricha2.bam
samtools index -@ 8 THeavenp11_1alignedGananPleucotricha2_sorted.bam THeavenp11_1alignedGananPleucotricha2_sorted.bam.index
samtools coverage THeavenp11_1alignedGananPleucotricha2_sorted.bam -o coverage2.txt

#Coverage of the combined data was estimated.
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenp11_1alignedGananPleucotricha1+2.sam -o THeavenp11_1alignedGananPleucotricha1+2.bam
samtools sort --threads 8 -o THeavenp11_1alignedGananPleucotricha1+2_sorted.bam THeavenp11_1alignedGananPleucotricha1+2.bam
samtools index -@ 8 THeavenp11_1alignedGananPleucotricha1+2_sorted.bam THeavenp11_1alignedGananPleucotricha1+2_sorted.bam.index
samtools coverage THeavenp11_1alignedGananPleucotricha1+2_sorted.bam -o coverage1+2.txt
```
### Kmer analysis toolkit
The quality of the first round of sequencing data was assessed using KAT.
```bash
#Sequencing reads were compared with the available apple powdery mildew genome, results were plotted with various settings
srun -p himem --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 100 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot100 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx
kat plot spectra-cn -x 1100 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot1100 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx
kat plot spectra-cn -u -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot2000u alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx
kat plot spectra-cn -m 10000 -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_gananplot9000 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan-main.mx

#Sequencing reads were compared with the available apple genome, results were plotted with various settings
mkdir -p alignment/P_leucotricha/THeavenp11_1/kat/apple
kat comp -m 21 -v -H 800000000 -I 800000000 -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz' assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -x 100 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx
kat plot spectra-cn -x 1100 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot1100 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx
kat plot spectra-cn -x 2000 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdelplot2000 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel-main.mx
```
The quality of the combined sequencing data was later assessed using KAT.
```bash
screen -r
srun -p himem --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Combined reads were compared to the available mildew genome and results plotted:
kat comp -m 15 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2 '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2plot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/reads_v_ganan1+2-main.mx

screen -r
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics
#Combined reads were compared to the available apple genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21 '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21plot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21-main.mx

kat plot spectra-cn -x 800 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21plot800 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21-main.mx

kat plot spectra-cn -x 1000 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21plot1000 alignment/P_leucotricha/THeavenp11_1/kat/apple/reads_v_gdel1+2-21-main.mx
```
## kraken2
```bash
screen -S kraken2_1
srun -p himem -J kraken2 --mem 250G --pty bash
conda activate kraken2
cd /projects/nano_diagnostics
mkdir -p dna_qc/P_leucotricha/THeavenp11_1/kraken
gunzip -k dna_qc/P_leucotricha/THeavenp11_1/paired/*/*/*.fq.gz
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_leucotricha/THeavenp11_1/kraken/ntoutput_#.txt \
--unclassified-out dna_qc/P_leucotricha/THeavenp11_1/kraken/ntunclassified_#.txt \
--classified-out dna_qc/P_leucotricha/THeavenp11_1/kraken/ntclassified_#.txt \
--report dna_qc/P_leucotricha/THeavenp11_1/kraken/ntreport_#.txt \
--use-names \
/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq
#   53711937 sequences classified (93.46%)
#   3760689 sequences unclassified (6.54%)
rm dna_qc/P_leucotricha/THeavenp11_1/paired/*/*/*.fq
conda deactivate
exit
exit
echo finished
```
## Assembly
Trimmed read that did not align to the apple genome were taken as raw data for assembly. Several assemblers; SPAdes, SPAdes --isolate, ATLAS, metaSPAdes and MEGAHIT were trialled. SPAdes was ultimately used.

```bash
#files were renamed to correct extensions for spades
mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.fq.1.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq.gz

mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2fr.fq.2.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq.gz

mv alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2s.fq.gz alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq.gz
#files needed to be unzipped for use with megahit
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq.gz
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq.gz
gunzip alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades
# himem, --careful flag used for mismatch correction, max memory 250gb, max threads 20
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
# Submitted batch job 580029  -250gb long
# Completed with warnings - (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 3

# himem, max memory 250gb, --isolate flag (recommended for high >100 coverage data), --careful therefore unavailable
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes_isolate.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
# Submitted batch job 580030  -250gb long
# Completed with warnings - (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 3

```
#### Quast
A conda installation of quast was performed.

Quast was used to assess the quality of genome assemblys:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/*/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
    conda deactivate
#19038
```
### metaSPAdes
metaSPAdes is included in the SPAdes toolkit. metaSPAdes supports only a single short read-read library which has to be paired-end. Mismatch correction is not available and coverage cuttoff cannot be specified.

Trimmed paired MiSeq reads were assembled using the program metaSPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades
# max memory 58gb, max threads 20
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@metaSPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $OutDir
    sbatch $ProgDir/submit_metaSPAdes.sh $F_Read $R_Read $OutDir 
  done
# Submitted batch job 578642 -58gb long anything higher will not run
# Completed
```
#### Quast
Quast was used to assess the quality of genome assembly:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/metaSPAdes/*/*/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
```
### MEGAHIT
A conda installation of megahit was performed

Trimmed paired MiSeq reads were assembled using the program megahit, contigs <500bp filtered out with --min-contig-len flag
```bash
conda activate megahit
# max memory 30,000,000,000 bytes, max threads 20, klist specified the same as with spades: 21,33,55,77,99,127
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@megahit@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_megahit.sh $F_Read $R_Read $S_Read $OutDir 
  done
# Submitted batch job 578644 -58gb long
# no output
# Submitted batch job 580031  -250gb long
# no output

mkdir assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/1
megahit -1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq -2 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq -o assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/2

megahit --verbose --k-list 21,33,55,77,99,127 --min-contig-len 500 -1 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-f.fq -2 alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-r.fq -r alignment/P_leucotricha/THeavenp11_1/bowtie2/apple/THeavenp11_1unalignedapple1+2-s.fq -o assembly/metagenome/P_leucotricha/THeavenp11_1/megahit/4

```
### ATLAS
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
#Finished job 108.
#1 of 146 steps (0.68%) done
#Error submitting jobscript (exit code 1):



config=assembly/genome/P_leucotricha/THeavenp11_1/ATLAS/config.yaml
workdir=assembly/genome/P_leucotricha/THeavenp11_1/ATLAS
ProgDir=~/git_repos/tools/seq_tools/assemblers
sbatch $ProgDir/sub_atlas.sh $config $workdir
#569879
```
### BUSCO
BUSCO was used to assess the completeness of the assemblies
```bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp.fasta) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/fungi/1
    cd $Input/BUSCO/fungi
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp.fasta) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/ascomycota/1
    cd $Input/BUSCO/ascomycota
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/*/*/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp.fasta) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/leotiomycetes/1
    cd $Input/BUSCO/leotiomycetes
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs); do 
    Data=$(ls $assembly/contigs_min_500bp.fasta) 
    ; Input=$(dirname $assembly);  
    mkdir -p $Input/BUSCO/fungi/1/2; 
    cd $Input/BUSCO/fungi/1;
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l fungi_odb10; 
    cd /projects/nano_diagnostics; 
    mkdir -p $Input/BUSCO/ascomycota/1/2; 
    cd $Input/BUSCO/ascomycota/1; 
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l ascomycota_odb10; 
    cd /projects/nano_diagnostics;  
    mkdir -p $Input/BUSCO/leotiomycetes/1/2; 
    cd $Input/BUSCO/leotiomycetes/1; 
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 2 -l leotiomycetes_odb10; 
    cd /projects/nano_diagnostics; done
```
For comparison purposes BUSCO was also run on a number of other species downloaded from NCBI; the published P.leucotricha genome, the yeast genome and the apple genome.
```bash
conda activate BUSCO
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/fungi/1
    cd $Input/BUSCO/fungi
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/ascomycota/1
    cd $Input/BUSCO/ascomycota
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/leotiomycetes/1
    cd $Input/BUSCO/leotiomycetes
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
conda activate BUSCO
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/fungi/1
    cd $Input/BUSCO/fungi
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/ascomycota/1
    cd $Input/BUSCO/ascomycota
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/leotiomycetes/1
    cd $Input/BUSCO/leotiomycetes
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/fungi/1
    cd $Input/BUSCO/fungi
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/ascomycota/1
    cd $Input/BUSCO/ascomycota
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
    cd /projects/nano_diagnostics
done
for assembly in $(echo assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta); do
    Data=$(ls $assembly) 
    Input=$(dirname $assembly)
    mkdir -p $Input/BUSCO/leotiomycetes/1
    cd $Input/BUSCO/leotiomycetes
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
echo fin
```
Based upon the BUSCO and quast results a SPAdes assembly was selected as of the best quality. This was then compared to the published Podosphaera leucotricha genome.

The existing Podosphaera leucotricha genome raw reads were downloaded.
```bash
mkdir /projects/nano_diagnostics/rawdata/P_leucotricha/ganan
pip install osfclient
osf -p reh8b clone rawdata/P_leucotricha/ganan
```
### KAT
KAT was used to re-estimate the coverage of our draft genome and the published P.leucotricha genome provided by our raw sequencing reads.
```bash
srun -p himem --pty bash
conda activate kat
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spades '/projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R2_001.fastq.gz' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#30797.asco

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_spades-main.mx
#our reads vs our assembly
screen -r
srun -p short  --mem 350G --pty bash
conda activate kat
cd /projects/nano_diagnostics

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/myreads_v_spades '/projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/myreads_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/apple/myreads_v_spades-main.mx

#their reads vs their assembly
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_ganan '/projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L001_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L002_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L003_R2_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R1_001.fastq.gz /projects/nano_diagnostics/rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/5732-PL3-HiSeqMetagenome_S9_L004_R2_001.fastq.gz' assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_gananplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/gananreads_v_ganan-main.mx
```
KAT was also used to compare the assembled contigs to the host apple genome and published apple mildew genome.
```bash
screen -r
srun -p himem --pty bash
conda activate kat
cd /projects/nano_diagnostics

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades2 'assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenp11_1/kat/apple/gdel_v_spadesplot300 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades2-main.mx

kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades3 'assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

kat plot spectra-cn -y 50000000 -x 10 -o alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spadesplot100-1 alignment/P_leucotricha/THeavenp11_1/kat/P_leucotricha/ganan_v_spades3-main.mx
```
## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. A number of programs were tried to identify the contents of our assembly; Metabat2, Concoct, Conterminator, Centrifuge, Kraken2
### CONCOCT
A conda installation of CONCOCT was performed.
```bash
#CONCOCT also requires assembled contigs and a BAM file with the mapping of reads to the contigs as an input. 

# adapted from https://github.com/BinPro/CONCOCT/tree/1.1.0

cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/concoct
cd analysis/P_leucotricha/THeavenp11_1/concoct 
conda activate concoct
# Slice contigs into smaller sequences
cut_up_fasta.py /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta -c 10000 -o 0 --merge_last -b contigs_10K.bed > contigs_10K.fa
 
# Generate coverage depth 
concoct_coverage_table.py contigs_10K.bed /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew/THeavenp11_1alignedmyapplemildew1+2.sorted.bam > coverage_table.tsv
 
# Execute CONCOCT
concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/
#ImportError: libmkl_rt.so: cannot open shared object file: No such file or directory
pip install dlib
 
# Merge sub-contig clustering into original contig clustering
merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv
 
# Create output folder for bins
mkdir concoct_output/fasta_bins
 
# Parse bins into different files
extract_fasta_bins.py /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins
```
https://onestopdataanalysis.com/binning/

### Centrifuge
Centrifuge has already been installed on slurm in the /scratch area.
```bash
# The following commands have been used to create a database with all fungal genomes on NCBI:
centrifuge-download -o library -m -a Any -d "fungi" genbank > seqid2taxid.map
centrifuge-download -o taxonomy taxonomy
cat library/fungi/*.fna > input-fungal-sequences.fna
centrifuge-build -p 4 --conversion-table seqid2taxid.map --taxonomy-tree taxonomy/nodes.dmp --name-table taxonomy/names.dmp input-fungal-sequences.fna fungi

#There is a database of fungi only at /data/scratch/gomeza/prog/centrifuge/
#There is a nucleotide database at /scratch/public_data/nt-centrifuge_12jan2021/nt

mkdir ~/git_repos/tools/seq_tools/metagenomics
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Metagenomics/centrifuge.sh ~/git_repos/tools/seq_tools/metagenomics/centrifuge.sh
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Metagenomics/centrifuge.sh ~/git_repos/tools/seq_tools/metagenomics/ag_centrifuge.sh
```
Centrifuge was run with a Fungi only database:
```bash
mkdir -p analysis/P_leucotricha/THeavenp11_1/centrifuge

#Centrifuge appears to run, at least by default, on reads rather than assembled contigs. This will be performed first for our filtered reads. -q flag used.
  for ReadDir in $(ls -d /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    echo $F_Read
    echo $R_Read
    echo $S_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/centrifuge.sh $Database $OutDir $F_Read $R_Read $S_Read
    done
#731047 - ERROR

#attempted with unedited version of a.gomez wrapper script.
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    echo $F_Read
    echo $R_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
    done
#737390 

#Following this a run with assembled contigs was attempted. -f flag used.
  for ReadDir in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta); do
    F_Read=$ReadDir
    echo $F_Read
    Database=fungi
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/contigs
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read
    done
#740029 - unsuccessful
```
Centrifuge was run with nt database.
```bash
#change database to /scratch/public_data/nt-centrifuge_12jan2021/
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    echo $F_Read
    echo $R_Read
    Database=nt
    OutDir=analysis/P_leucotricha/THeavenp11_1/centrifuge/reads/nt
    ProgDir=~/git_repos/tools/seq_tools/metagenomics
    sbatch $ProgDir/ag_centrifuge.sh $Database $OutDir $F_Read $R_Read
    done
#740638
```
###  Conterminator
```bash
head /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm this is fasta file
grep "^>" /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm this has many sequences
head /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm this is mapping file in correct format
grep -m 10 "X52703.1" /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm mapping file has example sequence from database file
grep "\s79249" /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map # confirm that Ganan P.leucotricha reads are in the mapping file
grep -m 10 "JAATOF010" /scratch/public_data/nt-centrifuge_12jan2021/nt.fa # confirm that Ganan P.leucotricha reads are in the sequence file - cannot confirm, file is not writable and ~350GB in size
sed 's/>P_leucotricha_/>/g' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa > /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa
#cat /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa  /scratch/public_data/nt-centrifuge_12jan2021/nt.fa #cannot perform this step without write permissions
mkdir -p analysis/P_leucotricha/THeavenp11_1/conterminator/nt/
screen -S conterminator
srun -p himem  --mem 350G --pty bash
conda activate conterminator 
conterminator dna /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod2.1.fa /scratch/public_data/nt-centrifuge_12jan2021/acc2tax.map analysis/P_leucotricha/THeavenp11_1/conterminator/nt/nt.result /scratch/public_data/tch
```

### Metabat2
A conda installation of metabat2 was performed
```bash
#metabat requires assembled contigs and a BAM file with the mapping of reads to the contigs as an input. Therefore trimmed reads were aligned to our metagenome assembly and formatted appropriately:
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew
conda activate bowtie2
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta myapplemildew_index
bowtie2 \
-x myapplemildew_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unalignedmyapplemildew1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedmyapplemildew1+2fr.fq.gz \
-S THeavenp11_1alignedmyapplemildew1+2.sam
samtools view -S -b THeavenp11_1alignedmyapplemildew1+2.sam > THeavenp11_1alignedmyapplemildew1+2.bam
samtools sort THeavenp11_1alignedmyapplemildew1+2.bam -o THeavenp11_1alignedmyapplemildew1+2.sorted.bam
samtools index THeavenp11_1alignedmyapplemildew1+2.sorted.bam
conda deactivate

#metabat2 was run
cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/metabat2
cd analysis/P_leucotricha/THeavenp11_1/metabat2
conda activate metabat2
runMetaBat.sh --saveCls --unbinned /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta /projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/myapplemildew/THeavenp11_1alignedmyapplemildew1+2.sorted.bam 
#Output 3 bins; size 262 (9 sequences), 2586 (106 sequences) and 35577kB (1743 sequences) + unbinned 11993 (3177 sequences) 7860 contigs - 2825 contigs missing?

#checkM was installed in the metabat2 conda environment
conda install checkm-genome

#focus was installed and run
pip3 install metagenomics-focus
pip3 install numpy
pip3 install scipy 
cd /projects/nano_diagnostics
mkdir -p analysis/P_leucotricha/THeavenp11_1/focus
focus -q /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs --list_output -o analysis/P_leucotricha/THeavenp11_1/focus

#metaphlan was installed
conda create -n metaphlan
conda activate metaphlan
conda install metaphlan=3.0=pyh5ca1d4c_2 --no-channel-priority
screen -r
srun -p short --mem 350G --pty bash
mkdir -p analysis/P_leucotricha/THeavenp11_1/metaphlan
metaphlan /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta --bowtie2out /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_bowtie2.bz2 --nproc 5 --input_type fasta -o /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_profile.txt

#KeyError: 'mpa_mpa_v30_CHOCOPhlAn_201901.tar'
```

### Kraken2
This is the program ultimately used for filtering our contigs. kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample. Several installations of kraken2 and setups of different databases were needed before the program eventually ran successfully.

#### Kraken2 - redundant
A conda installation of Kraken2 was performed and a standard database created.
```bash
#A kraken2 standard database was built for binning - had to repeat several times before taxo.k2d file was successfully downloaded
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/1
srun -p long  --mem 350G --pty bash
conda activate kraken2
kraken2-build --standard --db analysis/P_leucotricha/THeavenp11_1/kraken2/1

#Kraken2 analysis was performed
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta

#7860 sequences (51.51 Mbp) processed in 6.616s (71.3 Kseq/m, 467.14 Mbp/m).
#  2429 sequences classified (30.90%)
#  5431 sequences unclassified (69.10%)
#  19.4% return as human
```
The kraken2 standard database contains NCBI taxonomic information, as well as the complete genomes in RefSeq for the bacterial, archaeal, and viral domains, along with the human genome and a collection of known vectors (UniVec_Core). We are investigating a fungal plant pathogen and so the reference libraries for plants and fungi were also used.
```bash
#additional libraries were added to the standard database
screen -S krakenfungi
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2-build --download-library fungi --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library plant --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library protozoa --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-library UniVec --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
#Kraken2 analysis was performed
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#7860 sequences (51.51 Mbp) processed in 13.487s (35.0 Kseq/m, 229.17 Mbp/m).
#2429 sequences classified (30.90%)
#5431 sequences unclassified (69.10%)

#A fungi only database was created
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-library fungi --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
#taxo.k2d was again not downloaded properly by these commands the first time and so all was deleted and commands repeated, file downloaded successfully the second time
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#7860 sequences (51.51 Mbp) processed in 6.524s (72.3 Kseq/m, 473.75 Mbp/m).
#700 sequences classified (8.91%)
#7160 sequences unclassified (91.09%)
#detects zero fungi but 75 viruses despite the virus library not being used?
```
An alternative library download was tried sent by A.Armitage
```bash
#Alternative download scripts were downloaded from a git repo:
#* from https://github.com/R-Wright-1/peptides
#* following the discussion at https://github.com/DerrickWood/kraken2/issues/272
screen -S kraken
srun -p long  --mem 50G --pty bash
mkdir /scratch/public_data/tch
cd /scratch/public_data/tch
wget https://github.com/R-Wright-1/peptides/archive/refs/heads/master.zip
unzip master.zip
conda create -n biopython
conda activate biopython
conda update -n base conda
conda install -c conda-forge biopython
conda install pandas
mkdir tmp123
cd tmp123
DBNAME=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/kraken2/custom_kraken_db
kraken2-build --download-taxonomy --use-ftp --threads 20 --db $DBNAME 
#edit ../peptides-master/download_domain.py to http download
python ../peptides-master/download_domain.py --domain fungi --ext dna # 04052021
python ../peptides-master/download_domain.py --domain bacteria --complete True --ext dna 
python ../peptides-master/download_domain.py --domain plant --ext dna
python ../peptides-master/download_domain.py --domain vertebrate_mammalian --human True --complete True --ext dna
python ../peptides-master/download_domain.py --domain protozoa --ext dna 
python ../peptides-master/download_domain.py --domain archaea --ext dna 

python ../peptides-master/download_domain.py --domain plasmid --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain viral --complete True --ext dna
python ../peptides-master/download_domain.py --domain human --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain UniVec_Core --complete True --ext dna #unable to open assembly_summary.txt
echo complete
python ../peptides-master/download_domain.py --domain nt --ext dna #unable to open assembly_summary.txt

#Build a fungi only kraken database:
screen -S kraken2
srun -p himem  --mem 100G --pty bash
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
done
exit
echo finished

srun -p himem  --mem 490G --pty bash
kraken2-build --build --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
exit
echo finished 
#Run kraken with updated fungi only database
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#8.91% classified

#Build a kraken database:
 screen -S kraken2
srun -p long  --mem 100G --pty bash
for file in $(ls /scratch/public_data/tch/tmp123/archaea/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/bacteria/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/protozoa/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/viral/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
for file in $(ls /scratch/public_data/tch/tmp123/vertebrate_mammalian/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
done
exit
echo finished 
srun -p himem  --mem 490G --pty bash
kraken2-build --build --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
exit
echo finished 
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#2429 sequences classified (30.90%)

kraken2-build --add-to-library assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi #scan_fasta_file.pl: unable to determine taxonomy ID 
kraken2-build --add-to-library assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa  --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi #scan_fasta_file.pl: unable to determine taxonomy ID 

#Additional tools were downloaded to extract reads associated with each kraken2-identified taxon (https://github.com/jenniferlu717/KrakenTools)
srun --partition=short --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=1G --pty bash
cd ~/git_repos/tools/prog/kraken2/2
wget https://github.com/jenniferlu717/KrakenTools/archive/refs/tags/v1.0.1.tar.gz
exit
cd ~/git_repos/tools/prog/kraken2/2
tar -zxvf v1.0.1.tar.gz
chmod +x KrakenTools-1.0.1/*.py
chmod +x KrakenTools-1.0.1/*/*.py
#Added to PATH in ~/.profile
PATH=$HOME/git_repos/tools/prog/kraken2/KrakenTools-1.0.1:${PATH}
PATH=$HOME/git_repos/tools/prog/kraken2/KrakenTools-1.0.1/DiversityTools:${PATH}

#constructed databses were used with the published yeast genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputyeast.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outyeast.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outyeast.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportyeast.txt \
--use-names \
assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna
#  17 sequences classified (100.00%)
# 0 sequences unclassified (0.00%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputyeast.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outyeast.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outyeast.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportyeast.txt \
--use-names \
assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna
#  17 sequences classified (100.00%)
# 0 sequences unclassified (0.00%)

#constructed databses were used with the published P.leucotricha genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  632 sequences classified (7.08%)
#  8289 sequences unclassified (92.92%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  2415 sequences classified (27.07%)
#  6506 sequences unclassified (72.93%)

#constructed databses were used with the published V.inaequalis genome as a test
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#    135 sequences classified (56.72%)
#  103 sequences unclassified (43.28%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
#    228 sequences classified (95.80%)
#  10 sequences unclassified (4.20%)
```
The published P.leucotricha genome was added to the databases.
```bash
sed 's/ Podosphaera/|kraken:taxid|79249 Podosphaera/g' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa > /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa
grep "^>" /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa

3750
grep "^>" assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta


conda activate kraken2
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi
kraken2-build --download-taxonomy --use-ftp --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi 
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputganan2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outganan2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outganan2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportganan2.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  632 sequences classified (7.08%)
#  8289 sequences unclassified (92.92%)

kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/1
kraken2-build --download-taxonomy --use-ftp --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/1 2>&1 | tee krakenfungioutput.log

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputganan2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outganan2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outganan2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportganan2.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  2415 sequences classified (27.07%)
#  6506 sequences unclassified (72.93%)

screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/outputscab2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/unclassified-outscab2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/classified-outscab2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi/reportscab2.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  135 sequences classified (56.72%)
#  103 sequences unclassified (43.28%)
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/1 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/1/outputscab2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/unclassified-outscab2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/1/classified-outscab2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/1/reportscab2.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
#  228 sequences classified (95.80%)
#  10 sequences unclassified (4.20%)
```
A database containing all clades was created for the analysis of the assembly.
```bash
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/nt2
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee 3.log
for file in $(ls /scratch/public_data/tch/tmp123/archaea/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/bacteria/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/protozoa/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/viral/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/vertebrate_mammalian/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log 
done
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log
grep "|3750" /scratch/public_data/tch/tmp123/plant/*.fna # confirms that apple is in the plant database
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2
exit
exit
echo finished # taxo.k2d file missing >:()

#line 143:  2372 Exit 141                list_sequence_files
#      2373 Exit 125                | xargs -0 cat
#      2374 Killed                  | build_db -k $KRAKEN2_KMER_LEN -l $KRAKEN2_MINIMIZER_LEN -S $KRAKEN2_SEED_TEMPLATE $KRAKEN2XFLAG -H hash.k2d.tmp -t taxo.k2d.tmp -o opts.k2d.tmp -n taxonomy/ -m $seqid2taxid_map_file -c $required_capacity -p $KRAKEN2_THREAD_CT $max_db_flag -B $KRAKEN2_BLOCK_SIZE -b $KRAKEN2_SUBBLOCK_SIZE -r $KRAKEN2_MIN_TAXID_BITS $fast_build_flag

#The database was tested on a genome that should be within the database
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
# 8921 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

#The database was tested on a published genome not within the database
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  238 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

#The database was used on our assembly
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  7416 sequences classified (94.35%)
#  444 sequences unclassified (5.65%)
```
#### Kraken2 - final
A fungi database was created for the analysis of the assembly.
```bash
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3
kraken2-build --download-taxonomy --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee 1.log
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
done
kraken2-build --add-to-library /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.mod.1.fa --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
kraken2-build --build --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 2>&1 | tee -a 1.log
kraken2-build --clean --threads 20 --db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3
exit
exit
echo finished

#The database was tested on a genome that should be within the database
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/outputganan.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-outganan.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-outganan.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/reportganan.txt \
--use-names \
assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 
#  8921 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)

#The database was tested on a published genome not within the database
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/outputscab.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-outscab.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-outscab.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/reportscab.txt \
--use-names \
assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
#  222 sequences classified (93.28%)
#  16 sequences unclassified (6.72%)

#The database was used on our assembly
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/output.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/unclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/classified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3/report.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  6723 sequences classified (85.53%)
#  1137 sequences unclassified (14.47%)
```
Kraken rerun on our assembly using database containing all published mildew genomes and strawberry genome. Database creation detailed in https://github.com/harrisonlab/nano_diagnositcs/blob/master/P_aphanis/P_aphanis_genome_raspberry.md
```bash
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/unclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/classified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/report2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
#  7550 sequences classified (96.06%)
#  310 sequences unclassified (3.94%)
```
Kraken2 suggested a larger number of reads in our assembly are of human origin, to investigate this further unassembled trimmed reads were aligned to the human genome.
```bash
screen -S bowtie2
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/human
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/human
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/primate/H.sapiens/GCA_000001405.15_GRCh38_genomic.fa Human_index
bowtie2 \
-x Human_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unalignedhuman1+2s.fq.gz \
--un-conc-gz THeavenp11_1unalignedhuman1+2fr.fq.gz \
-S THeavenp11_1alignedhuman1+2.sam
#60306445 reads; of these:
#  56908048 (94.36%) were paired; of these:
#    56876068 (99.94%) aligned concordantly 0 times
#    6911 (0.01%) aligned concordantly exactly 1 time
#    25069 (0.04%) aligned concordantly >1 times
#    ----
#    56876068 pairs aligned concordantly 0 times; of these:
#      84 (0.00%) aligned discordantly 1 time
#    ----
#    56875984 pairs aligned 0 times concordantly or discordantly; of these:
#      113751968 mates make up the pairs; of these:
#        113393452 (99.68%) aligned 0 times
#        6153 (0.01%) aligned exactly 1 time
#        352363 (0.31%) aligned >1 times
#  3398397 (5.64%) were unpaired; of these:
#    3253868 (95.75%) aligned 0 times
#    1285 (0.04%) aligned exactly 1 time
#    143244 (4.22%) aligned >1 times
#0.48% overall alignment rate
```
Contaminant contigs were removed from the assembly
```bash
touch analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt
nano analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt

#Edited with the following: 

#Bacteria:
Buchnera 
Acinetobacter
Candidatus
Avibacterium
Vibrio
Campylobacter
Halarcobacter
Sphingobium
Clostridium
Cellulosilyticum
Staphylococcus
Paenibacillus
Streptomyces
Nocardiopsis
Pedobacter
#Archaea:
Methanosarcina
#Animals:
Homo sapiens
#Plants:
Embryophyta
Magnoliopsida
Mesangiospermae
Pentapetalae
rosids
fabids
Maleae
Malus
Rubus
Pyrus
Cannabis
50 kb inversion clade
Ziziphus
inversion
Phaseoleae
Vigna
Cajanus
Phaseolus
Glycine
Abrus
Medicago
Arachis
Lupinus
Prosopis
Quercus
Juglans
Hevea
Manihot
Jatropha
Ricinus
Populus
Cucurbitaceae
Benincasa
Cucumis
Cucurbita
Tripterygium
malvids
Malvoideae
Gossypium
Hibiscus
Durio
Brassica
Raphanus
Camelina
Arabidopsis
Rhodamnia
Eucalyptus
Syzygium
Punica
Pistacia
Citrus
asterids
Asteraceae
Lactuca
Helianthus
Cynara
Daucus
lamiids
Capsicum
Solanum
Nicotiana
Ipomoea
Olea europaea
Sesamum
Erythranthe
Coffea
Camellia
Chenopodium
Spinacia
Beta vulgaris
Petrosaviidae
Triticum
Panicum
Setaria
Zea mays
Ananas comosus
Arecaceae
Elaeis guineensis
Phoenix dactylifera
Dendrobium
Phalaenopsis
Dioscorea
Papaver
Nelumbo
Amborella
#Protists:
Plasmodium 
Theileria
Eimeria acervulina
#Algae:
Paramecium
Saprolegnia
#Amoeba:
Entamoeba
Dictyostelium
Trypanosoma
# These are the taxids identified by kraken2, excluding fungi identifed as these may be misidentifed mildew contigs given the lack of sequencing within the mildew clade.

# Most contaminat contigs are accounted for by Lactuca sativ and Mlaus domestica, a separate file was created for the other minor contaminants.
touch analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt
nano analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt

grep -f analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output2.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontigs.txt
grep -f analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantlist.txt analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/output2.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontigs.txt


nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontigs.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontigs.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontignames.txt

conda activate seqtk
seqtk subseq assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminants.fasta
seqtk subseq assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminantcontignames.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/minorcontaminants.fasta
conda deactivate

conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt > assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp.fasta > assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantlist.txt
wc -l analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/contaminantcontignames.txt #703
wc -l assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta #15720
wc -l assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta #14314
```
Following the removal of contaminant contigs, kraken2, BUSCO and quast analysis were performed again for the filtered assembly
```bash
screen -S kraken2
srun -p long  --mem 160G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredoutput.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredunclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredclassified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredreport.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
#  6614 sequences classified (93.71%)
#  444 sequences unclassified (6.29%)

#kraken rerunn with database containing all published mildew genomes and strawberry genome
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredoutput2.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredunclassified-out2.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredclassified-out2.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt2/filteredreport2.txt \
--use-names \
assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta
#  6847 sequences classified (95.67%)
#  310 sequences unclassified (4.33%)

conda deactivate
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
exit
exit
echo finished
conda deactivate
#busco scores higher now that some contigs removed? retest unfiltered in /2
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)/filtered
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#756881
```
### blobtools
```bash
scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_renamed2020.fasta 

scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_2020.fasta

#alignment of reads to unfiltered assembly
screen -S bowtie3
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta P112020_0_index
bowtie2 \
-x P112020_0_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unaligned_P112020_0_s.fq.gz \
--un-conc-gz THeavenp11_1unaligned_P112020_0_fr.fq.gz \
-S THeavenp11_1aligned_P112020_1+2_0.sam | tee -a report_0.txt
conda deactivate
exit
exit
echo finished

#alignment of reads to final assembly
screen -S bowtie2
srun -p himem -J bowtie --mem 250G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta P112020_index
bowtie2 \
-x P112020_index \
-1 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/F/P_leucotricha-THeavenp11_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/001/R/P_leucotricha-THeavenp11_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/F/P_leucotricha-THeavenp11_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/002/R/P_leucotricha-THeavenp11_1-paired-002_R_trim_unpaired.fq.gz \
--un-gz THeavenp11_1unaligned_P112020_s.fq.gz \
--un-conc-gz THeavenp11_1unaligned_P112020_fr.fq.gz \
-S THeavenp11_1aligned_P112020_1+2.sam | tee -a report.txt
conda deactivate
exit
exit
echo finished

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/*2020.fasta); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.fasta@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2642435
#Submitted batch job 2642436

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta
Coverage=/projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020/THeavenp11_1aligned_P112020_1+2.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19196
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp.fasta
Coverage=/projects/nano_diagnostics/alignment/P_leucotricha/THeavenp11_1/bowtie2/P112020/THeavenp11_1aligned_P112020_1+2_0.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenp11_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19205
conda deactivate
```
## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI reports (FCSreport.txt) were manually downloaded to the following locations:
```bash
mkdir -p genome_submission/P_leucotricha/THeavenp11_1/SPAdes/580029/NCBI_report_dir
mv genome_submission/P_leucotricha/THeavenp11_1/SPAdes/580029/NCBI_report_dir/Contamination.txt genome_submission/P_leucotricha/THeavenp11_1/SPAdes/580029/NCBI_report_dir/FCSreport.txt
```
These downloaded files were used to correct assemblies:
```bash
conda activate biopython2.7
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls genome_submission/P_leucotricha/THeavenp11_1/SPAdes/580029/NCBI_report_dir/FCSreport.txt)
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#780365
conda deactivate
```
Following feedback from reviews all contigs not identified as Leotiomycetes were removed.
```bash
screen -S kraken5
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029/ntoutput.txt \
--unclassified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029/ntunclassified-out.txt \
--classified-out analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029/ntclassified-out.txt \
--report analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029/ntreport.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta
#    6854 sequences classified (95.69%)
#    309 sequences unclassified (4.31%) 
conda deactivate
exit
exit
echo finished

touch analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantlist2.txt
nano analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantlist2.txt #edited to include all taxonomic hits not leotiomycetes

grep -f analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantlist2.txt analysis/P_leucotricha/THeavenp11_1/kraken2/nt/580029/ntoutput.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontigs2.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontigs2.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontignames2.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontignames2.txt > analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminants2.fasta
conda deactivate
conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontignames2.txt > assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp2.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/filtered_contigs_min_500bp2.fasta > /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta
wc -l analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantlist2.txt #43
wc -l analysis/P_leucotricha/THeavenp11_1/kraken2/nt/contaminantcontignames2.txt #358
wc -l /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta #14327
wc -l /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta #13610

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19002
conda deactivate

screen -S busco3
srun -p himem -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits); do
    Data=$(ls $assembly/contigs_min_500bp_renamed2.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/2/filtered
    cd $Input/BUSCO/fungi/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/ascomycota/2/filtered
    cd $Input/BUSCO/ascomycota/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
    cd /projects/nano_diagnostics

    mkdir -p $Input/BUSCO/leotiomycetes/2/filtered
    cd $Input/BUSCO/leotiomycetes/2
    busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
    cd /projects/nano_diagnostics
done
conda deactivate
exit
exit
echo finished
```
```bash
scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/.

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/.

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/.

scp -r /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/.

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/ncbi_edits/18994/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/ncbi_edits/.

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits2/contigs_min_500bp_renamed2.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits2/.
```
### Coverage
The coverage of the reads was estimated
```bash
mkdir -p alignment/P_leucotricha2019/bowtie2
mkdir -p alignment/P_leucotricha2020/bowtie2
mkdir -p alignment/P_leucotricha2021/bowtie2
mkdir -p alignment/P_aphanis2020/bowtie2
mkdir -p alignment/P_aphanis2021/bowtie2
mkdir -p alignment/P_aphanis_rasp2020/bowtie2

screen -S bowtie4
srun -J bowtie2 -p long --mem-per-cpu 8G --cpus-per-task 8 --pty bash

cd /home/theaven/scratch/alignment/P_leucotricha2019/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta apple2019_index
cd /home/theaven/scratch/alignment/P_leucotricha2020/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta apple2020_index
cd /home/theaven/scratch/alignment/P_leucotricha2021/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta apple2021_index
cd /home/theaven/scratch/alignment/P_aphanis2020/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed22.fasta strawberry2020_index
cd /home/theaven/scratch/alignment/P_aphanis2021/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenDRCT72021_1/SPAdes/18994/ncbi_edits/contigs_min_500bp_renamed.fasta strawberry2021_index
cd /home/theaven/scratch/alignment/P_aphanis_rasp2020/bowtie2
bowtie2-build /home/theaven/scratch/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits2/contigs_min_500bp_renamed2.fasta raspberry2020_index

for assembly in $(echo Pleucotricha2019); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2019_bowtie2.sh
cd /home/theaven/scratch/alignment/P_leucotricha2019/bowtie2
sbatch $ProgDir apple2019_index $assembly
done
for assembly in $(echo Pleucotricha2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2020_bowtie2.sh
cd /home/theaven/scratch/alignment/P_leucotricha2020/bowtie2
sbatch $ProgDir apple2020_index $assembly
done
for assembly in $(echo Pleucotricha2021); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Pleucotricha2021_bowtie2.sh
cd /home/theaven/scratch/alignment/P_leucotricha2021/bowtie2
sbatch $ProgDir apple2021_index $assembly
done
for assembly in $(echo Paphanis2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis2020_bowtie2.sh
cd /home/theaven/scratch/alignment/P_aphanis2020/bowtie2
sbatch $ProgDir strawberry2020_index $assembly
done
for assembly in $(echo Paphanis2021); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis2021_bowtie2.sh
cd /home/theaven/scratch/alignment/P_aphanis2021/bowtie2
sbatch $ProgDir strawberry2021_index $assembly
done
for assembly in $(echo Paphanis_rasp2020); do
    ProgDir=/home/theaven/scratch/apps/bowtie2/Paphanis_rasp_2020_bowtie2.sh
cd /home/theaven/scratch/alignment/P_aphanis_rasp2020/bowtie2
sbatch $ProgDir raspberry2020_index $assembly
done
#Submitted batch job 2737031-36
exit
exit

#Coverage of the second round of sequencing data was estimated.
cd alignment/P_leucotricha/THeavenp11_1/bowtie2/P_leucotricha
for alignment in $(ls /home/theaven/scratch/alignment/P*/bowtie2/*.sam | sed 's@.sam@@g'); do
samtools view --threads 8 -bS ${alignment}.sam -o ${alignment}.bam
samtools sort --threads 8 -o ${alignment}_sorted.bam ${alignment}.bam
samtools index -@ 8 ${alignment}_sorted.bam ${alignment}_sorted.bam.index
samtools coverage ${alignment}_sorted.bam -o ${alignment}_coverage.txt 
done
```
Identifying ITS regions:
```bash
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 

Assembly=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta 
its1=$(dirname $Assembly)/its1.fasta
its4=$(dirname $Assembly)/its4.fasta
its14=$(dirname $Assembly)/its14.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' $Assembly >> $its1
grep -B 1 'CGCAGGTTCACCTACGGA' $Assembly >> $its1
grep -B 1 'TCCTCCGCTTATTGATATGC' $Assembly >> $its4
grep -B 1 'GCATATCAATAAGCGGAGGA' $Assembly >> $its4
grep -f $its1 $its4 >> $its14
rm $its1
rm $its4
# only one contig contains both its1 and its4 primer hits, blasts to cladosporium and cercospora hits
exit
exit
```
## Annotation

### Mitofinder
Mitofinder was used to identify contigs in the assembly that belong to the mitochondrial genome.
```bash
mkdir -p rawdata/P_xanthii/KimS/mitochondrion/
cd rawdata/P_xanthii/KimS/mitochondrion/

#file uploaded of complete podosphaera xanthii mitochondrion from: https://www.ncbi.nlm.nih.gov/nuccore/MK674497.1?report=fasta&log$=seqview

conda activate Mitofinder
RefMtGb=$(ls rawdata/P_xanthii/KimS/mitochondrion)
NCBI_Code="4"
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta); do
  Prefix=P_leucotrichaTHeavenp11_1_MtDNA
  OutDir=$(dirname $Assembly)/mtDNA_mitofinder
  mkdir -p $OutDir
  ProgDir=~/git_repos/tools/seq_tools/assemblers
  echo $Prefix
  sbatch $ProgDir/sub_mitofinder.sh $Prefix $Assembly $RefMtGb $NCBI_Code $OutDir
done
#785092 - basic command not working, argument list too long

screen -S mito
srun -p long -c 10 --mem 50G --pty bash 
conda activate spades
ls /home/heavet/miniconda3/envs/Mitofinder/bin/mitofinder

cd assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/mtDNA_mitofinder
mitofinder \
  --seqid P_leucotrichaTHeavenp11_1_MtDNA \
  --tRNA-annotation mitfi \
  --adjust-direction \
  --new-genes \
  --max-contig-size 50000 \
  --circular-size 55 \
  --assembly /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta \
  --refseq /projects/nano_diagnostics/rawdata/P_xanthii/KimS/mitochondrion/pxanthiimito.gb \
  --organism 4 \
  --processors 10 \
  --max-memory 49
  #ERROR mitofinder is not installed?
```
### Assembly stats
```bash
mkdir -p /scratch/projects/heavet/prog/assemblystats
cd /scratch/projects/heavet/prog/assemblystats
git clone https://github.com/rjchallis/assembly-stats

conda activate assembly-stats
perl /scratch/projects/heavet/prog/assemblystats/assembly-stats/pl/asm2stats.pl assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta > /scratch/projects/heavet/prog/assemblystats/assembly-stats/json/applemildew.assembly-stats.json

nano /scratch/projects/heavet/prog/assemblystats/assembly-stats/applemildew.assembly-stats.json
#Edited to include BUSCO data:    "busco" : { "C" : 93.7,
#                                             "D" : 0.2,
#                                             "F" : 0.4,
#                                             "M" : 5.9,
#                                             "n" : 1706 }

#/scratch/projects/heavet/prog/assemblystats/assembly-stats was downloaded to the local machine to run html script with localhost:
http://localhost/assembly-stats/assembly-stats.html?path=json/&assembly=applemildew&view=circle&altView=cumulative&altView=table
```
### Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked/2
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling $ID
done
#784845, 2542133, 18981
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly)/filteredmasked/2
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI $ID
done
#784846, 2542134, 18982
conda deactivate
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands:
```bash
RepMaskGff=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=/projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/transposonPSI/heavet_contigs_unmasked.fa.TPSI.allHits.chains.gff3
printf "P_leucotricha/THeavenp11_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#22,276,747
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#7,468,634
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#Differing number of GFF fields encountered at line: 76245.  Exiting...
```
The TransposonPSI asked bases were used to mask additional bases from the repeatmasker softmasked files.
```bash
for File in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 23,280,855
```
The total length of the genome given by quast is 49,079,051bp if 23,280,855bp have been masked as repetative then 47.44% of the genome is made up of repeats.
```bash
scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/.
scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/.
```

## Gene prediction
RNAseq was performed on P. leucotricha to guide gene prediction. Gene prediction was performed using braker supplimented by additon predctions from codingquarry. Duplicated predictions were removed.

### RNA Alignment

Raw RNASeq reads can be found here:
```bash
ls rawdata/P_leucotricha/THeavenp11_1/paired/RNA1/
ls rawdata/P_leucotricha/THeavenp11_1/paired/RNA2/
```
These will be a mix of apple and strawberry powdery mildew RNASeq reads.

The raw RNAseq reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_leucotricha/THeavenp11_1/paired/RNA*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir
done
#17664
#17665
#17666
#17667
```
Raw RNASeq reads were trimmed using trimmomatic
```bash
for ReadDir in $(ls -d rawdata/P_leucotricha/THeavenp11_1/paired/RNA*); do
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
#17662
#17663
```
The trimmed reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls dna_qc/P_leucotricha/THeavenp11_1/paired/RNA*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir
done
#17815-17824
```
```bash
mkdir dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/F
mkdir dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/R
cat dna_qc/P_leucotricha/THeavenp11_1/paired/RNA1/F/*trim.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/RNA2/F/*trim.fq.gz > dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/F/P_leucotricha-THeavenp11_1-paired-RNA_F_trim.fq.gz
cat dna_qc/P_leucotricha/THeavenp11_1/paired/RNA1/R/*trim.fq.gz dna_qc/P_leucotricha/THeavenp11_1/paired/RNA2/R/*trim.fq.gz > dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/R/P_leucotricha-THeavenp11_1-paired-RNA_R_trim.fq.gz
```
STAR was used to align RNAseq data for P.leucotricha to our genome assembly.
```bash
scp -r /projects/nano_diagnostics/dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/* theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/dna_qc/P_leucotricha/THeavenp11_1/paired/RNA/.

scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/.

mkdir -p alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_1
conda activate STAR
for RNAdata in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/paired/RNA); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_1
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#2495666
conda deactivate 

mkdir -p alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_2
conda activate STAR
for RNAdata in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/paired/RNA); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed2.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_2
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#2737149
conda deactivate    
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence. BRAKER is a gene prediction pipeine using genomic and RNA-Seq data to automatically generate full gene structure annotations in novel genome. It combines two major tools: GeneMark-ES/ET and AUGUSTUS. These both use generalized hidden Markov model, a probabilistic model of a sequence and its gene structure.
```bash
conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_leucotricha/THeavenp11_1/braker1.9
AcceptedHits=$(ls alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_2/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=580029_2_softmasked_TPSI_appended
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2739619
conda deactivate



#############################################################################################

#Before braker predictiction is performed, double check that the genemark key is in user area and copy it over from the genemark install directory:
conda activate braker
cp /home/gomeza/miniconda3/envs/gene_pred/bin/filterGenesIn_mRNAname.pl /home/heavet/miniconda3/envs/braker/bin/filterGenesIn_mRNAname.pl
cp /home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction/braker_fungi.sh /home/heavet/git_repos/tools/gene_prediction/braker1/gom_braker_fungi.sh
#new key downloaded, unzipped and copied from ~/gm_key_64 to ~/.gm_key for genemark-ET from http://topaz.gatech.edu/GeneMark/license_download.cgi

scp -r /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/.

#newest braker installed to /home/theaven/scratch/apps/braker/braker_2.1.6/BRAKER/scripts/braker.pl
cp /home/theaven/scratch/apps/braker/braker_fungi.sh /home/theaven/scratch/apps/braker/braker_fungi_2.1.9.sh
nano /home/theaven/scratch/apps/braker/braker_fungi_2.1.9.sh #add /home/theaven/scratch/apps/braker/braker_2.1.6/BRAKER/scripts/braker.pl
cp -r /home/theaven/scratch/apps/braker/braker_2.1.6/BRAKER/scripts/* /home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/config/. 
#braker2.1.6 gives more information when the run fails but is failing whereas braker1.9 (conda install) seems to be working now that the STAR alignment is rerun to generate a good .bam input file for braker.

conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_leucotricha/THeavenp11_1/braker1.9_2
AcceptedHits=$(ls alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_2/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=580029_softmasked_TPSI_appended_4
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2492840 <--works, but why?
conda deactivate

conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_leucotricha/THeavenp11_1/braker1.9
AcceptedHits=$(ls alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_1/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=580029_softmasked_TPSI_appended_10
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2568322
conda deactivate
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. Codingquarry also uses hidden Markov models for prediction.

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate Stringtie

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenp11_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_leucotricha/THeavenp11_1/star/RNAx2/580029_2/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=~/scratch/apps/stringtie
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#2739652
conda deactivate
```
CodingQuarry was used to predict genes in regions of the genome not containing Braker gene models.
```bash
conda activate codingquary
  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/TransposonPSI
    GTF=gene_pred/P_leucotricha/THeavenp11_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=~/scratch/apps/codingquarry
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#2739691

#segmentation fault on crop diversity server therefore back over to niab hpc >:(

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/filteredmasked/2/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling
    GTF=gene_pred/P_leucotricha/THeavenp11_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#19296
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp112020_1/SPAdes/580029/ncbi_edits/filteredmasked/rep_modeling/2/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp112020_1/SPAdes/580029/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/19296/out/PredictedPass.gff3
PGNGff=gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/19296/out/PredictedPass.gff3 # no PGN predicted pass file
AddDir=gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/additional
FinalDir=gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir
#Duplicate genes were removed and genes renamed

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
#Braker genes: 15642
#Coding quarry: 2987
#Combined: 18629
```
```bash
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/*cha/*/SPAdes/*29/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
ID=$(echo $Assembly | rev |cut -f8,9 -d '/'| rev | sed 's@THeavenp112020_1@THeavenp11_1@g' )
GffAppended=gene_pred/$ID/codingquarry/rep_modeling/final/final_genes_appended.gff3
FinalDir=gene_pred/$ID/codingquarry/rep_modeling/final
echo $ID

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
#rm $GffFiltered

#Create renamed fasta files from each gene feature 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
done
```
### Swissprot

SWISS-PROT is a curated protein sequence database which strives to provide a high level of annotation, a minimal level of redundancy and a high level of integration with other databases. Swissprot Uniprot databases were downloaded
```bash
for Proteome in $(ls gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_leucotricha/THeavenp11_1/swissprot/rep_modeling/787033 
    SwissDbDir=../dbUniprot/swissprot_2020_June
    SwissDbName=uniprot_sprot
    ProgDir=/home/akinya/git_repos/fusarium_ex_strawberry/ProgScripts/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19803

for Proteome in $(ls gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_leucotricha/THeavenp11_1/swissprot/rep_modeling/787033
    SwissDbDir=../../scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
    SwissDbName=uniprot_sprot
    ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19814
wc gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
#
```
### Interproscan
```bash
mkdir gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI
#interproscan output run by A.Armitage on NRI HPC uploaded to gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI
```



































































# 2019 sample

## Note: /projects has been read only for months and I can't put of work any longer, I will run the pipeline with additional data in the /scratch area

Documentation of analysis and commands used with P.leucotricha 2019 sample as part of Nano Diagnistics PhD.

## Collecting data

Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /scratch/projects/heavet
```bash
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HTN5VDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/F/THeavenpOGB2019_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HTN5VDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/R/THeavenpOGB2019_1_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HGHJ7DSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/F/THeavenpOGB2019_2_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HGHJ7DSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/R/THeavenpOGB2019_2_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HKTV5DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/F/THeavenpOGB2019_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HKTV5DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/R/THeavenpOGB2019_3_r.fq.gz

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HTN5VDSXY_L3_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HTN5VDSXY_L3_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_1_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HGHJ7DSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_2_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HGHJ7DSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_2_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HKTV5DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP19/THMLAP19_FDSW210224377-1r_HKTV5DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/1/all/THeavenpOGB2019_3_r.fq.gz
```
## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_leucotricha/THeavenpOGB2019_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#11846
#11847
#11848
#11849
#11850
#11851

cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/F/THeavenpOGB2019_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#3,614,690
cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/001/R/THeavenpOGB2019_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#3,614,690
cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/F/THeavenpOGB2019_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#85,210,977
cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/002/R/THeavenpOGB2019_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#85,210,977
cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/F/THeavenpOGB2019_3_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#14,350,843
cat rawdata/P_leucotricha/THeavenpOGB2019_1/paired/003/R/THeavenpOGB2019_3_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#14,350,843
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
for ReadDir in $(ls -d rawdata/P_leucotricha/THeavenpOGB2019_1/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5,6 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#11860
#11861
#11862
```
The data was visualised following trimming using FastQC.
```bash
for RawData in $(ls dna_qc/P_leucotricha/THeavenpOGB2019_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData .fq.gz)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#11881
#11882
#11883
#11884
#11885
#11886
#11887
#11888
#11889
#11890
#11891
#11892

cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#3,522,709
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#62,058
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#3,522,709
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#22,546
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#83,066,066
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#1,638,477
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#83,066,066
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#354,550
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#13,999,459
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#285,908
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#13,999,459
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#45,102
```
```bash
mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim.fq.gz

cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_leucotricha/MiSeq/THeavenpOGB2019_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2019_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#18893
```

## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available apple genome downloaded from NCBI and our first P leucotricha assembly from 2020.
```bash
screen -S bowtie2
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple
cd alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index
bowtie2 \
-x apple_index \
-1 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2019_1unalignedapple.sam \
--un-gz THeavenpOGB2019_1unalignedapple_s.fq.gz \
--un-conc-gz THeavenpOGB2019_1unalignedapple_fr.fq.gz \
-S THeavenpOGB2019_1alignedapple.sam 2>&1 | tee -a report.txt
#7.42% overall alignment
exit
exit
exit
echo finished

screen -S bowtie3
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/P_leucotricha
cd alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa P_leucotricha_index
bowtie2 \
-x P_leucotricha_index \
-1 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2019_1unalignedP_leucotricha.sam \
--un-gz THeavenpOGB2019_1unalignedP_leucotricha_s.fq.gz \
--un-conc-gz THeavenpOGB2019_1unalignedP_leucotricha_fr.fq.gz \
-S THeavenpOGB2019_1alignedP_leucotricha.sam 2>&1 | tee -a report.txt
#28.91% overall alignment
exit
exit
exit
echo finished
```
## Coverage
Coverage of data was estimated and the quality of sequencing data assessed using KAT comparison to the publoshed P.leucotricha genome.
```bash
#Coverage of the sequence data was also estimated via alignmnet with the unpublished low coverage P.aphanis assembly.
cd alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenpOGB2019_1alignedP_leucotricha.sam -o THeavenpOGB2019_1alignedP_leucotricha.bam
samtools sort --threads 8 -o THeavenpOGB2019_1alignedP_leucotricha_sorted.bam THeavenpOGB2019_1alignedP_leucotricha.bam
samtools index -@ 8 THeavenpOGB2019_1alignedP_leucotricha_sorted.bam THeavenpOGB2019_1alignedP_leucotricha_sorted.bam.index
samtools coverage THeavenpOGB2019_1alignedP_leucotricha_sorted.bam -o coverage.txt
#median depth 298, mean depth 72.5 7933/8921 contigs
```
```bash
#trimmed reads vs final assembled contigs minus any non leotiomycete reads
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/kat/THeavenpOGB2019_1
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/THeavenpOGB2019_1/reads_v_THeavenpOGB2019_1 '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/THeavenpOGB2019_1/reads_v_THeavenpOGB2019_1plot300 alignment/P_leucotricha/THeavenpOGB2019_1/kat/THeavenpOGB2019_1/reads_v_THeavenpOGB2019_1-main.mx
conda deactivate
exit
exit
echo finished

screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/kat/ganan
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/ganan/reads_v_ganan '/scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/ganan/reads_v_gananplot300 alignment/P_leucotricha/THeavenpOGB2019_1/kat/ganan/reads_v_ganan-main.mx
conda deactivate
exit
exit
echo finished

#Shows ~60x coverage, clear contamination at ~100x coverage

screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/kat/apple
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/apple/reads_v_apple '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/apple/reads_v_appleplot300 alignment/P_leucotricha/THeavenpOGB2019_1/kat/apple/reads_v_apple-main.mx
conda deactivate
exit
exit
echo finished

screen -S KAT_1
srun -J kat -p long --mem 500G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/kat/spades
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/spades/reads_v_spades '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2019_1/kat/spades/reads_v_spadesplot300 alignment/P_leucotricha/THeavenpOGB2019_1/kat/spades/reads_v_spades-main.mx
conda deactivate
exit
exit
echo finished
```
## kraken2
```bash
screen -S kraken2_0
srun -p long -J kraken2 --mem 250G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p dna_qc/P_leucotricha/THeavenpOGB2019_1/kraken
gunzip -k dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/*/*/*.fq.gz
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_leucotricha/THeavenpOGB2019_1/kraken/ntoutput_#.txt \
--unclassified-out dna_qc/P_leucotricha/THeavenpOGB2019_1/kraken/ntunclassified_#.txt \
--classified-out dna_qc/P_leucotricha/THeavenpOGB2019_1/kraken/ntclassified_#.txt \
--report dna_qc/P_leucotricha/THeavenpOGB2019_1/kraken/ntreport_#.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq
#   15695165 sequences classified (73.11%)
#   5771910 sequences unclassified (26.89%)

rm dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/*/*/*.fq
conda deactivate
exit
exit
echo finished
```
## Assembly
Trimmed reads that did not align to the apple genome were taken as raw data for assembly. Reads were renamed for input into SPAdes.
```bash
#files were renamed to correct extensions for spades
mv alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr.fq.1.gz alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr-f.fq.gz
mv alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr.fq.2.gz alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr-r.fq.gz
mv alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_s.fq.gz alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_s-s.fq.gz

#files were unzipped
gunzip alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr-f.fq.gz
gunzip alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_fr-r.fq.gz 
gunzip alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple/THeavenpOGB2019_1unalignedapple_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss.
```bash
conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#11943
conda deactivate
#contigs_min_500bp.fasta is an empty file /scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/scaffolds.fasta isn't and contigs are clearly longer than 500bp therefore filtering step is messing up.

conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_leucotricha/*/SPAdes/11943/*/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#11993
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#12093
conda deactivate


conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 30
  done
#12094
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 40
  done
#12095
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 50
  done
#12096
conda deactivate
```
Using a coverage cuttoff of 10 was judged to provide the best quality assembly, this assembly was therefore carried forward.

## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. The program kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample.
### Kraken2
Kraken2 was used to screen the assembly for contaminant contigs.
```bash
screen -S kraken
srun -p short -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet
mkdir -p analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntoutput11943.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntunclassified-out11943.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntclassified-out11943.txt \
--report analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntreport11943.txt \
--use-names \
/scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta
#   37720 sequences classified (64.35%)
#   20899 sequences unclassified (35.65%)
conda deactivate
exit
exit
echo finished
# Shows that there are a large number of contaminants

#A kraken database was created for fungi with our draft podosphaera leucotricha and podosphaera aphanis assemblies included. Unclassified reads were run against this to investigate whether any unclassified reads could be matched to our new assemblies.
screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
mkdir analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/output11943.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/unclassified-out11943.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/classified-out11943.txt \
--report analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/report11943.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntunclassified-out11943.txt
#  166 sequences classified (0.79%)
#  20733 sequences unclassified (99.21%)
exit
exit
echo finished 
```
Contaminants were removed
```bash
touch analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contlist.txt
nano analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contlist.txt #edited to include all entries in analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntreport11943.txt that were not leotiomycete fungi, including unclassified. These were removed from the assembly as contaminants.
grep -f analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contlist.txt analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/ntoutput11943.txt > analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontigs11943.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontigs11943.txt > analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontignames11943.txt
conda activate seqtk
seqtk subseq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/*/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontignames11943.txt > analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminants11943.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta /scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontignames11943.txt > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contlist.txt #3709
wc -l analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontigs11943.txt #50579
wc -l analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminantcontignames11943.txt #50579
wc -l analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/nt/contaminants11943.fasta #101158
wc -l /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/filtered_contigs_min_500bp.fasta #896016
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta #117238
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta #16080
#Those newly classified reads were added back into the genome
cat analysis/P_leucotricha/THeavenpOGB2019_1/kraken2/fungi4/classified-out11943.txt >> assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta #16412
#subsequently removed again.
rm /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta
```
### BUSCO
Quality of filtered assembly was assessed via quast and BUSCO analysis
```bash
conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18963
conda deactivate

screen -S BUSCO7
srun -p long -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done
conda deactivate
exit
exit
echo finished
```
### blobtools
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_renamed2019.fasta 

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_2019.fasta

#alignment of reads to unfiltered assembly
screen -S bowtie4
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019
cd alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta OGB2019_0_index
bowtie2 \
-x OGB2019_0_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2019_1unaligned_OGB2019_0.sam \
--un-gz THeavenpOGB2019_1unaligned_OGB2019_0_s.fq.gz \
--un-conc-gz THeavenpOGB2019_1unaligned_OGB2019_0_fr.fq.gz \
-S THeavenpOGB2019_1aligned_OGB2019_0.sam 2>&1 | tee -a report_0.txt
conda deactivate
exit
exit
echo finished

#alignment of reads to final assembly
screen -S bowtie3
srun -p himem -J bowtie --mem 250G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019
cd alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta OGB2019_index
bowtie2 \
-x OGB2019_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/F/P_leucotricha-THeavenpOGB2019_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/001/R/P_leucotricha-THeavenpOGB2019_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/F/P_leucotricha-THeavenpOGB2019_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/002/R/P_leucotricha-THeavenpOGB2019_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/F/P_leucotricha-THeavenpOGB2019_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2019_1/paired/003/R/P_leucotricha-THeavenpOGB2019_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2019_1unaligned_OGB2019.sam \
--un-gz THeavenpOGB2019_1unaligned_OGB2019_s.fq.gz \
--un-conc-gz THeavenpOGB2019_1unaligned_OGB2019_fr.fq.gz \
-S THeavenpOGB2019_1aligned_OGB2019.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/*2019.fasta); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.fasta@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2642433
#Submitted batch job 2642434

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019/THeavenpOGB2019_1aligned_OGB2019.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2019_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2019_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19195
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_leucotricha/THeavenpOGB2019_1/bowtie2/OGB2019/THeavenpOGB2019_1aligned_OGB2019_0.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2019_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2019_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19206
conda deactivate
```
## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI reports (FCSreport.txt) were manually downloaded to the following locations:
```bash
mkdir -p /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/NCBI_report_dir
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/NCBI_report_dir/Contamination2.txt /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/NCBI_report_dir/FCSreport.txt
```
These downloaded files were used to correct assemblies:
```bash
conda activate codingquary
for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/filtered_contigs/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/NCBI_report_dir/FCSreport.txt)
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18964, 19184
conda deactivate

screen -S BUSCO7
srun -p long -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(echo assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits); do
    Data=$(ls $assembly/contigs_min_500bp_renamed.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done
conda deactivate
exit
exit
echo finished
```
NCBI have assigned an assession number and finished processing the genome without enabling the fix button to add gene prediction as requested. This is suspicious.
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/.
```
Identifying ITS regions:
```bash
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 

Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta
its1=$(dirname $Assembly)/its1.fasta
its4=$(dirname $Assembly)/its4.fasta
its14=$(dirname $Assembly)/its14.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' $Assembly >> $its1
grep -B 1 'CGCAGGTTCACCTACGGA' $Assembly >> $its1
grep -B 1 'TCCTCCGCTTATTGATATGC' $Assembly >> $its4
grep -B 1 'GCATATCAATAAGCGGAGGA' $Assembly >> $its4
grep -f $its1 $its4 >> $its14
#no contig with both its1 and its4 primer, one seperate contig hits for each
exit
exit
```
## Anotation 

### Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly | sed 's@data/assembly@assembly@g')/filteredmasked
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling $ID
done
#2557827, 18983, 19198
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly | sed 's@data/assembly@assembly@g')/filteredmasked
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI $ID
done
#  2557828, 18983, 19001, 19199
conda deactivate

RepMaskGff=assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
printf "P_leucotricha/THeavenpOGB2019_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#22,728,979
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#7,721,989
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#23,884,572
```
The TransposonPSI asked bases were used to mask additional bases from the repeatmasker softmasked files.
```bash
for File in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 23,884,572
```
The total length of the genome given by quast is 52,561,395bp if 23,884,572bp have been masked as repetative then 45.44% of the genome is made up of repeats.
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/.
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/.
```

## Gene prediction
RNAseq was performed on P. leucotricha to guide gene prediction. Gene prediction was performed using braker supplimented by additon predctions from codingquarry. Duplicated predictions were removed.

### RNA Alignment
STAR was used to align RNAseq data for P.leucotricha to our genome assembly.
```bash
mkdir -p alignment/P_leucotricha/THeavenpOGB2019_1/star/RNA/11943
conda activate STAR
for RNAdata in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/paired/RNA); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=data/assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/contigs_min_500bp_renamed.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_leucotricha/THeavenpOGB2019_1/star/RNA/11943
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#2739665
conda deactivate    
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence. BRAKER is a gene prediction pipeine using genomic and RNA-Seq data to automatically generate full gene structure annotations in novel genome. It combines two major tools: GeneMark-ES/ET and AUGUSTUS. These both use generalized hidden Markov model, a probabilistic model of a sequence and its gene structure.
```bash
conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/braker1.9
AcceptedHits=$(ls alignment/P_leucotricha/THeavenpOGB2019_1/star/RNA/11943/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=11943_softmasked_TPSI_appended
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2741695
conda deactivate
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. Codingquarry also uses hidden Markov models for prediction.

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate stringtie

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_leucotricha/THeavenpOGB2019_1/star/RNA/11943/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=~/scratch/apps/stringtie
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#2742052
conda deactivate
```
CodingQuarry was used to predict genes in regions of the genome not containing Braker gene models.
```bash
conda activate codingquary
#segmentation fault on crop diversity server therefore back over to niab hpc >:(

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling
    GTF=gene_pred/P_leucotricha/THeavenpOGB2019_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#19297
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/2/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenOGB2019_1/SPAdes/11943/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/19297/out/PredictedPass.gff3
PGNGff=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/19297/out/PredictedPass.gff3 # no PGN predicted pass file
AddDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/additional
FinalDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir
#Duplicate genes were removed and genes renamed

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
#Braker genes: 16533
#Coding quarry: 3203
#Combined: 19736
```
```bash
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/*cha/*/SPAdes/*/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
ID=$(echo $Assembly | rev |cut -f8,9 -d '/'| rev | sed 's@THeaven@THeavenp@g' )
GffAppended=gene_pred/$ID/codingquarry/rep_modeling/final/final_genes_appended.gff3
FinalDir=gene_pred/$ID/codingquarry/rep_modeling/final
echo $ID

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
rm $GffFiltered

#Create renamed fasta files from each gene feature 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
done
```
### Swissprot

SWISS-PROT is a curated protein sequence database which strives to provide a high level of annotation, a minimal level of redundancy and a high level of integration with other databases. Swissprot Uniprot databases were downloaded
```bash
for Proteome in $(ls gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/swissprot/rep_modeling/787033 
    SwissDbDir=../dbUniprot/swissprot_2020_June
    SwissDbName=uniprot_sprot
    ProgDir=/home/akinya/git_repos/fusarium_ex_strawberry/ProgScripts/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19801

for Proteome in $(ls gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2019_1/swissprot/rep_modeling/787033
    SwissDbDir=../../scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
    SwissDbName=uniprot_sprot
    ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19813
wc gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
#
```
### Interproscan
```bash
mkdir gene_pred/P_leucotricha/THeavenpOGB2019_1/interproscan/NRI
#interproscan output run by A.Armitage on NRI HPC uploaded to gene_pred/P_leucotricha/THeavenpOGB2019_1/interproscan/NRI
```































































# 2021 sample

## Note: /projects has been read only for months and I can't put of work any longer, I will run the pipeline with additional data in the /scratch area

Documentation of analysis and commands used with P.leucotricha 2021 sample as part of Nano Diagnistics PhD.

# Secondary sequencing

KAT analysis of the 2021 sample appeared to show that the sample contained no apple mildew data, in order to obtain sequence data containing apple mildew reads additional DNA extractions were performed and submitted for low coverage sequencing, the analysis of this data is given below. The results of this sequencing was the same as with the initial DNA extraction, library prep and high coverage sequencing, we therefore proceeded with that library rather than increasing the sequencing depth of these samples. Subsequent analysis with kraken2 later showed that this initial library did contain apple mildew data albeit heavily contaminated with other sequences. The analysis of this data is recorded later in this document.

## Collecting data

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all

ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21DIL/THMLAP21DIL_ESFP220001654-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/THeavenpOGB2021_1_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21DIL/THMLAP21DIL_ESFP220001654-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/THeavenpOGB2021_1_r.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPIN/THMLAP21SPIN_ESFP220001656-1b_H25W7DSX3_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/THeavenpOGB2021_2_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPIN/THMLAP21SPIN_ESFP220001656-1b_H25W7DSX3_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/THeavenpOGB2021_2_r.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPUN/THMLAP21SPUN_ESFP220001655-1b_H2C32DSX3_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/THeavenpOGB2021_3_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPUN/THMLAP21SPUN_ESFP220001655-1b_H2C32DSX3_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/THeavenpOGB2021_3_r.fq.gz


ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21DIL/THMLAP21DIL_ESFP220001654-1a_H223VDSX3_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_1_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21DIL/THMLAP21DIL_ESFP220001654-1a_H223VDSX3_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_1_r.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPIN/THMLAP21SPIN_ESFP220001656-1b_H25W7DSX3_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_2_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPIN/THMLAP21SPIN_ESFP220001656-1b_H25W7DSX3_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_2_r.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPUN/THMLAP21SPUN_ESFP220001655-1b_H2C32DSX3_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_3_f.fq.gz
ln -s /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THMLAP21SPUN/THMLAP21SPUN_ESFP220001655-1b_H2C32DSX3_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_3_r.fq.gz
```
## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#16849
#16850
#16860
#16861
#16858
#16859
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
for ReadDir in $(ls -d rawdata/P_aphanis/MiSeq/THeavenpOGB2021_1/*/*3);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5,6 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#16855
#16862
#16863
```
The data was visualised following trimming using FastQC.
```bash
for RawData in $(ls dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#16870-16881
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available apple genome downloaded from NCBI and our first P leucotricha assembly from 2020.
```bash
screen -S bowtie3
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_2/bowtie2/apple
cd alignment/P_leucotricha/THeavenpOGB2021_2/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index
bowtie2 \
-x apple_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_2unalignedapple.sam \
--un-gz THeavenpOGB2021_2unalignedapple_s.fq.gz \
--un-conc-gz THeavenpOGB2021_1unalignedapple_fr.fq.gz \
-S THeavenpOGB2021_2alignedapple.sam 2>&1 | tee -a report.txt
#31.02% overall alignment rate
conda deactivate
exit
exit
echo finished

screen -S bowtie4
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_2/bowtie2/P_leucotricha
cd alignment/P_leucotricha/THeavenpOGB2021_2/bowtie2/P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa P_leucotricha_index
bowtie2 \
-x P_leucotricha_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_2unalignedP_leucotricha.sam \
--un-gz THeavenpOGB2021_2unalignedP_leucotricha_s.fq.gz \
--un-conc-gz THeavenpOGB2021_2unalignedP_leucotricha_fr.fq.gz \
-S THeavenpOGB2021_2alignedP_leucotricha.sam 2>&1 | tee -a report.txt
#23.90% overall alignment rate
conda deactivate
exit
exit
echo finished
```
## Coverage
Coverage of data was estimated and the quality of sequencing data assessed using KAT comparison to our P.aphanis genome.
```bash
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_2/kat/ganan
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2021_2/kat/ganan/reads_v_ganan '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/001/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/002/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/F/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_aphanis/MiSeq/THeavenpOGB2021_1/paired/003/R/P_aphanis-MiSeq-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2021_2/kat/ganan/reads_v_gananplot300 alignment/P_leucotricha/THeavenpOGB2021_2/kat/ganan/reads_v_ganan-main.mx
conda deactivate
exit
exit
echo finished
```
# Primary sequencing

## Collecting data

Raw MiSeq sequence data for P.leucotricha was linked from long term storage in /archives to the working folder /scratch/projects/heavet

```bash
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/F
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/R
mkdir -p rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HK5KKDSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/F/THeavenpOGB2021_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HK5KKDSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/R/THeavenpOGB2021_1_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA02/THMLRA02_FDMS210224380-1r_HK5KKDSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/F/THeavenpOGB2021_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA02/THMLRA02_FDMS210224380-1r_HK5KKDSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/R/THeavenpOGB2021_2_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HGHJ7DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/F/THeavenpOGB2021_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HGHJ7DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/R/THeavenpOGB2021_3_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HKTV5DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/F/THeavenpOGB2021_4_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HKTV5DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/R/THeavenpOGB2021_4_r.fq.gz

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HK5KKDSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HK5KKDSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_1_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA02/THMLRA02_FDMS210224380-1r_HK5KKDSX2_L1_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA02/THMLRA02_FDMS210224380-1r_HK5KKDSX2_L1_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_2_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HGHJ7DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HGHJ7DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_3_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HKTV5DSX2_L2_1.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_4_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLAP21/THMLAP21_FDMS210224378-1r_HKTV5DSX2_L2_2.fq.gz rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/1/all/THeavenpOGB2021_4_r.fq.gz
```
## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_leucotricha/THeavenpOGB2021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#11852
#11853
#11854
#11855
#11856
#11857
#11858
#11859

cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/F/THeavenpOGB2021_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,751,136
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/001/R/THeavenpOGB2021_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,751,136
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/F/THeavenpOGB2021_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,308,289
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/002/R/THeavenpOGB2021_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,308,289
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/F/THeavenpOGB2021_3_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#85,706,123
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/003/R/THeavenpOGB2021_3_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#85,706,123
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/F/THeavenpOGB2021_4_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#19,083,032
cat rawdata/P_leucotricha/THeavenpOGB2021_1/paired/004/R/THeavenpOGB2021_4_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#19,083,032
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
for ReadDir in $(ls -d rawdata/P_leucotricha/THeavenpOGB2021_1/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5,6 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#11863
#11864
#11865
#11866
```
The data was visualised following trimming using FastQC.
```bash
for RawData in $(ls dna_qc/P_leucotricha/THeavenpOGB2021_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData .fq.gz)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#11893
#11894
#11895
#11896
#11897
#11898
#11899
#11900
#11901
#11902
#11903
#11904
#11905
#11906
#11907
#11908

cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,660,020
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#65,757
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,660,020
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#19,317
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,226,626
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#60,667
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,226,626
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#16,242
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#83,347,589
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#1,835,889
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#83,347,589
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#374,233
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#18,645,424
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#358,844
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#18,645,424
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#56,158
```
```bash
mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim.fq.gz

cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim.fq.gz
touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/F/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/R/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_leucotricha/MiSeq/THeavenpOGB2021_1/paired/all/P_leucotricha-MiSeq-THeavenpOGB2021_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#18894
```

## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the available apple genome downloaded from NCBI and our first P leucotricha assembly from 2020.
```bash
screen -S bowtie4
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple
cd alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta apple_index
bowtie2 \
-x apple_index \
-1 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_1unalignedapple.sam \
--un-gz THeavenpOGB2021_1unalignedapple_s.fq.gz \
--un-conc-gz THeavenpOGB2021_1unalignedapple_fr.fq.gz \
-S THeavenpOGB2021_1alignedapple.sam 2>&1 | tee -a report.txt
#31.90% overall alignment rate
exit
exit
exit
echo finished

screen -S bowtie5
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/P_leucotricha
cd alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa P_leucotricha_index
bowtie2 \
-x P_leucotricha_index \
-1 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_1unalignedP_leucotricha.sam \
--un-gz THeavenpOGB2021_1unalignedP_leucotricha_s.fq.gz \
--un-conc-gz THeavenpOGB2021_1unalignedP_leucotricha_fr.fq.gz \
-S THeavenpOGB2021_1alignedP_leucotricha.sam 2>&1 | tee -a report.txt
#24.08% overall alignment rate
exit
exit
exit
echo finished
```
## Coverage
Coverage of data was estimated and the quality of sequencing data assessed using KAT comparison to the published P.leucotricha genome.
```bash
#Coverage of the sequence data was also estimated via alignmnet with the unpublished low coverage P.aphanis assembly.
cd alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/P_leucotricha
samtools view --threads 8 -bS THeavenpOGB2021_1alignedP_leucotricha.sam -o THeavenpOGB2021_1alignedP_leucotricha.bam
samtools sort --threads 8 -o THeavenpOGB2021_1alignedP_leucotricha_sorted.bam THeavenpOGB2021_1alignedP_leucotricha.bam
samtools index -@ 8 THeavenpOGB2021_1alignedP_leucotricha_sorted.bam THeavenpOGB2021_1alignedP_leucotricha_sorted.bam.index
samtools coverage THeavenpOGB2021_1alignedP_leucotricha_sorted.bam -o coverage.txt
#median depth 272, mean depth x77.5 7945/8922 contigs
```
### KAT
```bash
#trimmed reads vs final assembled contigs minus any non leotiomycete reads
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/kat/THeavenpOGB2021_1
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/THeavenpOGB2021_1/reads_v_THeavenpOGB2021_1 '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -y 6000000 -x 300 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/THeavenpOGB2021_1/reads_v_THeavenpOGB2021_1plot300_test alignment/P_leucotricha/THeavenpOGB2021_1/kat/THeavenpOGB2021_1/reads_v_THeavenpOGB2021_1-main.mx
conda deactivate
exit
exit
echo finished

screen -S KAT3
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/kat/ganan
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/ganan/reads_v_ganan '/scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa

kat plot spectra-cn -y 6000000 -x 300 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/ganan/reads_v_gananplot300_test alignment/P_leucotricha/THeavenpOGB2021_1/kat/ganan/reads_v_ganan-main.mx
conda deactivate
exit
exit
echo finished
#shows no coverage?

screen -S KAT2
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/kat/apple
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/apple/reads_v_apple '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/rosales/GDDH13_1-1_formatted.fasta

kat plot spectra-cn -y 6000000 -x 300 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/apple/reads_v_appleplot300_test alignment/P_leucotricha/THeavenpOGB2021_1/kat/apple/reads_v_apple-main.mx
conda deactivate
exit
exit
echo finished

screen -S KAT_2
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/kat/spades
kat comp -m 21 -v -h -t 8 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/spades/reads_v_spades '/scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta

kat plot spectra-cn -x 300 -o alignment/P_leucotricha/THeavenpOGB2021_1/kat/spades/reads_v_spadesplot300 alignment/P_leucotricha/THeavenpOGB2021_1/kat/spades/reads_v_spades-main.mx
conda deactivate
exit
exit
echo finished
```
### kraken2
KAT appears to show that this sequening library contains no apple mildew data, this was further investigated by using kraken2 to taxonomically classify the trimmed reads. This showed that the library did contain mildew data, albeit heavily contaminated with DNA from other species.
```bash
mkdir dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken
cp dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/*/*/*.fq.gz dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/.
gunzip dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/*

screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--paired \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/ntreport.txt \
--unclassified-out dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/ntunclassified#.txt \
--classified-out dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/ntclassified#.txt \
--report dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/ntreport.txt \
--use-names \
dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq dna_qc/P_leucotricha/THeavenpOGB2021_1/kraken/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq
# 8.68% unclassified
# 91.32% classified, 36.45% leotiomycetes
conda deactivate
exit
exit
echo finished
```
## Assembly
Trimmed reads that did not align to the apple genome were taken as raw data for assembly. Reads were renamed for input into SPAdes.
```bash
#files were renamed to correct extensions for spades
mv alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr.fq.1.gz alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr-f.fq.gz
mv alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr.fq.2.gz alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr-r.fq.gz
mv alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_s.fq.gz alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_s-s.fq.gz

#files were unzipped
gunzip alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr-f.fq.gz
gunzip alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_fr-r.fq.gz 
gunzip alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple/THeavenpOGB2021_1unalignedapple_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss.
```bash
conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#11944
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/11944/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/11944/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/11944/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#17082
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 50
  done
#17255
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 40
  done
#17257
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17257/scaffolds.fasta 500 > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17257/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17257/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18030
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 30
  done
#17258
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/scaffolds.fasta 500 > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18029
conda deactivate

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#17256
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/scaffolds.fasta 500 > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta
    for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18028
conda deactivate
```
It was difficult to determine at this stage which assembly was the highest quality as a large number of contigs are likely from species other than apple powdery mildew, we therefore carried two assemblies forward, cuttoff 20 and 30.

## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. The program kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample.
### Kraken2
Kraken2 was used to screen the assembly for contaminant contigs.
```bash
screen -S kraken
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntoutput17256.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntunclassified-out17256.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntclassified-out17256.txt \
--report analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntreport17256.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta
#  16221 sequences classified (81.00%)
#  3805 sequences unclassified (19.00%)

# Shows that there are a large number of contaminants

screen -S kraken
srun -p short -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntoutput17258.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntunclassified-out17258.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntclassified-out17258.txt \
--report analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntreport17258.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta
#  11075 sequences classified (93.20%)
#  808 sequences unclassified (6.80%)
conda deactivate
exit
exit
echo finished
# Shows that there are a large number of contaminants
```
Contaminants were removed
```bash
touch analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contlist.txt
nano analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contlist.txt #edited to include all entries in analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntreport17256.txt that were not leotiomycete fungi, including unclassified. These were removed from the assembly as contaminants.
grep -f analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contlist.txt analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntoutput17256.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontigs17256.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontigs17256.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontignames17256.txt
conda activate seqtk
seqtk subseq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontignames17256.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminants17256.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta /scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontignames17256.txt > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contlist.txt #1832
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontigs17256.txt #12491
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminantcontignames17256.txt #12491
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/contaminants17256.fasta #24982
wc -l /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/filtered_contigs_min_500bp.fasta #86842
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/contigs_min_500bp.fasta #40052
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/contigs_min_500bp_filtered.fasta #15070
```
```bash
touch analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contlist.txt
nano analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contlist.txt #edited to include all entries in analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntreport17256.txt that were not leotiomycete fungi, including unclassified. These were removed from the assembly as contaminants.
grep -f analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contlist.txt analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntoutput17258.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontigs17258.txt
nawk -F"\\t" '{print $2}' analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontigs17258.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontignames17258.txt
conda activate seqtk
seqtk subseq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontignames17258.txt > analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminants17258.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta /scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontignames17258.txt > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contlist.txt #1127
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontigs17258.txt #4558
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminantcontignames17258.txt #4558
wc -l analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/contaminants17258.fasta #9116
wc -l /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/filtered_contigs_min_500bp.fasta #848584
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta #23766
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta #14650
#Those newly classified reads were added back into the genome - subsequently undone
cat analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/classified-out17258.txt >> assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta #16412
```
A kraken database was created for fungi with our draft podosphaera leucotricha and podosphaera aphanis assemblies included. Unclassified reads were run against this to investigate whether any unclassified reads could be matched to our new assemblies.
```bash
screen -S kraken
srun -p short -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

mkdir analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/output17256.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/unclassified-out17256.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/classified-out17256.txt \
--report analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/report17256.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt/ntunclassified-out17256.txt
#  97 sequences classified (2.55%)
#  3708 sequences unclassified (97.45%)
mkdir analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/output17258.txt \
--unclassified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/unclassified-out17258.txt \
--classified-out analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/classified-out17258.txt \
--report analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/report17258.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/nt2/ntunclassified-out17258.txt
#  80 sequences classified (9.90%)
#  728 sequences unclassified (90.10%)

conda deactivate
exit
exit
echo finished
```
Those newly classified reads were added back into the genome - this was subsequently undone
```bash
cat analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi4/classified-out17256.txt >> assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/contigs_min_500bp_filtered.fasta #15264

cat analysis/P_leucotricha/THeavenpOGB2021_1/kraken2/fungi42/classified-out17258.txt >> assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta #14810
```
### BUSCO
The quality of filtered assemblies was assessed via quast and BUSCO analysis
```bash
conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17256/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18965
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18966
conda deactivate

screen -S BUSCO7
srun -p himem -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(ls -d assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/1725*/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done
conda deactivate
exit
exit
echo finished
```
Based on these quality reading we judge the assembly with 30 cuttoff to be of the highest quality (17258) although 20 and 30 are very close.
### blobtools
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_renamed2021.fasta 

scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/contigs_min_500bp_2021.fasta

#alignment of reads to unfiltered assembly
screen -S bowtie5
srun -p long -J bowtie  --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021
cd alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta   OGB2021_0_index
bowtie2 \
-x OGB2021_0_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_1unaligned_OGB2021_0.sam \
--un-gz THeavenpOGB2021_1unaligned_OGB2021_0_s.fq.gz \
--un-conc-gz THeavenpOGB2021_1unaligned_OGB2021_0_fr.fq.gz \
-S THeavenpOGB2021_1aligned_OGB2021_0.sam 2>&1 | tee -a report_0.txt
conda deactivate
exit
exit
echo finished

#alignment of reads to final assembly
screen -S bowtie4
srun -p himem -J bowtie --mem 250G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021
cd alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021
bowtie2-build /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta  OGB2021_index
bowtie2 \
-x OGB2021_index \
-1 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim.fq.gz \
-2 /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim.fq.gz \
-U /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/F/P_leucotricha-THeavenpOGB2021_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/001/R/P_leucotricha-THeavenpOGB2021_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/F/P_leucotricha-THeavenpOGB2021_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/002/R/P_leucotricha-THeavenpOGB2021_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/F/P_leucotricha-THeavenpOGB2021_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/003/R/P_leucotricha-THeavenpOGB2021_1-paired-003_R_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/F/P_leucotricha-THeavenpOGB2021_1-paired-004_F_trim_unpaired.fq.gz, /scratch/projects/heavet/gene_pred_vAG/_sigP/split/dna_qc/P_leucotricha/THeavenpOGB2021_1/paired/004/R/P_leucotricha-THeavenpOGB2021_1-paired-004_R_trim_unpaired.fq.gz \
--un THeavenpOGB2021_1unaligned_OGB2021.sam \
--un-gz THeavenpOGB2021_1unaligned_OGB2021_s.fq.gz \
--un-conc-gz THeavenpOGB2021_1unaligned_OGB2021_fr.fq.gz \
-S THeavenpOGB2021_1aligned_OGB2021.sam 2>&1 | tee -a report.txt
conda deactivate
exit
exit
echo finished

conda activate blast+
for assembly in $(ls /home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha/*2021.fasta); do
Assembly=$assembly
Outfile=$(echo $assembly |sed 's@data/assembly/genome@analysis/blastn@g'|sed 's@.fasta@@g')/assembly.vs.nt.mts1.hsp1.1e25.megablast.out
OutDir=$(dirname $Outfile)
mkdir -p $OutDir
ProgDir=~/scratch/apps/blast
sbatch $ProgDir/blastn.sh $Assembly $Outfile
done
conda deactivate
#Submitted batch job 2642431
#Submitted batch job 2642432

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021/THeavenpOGB2021_1aligned_OGB2021.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2021_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2021_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_2.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19194
conda deactivate

conda activate blobtools
ProgDir=~/git_repos/tools/prog/blobtools
Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/contigs_min_500bp.fasta
Coverage=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/alignment/P_leucotricha/THeavenpOGB2021_1/bowtie2/OGB2021/THeavenpOGB2021_1aligned_OGB2021_0.sam
OutDir=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2021_1/blobtools
Hitfile=/projects/nano_diagnostics/analysis/P_leucotricha/THeavenpOGB2021_1/blastn/assembly.vs.nt.mts1.hsp1.1e25.megablast_0.out
sbatch $ProgDir/run_blobtools.sh $Assembly $Coverage $Hitfile $OutDir
#19207
conda deactivate
```

## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI have assigned an assession number and finished processing the genome without reporting any fixes for this assembly or enabling the fix button to add gene prediction as requested. This is suspicious.

```bash
mkdir /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/NCBI_report_dir
touch /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/NCBI_report_dir/FCSreport.txt

conda activate biopython
for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/filtered_contigs/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/NCBI_report_dir/FCSreport.txt) #As no report file has been provided a blank file was created
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python2.7 $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#19183
conda deactivate

screen -S BUSCO8
srun -p himem -J busco  --mem 250G --pty bash
conda activate BUSCO
for assembly in $(ls -d assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits); do
    Data=$(ls $assembly/contigs_min_500bp_renamed.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done
conda deactivate
exit
exit
echo finished
```
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/.
```

Identifying ITS regions:
```bash
screen -S ITS1
srun -p long -c 10 --mem 10G --pty bash 

Assembly=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta
its1=$(dirname $Assembly)/its1.fasta
its4=$(dirname $Assembly)/its4.fasta
its14=$(dirname $Assembly)/its14.fasta
grep -B 1 'TCCGTAGGTGAACCTGCG' $Assembly >> $its1
grep -B 1 'CGCAGGTTCACCTACGGA' $Assembly >> $its1
grep -B 1 'TCCTCCGCTTATTGATATGC' $Assembly >> $its4
grep -B 1 'GCATATCAATAAGCGGAGGA' $Assembly >> $its4
grep -f $its1 $its4 >> $its14
# no hits for the its1 primer
exit
exit
```

## Anotation 

### Repeat Masking
Soft masking means transforming every nucleotide identified as a repeat to a lower case a, t, g or c to be included in later gene prediction stages. Hard masking means transforming every nucleotide identified as a repeat to an 'N' or 'X'.

Conda installations of Repeatmodeler and transposonPSI were performed.

Repeatmodeler and transposonPSI were run on our assembly.
```bash
conda activate repeatmasking
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly | sed 's@data/assembly@assembly@g')/filteredmasked
    mkdir -p $OutDir/rep_modeling
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir/rep_modeling $ID
done
# 2557830,18992, 19200
conda deactivate

conda activate transposonpsi
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta); do
    ID=$(echo $Assembly| rev |cut -f3 -d '/'| rev | cut -f1 -d '/'  )
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $Assembly | sed 's@data/assembly@assembly@g')/filteredmasked
    mkdir -p $OutDir/transposonPSI
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir/transposonPSI $ID
done
# 2557831,18993, 19201
conda deactivate

RepMaskGff=assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
printf "P_leucotricha/THeavenpOGB2021_1\n"
printf "The number of bases masked by RepeatMasker:\t"
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#21,883,577
printf "The number of bases masked by TransposonPSI:\t"
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#7,523,238
printf "The total number of masked bases are:\t"
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
#23,048,301
```
The TransposonPSI asked bases were used to mask additional bases from the repeatmasker softmasked files.
```bash
for File in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/*_contigs_softmasked.fa); do
OutDir=$(dirname $File)
TPSI=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=$(echo $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo $OutFile
echo "Number of masked bases:"
cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' '
done
#Number of masked bases: 23,048,301
```
The total length of the genome given by quast is 49,818,523bp if 23,048,301bp have been masked as repetative then 46.26% of the genome is made up of repeats.
```bash
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/.
scp -r /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/.
```

## Gene prediction
RNAseq was performed on P. leucotricha to guide gene prediction. Gene prediction was performed using braker supplimented by additon predctions from codingquarry. Duplicated predictions were removed.

### RNA Alignment
STAR was used to align RNAseq data for P.leucotricha to our genome assembly.
```bash
mkdir -p alignment/P_leucotricha/THeavenpOGB2021_1/star/RNA/17258
conda activate STAR
for RNAdata in $(ls -d dna_qc/P_leucotricha/THeavenp11_1/paired/RNA); do
    Freads=$RNAdata/F/*trim.fq.gz
    Rreads=$RNAdata/R/*trim.fq.gz
    ls $Freads
    ls $Rreads
    InGenome=data/assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/contigs_min_500bp_renamed.fasta
    ProgDir=~/scratch/apps/star
    OutDir=alignment/P_leucotricha/THeavenpOGB2021_1/star/RNA/17258
    sbatch $ProgDir/star_alignment.sh $InGenome $Freads $Rreads $OutDir
done
#2739667
conda deactivate    
``` 
### Braker prediction
Genes were predited using the program Braker1 using RNAseq wvidence. BRAKER is a gene prediction pipeine using genomic and RNA-Seq data to automatically generate full gene structure annotations in novel genome. It combines two major tools: GeneMark-ES/ET and AUGUSTUS. These both use generalized hidden Markov model, a probabilistic model of a sequence and its gene structure.
```bash
conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/braker1.9
AcceptedHits=$(ls alignment/P_leucotricha/THeavenpOGB2021_1/star/RNA/17258/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=17258_softmasked_TPSI_appended
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#2741694
conda deactivate
```
### CodingQuary
Additional genes were added  to Braker gene predictions using CodingQuary in pathogen mode to predict additional regions. Codingquarry also uses hidden Markov models for prediction.

Firstly, aligned RNAseq data was assembled into transcripts using Stringtie.
```bash
conda activate stringtie

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/stringtie/concatenated_prelim/rep_modeling
    AcceptedHits=alignment/P_leucotricha/THeavenpOGB2021_1/star/RNA/17258/star_aligmentAligned.sortedByCoord.out.bam
    ProgDir=~/scratch/apps/stringtie
    sbatch $ProgDir/stringtie.sh $AcceptedHits $OutDir
   done
#2742053
conda deactivate
```
CodingQuarry was used to predict genes in regions of the genome not containing Braker gene models.
```bash
conda activate codingquary
#segmentation fault on crop diversity server therefore back over to niab hpc >:(

  for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_unmasked.fa); do
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling
    GTF=gene_pred/P_leucotricha/THeavenpOGB2021_1/stringtie/concatenated_prelim/rep_modeling/out.gtf
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    sbatch $ProgDir/sub_CodingQuary.sh $Assembly $GTF $OutDir
  done
#19298
```
Where CodingQuarry genes were predicted in regions of the genome not containing Braker gene models these transcripts were added to the Braker gene models
```bash
srun -p short  --mem 100G --pty bash
cpanm Bio::Perl

for BrakerGff in $(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/2/augustus.gff3); do
Assembly=$(ls /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa)
CodingQuaryGff=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/19298/out/PredictedPass.gff3
PGNGff=/scratch/projects/heavet/gene_pred_vAG/_sigP/split/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/19298/out/PredictedPass.gff3 # no PGN predicted pass file
AddDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/additional
FinalDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir
#Duplicate genes were removed and genes renamed

#Create a list with the additional transcripts in CodingQuarry gff vs Braker gene models
bedtools intersect -v -a $CodingQuaryGff -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';' > $AddGenesList

#Create Gff file with the additional transcripts
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction
$ProgDir/gene_list_to_gff.pl $AddGenesList $CodingQuaryGff CodingQuarry_v2.0 ID CodingQuary > $AddGenesGff

#Create a final Gff file with gene features
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $FinalDir/final_genes_CodingQuary.gff3

#Create fasta files from each gene feature in the CodingQuarry gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary

#Create fasta files from each gene feature in the Braker gff3
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker

#Combine both fasta files
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

#Combine both gff3 files
GffBraker=$FinalDir/final_genes_Braker.gff3
GffQuary=$FinalDir/final_genes_CodingQuary.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done

#Check the final number of genes 
for DirPath in $(ls -d $FinalDir); do echo $DirPath; cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l; cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l; echo ""; 
done
#gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final
#Braker genes: 15779
#Coding quarry: 2545
#Combined: 18324
```
```bash
for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/*cha/*/SPAdes/*/ncbi_edits/filteredmasked/rep_modeling/2/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
ID=P_leucotricha/THeavenpOGB2021_1
#ID=$(echo $Assembly | rev |cut -f8,9 -d '/'| rev | sed 's@THeaven@THeaven@g' )
GffAppended=gene_pred/$ID/codingquarry/rep_modeling/final/final_genes_appended.gff3
#FinalDir=gene_pred/$ID/codingquarry/rep_modeling/final
FinalDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/
echo $ID

#Remove duplicated genes 
GffFiltered=$FinalDir/filtered_duplicates.gff 
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
$ProgDir/remove_dup_features.py --inp_gff $GffAppended --out_gff $GffFiltered

#Rename genes 
GffRenamed=$FinalDir/final_genes_appended_renamed.gff3 
LogFile=$FinalDir/final_genes_appended_renamed.log 
$ProgDir/gff_rename_genes.py --inp_gff $GffFiltered --conversion_log $LogFile > $GffRenamed 
#The number of genes increases after this? following command shows duplicated genes:
cat $Logfile |cut -f1 -d '/'|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'
rm $GffFiltered

#Create renamed fasta files from each gene feature 
$ProgDir/gff2fasta.pl $Assembly $GffRenamed $FinalDir/final_genes_appended_renamed2 

#The proteins fasta file contains * instead of Xs for stop codons, these should be changed 
sed -i 's/*/X/g' $FinalDir/final_genes_appended_renamed.pep.fasta

#View gene names 
cat $FinalDir/final_genes_appended_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
grep -c -i '>' $FinalDir/final_genes_appended_renamed.cdna.fasta
done

grep -w 'gene' $FinalDir/final_genes_appended.gff3 > 123.txt #18027 
grep -w 'mRNA' $FinalDir/final_genes_appended.gff3 > 321.txt #18324
grep -w 'gene' gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > 456.txt #18073
grep -w 'mRNA' gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > 654.txt #18370
grep -w 'gene' $GffFiltered | wc -l #18027
grep -w 'mRNA' $GffFiltered | wc -l #18324
grep -w 'gene' $GffRenamed | wc -l
grep -w 'mRNA' $GffRenamed | wc -l

STRG_3660_8_10  -       g2922
STRG_3660_8_10  -       g2926
STRG_3660_8_10  -       g2930
STRG_3660_8_10  -       g2934

```
### Swissprot

SWISS-PROT is a curated protein sequence database which strives to provide a high level of annotation, a minimal level of redundancy and a high level of integration with other databases. Swissprot Uniprot databases were downloaded
```bash
for Proteome in $(ls gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/swissprot/rep_modeling/787033 
    SwissDbDir=../dbUniprot/swissprot_2020_June
    SwissDbName=uniprot_sprot
    ProgDir=/home/akinya/git_repos/fusarium_ex_strawberry/ProgScripts/Feature_annotation
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19799

for Proteome in $(ls gene_pred/P_*/THeaven*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do  
    OutDir=$(dirname $Proteome | sed 's@codingquarry@swissprot@g')
    SwissDbDir=../../scratch/public_data/tch/dbUniprot/swissprot_2021_Sept
    SwissDbName=uniprot_sprot
    ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    echo $OutDir
    sbatch $ProgDir/sub_swissprot.sh $Proteome $OutDir $SwissDbDir $SwissDbName 
done
#19815-20
wc gene_pred/P_aphanis/THeavenDRCT72020_1/swissprot/rep_modeling/787033/swissprot_vSept_2021_10_hits.tbl
#
```
### Interproscan
```bash
mkdir gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan/NRI
#interproscan output run by A.Armitage on NRI HPC uploaded to gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan/NRI

# DO NOT RUN IN CONDA ENV
# This command will split your gene fasta file and run multiple interproscan jobs.
#PATH=/data/scratch/gomeza/prog/java/jdk-11.0.4/bin:${PATH}
for Genes in $(ls gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
    Organism=$(echo $Genes|cut -f2 -d '/')
    Strain=$(echo $Genes|cut -f3 -d '/')
    echo $Genes
$ProgDir/interproscan.sh $Genes $Organism $Strain
done 2>&1 | tee -a interproscan_submisison_.log
#20192-228

for Genes in $(ls gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
    ProgDir=/home/theaven/scratch/apps/tools/Feature_annotation
    Organism=$(echo $Genes|cut -f2 -d '/')
    Strain=$(echo $Genes|cut -f3 -d '/')
    OutDir=gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan2
    echo $Genes
$ProgDir/interproscan.sh $Genes $Organism $Strain $OutDir
done 2>&1 | tee -a interproscan_submisison_.log
#3072460-96
#3074816-52
#3086755-91
```


ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3

scp -r gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final

scp -r gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final

scp -r gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final

scp -r gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final

scp -r gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final

scp -r gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final

scp -r ProgDir=/projects/oldhome/armita/git_repos/emr_repos/tools/gene_prediction/ORF_finder/extract_gff_for_sigP_hits.pl theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools/.












































#Ganan raw data re-assembly
## Ganan raw data
```bash
#Quality control:

for RawData in $(ls rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/*.fastq.gz); do
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
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/F/p11_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854
cat rawdata/P_leucotricha/THeavenp11_1/paired/002/R/p11_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#39,700,854

#Trimming:
for ReadDir in $(ls -d rawdata/P_leucotricha/ganan/osfstorage/Raw_reads/);
do
 Fread=$(ls $ReadDir*R1_001.fastq.gz)
 Rread=$(ls $ReadDir*R2_001.fastq.gz)
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



mkdir
ln -s 

conda activate spades
  for ReadDir in $(ls -d alignment/P_leucotricha/THeavenp11_1/bowtie2/apple); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/apple@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
```

