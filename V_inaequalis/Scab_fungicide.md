# Scab_fungicide

```bash
for rawdata in $(ls -d /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THSC*); do
	Isolate=$(echo $rawdata | cut -d '/' -f7)
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/F
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/R
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all
	Fread=$(ls $rawdata/*1.fq.gz)
	Rread=$(ls $rawdata/*2.fq.gz)
	Fname=$(basename $Fread | cut -d '_' -f1)_f.fq.gz
	Rname=$(basename $Rread | cut -d '_' -f1)_r.fq.gz
	ln -s $Fread rawdata/V_inaequalis/LLimon/paired/$Isolate/F/$Fname
	ln -s $Rread rawdata/V_inaequalis/LLimon/paired/$Isolate/R/$Rname
	ln -s $Fread rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all/$Fname
	ln -s $Rread rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all/$Rname
done
```
```bash
wget -P assembly/genome/NCBI/venturia/V_inaequalis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/351/075/GCA_003351075.1_ASM335107v1/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
```
```bash
for RawData in $(ls rawdata/V_inaequalis/LLimon/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#791086 etc
```
```bash
for ReadDir in $(ls -d rawdata/V_inaequalis/LLimon/*/*);
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
#791135 etc
```
```bash
for QCData in $(ls dna_qc/V_inaequalis/LLimon/*/*/*/*.fq.gz); do
echo $QCData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $QCData)
Outfile=$(basename -a $QCData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $QCData $OutDir $Outfile
done
#558-741
```
```bash
screen -S KAT
srun -p himem --mem 500G --pty bash
conda activate kat

for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCAF28); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/F/V_inaequalis-LLimon-paired-THSCAF28_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/F/V_inaequalis-LLimon-paired-THSCAF28_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/R/V_inaequalis-LLimon-paired-THSCAF28_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/R/V_inaequalis-LLimon-paired-THSCAF28_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCSP1); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCSP1/F/V_inaequalis-LLimon-paired-THSCSP1_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCSP1/F/V_inaequalis-LLimon-paired-THSCSP1_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCSP1/R/V_inaequalis-LLimon-paired-THSCSP1_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCSP1/R/V_inaequalis-LLimon-paired-THSCSP1_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS1); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS1/F/V_inaequalis-LLimon-paired-THSCRS1_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS1/F/V_inaequalis-LLimon-paired-THSCRS1_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS1/R/V_inaequalis-LLimon-paired-THSCRS1_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS1/R/V_inaequalis-LLimon-paired-THSCRS1_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS101); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS101/F/V_inaequalis-LLimon-paired-THSCRS101_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS101/F/V_inaequalis-LLimon-paired-THSCRS101_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS101/R/V_inaequalis-LLimon-paired-THSCRS101_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS101/R/V_inaequalis-LLimon-paired-THSCRS101_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS102); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS102/F/V_inaequalis-LLimon-paired-THSCRS102_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS102/F/V_inaequalis-LLimon-paired-THSCRS102_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS102/R/V_inaequalis-LLimon-paired-THSCRS102_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS102/R/V_inaequalis-LLimon-paired-THSCRS102_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS103); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS103/F/V_inaequalis-LLimon-paired-THSCRS103_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS103/F/V_inaequalis-LLimon-paired-THSCRS103_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS103/R/V_inaequalis-LLimon-paired-THSCRS103_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS103/R/V_inaequalis-LLimon-paired-THSCRS103_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS11); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS11/F/V_inaequalis-LLimon-paired-THSCRS11_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS11/F/V_inaequalis-LLimon-paired-THSCRS11_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS11/R/V_inaequalis-LLimon-paired-THSCRS11_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS11/R/V_inaequalis-LLimon-paired-THSCRS11_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS118); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS118/F/V_inaequalis-LLimon-paired-THSCRS118_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS118/F/V_inaequalis-LLimon-paired-THSCRS118_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS118/R/V_inaequalis-LLimon-paired-THSCRS118_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS118/R/V_inaequalis-LLimon-paired-THSCRS118_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS119); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS119/F/V_inaequalis-LLimon-paired-THSCRS119_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS119/F/V_inaequalis-LLimon-paired-THSCRS119_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS119/R/V_inaequalis-LLimon-paired-THSCRS119_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS119/R/V_inaequalis-LLimon-paired-THSCRS119_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS2); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/F/V_inaequalis-LLimon-paired-THSCRS2_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/F/V_inaequalis-LLimon-paired-THSCRS2_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/R/V_inaequalis-LLimon-paired-THSCRS2_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/R/V_inaequalis-LLimon-paired-THSCRS2_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS121); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS121/F/V_inaequalis-LLimon-paired-THSCRS121_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS121/F/V_inaequalis-LLimon-paired-THSCRS121_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS121/R/V_inaequalis-LLimon-paired-THSCRS121_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS121/R/V_inaequalis-LLimon-paired-THSCRS121_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS123); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS123/F/V_inaequalis-LLimon-paired-THSCRS123_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS123/F/V_inaequalis-LLimon-paired-THSCRS123_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS123/R/V_inaequalis-LLimon-paired-THSCRS123_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS123/R/V_inaequalis-LLimon-paired-THSCRS123_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS124); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS124/F/V_inaequalis-LLimon-paired-THSCRS124_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS124/F/V_inaequalis-LLimon-paired-THSCRS124_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS124/R/V_inaequalis-LLimon-paired-THSCRS124_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS124/R/V_inaequalis-LLimon-paired-THSCRS124_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS125); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS125/F/V_inaequalis-LLimon-paired-THSCRS125_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS125/F/V_inaequalis-LLimon-paired-THSCRS125_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS125/R/V_inaequalis-LLimon-paired-THSCRS125_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS125/R/V_inaequalis-LLimon-paired-THSCRS125_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS127); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS127/F/V_inaequalis-LLimon-paired-THSCRS127_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS127/F/V_inaequalis-LLimon-paired-THSCRS127_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS127/R/V_inaequalis-LLimon-paired-THSCRS127_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS127/R/V_inaequalis-LLimon-paired-THSCRS127_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS13); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS13/F/V_inaequalis-LLimon-paired-THSCRS13_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS13/F/V_inaequalis-LLimon-paired-THSCRS13_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS13/R/V_inaequalis-LLimon-paired-THSCRS13_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS13/R/V_inaequalis-LLimon-paired-THSCRS13_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS14); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS14/F/V_inaequalis-LLimon-paired-THSCRS14_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS14/F/V_inaequalis-LLimon-paired-THSCRS14_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS14/R/V_inaequalis-LLimon-paired-THSCRS14_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS14/R/V_inaequalis-LLimon-paired-THSCRS14_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS17); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS17/F/V_inaequalis-LLimon-paired-THSCRS17_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS17/F/V_inaequalis-LLimon-paired-THSCRS17_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS17/R/V_inaequalis-LLimon-paired-THSCRS17_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS17/R/V_inaequalis-LLimon-paired-THSCRS17_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS2); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/F/V_inaequalis-LLimon-paired-THSCRS2_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/F/V_inaequalis-LLimon-paired-THSCRS2_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/R/V_inaequalis-LLimon-paired-THSCRS2_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS2/R/V_inaequalis-LLimon-paired-THSCRS2_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS229); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS229/F/V_inaequalis-LLimon-paired-THSCRS229_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS229/F/V_inaequalis-LLimon-paired-THSCRS229_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS229/R/V_inaequalis-LLimon-paired-THSCRS229_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS229/R/V_inaequalis-LLimon-paired-THSCRS229_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS3); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS3/F/V_inaequalis-LLimon-paired-THSCRS3_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS3/F/V_inaequalis-LLimon-paired-THSCRS3_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS3/R/V_inaequalis-LLimon-paired-THSCRS3_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS3/R/V_inaequalis-LLimon-paired-THSCRS3_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS31); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS31/F/V_inaequalis-LLimon-paired-THSCRS31_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS31/F/V_inaequalis-LLimon-paired-THSCRS31_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS31/R/V_inaequalis-LLimon-paired-THSCRS31_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS31/R/V_inaequalis-LLimon-paired-THSCRS31_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS32); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS32/F/V_inaequalis-LLimon-paired-THSCRS32_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS32/F/V_inaequalis-LLimon-paired-THSCRS32_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS32/R/V_inaequalis-LLimon-paired-THSCRS32_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS32/R/V_inaequalis-LLimon-paired-THSCRS32_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS33); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS33/F/V_inaequalis-LLimon-paired-THSCRS33_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS33/F/V_inaequalis-LLimon-paired-THSCRS33_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS33/R/V_inaequalis-LLimon-paired-THSCRS33_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS33/R/V_inaequalis-LLimon-paired-THSCRS33_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS36); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS36/F/V_inaequalis-LLimon-paired-THSCRS36_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS36/F/V_inaequalis-LLimon-paired-THSCRS36_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS36/R/V_inaequalis-LLimon-paired-THSCRS36_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS36/R/V_inaequalis-LLimon-paired-THSCRS36_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS37); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS37/F/V_inaequalis-LLimon-paired-THSCRS37_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS37/F/V_inaequalis-LLimon-paired-THSCRS37_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS37/R/V_inaequalis-LLimon-paired-THSCRS37_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS37/R/V_inaequalis-LLimon-paired-THSCRS37_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS39); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS39/F/V_inaequalis-LLimon-paired-THSCRS39_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS39/F/V_inaequalis-LLimon-paired-THSCRS39_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS39/R/V_inaequalis-LLimon-paired-THSCRS39_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS39/R/V_inaequalis-LLimon-paired-THSCRS39_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS40); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS40/F/V_inaequalis-LLimon-paired-THSCRS40_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS40/F/V_inaequalis-LLimon-paired-THSCRS40_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS40/R/V_inaequalis-LLimon-paired-THSCRS40_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS40/R/V_inaequalis-LLimon-paired-THSCRS40_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS41); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS41/F/V_inaequalis-LLimon-paired-THSCRS41_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS41/F/V_inaequalis-LLimon-paired-THSCRS41_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS41/R/V_inaequalis-LLimon-paired-THSCRS41_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS41/R/V_inaequalis-LLimon-paired-THSCRS41_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS42); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS42/F/V_inaequalis-LLimon-paired-THSCRS42_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS42/F/V_inaequalis-LLimon-paired-THSCRS42_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS42/R/V_inaequalis-LLimon-paired-THSCRS42_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS42/R/V_inaequalis-LLimon-paired-THSCRS42_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS43); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS43/F/V_inaequalis-LLimon-paired-THSCRS43_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS43/F/V_inaequalis-LLimon-paired-THSCRS43_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS43/R/V_inaequalis-LLimon-paired-THSCRS43_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS43/R/V_inaequalis-LLimon-paired-THSCRS43_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS44); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS44/F/V_inaequalis-LLimon-paired-THSCRS44_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS44/F/V_inaequalis-LLimon-paired-THSCRS44_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS44/R/V_inaequalis-LLimon-paired-THSCRS44_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS44/R/V_inaequalis-LLimon-paired-THSCRS44_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS48); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS48/F/V_inaequalis-LLimon-paired-THSCRS48_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS48/F/V_inaequalis-LLimon-paired-THSCRS48_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS48/R/V_inaequalis-LLimon-paired-THSCRS48_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS48/R/V_inaequalis-LLimon-paired-THSCRS48_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS49); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS49/F/V_inaequalis-LLimon-paired-THSCRS49_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS49/F/V_inaequalis-LLimon-paired-THSCRS49_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS49/R/V_inaequalis-LLimon-paired-THSCRS49_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS49/R/V_inaequalis-LLimon-paired-THSCRS49_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS50); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS50/F/V_inaequalis-LLimon-paired-THSCRS50_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS50/F/V_inaequalis-LLimon-paired-THSCRS50_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS50/R/V_inaequalis-LLimon-paired-THSCRS50_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS50/R/V_inaequalis-LLimon-paired-THSCRS50_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS54); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS54/F/V_inaequalis-LLimon-paired-THSCRS54_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS54/F/V_inaequalis-LLimon-paired-THSCRS54_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS54/R/V_inaequalis-LLimon-paired-THSCRS54_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS54/R/V_inaequalis-LLimon-paired-THSCRS54_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS57); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS57/F/V_inaequalis-LLimon-paired-THSCRS57_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS57/F/V_inaequalis-LLimon-paired-THSCRS57_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS57/R/V_inaequalis-LLimon-paired-THSCRS57_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS57/R/V_inaequalis-LLimon-paired-THSCRS57_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS58); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS58/F/V_inaequalis-LLimon-paired-THSCRS58_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS58/F/V_inaequalis-LLimon-paired-THSCRS58_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS58/R/V_inaequalis-LLimon-paired-THSCRS58_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS58/R/V_inaequalis-LLimon-paired-THSCRS58_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS59); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS59/F/V_inaequalis-LLimon-paired-THSCRS59_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS59/F/V_inaequalis-LLimon-paired-THSCRS59_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS59/R/V_inaequalis-LLimon-paired-THSCRS59_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS59/R/V_inaequalis-LLimon-paired-THSCRS59_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS60); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS60/F/V_inaequalis-LLimon-paired-THSCRS60_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS60/F/V_inaequalis-LLimon-paired-THSCRS60_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS60/R/V_inaequalis-LLimon-paired-THSCRS60_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS60/R/V_inaequalis-LLimon-paired-THSCRS60_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS70); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS70/F/V_inaequalis-LLimon-paired-THSCRS70_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS70/F/V_inaequalis-LLimon-paired-THSCRS70_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS70/R/V_inaequalis-LLimon-paired-THSCRS70_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS70/R/V_inaequalis-LLimon-paired-THSCRS70_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS736); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS736/F/V_inaequalis-LLimon-paired-THSCRS736_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS736/F/V_inaequalis-LLimon-paired-THSCRS736_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS736/R/V_inaequalis-LLimon-paired-THSCRS736_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS736/R/V_inaequalis-LLimon-paired-THSCRS736_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS77); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS77/F/V_inaequalis-LLimon-paired-THSCRS77_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS77/F/V_inaequalis-LLimon-paired-THSCRS77_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS77/R/V_inaequalis-LLimon-paired-THSCRS77_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS77/R/V_inaequalis-LLimon-paired-THSCRS77_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS78); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS78/F/V_inaequalis-LLimon-paired-THSCRS78_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS78/F/V_inaequalis-LLimon-paired-THSCRS78_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS78/R/V_inaequalis-LLimon-paired-THSCRS78_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS78/R/V_inaequalis-LLimon-paired-THSCRS78_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS80); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS80/F/V_inaequalis-LLimon-paired-THSCRS80_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS80/F/V_inaequalis-LLimon-paired-THSCRS80_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS80/R/V_inaequalis-LLimon-paired-THSCRS80_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS80/R/V_inaequalis-LLimon-paired-THSCRS80_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSCRS81); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS81/F/V_inaequalis-LLimon-paired-THSCRS81_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS81/F/V_inaequalis-LLimon-paired-THSCRS81_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS81/R/V_inaequalis-LLimon-paired-THSCRS81_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCRS81/R/V_inaequalis-LLimon-paired-THSCRS81_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
	
```

```bash
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSC*); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	echo $Isolate
	F_Read=$(ls $ReadDir/F/*trim.fq.gz)
	R_Read=$(ls $ReadDir/R/*trim.fq.gz)
	OutDir=$(echo $ReadDir/genome_coverage)
	mkdir -p $OutDir
	ProgDir=~/git_repos/tools/seq_tools/dna_qc
	sbatch $ProgDir/sub_count_nuc.sh $F_Read $R_Read 72 $OutDir
done
#1206-1251
```

## SNP
Mapping reads to reference, cleaning the mapped files and calling SNPs. Filtering SNPs and their basic summary stats. Various methods of establishing population structure, including SNP-based NJ trees.

Reads were mapped using the Passey Scab genome as a reference.
```bash
conda activate bowtie2
for ReadDir in $(ls -d dna_qc/V_inaequalis/LLimon/*/THSC*); do
	Isolate=$(echo $ReadDir | cut -d '/' -f5)
	echo $Isolate
	Reference=assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	F_Read=$(ls $ReadDir/F/*trim.fq.gz)
	R_Read=$(ls $ReadDir/R/*trim.fq.gz)
	OutDir=$(echo $ReadDir/passey | sed 's@LLimon@LLimon/bowtie@g' | sed 's@dna_qc@alignment@g')
	ProgDir=/home/heavet/git_repos/tools/seq_tools/genome_alignment/bowtie
	sbatch $ProgDir/sub_bowtie.sh $Reference $F_Read $R_Read $OutDir
done
#752, 754-798 
conda deactivate

for mapfile in $(ls alignment/V_inaequalis/LLimon/bowtie/*/*/passey/*.sam); do
	Isolate=$(echo $mapfile | cut -d '/' -f6)
	echo $Isolate
	mv $mapfile $(dirname $mapfile)/$(echo $Isolate)_$(basename $mapfile)
done
```
```bash
conda activate Picard
for mapfile in $(ls alignment/V_inaequalis/LLimon/bowtie/*/THSCRS*/passey/*.sam); do
	Isolate=$(echo $mapfile | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $mapfile)/nomulti
    mkdir $OutDir
    ProgDir=~/git_repos/tools/popgen/snp
    sbatch $ProgDir/pre_SNP_calling.slurm2.sh $mapfile $Isolate $OutDir 
done
#1422-1468
conda deactivate
``` 
Redundant?:
```bash 
conda activate Picard
for input in $(ls alignment/V_inaequalis/LLimon/bowtie/paired/THSCA*/passey/nomulti/*.bam); do
	Isolate=$(echo $mapfile | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $input  | sed 's@nomulti@pre_indel_realignment@g')
    mkdir -p $OutDir
    Reference=/projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
    ProgDir=~/git_repos/tools/popgen/snp
    sbatch $ProgDir/pre_indel_realignment_v2.sh $Reference $input $Strain $Outdir
done
#
conda deactivate  
```
The next step in the GATK SNP calling pileup pipeline is base quality score recalibration (BQSR) which uses known variant sets to mask out positions where variations are commonly found. 
If no preexisting SNP and INDEL data is available, variant calling may be performed without applying BQSR, by applying hard filtering on the raw call data set 

Call snps
```bash
#Standard annotation:
conda activate Picard
for input in $(ls alignment/V_inaequalis/LLimon/bowtie/paired/THSC*/passey/nomulti/*.bam); do
	Isolate=$(echo $input | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $input  | sed 's@nomulti@@g' | sed 's@alignment@snp_calling@g' | sed 's@bowtie/paired@gatk@g')
    mkdir -p $OutDir
    Reference=/projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
    Ploidy="1"
    ProgDir=~/git_repos/tools/popgen/snp
    sbatch $ProgDir/haplotyp_caller.sh $Reference $Isolate $input $OutDir $Ploidy
done
#1554-1600
```
Combine samples pre-called with HaplotypeCaller and Perform joint genotyping.

Break down complex SNPs into primitive ones with VariantsToAllelicPrimitives
This tool will take an MNP (e.g. ACCCA -> TCCCG) and break it up into separate records for each component part (A-T and A->G). This tool modifies only bi-allelic variants.
```bash
mkdir snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls
touch snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
for vcf in $(ls /projects/nano_diagnostics/snp_calling/V_inaequalis/LLimon/gatk/THSC*/passey/*_SNP_calls.g.vcf); do
	Isolate=$(echo $vcf | cut -d '/' -f8)
	echo $Isolate
	echo $vcf >> snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
done

Reference=assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
VCFlist=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
Outprefix=LLimon50
OutDir=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls
ProgDir=~/git_repos/tools/popgen/snp
conda activate Picard
sbatch $ProgDir/CombineGVCFs.sh $Reference $VCFlist $OutDir $Outprefix
#1661
VCFcombined=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon50_cohort.g.vf.gz
sbatch $ProgDir/genotype_gvcf.sh $Reference $VCFcombined $OutDir $Outprefix
#1664 - primitives not working
conda deactivate
conda activate vcflib
vcfallelicprimitives -kg $OutDir/LLimon50_SNPs_genotype_primitive.vcf > $OutDir/LLimon50_SNPs_genotype_primitive2.vcf #still same file length
conda deactivate
```
Filtering with vcftools:
```bash
conda activate vcflib
for vcf in $(ls snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/*_genotype.vcf); do
	mq=40 #the phred-scaled probability of a SNP occurring at this site.
	qual=30 #phred-scaled probability that the read is mapped to the correct location (a low map score will occur if reads are not mapped uniquely at that site).
	dp=10 #Minimum depth (integer) at the site per sample.
	gq=30 #the phred-scaled probability that the sample genotype being called is correct, given that there is a SNP at that site.
	na=1 #Exclude sites on the basis of the proportion of missing data (defined to be between 0 and 1, where 0 allows sites that are completely missing and 1 indicates no missing data allowed).
	indel=N #Remove indels or not? Y/N
	Outdir=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls
	Prefix=LLimon50_SNPs
	ProgDir=~/git_repos/tools/popgen/snp
	sbatch $ProgDir/sub_vcf_parser.sh $vcf $Outdir $Prefix 40 30 10 30 1 N
done
#2526
conda deactivate 
wc -l snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon50_SNPs_filtered.vcf #275 - no variants in file, jsut headers etc. "After filtering, kept 0 out of a possible 136007 Sites"
```
Filtering with GATK tools:
Recommended when a variant callset is too small for VQSR or for which truth/training sets are not available.
https://sites.google.com/a/broadinstitute.org/legacy-gatk-forum-discussions/tutorials/2806-how-to-apply-hard-filters-to-a-call-set

```bash
conda activate Picard
for vcf in $(ls snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/*_genotype.vcf); do 
	Reference=assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	Outdir=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls
	prefix=LLimon50_SNPs_gatk
	mkdir -p $Outdir
	ProgDir=~/git_repos/tools/popgen/snp
	sbatch $ProgDir/variant_hard_filter.sh $Reference $vcf $Outdir $prefix
done 
#2525
conda deactivate 
grep -c -i QFBF snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon50_SNPs_gatk_filtered_indels.vcf #49,236
grep -c -i QFBF snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon50_SNPs_gatk_filtered_snps.vcf #536,230
#Output from this are not primitive snps
```
Make table with filtered variants:
```bash
conda activate Picard
for vcf in /projects/nano_diagnostics/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/*gatk_filtered_*; do 
  #Outdir=/projects/nano_diagnostics/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/table
  Outdir=/scratch/projects/heavet/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/table
  mkdir -p $Outdir
  Reference=/projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
  ProgDir=~/git_repos/tools/popgen/snp
  prefix=LLimon50_SNPs_gatk
  sbatch $ProgDir/variants_to_table.sh $Reference $prefix $vcf $Outdir
done 
#5956
#5957
conda deactivate
```
Plot filtering results:
```bash
srun --partition long --time 0-04:00:00 --mem 10gb --cpus-per-task 10 --pty bash
SnpTsv=$(ls /scratch/projects/heavet/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/table/*_snps_stats.tsv)
Outdir=/scratch/projects/heavet/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/cohort/filtering_plots_R
mkdir -p $Outdir
ProgDir=~/git_repos/tools/popgen/snp
Rscript --vanilla $ProgDir/plot_filter_results.R $SnpTsv
```

























KLARA pipeline:


##-------------------------------------------------11. Plot filtering results (R)------------------------------------------------------------------------

##setwd("C:/Users/hajdk/OneDrive/New folder/Thesis/Chapter4_Hop_genome_analysis")
##library('ggplot2')
##library('tools')
##library('tidyverse')
##library('ggpubr')
##
##
##df1<-read.table("cohort_snps_stats.tsv" , sep = '\t', header = TRUE)
##
##str(df1)
##
##df1$PASS <- df1$FILTER
##df1$PASS[df1$PASS!="PASS"] <- "FAIL"
##df1$PASS <- as.factor(df1$PASS)
#### Histogram with density plot
##geom_histogram(aes(y=..density..), alpha=0.2, bins=50)
##
##p0 <- ggplot(df1, aes(x=QD)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p0)
##ggsave("../QD_all.pdf", p0)
##
##p1 <- ggplot(df1, aes(x=QD, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="right") 
##print(p1)
##
##p2 <- ggplot(df1, aes(x=FS, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="") +
##  scale_x_continuous(trans='log10')
##print(p2)
##
##p3 <- ggplot(df1, aes(x=SOR, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p3)
##
##p4 <- ggplot(df1, aes(x=MQ, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p4)
##
##p5 <- ggplot(df1, aes(x=MQRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p5)
##
##p6 <- ggplot(df1, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p6)
##
##
##df2<-read.table("cohort_indels_stats.tsv" , sep = '\t', header = TRUE)
##
##str(df1)
##
##df2$PASS <- df2$FILTER
##df2$PASS[df2$PASS!="PASS"] <- "FAIL"
##df2$PASS <- as.factor(df1$PASS)
#### Histogram with density plot
##geom_histogram(aes(y=..density..), alpha=0.4, bins=50)
##
##p7 <- ggplot(df2, aes(x=QD, colour=PASS, fill=PASS)) +
## geom_density(alpha=.4) +
##  theme(legend.position="none")
##print(p7)
##
##p8 <- ggplot(df2, aes(x=FS, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none") +
##  scale_x_continuous(trans='log10')
##print(p8)
##
##p9 <- ggplot(df2, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p9)


#alternatively use bash command to execute R script for visualising filtering results (this didn't work for me and just ran the script above directly from R)
#```bash
#srun --partition long --time 0-04:00:00 --mem 10gb --cpus-per-task 10 --pty bash
#SnpTsv=$(ls projects/hop/SNP_calling/haplotype_calls/cohort/filtered_gatk5/*_snps_stats.tsv)
#Outdir=/projects/hop/SNP_calling/haplotype_calls/cohort/filtering_plots_R
#mkdir -p $Outdir
#ProgDir=/home/hajduk/git_repos/scripts/hop_genomics/SNP_calling
#Rscript --vanilla $ProgDir/plot_filter_results_KH.R $SnpTsv
#```
#
#```bash
#srun --partition long --time 0-04:00:00 --mem 10gb --cpus-per-task 10 --pty bash
#IndelTsv=$(ls projects/hop/SNP_calling/haplotype_calls/cohort/filtered_gatk5/*_indels_stats.tsv)
#Outdir=/projects/hop/SNP_calling/haplotype_calls/cohort/filtering_plots_R
#mkdir -p $Outdir
#ProgDir=/home/hajduk/git_repos/scripts/hop_genomics/SNP_calling
#Rscript --vanilla $ProgDir/plot_filter_results_KH.R $IndelTsv
#``` 


##--------------------------------------------12. Annotate filtered VCF file for SNP effects (snpeff)---------------------------------------------------------------------------------- 

## Create custom SnpEff genome database

```bash
SnpEff=/projects/oldhome/sobczm/bin/snpEff
nano $SnpEff/snpEff.config
```

##download and unzip genemodels from hopbase.org
## /projects/hop mkdir gene_predictions
## $gene_predictions wget http://hopbase.org/content/maskedDedupCascade/version5/maskedCascadePrimary.genes.gff.gz
## $gene_predictions gunzip maskedCascadePrimary.genes.gff.gz

## Add the following lines to the section with databases:

```
##---
## EMR Databases
##----
## H. lupulus cascade genome
cascadePrimary.genome : hop_ref2021
```

##Collect input files

```bash
Reference=$(ls /projects/hop/cascade_2021/cascadePrimary.fasta)
Gff=$(ls /projects/hop/gene_prediction/cascade/maskedCascadePrimary.genes.gff)
SnpEff=/projects/oldhome/sobczm/bin/snpEff
mkdir $SnpEff/data/cascadePrimary
cp $Reference $SnpEff/data/cascadePrimary/sequences.fa
cp $Gff $SnpEff/data/cascadePrimary/genes.gff

##Build database using GFF3 annotation
java -jar $SnpEff/snpEff.jar build -gff3 -v cascadePrimary
```

## Annotate VCF files
CurDir=../../projects/hop/SNP_calling
cd $CurDir
for a in $(ls /projects/hop/SNP_calling/haplotype_calls_v2/hop_joint/filtered_gatk/*_filtered_snps.vcf); do  
    echo $a
    filename=$(basename "$a")
    Prefix=${filename%.vcf}
    OutDir=$(ls -d /projects/hop/SNP_calling/haplotype_calls_v2/hop_joint)
    #mkdir -p $Outdir
    SnpEff=/projects/oldhome/sobczm/bin/snpEff
    java -Xmx4g -jar $SnpEff/snpEff.jar -v -ud 0 cascadePrimary $a > $OutDir/"$Prefix"_annotated.vcf
    mv snpEff_genes.txt $OutDir/snpEff_genes_"$Prefix".txt
    mv snpEff_summary.html $OutDir/snpEff_summary_"$Prefix".html
done

  #submitted scripts below from the directory where files are located: /projects/hop/SNP_calling/haplotype_calls/cohort 
  ```bash 
    SnpEff=/projects/oldhome/sobczm/bin/snpEff
    #mv cohort_filtered_snps* $OutDir/.
    #-
    #Create subsamples of SNPs containing those in a given category
    #-
    #genic (includes 5', 3' UTRs)
    java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has 'missense_variant') || (ANN[*].EFFECT has 'nonsense_variant') || (ANN[*].EFFECT has 'synonymous_variant') || (ANN[*].EFFECT has 'intron_variant') || (ANN[*].EFFECT has '5_prime_UTR_variant') || (ANN[*].EFFECT has '3_prime_UTR_variant')" hop_joint_filtered_snps_annotated.vcf > hop_joint_filtered_snps_genic.vcf
    #coding
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant') || (ANN[0].EFFECT has 'synonymous_variant')" hop_joint_filtered_snps_annotated.vcf > hop_joint_filtered_snps_coding.vcf
    #non-synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant')" hop_joint_filtered_snps_annotated.vcf > hop_joint_filtered_snps_nonsyn.vcf
    #synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'synonymous_variant')" hop_joint_filtered_snps_annotated.vcf > hop_joint_filtered_snps_syn.vcf
    #Four-fold degenrate sites (output file suffix: 4fd)
   ```
  #```bash 
  #  ProgDir=/projects/oldhome/sobczm/bin/popgen/summary_stats
  #  Outdir=/projects/hop/SNP_calling/haplotype_calls/cohort/
  #  python $ProgDir/parse_snpeff_synonymous.py $OutDir/cohort_filtered_snps_syn.vcf
  #  AllSnps=$(cat $Outdir/cohort_filtered_snps_annotated.vcf | grep -v '#' | wc -l)
  #  GeneSnps=$(cat $Outdir/cohort_filtered_snps_gene.vcf | grep -v '#' | wc -l)
  #  CdsSnps=$(cat $Outdir/cohort_filtered_snps_coding.vcf | grep -v '#' | wc -
  #  NonsynSnps=$(cat $Outdir/cohort_filtered_snps_nonsyn.vcf | grep -v '#' | wc -l  )
  #  SynSnps=$(cat $Outdir/cohort_filtered_snps_syn.vcf | grep -v '#' | wc -l)
  #  printf "Comparison\$AllSnps\tGeneSnps\tCdsSnps\tSynSnps\tNonsynSnps\n"
  #  printf "cohort_filtered_snps\t$AllSnps\t$GeneSnps\t$CdsSnps\t$SynSnps\t$NonsynSnps\n"
  #```
grep -v '#' | wc -l hop_joint_filtered* 
  ### Results:
  ### 8850932 cohort_filtered_snps_annotated.vcf
  ### 178284 cohort_filtered_snps_coding.vcf
  ###  585881 cohort_filtered_snps_genic.vcf
  ###  115559 cohort_filtered_snps_nonsyn.vcf
  ###   71507 cohort_filtered_snps_syn.vcf

#manipulate snpeff vcf:
more cohort_annotated_snps_extracted.vcf | grep -v '#' | grep "PASS" | cut -f 1,2,8,9,10 | sed 's/|/\t/g' | cut -f 1,2,4,5,7 | grep -v "intergenic\|stream" > cohort_filtered_snps_annotated_table > 
# grep -v "" takes every line that start with " 
# wc -l counts  
# cut -f will take whole columns from a file , numbers to define which ones
# cut -f 1 | sort | uniq | wc -l  take a column and removes duplicates
# sed 's/|/\t/g' will put things in separate columns that had a pipe (|) between them. after they are separated, information can be extracted
# https://www.youtube.com/watch?v=-rmreyRAbkE very good snpeff interpretation and manipulation video
#want to extract information on where the snp is , impact level, what gene is in 
# venny (bioinfogp.cnb.csic.es) makes vennn diagrams for comparing snps in different genomes

##Pipeline complete 




