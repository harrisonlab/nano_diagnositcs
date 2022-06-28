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
for rawdata in $(ls -d /main/temp-archives/2022_eastmall_general/thomas_heaven_X204SC22010737-Z01-F001/X204SC22010737-Z01-F001/raw_data/THSC*); do
	Isolate=$(echo $rawdata | cut -d '/' -f8)
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
for rawdata in $(ls -d /archives/2021_eastmall_general/thomas_heaven_X204SC21091991-Z01-F003/X204SC21091991-Z01-F003/raw_data/THSC*83); do
	Isolate=$(echo $rawdata | cut -d '/' -f7)
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/F
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/R
	mkdir -p rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all	
	echo $Isolate
	Fread=$(ls $rawdata/*L1_1.fq.gz)
	Rread=$(ls $rawdata/*L1_2.fq.gz)
	Fname=$(basename $Fread | cut -d '_' -f1)_f.fq.gz
	Rname=$(basename $Rread | cut -d '_' -f1)_r.fq.gz
	ln -s $Fread rawdata/V_inaequalis/LLimon/paired/$Isolate/F/$Fname
	ln -s $Rread rawdata/V_inaequalis/LLimon/paired/$Isolate/R/$Rname
	ln -s $Fread rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all/$Fname
	ln -s $Rread rawdata/V_inaequalis/LLimon/paired/$Isolate/1/all/$Rname
done

scp -r rawdata/V_inaequalis/LLimon theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/projects/niab/theaven/raw_data/DNA/venturia/inaequalis/.
```
Raw reads were submitted to the NCBI SRA
```bash
screen -S ftp
conda activate ftp
lftp ftp-private.ncbi.nlm.nih.gov
login subftp
w4pYB9VQ
cd uploads/tcheaven_googlemail.com_mCkezA8U
mkdir PRJNA817384
cd PRJNA817384
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCAF28/1/all/THSCAF28_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCAF28/1/all/THSCAF28_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS101/1/all/THSCRS101_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS101/1/all/THSCRS101_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS102/1/all/THSCRS102_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS102/1/all/THSCRS102_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS103/1/all/THSCRS103_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS103/1/all/THSCRS103_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS104/1/all/THSCRS104_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS104/1/all/THSCRS104_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS106/1/all/THSCRS106_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS106/1/all/THSCRS106_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS109/1/all/THSCRS109_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS109/1/all/THSCRS109_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS110/1/all/THSCRS110_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS110/1/all/THSCRS110_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS111/1/all/THSCRS111_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS111/1/all/THSCRS111_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS11/1/all/THSCRS11_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS11/1/all/THSCRS11_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS115/1/all/THSCRS115_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS115/1/all/THSCRS115_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS116/1/all/THSCRS116_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS116/1/all/THSCRS116_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS117/1/all/THSCRS117_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS117/1/all/THSCRS117_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS118/1/all/THSCRS118_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS118/1/all/THSCRS118_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS119/1/all/THSCRS119_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS119/1/all/THSCRS119_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS1/1/all/THSCRS1_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS1/1/all/THSCRS1_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS121/1/all/THSCRS121_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS121/1/all/THSCRS121_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS12/1/all/THSCRS12_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS12/1/all/THSCRS12_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS123/1/all/THSCRS123_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS123/1/all/THSCRS123_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS124/1/all/THSCRS124_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS124/1/all/THSCRS124_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS125/1/all/THSCRS125_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS125/1/all/THSCRS125_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS127/1/all/THSCRS127_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS127/1/all/THSCRS127_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS128/1/all/THSCRS128_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS128/1/all/THSCRS128_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS13/1/all/THSCRS13_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS13/1/all/THSCRS13_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS14/1/all/THSCRS14_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS14/1/all/THSCRS14_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS16/1/all/THSCRS16_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS16/1/all/THSCRS16_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS17/1/all/THSCRS17_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS17/1/all/THSCRS17_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS21/1/all/THSCRS21_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS21/1/all/THSCRS21_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS2/1/all/THSCRS2_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS2/1/all/THSCRS2_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS229/1/all/THSCRS229_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS229/1/all/THSCRS229_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS29/1/all/THSCRS29_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS29/1/all/THSCRS29_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS31/1/all/THSCRS31_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS31/1/all/THSCRS31_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS3/1/all/THSCRS3_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS3/1/all/THSCRS3_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS32/1/all/THSCRS32_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS32/1/all/THSCRS32_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS33/1/all/THSCRS33_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS33/1/all/THSCRS33_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS36/1/all/THSCRS36_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS36/1/all/THSCRS36_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS37/1/all/THSCRS37_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS37/1/all/THSCRS37_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS38/1/all/THSCRS38_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS38/1/all/THSCRS38_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS39/1/all/THSCRS39_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS39/1/all/THSCRS39_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS40/1/all/THSCRS40_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS40/1/all/THSCRS40_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS41/1/all/THSCRS41_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS41/1/all/THSCRS41_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS42/1/all/THSCRS42_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS42/1/all/THSCRS42_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS43/1/all/THSCRS43_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS43/1/all/THSCRS43_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS44/1/all/THSCRS44_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS44/1/all/THSCRS44_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS48/1/all/THSCRS48_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS48/1/all/THSCRS48_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS49/1/all/THSCRS49_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS49/1/all/THSCRS49_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS50/1/all/THSCRS50_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS50/1/all/THSCRS50_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS54/1/all/THSCRS54_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS54/1/all/THSCRS54_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS57/1/all/THSCRS57_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS57/1/all/THSCRS57_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS58/1/all/THSCRS58_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS58/1/all/THSCRS58_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS59/1/all/THSCRS59_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS59/1/all/THSCRS59_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS60/1/all/THSCRS60_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS60/1/all/THSCRS60_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS70/1/all/THSCRS70_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS70/1/all/THSCRS70_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS736/1/all/THSCRS736_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS736/1/all/THSCRS736_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS77/1/all/THSCRS77_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS77/1/all/THSCRS77_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS78/1/all/THSCRS78_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS78/1/all/THSCRS78_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS79/1/all/THSCRS79_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS79/1/all/THSCRS79_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS80/1/all/THSCRS80_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS80/1/all/THSCRS80_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS81/1/all/THSCRS81_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS81/1/all/THSCRS81_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS82/1/all/THSCRS82_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS82/1/all/THSCRS82_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83/1/all/THSCRS83_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83/1/all/THSCRS83_r.fq.gz

mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_f.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_replicate_f.fq.gz
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_r.fq.gz /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_replicate_r.fq.gz

put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS83_2/1/all/THSCRS83_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS85/1/all/THSCRS85_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCRS85/1/all/THSCRS85_r.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCSP1/1/all/THSCSP1_f.fq.gz
put /scratch/projects/heavet/gene_pred_vAG/_sigP/split/rawdata/V_inaequalis/LLimon/paired/THSCSP1/1/all/THSCSP1_r.fq.gz

put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCSP1/THSCSP1_FDSW210224376-1r_HGCMMDSX2_L4_1.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCSP1/THSCSP1_FDSW210224376-1r_HGCMMDSX2_L4_2.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCSP1/THSCSP1_FDSW210224376-1r_HGH5KDSX2_L1_1.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCSP1/THSCSP1_FDSW210224376-1r_HGH5KDSX2_L1_2.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCAF28/THSCAF28_FDSW210224375-1r_HGCMMDSX2_L4_1.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCAF28/THSCAF28_FDSW210224375-1r_HGCMMDSX2_L4_2.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCAF28/THSCAF28_FDSW210224375-1r_HGH5KDSX2_L1_1.fq.gz
put /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THSCAF28/THSCAF28_FDSW210224375-1r_HGH5KDSX2_L1_2.fq.gz

exit
conda deactivate
exit
```
```bash
wget -P /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/351/075/GCA_003351075.1_ASM335107v1/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
gunzip /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna.gz 
```
```bash
for RawData in $(ls /home/theaven/projects/niab/theaven/raw_data/DNA/venturia/inaequalis/LLimon/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/scratch/apps/fastqc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#16884-17007,2491082-2491209
```
```bash
conda activate trimmomatic
for ReadDir in $(ls -d /home/theaven/projects/niab/theaven/raw_data/DNA/venturia/inaequalis/LLimon/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/scratch/apps/trimmomatic/ncbi_adapters.fa
ProgDir=~/scratch/apps/trimmomatic
OutDir=$(echo $ReadDir|sed 's@/home/theaven/projects/niab/theaven/raw_data/DNA@/home/theaven/scratch/dna_qc@g')
Prefix=$(echo $ReadDir|cut -f9,10,11,13,14 -d '/' --output-delimiter '-')
echo $Prefix
echo $OutDir
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
conda dactivate
#17008-17072,2491429-2491577,2491648
```
```bash
for QCData in $(ls dna_qc/venturia/inaequalis/LLimon/*/*/*/*.fq.gz); do
echo $QCData
ProgDir=~/scratch/apps/fastqc
OutDir=$(dirname $QCData)
Outfile=$(basename -a $QCData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $QCData $OutDir $Outfile
done
#558-741,-2491904
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
	#kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/F/V_inaequalis-LLimon-paired-THSCAF28_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/F/V_inaequalis-LLimon-paired-THSCAF28_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/R/V_inaequalis-LLimon-paired-THSCAF28_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/V_inaequalis/LLimon/paired/THSCAF28/R/V_inaequalis-LLimon-paired-THSCAF28_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/NCBI/venturia/V_inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 100 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot100 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
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
conda deactivate 
exit
exit	

screen -S KAT
srun -p himem --mem 500G --pty bash
conda activate kat
for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS104); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS104/F/venturia-inaequalis-LLimon-THSCRS104_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS104/F/venturia-inaequalis-LLimon-THSCRS104_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS104/R/venturia-inaequalis-LLimon-THSCRS104_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS104/R/venturia-inaequalis-LLimon-THSCRS104_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS106); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS106/F/venturia-inaequalis-LLimon-THSCRS106_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS106/F/venturia-inaequalis-LLimon-THSCRS106_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS106/R/venturia-inaequalis-LLimon-THSCRS106_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS106/R/venturia-inaequalis-LLimon-THSCRS106_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS109); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS109/F/venturia-inaequalis-LLimon-THSCRS109_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS109/F/venturia-inaequalis-LLimon-THSCRS109_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS109/R/venturia-inaequalis-LLimon-THSCRS109_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS109/R/venturia-inaequalis-LLimon-THSCRS109_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS110); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS110/F/venturia-inaequalis-LLimon-THSCRS110_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS110/F/venturia-inaequalis-LLimon-THSCRS110_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS110/R/venturia-inaequalis-LLimon-THSCRS110_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS110/R/venturia-inaequalis-LLimon-THSCRS110_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS111); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
done
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS115); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS111/F/venturia-inaequalis-LLimon-THSCRS111_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS111/F/venturia-inaequalis-LLimon-THSCRS111_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS111/R/venturia-inaequalis-LLimon-THSCRS111_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS111/R/venturia-inaequalis-LLimon-THSCRS111_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS116); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS116/F/venturia-inaequalis-LLimon-THSCRS116_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS116/F/venturia-inaequalis-LLimon-THSCRS116_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS116/R/venturia-inaequalis-LLimon-THSCRS116_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS116/R/venturia-inaequalis-LLimon-THSCRS116_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS117); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS117/F/venturia-inaequalis-LLimon-THSCRS117_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS117/F/venturia-inaequalis-LLimon-THSCRS117_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS117/R/venturia-inaequalis-LLimon-THSCRS117_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS117/R/venturia-inaequalis-LLimon-THSCRS117_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS12); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS12/F/venturia-inaequalis-LLimon-THSCRS12_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS12/F/venturia-inaequalis-LLimon-THSCRS12_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS12/R/venturia-inaequalis-LLimon-THSCRS12_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS12/R/venturia-inaequalis-LLimon-THSCRS12_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS128); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS128/F/venturia-inaequalis-LLimon-THSCRS128_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS128/F/venturia-inaequalis-LLimon-THSCRS128_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS128/R/venturia-inaequalis-LLimon-THSCRS128_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS128/R/venturia-inaequalis-LLimon-THSCRS128_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS16); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS16/F/venturia-inaequalis-LLimon-THSCRS16_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS16/F/venturia-inaequalis-LLimon-THSCRS16_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS16/R/venturia-inaequalis-LLimon-THSCRS16_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS16/R/venturia-inaequalis-LLimon-THSCRS16_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS21); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS21/F/venturia-inaequalis-LLimon-THSCRS21_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS21/F/venturia-inaequalis-LLimon-THSCRS21_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS21/R/venturia-inaequalis-LLimon-THSCRS21_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS21/R/venturia-inaequalis-LLimon-THSCRS21_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS29); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS29/F/venturia-inaequalis-LLimon-THSCRS29_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS29/F/venturia-inaequalis-LLimon-THSCRS29_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS29/R/venturia-inaequalis-LLimon-THSCRS29_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS29/R/venturia-inaequalis-LLimon-THSCRS29_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS38); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS38/F/venturia-inaequalis-LLimon-THSCRS38_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS38/F/venturia-inaequalis-LLimon-THSCRS38_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS38/R/venturia-inaequalis-LLimon-THSCRS38_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS38/R/venturia-inaequalis-LLimon-THSCRS38_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS79); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS79/F/venturia-inaequalis-LLimon-THSCRS79_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS79/F/venturia-inaequalis-LLimon-THSCRS79_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS79/R/venturia-inaequalis-LLimon-THSCRS79_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS79/R/venturia-inaequalis-LLimon-THSCRS79_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS82); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS82/F/venturia-inaequalis-LLimon-THSCRS82_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS82/F/venturia-inaequalis-LLimon-THSCRS82_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS82/R/venturia-inaequalis-LLimon-THSCRS82_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS82/R/venturia-inaequalis-LLimon-THSCRS82_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS83); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83/F/venturia-inaequalis-LLimon-THSCRS83_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83/F/venturia-inaequalis-LLimon-THSCRS83_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83/R/venturia-inaequalis-LLimon-THSCRS83_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83/R/venturia-inaequalis-LLimon-THSCRS83_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS83_2); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83_2/F/venturia-inaequalis-LLimon-THSCRS83_2_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83_2/F/venturia-inaequalis-LLimon-THSCRS83_2_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83_2/R/venturia-inaequalis-LLimon-THSCRS83_2_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS83_2/R/venturia-inaequalis-LLimon-THSCRS83_2_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSCRS85); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	Reads=$(ls $PWD/$ReadDir/*/*.fq.gz)
	echo $Isolate
	echo $Reads
	mkdir -p alignment/V_inaequalis/LLimon/kat/$Isolate/passey
	kat comp -m 21 -v -h -t 8 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey '/home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS85/F/venturia-inaequalis-LLimon-THSCRS85_F_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS85/F/venturia-inaequalis-LLimon-THSCRS85_F_trim_unpaired.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS85/R/venturia-inaequalis-LLimon-THSCRS85_R_trim.fq.gz /home/theaven/scratch/dna_qc/venturia/inaequalis/LLimon/paired/THSCRS85/R/venturia-inaequalis-LLimon-THSCRS85_R_trim_unpaired.fq.gz' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	kat plot spectra-cn -x 300 -o alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passeyplot300 alignment/V_inaequalis/LLimon/kat/$Isolate/passey/reads_v_passey-main.mx
done
conda deactivate 
exit
exit	
exit
```

```bash
scp -r /data/scratch/gomeza/prog/count_nucl.pl  theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/trimmomatic/.

for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSC*); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	echo $Isolate
	F_Read=$(ls $ReadDir/F/*trim.fq.gz)
	R_Read=$(ls $ReadDir/R/*trim.fq.gz)
	OutDir=$(echo $ReadDir/genome_coverage)
	mkdir -p $OutDir
	ProgDir=~/scratch/apps/trimmomatic
	sbatch $ProgDir/sub_count_nuc.sh $F_Read $R_Read 72 $OutDir
done
#1206-1251,-2491970
```

## SNP
Mapping reads to reference, cleaning the mapped files and calling SNPs. Filtering SNPs and their basic summary stats. Various methods of establishing population structure, including SNP-based NJ trees.

Reads were mapped using the Passey Scab genome as a reference.
```bash
conda activate bowtie2
for ReadDir in $(ls -d dna_qc/venturia/inaequalis/LLimon/*/THSC*); do
	Isolate=$(echo $ReadDir | cut -d '/' -f6)
	echo $Isolate
	Reference=data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	F_Read=$(ls $ReadDir/F/*trim.fq.gz)
	R_Read=$(ls $ReadDir/R/*trim.fq.gz)
	OutDir=$(echo $ReadDir/passey | sed 's@LLimon/paired@LLimon/bowtie@g' | sed 's@dna_qc@alignment@g')
	ProgDir=~/scratch/apps/bowtie2
	sbatch $ProgDir/bowtie2.sh $Reference $F_Read $R_Read $OutDir
done
#752, 754-798, -2492726
conda deactivate

for mapfile in $(ls alignment/venturia/inaequalis/LLimon/bowtie/*/passey/*.sam); do
	Isolate=$(echo $mapfile | cut -d '/' -f6)
	echo $Isolate
	mv $mapfile $(dirname $mapfile)/$(echo $Isolate)_$(basename $mapfile)
done
```
Remove multimapping reads, discordant reads, optical duplicates (samtools) and add read group and sample name to each mapped read.
```bash
scp -r ~/git_repos/tools/popgen/snp/pre_SNP_calling.slurm2.sh  theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.

conda activate Picard
for mapfile in $(ls alignment/venturia/inaequalis/LLimon/bowtie/THSC*/passey/*.sam); do
	Isolate=$(echo $mapfile | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $mapfile)/nomulti
    mkdir $OutDir
    ProgDir=~/scratch/apps/snp
    sbatch $ProgDir/pre_SNP_calling.slurm2.sh $mapfile $Isolate $OutDir 
done
#1422-1468, -2495733
conda deactivate
``` 
Redundant?:" starting in GATK4 the indel realignment step will no longer be part of the pipeline""variant calling workflows that use HaplotypeCaller or MuTect2 now omit indel realignment.-HaplotypeCaller and MuTect2 do their own internal realignment"
```bash 
scp -r ~/git_repos/tools/popgen/snp/pre_indel_realignment_v2.sh  theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.

conda activate Picard
for input in $(ls alignment/venturia/inaequalis/LLimon/bowtie/THSC*/passey/nomulti/*.bam); do
	Isolate=$(echo $input | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $input  | sed 's@nomulti@pre_indel_realignment@g')
    mkdir -p $OutDir
    Reference=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
    ProgDir=~/scratch/apps/snp
    sbatch $ProgDir/pre_indel_realignment_v2.sh $Reference $input $Strain $Outdir
done
#-2496529
conda deactivate  
```
The next step in the GATK SNP calling pileup pipeline is base quality score recalibration (BQSR) which uses known variant sets to mask out positions where variations are commonly found. 
If no preexisting SNP and INDEL data is available, variant calling may be performed without applying BQSR, by applying hard filtering on the raw call data set 

Call snps
```bash
#Standard annotation:
conda activate Picard
for input in $(ls alignment/venturia/inaequalis/LLimon/bowtie/THSC*/passey/nomulti/*.bam); do
	Isolate=$(echo $input | cut -d '/' -f6)
	echo $Isolate
    OutDir=$(dirname $input  | sed 's@nomulti@@g' | sed 's@alignment@snp_calling@g' | sed 's@bowtie/paired@gatk@g')
    mkdir -p $OutDir
    Reference=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna 
    Ploidy="1"
    ProgDir=~/scratch/apps/snp
    sbatch $ProgDir/haplotyp_caller.sh $Reference $Isolate $input $OutDir $Ploidy
done
#1554-1600,-2521348
```

###############################################################################################
#13.) Combine.vcf files from haplotype caller using GenogypeGVCF and filter only biallelic SNPs.

```bash
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/SNP_calling_pileup
sbatch $ProgDir/genotype_gvcf.sh
```
###############################################################################################

Combine samples pre-called with HaplotypeCaller and Perform joint genotyping.

Break down complex SNPs into primitive ones with VariantsToAllelicPrimitives
This tool will take an MNP (e.g. ACCCA -> TCCCG) and break it up into separate records for each component part (A-T and A->G). This tool modifies only bi-allelic variants.
```bash
mkdir -p snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls
touch snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
for vcf in $(ls /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/bowtie/THSC*/passey/*_SNP_calls.g.vcf); do
	Isolate=$(echo $vcf | cut -d '/' -f9)
	echo $Isolate
	echo $vcf >> snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
done

Reference=data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
VCFlist=snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/SNP.list
Outprefix=LLimon
OutDir=snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls
#ProgDir=~/git_repos/tools/popgen/snp
ProgDir=~/scratch/apps/snp
conda activate Picard
sbatch $ProgDir/CombineGVCFs.sh $Reference $VCFlist $OutDir $Outprefix
#1661, 2674416

VCFcombined=snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_cohort.g.vf.gz
sbatch $ProgDir/genotype_gvcf.sh $Reference $VCFcombined $OutDir $Outprefix
#2747506, 2775169, 2780496
#1664 - primitives not working
conda deactivate
conda activate vcflib
vcfallelicprimitives -kg $OutDir/LLimon50_SNPs_genotype_primitive.vcf > $OutDir/LLimon50_SNPs_genotype_primitive2.vcf #still same file length
conda deactivate
```
Filtering with vcftools:
```bash
scp -r ~/git_repos/tools/popgen/snp/sub_vcf_parser.sh theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.

conda activate vcflib
for vcf in $(ls snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/*_genotype.vcf); do
	mq=40 #the phred-scaled probability of a SNP occurring at this site.
	qual=30 #phred-scaled probability that the read is mapped to the correct location (a low map score will occur if reads are not mapped uniquely at that site).
	dp=10 #Minimum depth (integer) at the site per sample.
	gq=30 #the phred-scaled probability that the sample genotype being called is correct, given that there is a SNP at that site.
	na=1 #Exclude sites on the basis of the proportion of missing data (defined to be between 0 and 1, where 0 allows sites that are completely missing and 1 indicates no missing data allowed).
	indel=N #Remove indels or not? Y/N
	Outdir=snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls
	Prefix=LLimon50_SNPs
	#ProgDir=~/git_repos/tools/popgen/snp
	ProgDir=/home/theaven/scratch/apps/snp
	sbatch $ProgDir/sub_vcf_parser.sh $vcf $Outdir $Prefix 40 30 10 30 1 N
done
#2526, 2780529, 2789243
conda deactivate 
wc -l snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon50_SNPs_filtered.vcf #275 - no variants in file, jsut headers etc. "After filtering, kept 0 out of a possible 136007 Sites"
```
We are going to only keep variants that have been successfully genotyped in 50% of individuals, a minimum quality score of 30, and a minor allele count of 3.
```bash
conda activate vcflib
vcftools --gzvcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype.vcf --max-missing 0.5 --mac 3 --minQ 30 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter1
#After filtering, kept 64 out of 64 Individuals
#After filtering, kept 290830 out of a possible 603595 Sites
conda deactivate
```
Filter for minimum depth for a genotype call and a minimum mean depth, This command will recode genotypes that have less than 3 reads
```bash
conda activate vcflib
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter1.recode.vcf --minDP 3 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter2
conda deactivate
#After filtering, kept 64 out of 64 Individuals
#After filtering, kept 290830 out of a possible 290830 Sites
```
Get rid of individuals that did not sequence well:
```bash
conda activate vcflib
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter2.recode.vcf --missing-indv
mv out.imiss snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/.
#After filtering, kept 64 out of 64 Individuals
#After filtering, kept 290830 out of a possible 290830 Sites

mawk '!/IN/' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/out.imiss | cut -f5 > totalmissing
gnuplot << \EOF 
set terminal dumb size 120, 30
set autoscale 
unset label
set title "Histogram of % missing data per individual"
set ylabel "Number of Occurrences"
set xlabel "% of missing data"
#set yr [0:100000]
binwidth=0.01
bin(x,width)=width*floor(x/width) + binwidth/2.0
plot 'totalmissing' using (bin($1,binwidth)):(1.0) smooth freq with boxes
pause -1
EOF
rm totalmissing
conda deactivate

#                                         Histogram of % missing data per individual
#     18 +-----------------------------------------------------------------------------------------------------------+
#        |         +**       +        +         +         +         +         +         +        +         +         |
#        |          **                                         'totalmissing' using (bin($1,binwidth)):(1.0) ******* |
#     16 |-+        **                                                                                             +-|
#        |          **                                                                                               |
#     14 |-+        **                                                                                             +-|
#        |          **                                                                                               |
#        |          **                                                                                               |
#     12 |-+        **                                                                                             +-|
#        |          **                                                                                               |
#     10 |-+        ***                                                                                            +-|
#        |         ****                                                                                              |
#        |         ****                                                                                              |
#      8 |-+       ****                                                                                            +-|
#        |        *****                                                                                              |
#      6 |-+      ******                                                                                           +-|
#        |        ******                                                                                             |
#        |        ******                                                                                             |
#      4 |-+      ******                                                                                           +-|
#        |        ******                                                                                  ***        |
#      2 |-+      *******                                                                                 ***      +-|
#        |        *******                                                                                 ***        |
#        |     **********************************************************************************************        |
#      0 +-----------------------------------------------------------------------------------------------------------+
#        0        0.1       0.2      0.3       0.4       0.5       0.6       0.7       0.8      0.9        1        1.1
#                                                      % of missing data
#
```
Create a list of individuals with more than 50% missing data and remove them
```bash
conda activate vcflib
mawk '$5 > 0.5' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/out.imiss | cut -f1 > snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/lowDP.indv
mawk '$5 > 0.9' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/out.imiss | cut -f1 > snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/90DP.indv
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter2.recode.vcf --remove snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/lowDP.indv --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3
#After filtering, kept 56 out of 64 Individuals
#After filtering, kept 290830 out of a possible 290830 Sites

#Table shows that 100% of data is missing for 8 samples
conda deactivate
```
Now that we have removed poor coverage individuals, we can restrict the data to variants called in a high percentage of individuals and filter by mean depth of genotypes;  a genotype call rate (95%) across all individuals. 
```bash
conda activate vcflib
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.05 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4 --min-meanDP 20
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 504 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.05 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.1 --min-meanDP 5
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 168863 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.05 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.2
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 169502 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.05 --max-maf 0.95 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.3 --min-meanDP 5
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 168863 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.05 --max-maf 0.95 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.4 --min-meanDP 10
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 42620 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.25 --max-maf 0.75 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.5 --min-meanDP 5
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 167505 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.40 --max-maf 0.60 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.6 --min-meanDP 5
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 141617 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.45 --max-maf 0.55 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.7 --min-meanDP 5
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 77154 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.40 --max-maf 0.60 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.8 --min-meanDP 10
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 33721 out of a possible 290830 Sites
vcftools --vcf snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter3.recode.vcf --max-missing 0.95 --maf 0.45 --max-maf 0.55 --recode --recode-INFO-all --out snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.9 --min-meanDP 10
#After filtering, kept 56 out of 56 Individuals
#After filtering, kept 17885 out of a possible 290830 Sites
conda deactivate
```
```bash
conda activate Picard
gatk FilterVcf -I snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.6.recode.vcf --MIN_AB  0.45 -O snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter5.vcf
```

Filtering with GATK tools:
Recommended when a variant callset is too small for VQSR or for which truth/training sets are not available.
https://sites.google.com/a/broadinstitute.org/legacy-gatk-forum-discussions/tutorials/2806-how-to-apply-hard-filters-to-a-call-set

The established way to filter the raw variant callset is to use variant quality score recalibration (VQSR), which uses machine learning to identify annotation profiles of variants that are likely to be real, and assigns a VQSLOD score to each variant that is much more reliable than the QUAL score calculated by the caller. To apply this we need a reference set of variant calls (unlikely in our organisms). Alternatively, we hard-filter the VCF file to our best variants and use these for training.

```bash
conda activate Picard
#for vcf in $(ls snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/*_genotype.vcf); do 
for vcf in snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_genotype_filter4.7*.vcf; do
	Reference=data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
	Outdir=snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7
	prefix=LLimon_SNPs_vcftools_gatk
	mkdir -p $Outdir
	#ProgDir=~/git_repos/tools/popgen/snp
	ProgDir=/home/theaven/scratch/apps/snp
	sbatch $ProgDir/variant_hard_filter.sh $Reference $vcf $Outdir $prefix
done 
#2525, 2780774 19312, 2792483
conda deactivate 

grep -c -i QFBF snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_gatk_filtered_indels.vcf #51,009
grep -c -i QFBF snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_gatk_filtered_snps.vcf #550,207
grep -c -i QFBF snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/*_genotype.vcf #603,833
#Output from this are not primitive snps
grep -c -i QFBF snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf
#134,026
```

Make table with filtered variants:
```bash
conda activate Picard
#for vcf in /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/*gatk_filtered_*; do 
  #Outdir=/projects/nano_diagnostics/snp_calling/V_inaequalis/LLimon/gatk/passey_haplotype_calls/table
for vcf in /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model1/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf; do
  Outdir=/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/table1
  mkdir -p $Outdir
  Reference=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
  ProgDir=/home/theaven/scratch/apps/snp
  #ProgDir=~/git_repos/tools/popgen/snp
  prefix=LLimon_SNPs_gatk_remodel
  sbatch $ProgDir/variants_to_table.sh $Reference $prefix $vcf $Outdir
done 
#5956, 2780824,  2792495
#5957, 2780825
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

#packages are not able to install properly as /user area is set to read only,  therefore have to use Rstudio on local machine
```
Files downloaded for use in Rstudio, to C:/Users/heavt/OneDrive - NIAB/Documents/R/bioinfo:
/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/table/LLimon_SNPs_gatk_indels_stats.tsv
/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/table/LLimon_SNPs_gatk_snps_stats.tsv
/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/table1/LLimon_SNPs_gatk_snps_stats.tsv

Following R script run locally:
```R

setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/bioinfo")
library('ggplot2')
library('tools')
library('tidyverse')
library('ggpubr')


df1<-read.table("LLimon_SNPs_gatk_snps_stats.tsv" , sep = '\t', header = TRUE)

str(df1)

df1$PASS <- df1$FILTER
df1$PASS[df1$PASS!="PASS"] <- "FAIL"
df1$PASS <- as.factor(df1$PASS)
## Histogram with density plot
geom_histogram(aes(y=..density..), alpha=0.2, bins=50)

p0 <- ggplot(df1, aes(x=QD)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p0)
ggsave("../QD_all.pdf", p0)

p1 <- ggplot(df1, aes(x=QD, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="right") 
print(p1)

p2 <- ggplot(df1, aes(x=FS, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="") +
  scale_x_continuous(trans='log10')
print(p2)

p3 <- ggplot(df1, aes(x=SOR, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p3)

p4 <- ggplot(df1, aes(x=MQ, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p4)

p5 <- ggplot(df1, aes(x=MQRankSum, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p5)

p6 <- ggplot(df1, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p6)


df2<-read.table("LLimon_SNPs_gatk_indels_stats.tsv" , sep = '\t', header = TRUE)

str(df1)

df2$PASS <- df2$FILTER
df2$PASS[df2$PASS!="PASS"] <- "FAIL"
df2$PASS <- as.factor(df1$PASS)
## Histogram with density plot
geom_histogram(aes(y=..density..), alpha=0.4, bins=50)

p7 <- ggplot(df2, aes(x=QD, colour=PASS, fill=PASS)) +
 geom_density(alpha=.4) +
  theme(legend.position="none")
print(p7)

p8 <- ggplot(df2, aes(x=FS, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none") +
  scale_x_continuous(trans='log10')
print(p8)

p9 <- ggplot(df2, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
  geom_density(alpha=.2) +
  theme(legend.position="none")
print(p9)

```
Extract snps that have passed quality filters
```bash
grep '#' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf > snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
grep 'PASS' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf >> snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
wc -l snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf #52,670

grep '#' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf > snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
grep 'PASS' snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7/LLimon_SNPs_vcftools_gatk_filtered_snps.vcf >> snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
wc -l snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model4.7/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf #28,546
```

## Joinmap

The filtered file snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf was downloaded and the program Tassel v5.2.81 used to convert it from .vcf to hapmap format.

Convert from hapmap format to joinmap format using python and pandas:
```python
import pandas as pd
import os
df = pd.read_csv("/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/sorted.vcf.hmp.txt",sep='\t') #read in data to pandas dataframe
len(df.index) #52389
#Remove any SNP entries where both parents have the same identity, these may be true SNPs vs the reference genome however will not be informative to our study
df2 = df[df['THSCAF28'] != df['THSCSP1']]
len(df2.index) #52382

#For each individual check to see if nucleotide identity at snps matches one or the other parent and assign A or B parent identity at that location accordingly:
for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS1_val = df2.at[x,'THSCRS1']
	if THSCRS1_val == THSCSP1_val:
		df2.at[x,'THSCRS1'] = 'B'
	else:
		if THSCRS1_val == THSCAF28_val:
			df2.at[x,'THSCRS1'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS101_val = df2.at[x,'THSCRS101']
	if THSCRS101_val == THSCSP1_val:
		df2.at[x,'THSCRS101'] = 'B'
	else:
		if THSCRS101_val == THSCAF28_val:
			df2.at[x,'THSCRS101'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS102_val = df2.at[x,'THSCRS102']
	if THSCRS102_val == THSCSP1_val:
		df2.at[x,'THSCRS102'] = 'B'
	else:
		if THSCRS102_val == THSCAF28_val:
			df2.at[x,'THSCRS102'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS103_val = df2.at[x,'THSCRS103']
	if THSCRS103_val == THSCSP1_val:
		df2.at[x,'THSCRS103'] = 'B'
	else:
		if THSCRS103_val == THSCAF28_val:
			df2.at[x,'THSCRS103'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS104_val = df2.at[x,'THSCRS104']
	if THSCRS104_val == THSCSP1_val:
		df2.at[x,'THSCRS104'] = 'B'
	else:
		if THSCRS104_val == THSCAF28_val:
			df2.at[x,'THSCRS104'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS106_val = df2.at[x,'THSCRS106']
	if THSCRS106_val == THSCSP1_val:
		df2.at[x,'THSCRS106'] = 'B'
	else:
		if THSCRS106_val == THSCAF28_val:
			df2.at[x,'THSCRS106'] = 'A'		

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS109_val = df2.at[x,'THSCRS109']
	if THSCRS109_val == THSCSP1_val:
		df2.at[x,'THSCRS109'] = 'B'
	else:
		if THSCRS109_val == THSCAF28_val:
			df2.at[x,'THSCRS109'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS11_val = df2.at[x,'THSCRS11']
	if THSCRS11_val == THSCSP1_val:
		df2.at[x,'THSCRS11'] = 'B'
	else:
		if THSCRS11_val == THSCAF28_val:
			df2.at[x,'THSCRS11'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS110_val = df2.at[x,'THSCRS110']
	if THSCRS110_val == THSCSP1_val:
		df2.at[x,'THSCRS110'] = 'B'
	else:
		if THSCRS110_val == THSCAF28_val:
			df2.at[x,'THSCRS110'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS111_val = df2.at[x,'THSCRS111']
	if THSCRS111_val == THSCSP1_val:
		df2.at[x,'THSCRS111'] = 'B'
	else:
		if THSCRS111_val == THSCAF28_val:
			df2.at[x,'THSCRS111'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS115_val = df2.at[x,'THSCRS115']
	if THSCRS115_val == THSCSP1_val:
		df2.at[x,'THSCRS115'] = 'B'
	else:
		if THSCRS115_val == THSCAF28_val:
			df2.at[x,'THSCRS115'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS116_val = df2.at[x,'THSCRS116']
	if THSCRS116_val == THSCSP1_val:
		df2.at[x,'THSCRS116'] = 'B'
	else:
		if THSCRS116_val == THSCAF28_val:
			df2.at[x,'THSCRS116'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS117_val = df2.at[x,'THSCRS117']
	if THSCRS117_val == THSCSP1_val:
		df2.at[x,'THSCRS117'] = 'B'
	else:
		if THSCRS117_val == THSCAF28_val:
			df2.at[x,'THSCRS117'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS118_val = df2.at[x,'THSCRS118']
	if THSCRS118_val == THSCSP1_val:
		df2.at[x,'THSCRS118'] = 'B'
	else:
		if THSCRS118_val == THSCAF28_val:
			df2.at[x,'THSCRS118'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS119_val = df2.at[x,'THSCRS119']
	if THSCRS119_val == THSCSP1_val:
		df2.at[x,'THSCRS119'] = 'B'
	else:
		if THSCRS119_val == THSCAF28_val:
			df2.at[x,'THSCRS119'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS12_val = df2.at[x,'THSCRS12']
	if THSCRS12_val == THSCSP1_val:
		df2.at[x,'THSCRS12'] = 'B'
	else:
		if THSCRS12_val == THSCAF28_val:
			df2.at[x,'THSCRS12'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS121_val = df2.at[x,'THSCRS121']
	if THSCRS121_val == THSCSP1_val:
		df2.at[x,'THSCRS121'] = 'B'
	else:
		if THSCRS121_val == THSCAF28_val:
			df2.at[x,'THSCRS121'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS123_val = df2.at[x,'THSCRS123']
	if THSCRS123_val == THSCSP1_val:
		df2.at[x,'THSCRS123'] = 'B'
	else:
		if THSCRS123_val == THSCAF28_val:
			df2.at[x,'THSCRS123'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS124_val = df2.at[x,'THSCRS124']
	if THSCRS124_val == THSCSP1_val:
		df2.at[x,'THSCRS124'] = 'B'
	else:
		if THSCRS124_val == THSCAF28_val:
			df2.at[x,'THSCRS124'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS125_val = df2.at[x,'THSCRS125']
	if THSCRS125_val == THSCSP1_val:
		df2.at[x,'THSCRS125'] = 'B'
	else:
		if THSCRS125_val == THSCAF28_val:
			df2.at[x,'THSCRS125'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS127_val = df2.at[x,'THSCRS127']
	if THSCRS127_val == THSCSP1_val:
		df2.at[x,'THSCRS127'] = 'B'
	else:
		if THSCRS127_val == THSCAF28_val:
			df2.at[x,'THSCRS127'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS128_val = df2.at[x,'THSCRS128']
	if THSCRS128_val == THSCSP1_val:
		df2.at[x,'THSCRS128'] = 'B'
	else:
		if THSCRS128_val == THSCAF28_val:
			df2.at[x,'THSCRS128'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS13_val = df2.at[x,'THSCRS13']
	if THSCRS13_val == THSCSP1_val:
		df2.at[x,'THSCRS13'] = 'B'
	else:
		if THSCRS13_val == THSCAF28_val:
			df2.at[x,'THSCRS13'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS14_val = df2.at[x,'THSCRS14']
	if THSCRS14_val == THSCSP1_val:
		df2.at[x,'THSCRS14'] = 'B'
	else:
		if THSCRS14_val == THSCAF28_val:
			df2.at[x,'THSCRS14'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS16_val = df2.at[x,'THSCRS16']
	if THSCRS16_val == THSCSP1_val:
		df2.at[x,'THSCRS16'] = 'B'
	else:
		if THSCRS16_val == THSCAF28_val:
			df2.at[x,'THSCRS16'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS17_val = df2.at[x,'THSCRS17']
	if THSCRS17_val == THSCSP1_val:
		df2.at[x,'THSCRS17'] = 'B'
	else:
		if THSCRS17_val == THSCAF28_val:
			df2.at[x,'THSCRS17'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS2_val = df2.at[x,'THSCRS2']
	if THSCRS2_val == THSCSP1_val:
		df2.at[x,'THSCRS2'] = 'B'
	else:
		if THSCRS2_val == THSCAF28_val:
			df2.at[x,'THSCRS2'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS21_val = df2.at[x,'THSCRS21']
	if THSCRS21_val == THSCSP1_val:
		df2.at[x,'THSCRS21'] = 'B'
	else:
		if THSCRS21_val == THSCAF28_val:
			df2.at[x,'THSCRS21'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS229_val = df2.at[x,'THSCRS229']
	if THSCRS229_val == THSCSP1_val:
		df2.at[x,'THSCRS229'] = 'B'
	else:
		if THSCRS229_val == THSCAF28_val:
			df2.at[x,'THSCRS229'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS29_val = df2.at[x,'THSCRS29']
	if THSCRS29_val == THSCSP1_val:
		df2.at[x,'THSCRS29'] = 'B'
	else:
		if THSCRS29_val == THSCAF28_val:
			df2.at[x,'THSCRS29'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS3_val = df2.at[x,'THSCRS3']
	if THSCRS3_val == THSCSP1_val:
		df2.at[x,'THSCRS3'] = 'B'
	else:
		if THSCRS3_val == THSCAF28_val:
			df2.at[x,'THSCRS3'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS31_val = df2.at[x,'THSCRS31']
	if THSCRS31_val == THSCSP1_val:
		df2.at[x,'THSCRS31'] = 'B'
	else:
		if THSCRS31_val == THSCAF28_val:
			df2.at[x,'THSCRS31'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS33_val = df2.at[x,'THSCRS33']
	if THSCRS33_val == THSCSP1_val:
		df2.at[x,'THSCRS33'] = 'B'
	else:
		if THSCRS33_val == THSCAF28_val:
			df2.at[x,'THSCRS33'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS37_val = df2.at[x,'THSCRS37']
	if THSCRS37_val == THSCSP1_val:
		df2.at[x,'THSCRS37'] = 'B'
	else:
		if THSCRS37_val == THSCAF28_val:
			df2.at[x,'THSCRS37'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS38_val = df2.at[x,'THSCRS38']
	if THSCRS38_val == THSCSP1_val:
		df2.at[x,'THSCRS38'] = 'B'
	else:
		if THSCRS38_val == THSCAF28_val:
			df2.at[x,'THSCRS38'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS40_val = df2.at[x,'THSCRS40']
	if THSCRS40_val == THSCSP1_val:
		df2.at[x,'THSCRS40'] = 'B'
	else:
		if THSCRS40_val == THSCAF28_val:
			df2.at[x,'THSCRS40'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS41_val = df2.at[x,'THSCRS41']
	if THSCRS41_val == THSCSP1_val:
		df2.at[x,'THSCRS41'] = 'B'
	else:
		if THSCRS41_val == THSCAF28_val:
			df2.at[x,'THSCRS41'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS42_val = df2.at[x,'THSCRS42']
	if THSCRS42_val == THSCSP1_val:
		df2.at[x,'THSCRS42'] = 'B'
	else:
		if THSCRS42_val == THSCAF28_val:
			df2.at[x,'THSCRS42'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS43_val = df2.at[x,'THSCRS43']
	if THSCRS43_val == THSCSP1_val:
		df2.at[x,'THSCRS43'] = 'B'
	else:
		if THSCRS43_val == THSCAF28_val:
			df2.at[x,'THSCRS43'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS44_val = df2.at[x,'THSCRS44']
	if THSCRS44_val == THSCSP1_val:
		df2.at[x,'THSCRS44'] = 'B'
	else:
		if THSCRS44_val == THSCAF28_val:
			df2.at[x,'THSCRS44'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS48_val = df2.at[x,'THSCRS48']
	if THSCRS48_val == THSCSP1_val:
		df2.at[x,'THSCRS48'] = 'B'
	else:
		if THSCRS48_val == THSCAF28_val:
			df2.at[x,'THSCRS48'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS49_val = df2.at[x,'THSCRS49']
	if THSCRS49_val == THSCSP1_val:
		df2.at[x,'THSCRS49'] = 'B'
	else:
		if THSCRS49_val == THSCAF28_val:
			df2.at[x,'THSCRS49'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS58_val = df2.at[x,'THSCRS58']
	if THSCRS58_val == THSCSP1_val:
		df2.at[x,'THSCRS58'] = 'B'
	else:
		if THSCRS58_val == THSCAF28_val:
			df2.at[x,'THSCRS58'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS59_val = df2.at[x,'THSCRS59']
	if THSCRS59_val == THSCSP1_val:
		df2.at[x,'THSCRS59'] = 'B'
	else:
		if THSCRS59_val == THSCAF28_val:
			df2.at[x,'THSCRS59'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS60_val = df2.at[x,'THSCRS60']
	if THSCRS60_val == THSCSP1_val:
		df2.at[x,'THSCRS60'] = 'B'
	else:
		if THSCRS60_val == THSCAF28_val:
			df2.at[x,'THSCRS60'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS70_val = df2.at[x,'THSCRS70']
	if THSCRS70_val == THSCSP1_val:
		df2.at[x,'THSCRS70'] = 'B'
	else:
		if THSCRS70_val == THSCAF28_val:
			df2.at[x,'THSCRS70'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS736_val = df2.at[x,'THSCRS736']
	if THSCRS736_val == THSCSP1_val:
		df2.at[x,'THSCRS736'] = 'B'
	else:
		if THSCRS736_val == THSCAF28_val:
			df2.at[x,'THSCRS736'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS77_val = df2.at[x,'THSCRS77']
	if THSCRS77_val == THSCSP1_val:
		df2.at[x,'THSCRS77'] = 'B'
	else:
		if THSCRS77_val == THSCAF28_val:
			df2.at[x,'THSCRS77'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS78_val = df2.at[x,'THSCRS78']
	if THSCRS78_val == THSCSP1_val:
		df2.at[x,'THSCRS78'] = 'B'
	else:
		if THSCRS78_val == THSCAF28_val:
			df2.at[x,'THSCRS78'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS79_val = df2.at[x,'THSCRS79']
	if THSCRS79_val == THSCSP1_val:
		df2.at[x,'THSCRS79'] = 'B'
	else:
		if THSCRS79_val == THSCAF28_val:
			df2.at[x,'THSCRS79'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS80_val = df2.at[x,'THSCRS80']
	if THSCRS80_val == THSCSP1_val:
		df2.at[x,'THSCRS80'] = 'B'
	else:
		if THSCRS80_val == THSCAF28_val:
			df2.at[x,'THSCRS80'] = 'A'	

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS85_val = df2.at[x,'THSCRS85']
	if THSCRS85_val == THSCSP1_val:
		df2.at[x,'THSCRS85'] = 'B'
	else:
		if THSCRS85_val == THSCAF28_val:
			df2.at[x,'THSCRS85'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS82_val = df2.at[x,'THSCRS82']
	if THSCRS82_val == THSCSP1_val:
		df2.at[x,'THSCRS82'] = 'B'
	else:
		if THSCRS82_val == THSCAF28_val:
			df2.at[x,'THSCRS82'] = 'A'

for x, row in df2.iterrows():
	THSCAF28_val = df2.at[x,'THSCAF28']
	THSCSP1_val = df2.at[x, 'THSCSP1']
	THSCRS81_val = df2.at[x,'THSCRS81']
	if THSCRS81_val == THSCSP1_val:
		df2.at[x,'THSCRS81'] = 'B'
	else:
		if THSCRS81_val == THSCAF28_val:
			df2.at[x,'THSCRS81'] = 'A'

#convert the two parents to A and B format
for x, row in df2.iterrows():
	df2.at[x,'THSCAF28'] = 'A'
	df2.at[x, 'THSCSP1'] = 'B'

df2.to_csv("/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.txt", sep='\t') #export from python back to a file
```
Remove SNPs with missing data, or where a parent has been misscalled
```bash
#remove snps with missing data:
grep -vw 'N' /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.txt > /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.txt

#remove false snps with misscalled parents:
#Edited headers of blank columns so that header row contained 3 As and 3 Bs and every row contained As and Bs
sed -i 's@assembly#@A@g;s@center@B@g;s@protLSID@A@g;s@assayLSID@B@g;s@panelLSID@A@g;s@QCcode@B@g' /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.txt
#run python to use pandas dataframes to manipulate data
python3
import pandas as pd
import os
df = pd.read_csv("/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.txt",sep='\t') #read in data to dataframe
df2 = df.T #transpose data so that columns becomme rows and rows become columns
#remove snps were only one of the parents shows the snp, ie. a misscall for a parent
for column in df2:
    B_count = df2[column].value_counts()['B'] #will fail if there are any columns not containing the searched for string
    A_count = df2[column].value_counts()['A'] #will fail if there are any columns not containing the searched for string
    if B_count < 3:
    	del df2[column]

for column in df2:
    B_count = df2[column].value_counts()['B'] #will fail if there are any columns not containing the searched for string
    A_count = df2[column].value_counts()['A'] #will fail if there are any columns not containing the searched for string
    if A_count < 3:
    	del df2[column]

df3 = df2.T #transpose data back to original orientation

df3.to_csv("/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.3.txt", sep='\t') #export from python back to a file
exit()
```
Following this /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/ascii4.6.3.txt was downloaded and input to joinmap5. Having removed erronious snps and any snps containing missing data the number of loci was reduced from 52,670 t0 46,727. Using exclude similar loci (Exclude the 2nd locus in pairs with similarity larger than/equal to:1) reduced this to 861 unique loci that were mapped to 11 groups at LOD=3.4. Joinmap4.1 and 5 were used to map groups. As we have positional information about wich reference assembly contigs snps were called against and where in these contigs it was clear that many were placed in an incorrect order by joinmap4.1, therefore joinmap5 linkage data was used. As we do not have a joinmap5 license groups had to be mapped two at a time and the results copied to exel manually.

```R
setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/SNP calling")
install.packages("tidyverse")
library(tidyverse)
install.packages("drc")
library(drc)
library("readxl")
install.packages("writexl")
library("writexl")
#read in data:
data <- read_excel("Laura scab.xlsx")
head(data)

#Extract parent data and plot:
AF28 <- data[data$Isolate=="AF28", c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
Spartan <-  data[data$Isolate=="Spartan 1", c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
AF28model<- drm(growtharea~Concentration, data=AF28, Isolate, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartanmodel<- drm(growtharea~Concentration, data=Spartan, Isolate, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
par(mfrow = c(1, 2)) #create a 1 x 2 plotting matrix
plot(AF28model, type="all", main="AF28")
plot(Spartanmodel, type="all", main="Spartan 1")
summary(AF28model)
summary(Spartanmodel)

#Find best model for parents:
mselect(AF28model, fctList = list(W1.3(),W1.4(), W2.3(), W2.4(), LL.2(), LL.3(), LL.4()),linreg=TRUE) 
mselect(Spartanmodel, fctList = list(W1.3(),W1.4(), W2.3(), W2.4(), LL.2(), LL.3(), LL.4()),linreg=TRUE)

AF28.W23 <-  drm(growtharea~Concentration, data=AF28, fct=W2.3(names = c("Slope", "Upper Limit",  "ED50")))
AF28.W24 <-  drm(growtharea~Concentration, data=AF28, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
AF28.W14 <-  drm(growtharea~Concentration, data=AF28, fct=W1.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
AF28.LL4 <-  drm(growtharea~Concentration, data=AF28, fct=LL.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(AF28.W23, xlab="Concentration", ylab="Growth area", type='all',lty=1, lwd=2, main="AF28")
plot(AF28.W24, add=TRUE,col="orange",lty=1, lwd=2)
plot(AF28.LL4, add=TRUE,col="blue",lty=2, lwd=2)
plot(AF28.W14, add=TRUE,col="forestgreen",lty=2, lwd=2)

Spartan.LL2 <-  drm(growtharea~Concentration, data=Spartan, fct=LL.2(upper = 700, fixed=c(NA, NA), names = c("Slope",  "ED50")))
Spartan.W23 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.3(fixed=c(NA, NA, NA),names = c("Slope", "Upper Limit",  "ED50")))
Spartan.W24 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.4(fixed=c(NA, 0, NA, NA),names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartan.LL4 <-  drm(growtharea~Concentration, data=Spartan, fct=LL.4(fixed=c(NA, 0, NA, NA),names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartan.W14 <-  drm(growtharea~Concentration, data=Spartan, fct=W1.4(fixed=c(NA, 0, NA, NA),names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(Spartan.W23, xlab="Concentration", ylab="Growth area", type='all',lty=1, lwd=2, main="Spartan")
plot(Spartan.W24, add=TRUE,col="orange",lty=1, lwd=2)
plot(Spartan.LL4, add=TRUE,col="blue",lty=2, lwd=2)
plot(Spartan.W14, add=TRUE,col="forestgreen",lty=2, lwd=2)

maED(AF28.W23, 
     list(W1.3(),W1.4(), W2.4(), LL.2(), LL.3(), LL.4()), c(50),
     interval="kang")
maED(Spartan.W23, 
     list(W1.3(),W1.4(), W2.4(), LL.2(), LL.3(), LL.4()), c(50),
     interval="kang")

#Fixed vs. unfixed
Spartan.W24 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartan.W24.2 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.4(fixed=c(NA, 0, NA, NA),names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(Spartan.W24, xlab="Concentration", ylab="Growth area", type='all',lty=1, lwd=2, main="Spartan")
plot(Spartan.W24.2, add=TRUE,col="orange",lty=1, lwd=2)

#Calculate EC50s for all isolates:
model<- drm(growtharea~Concentration, data=data, Isolate, fct=W2.3(names = c("Slope", "Upper Limit", "ED50")))

#create artificial datapoints with no growth at very high concentration fungicide
Isolates <- unique(data$Isolate)
Concentration <- list(40)
Plate <- list(0)
Replicate <- list(1)
Diameter1 <- list(2)
Diameter2 <- list(2)
growtharea <- list(0)
artificial_data1 <- data.frame(Isolates, Concentration, Plate, Replicate, Diameter1, Diameter2, growtharea)
colnames(artificial_data1) <-c("Isolates","Concentration","Plate","Replicate","Diameter1","Diameter2","growtharea")
Replicate <- list(2)
artificial_data2 <- data.frame(Isolates, Concentration, Plate, Replicate, Diameter1, Diameter2, growtharea)
colnames(artificial_data2) <- colnames(artificial_data1)
Replicate <- list(3)
artificial_data3 <- data.frame(Isolates, Concentration, Plate, Replicate, Diameter1, Diameter2, growtharea)
colnames(artificial_data3) <- colnames(artificial_data1)
Replicate <- list(4)
artificial_data4 <- data.frame(Isolates, Concentration, Plate, Replicate, Diameter1, Diameter2, growtharea)
colnames(artificial_data4) <- colnames(artificial_data1)
artificial_data <- rbind(artificial_data1, artificial_data2, artificial_data3, artificial_data4)
colnames(artificial_data) <- colnames(data)
data_artificial <- rbind(artificial_data, data)
#Extract parent data and plot:
AF28 <- data_artificial[data_artificial$Isolate=="AF28", c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
Spartan <-  data_artificial[data_artificial$Isolate=="Spartan 1", c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
AF28model<- drm(growtharea~Concentration, data=AF28, Isolate, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartanmodel<- drm(growtharea~Concentration, data=Spartan, Isolate, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(AF28model, type="all", main="AF28")
plot(Spartanmodel, type="all", main="Spartan 1")
summary(AF28model)
summary(Spartanmodel)

#Find best model for parents:
mselect(AF28model, fctList = list(W1.3(),W1.4(), W2.3(), W2.4(), LL.2(), LL.3(), LL.4()),linreg=TRUE) 
mselect(Spartanmodel, fctList = list(W1.3(),W1.4(), W2.3(), W2.4(), LL.2(), LL.3(), LL.4()),linreg=TRUE)

AF28.W23 <-  drm(growtharea~Concentration, data=AF28, fct=W2.3(names = c("Slope", "Upper Limit",  "ED50")))
AF28.W24 <-  drm(growtharea~Concentration, data=AF28, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
AF28.W14 <-  drm(growtharea~Concentration, data=AF28, fct=W1.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
AF28.LL4 <-  drm(growtharea~Concentration, data=AF28, fct=LL.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(AF28.W23, xlab="Concentration", ylab="Growth area", type='all',lty=1, lwd=2, main="AF28")
plot(AF28.W24, add=TRUE,col="orange",lty=1, lwd=2)
plot(AF28.LL4, add=TRUE,col="blue",lty=2, lwd=2)
plot(AF28.W14, add=TRUE,col="forestgreen",lty=2, lwd=2)

Spartan.W23 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.3(names = c("Slope", "Upper Limit",  "ED50")))
Spartan.W24 <-  drm(growtharea~Concentration, data=Spartan, fct=W2.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartan.LL4 <-  drm(growtharea~Concentration, data=Spartan, fct=LL.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
Spartan.W14 <-  drm(growtharea~Concentration, data=Spartan, fct=W1.4(names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
plot(Spartan.W24, xlab="Concentration", ylab="Growth area", type='all',lty=1, lwd=2, main="Spartan")
plot(Spartan.W23, add=TRUE,col="orange",lty=1, lwd=2)
plot(Spartan.LL4, add=TRUE,col="blue",lty=2, lwd=2)
plot(Spartan.W14, add=TRUE,col="forestgreen",lty=2, lwd=2)

maED(AF28.W23, 
     list(W1.3(),W1.4(), W2.4(), LL.2(), LL.3(), LL.4()), c(50),
     interval="kang")
maED(Spartan.W23, 
     list(W1.3(),W1.4(), W2.4(), LL.2(), LL.3(), LL.4()), c(50),
     interval="kang")

#Changed to %:
pdata <- data %>% 
  mutate(percent_response = growtharea/(mean(data$growtharea[data$Concentration==0]))*100) #converts growth areas to %s where 100% is tne average growth area at zero fungicide concentration. GROWTH RATE WILL VARY BY ISOLATE SO NEED TO DO AVERAGE FOR EACH
pAF28 <- AF28 %>% 
  mutate(percent_response = growtharea/(mean(AF28$growtharea[AF28$Concentration==0]))*100)
pSpartan <- Spartan %>% 
  mutate(percent_response = growtharea/(mean(Spartan$growtharea[Spartan$Concentration==0]))*100)
fAF28<- drm(percent_response~Concentration, data=pAF28, 
                  fct=LL.4(fixed=c(NA, 0, 100, NA),
                           names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))
fSpartan<- drm(percent_response~Concentration, data=pSpartan, 
                  fct=LL.4(fixed=c(NA, 0, 100, NA),
                           names = c("Slope", "Lower Limit", "Upper Limit", "ED50")))

mselect(fAF28, fctList = list(W1.2(upper = 100, fixed=c(NA, NA)),W1.3(fixed=c(NA, NA, NA)),W1.4(fixed=c(NA, NA, NA, NA)),W2.2(upper = 100, fixed=c(NA, NA)), W2.3(fixed=c(NA, NA, NA)), W2.4(fixed=c(NA, NA, NA, NA)),LL.2(upper = 100, fixed=c(NA, NA)), LL.3(fixed=c(NA, NA, NA)), LL.4(fixed=c(NA, NA, NA, NA))),linreg=TRUE) 
mselect(fSpartan, fctList = list(W1.2(upper = 100, fixed=c(NA, NA)),W1.3(fixed=c(NA, NA, NA)),W1.4(fixed=c(NA, NA, NA, NA)),W2.2(upper = 100, fixed=c(NA, NA)), W2.3(fixed=c(NA, NA, NA)), W2.4(fixed=c(NA, NA, NA, NA)),LL.2(upper = 100, fixed=c(NA, NA)), LL.3(fixed=c(NA, NA, NA)), LL.4(fixed=c(NA, NA, NA, NA))),linreg=TRUE) 

AF28.LL2 <-  drm(percent_response~Concentration, data=pAF28, fct=LL.2(upper = 100, fixed=c(NA, NA)))
AF28.LL3 <-  drm(percent_response~Concentration, data=pAF28, fct=LL.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))
AF28.W12 <-  drm(percent_response~Concentration, data=pAF28, fct=W1.2(upper = 100, fixed=c(NA, NA)))
AF28.W13 <-  drm(percent_response~Concentration, data=pAF28, fct=W1.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))
AF28.W22 <-  drm(percent_response~Concentration, data=pAF28, fct=W2.2(upper = 100, fixed=c(NA, NA)))
AF28.W23 <-  drm(percent_response~Concentration, data=pAF28, fct=W2.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))

plot(AF28.LL2, xlab="Concentration", ylab="Percent Response", type='all',lty=1, lwd=2, main="AF28")
plot(AF28.LL3, add=TRUE,col="orange",lty=1, lwd=2)
plot(AF28.W12, add=TRUE,col="blue",lty=2, lwd=2)
plot(AF28.W13, add=TRUE,col="forestgreen",lty=2, lwd=2)
plot(AF28.W22, add=TRUE,col="purple",lty=2, lwd=2)
plot(AF28.W23, add=TRUE,col="red",lty=2, lwd=2)

Spartan.LL2 <-  drm(percent_response~Concentration, data=pSpartan, fct=LL.2(upper = 100, fixed=c(NA, NA)))
Spartan.LL3 <-  drm(percent_response~Concentration, data=pSpartan, fct=LL.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))
Spartan.W12 <-  drm(percent_response~Concentration, data=pSpartan, fct=W1.2(upper = 100, fixed=c(NA, NA)))
Spartan.W13 <-  drm(percent_response~Concentration, data=pSpartan, fct=W1.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))
Spartan.W22 <-  drm(percent_response~Concentration, data=pSpartan, fct=W2.2(upper = 100, fixed=c(NA, NA)))
Spartan.W23 <-  drm(percent_response~Concentration, data=pSpartan, fct=W2.3(fixed=c(NA, NA, NA), names = c("Slope", "Upper Limit",  "ED50")))

plot(Spartan.LL2, xlab="Concentration", ylab="Percent Response", type='all',lty=1, lwd=2, main="AF28")
plot(Spartan.LL3, add=TRUE,col="orange",lty=1, lwd=2)
plot(Spartan.W12, add=TRUE,col="blue",lty=2, lwd=2)
plot(Spartan.W13, add=TRUE,col="forestgreen",lty=2, lwd=2)
plot(Spartan.W22, add=TRUE,col="purple",lty=2, lwd=2)
plot(Spartan.W23, add=TRUE,col="red",lty=2, lwd=2)

maED(AF28.W23, 
     list(W1.2(upper = 100, fixed=c(NA, NA)),W1.3(fixed=c(NA, NA, NA)),W1.4(fixed=c(NA, NA, NA, NA)),W2.2(upper = 100, fixed=c(NA, NA)), W2.3(fixed=c(NA, NA, NA)), W2.4(fixed=c(NA, NA, NA, NA)),LL.2(upper = 100, fixed=c(NA, NA)), LL.3(fixed=c(NA, NA, NA)), LL.4(fixed=c(NA, NA, NA, NA))), c(50),
     interval="kang")
maED(Spartan.W23, 
     list(W1.2(upper = 100, fixed=c(NA, NA)),W1.3(fixed=c(NA, NA, NA)),W1.4(fixed=c(NA, NA, NA, NA)),W2.2(upper = 100, fixed=c(NA, NA)), W2.3(fixed=c(NA, NA, NA)), W2.4(fixed=c(NA, NA, NA, NA)),LL.2(upper = 100, fixed=c(NA, NA)), LL.3(fixed=c(NA, NA, NA)), LL.4(fixed=c(NA, NA, NA, NA))), c(50),
     interval="kang")

#Calculate EC50s for all isolates:
Isolates <- unique(data$Isolate)

outputED50 <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(outputED50) <- c("Estimate", "Std. Error", "Lower", "Upper")

for (x in Isolates)
{df <- data[data$Isolate==x, c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
pdf <- df %>% 
  mutate(percent_response = growtharea/(mean(df$growtharea[df$Concentration==0]))*100)
model <- drm(percent_response~Concentration, data=pdf, Isolate, fct=W2.2(upper = 100, fixed=c(NA, NA)))
output <- ED(model, c(50), interval="delta")
colnames(output) <- colnames(outputED50)
outputED50 <- rbind(output, outputED50)
}
outputED50$Isolate <- rownames(outputED50)
outputED50 <- outputED50[, c(5,1,2,3,4)]
write_xlsx(outputED50,"outputED50.xlsx")


outputED50_3 <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(outputED50_3) <- c("EstimateED50", "Std. Error", "Lower", "Upper")
Isolates <- unique(data$Isolate)
for (x in Isolates)
{df <- data[data$Isolate==x, c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
model <- drm(growtharea~Concentration, data=df, Isolate, fct=W2.3(fixed=c(NA, NA, NA)))
output <- ED(model, c(50), interval="delta")
colnames(output) <- colnames(outputED50_3)
outputED50_3 <- rbind(output, outputED50_3)
}
outputED50_3$Isolate <- rownames(outputED50_3)
outputED50_3 <- outputED50_3[, c(5,1,2,3,4)]
write_xlsx(outputED50_3,"outputED50_3.xlsx")

#ED10:
outputED10_3 <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(outputED10_3) <- c("EstimateED10", "Std. Error", "Lower", "Upper")
Isolates <- unique(data$Isolate)
for (x in Isolates)
{df <- data[data$Isolate==x, c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
model <- drm(growtharea~Concentration, data=df, Isolate, fct=W2.3(fixed=c(NA, NA, NA)))
output <- ED(model, c(10), interval="delta")
colnames(output) <- colnames(outputED10_3)
outputED10_3 <- rbind(output, outputED10_3)
}
outputED10_3$Isolate <- rownames(outputED10_3)
outputED10_3 <- outputED10_3[, c(5,1,2,3,4)]
write_xlsx(outputED10_3,"outputED10_3.xlsx")

#ED90:
outputED90_3 <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(outputED90_3) <- c("EstimateED90", "Std. Error", "Lower", "Upper")
Isolates <- unique(data$Isolate)
for (x in Isolates)
{df <- data[data$Isolate==x, c("Isolate", "Concentration", "Plate", "Replicate", "Diameter1", "Diameter2", "growtharea")]
model <- drm(growtharea~Concentration, data=df, Isolate, fct=W2.3(fixed=c(NA, NA, NA)))
output <- ED(model, c(90), interval="delta")
colnames(output) <- colnames(outputED90_3)
outputED90_3 <- rbind(output, outputED90_3)
}
outputED90_3$Isolate <- rownames(outputED90_3)
outputED90_3 <- outputED90_3[, c(5,1,2,3,4)]
write_xlsx(outputED90_3,"outputED90_3.xlsx")
```
Cumulative frequency plots:
```R
setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/SNP calling")
install.packages("tidyverse")
library(tidyverse)
install.packages("drc")
library(drc)

library(ggplot2)
library("readxl")
install.packages("writexl")
library("writexl")
#read in data:
data <- read_excel("outputED10_3.xlsx")
str(data)
parents<-subset(data, Isolate=='e:RS24:10' | Isolate=='e:Spartan 1:10')

require(gridExtra)
plot1<-ggplot(data, aes(x=EstimateED10_log, y=ED10_order))+geom_point()+labs(y="Cumulative Frequency",  x=expression(lnED[10])) + geom_point(data=parents, aes(x=EstimateED10_log, y=ED10_order), colour="red", size=3)
plot2<-ggplot(data, aes(x=EstimateED50_log, y=ED50_order))+geom_point()+labs(y="Cumulative Frequency",  x=expression(lnED[50])) + geom_point(data=parents, aes(x=EstimateED50_log, y=ED50_order), colour="red", size=3)
plot3<-ggplot(data, aes(x=EstimateED90_log, y=ED90_order))+geom_point()+labs(y="Cumulative Frequency",  x=expression(lnED[90])) + geom_point(data=parents, aes(x=EstimateED90_log, y=ED90_order), colour="red", size=3)
grid.arrange(plot1, plot2, plot3, nrow=2, ncol=2)

```
Check for normal distribution of ED50 against Isolates;
```R
setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/SNP calling")
install.packages("dplyr")
install.packages("ggpubr")
library("dplyr")
library("ggpubr")
library("readxl")

#read in data:
outputED50_3 <- read_excel("outputED50_3.xlsx")


barplot(height = outputED50_3$Estimate, names = outputED50_3$Isolate, main = "ED50 of different isolates", ylab = "ED50 (mg/L)", xlab = "Isolate", las=2, cex.names=0.6)
install.packages("dplyr")
install.packages("ggpubr")
library("dplyr")
library("ggpubr")
#rIf the sample size is large enough (n > 30), we can ignore the distribution of the data and use parametric tests. However, to be consistent, normality can be checked by visual inspection [normal plots (histogram), Q-Q plot (quantile-quantile plot)] or by significance tests].
#Density plot: the density plot provides a visual judgment about whether the distribution is bell shaped.
ggdensity(outputED50_3$Estimate, 
          main = "Density plot of ED50",
          xlab = "ED50") #Density plot: the density plot provides a visual judgment about whether the distribution is bell shaped.
#The R function shapiro.test() can be used to perform the Shapiro-Wilk test of normality for one variable (univariate):
shapiro.test(outputED50_3$EstimateED50)
#   W = 0.69881, p-value = 6.497e-12
# From the output, the p-value <0.05 implying that the distribution of the data are significantly different from normal distribution.

#check for ED10 and ED90
outputED10_3 <- read_excel("outputED10_3.xlsx")
outputED90_3 <- read_excel("outputED90_3.xlsx")
shapiro.test(outputED10_3$EstimateED10) #no normal distribution
shapiro.test(outputED90_3$EstimateED90) #not normal distribution
```
Kruskall wallis:

Kruskal-Wallis test by rank is a non-parametric alternative to one-way ANOVA test, which extends the two-samples Wilcoxon test in the situation where there are more than two groups. It’s recommended when the assumptions of one-way ANOVA test are not met (not normal distribution).

```R
setwd("C:/Users/lapto/Downloads")
install.packages("data.table")
install.packages("dplyr")
library(data.table)
library(dplyr)
install.packages("readxl")
library(readxl)

#For ED50:
genopheno <- read_excel("outputED50_3.xlsx")
genopheno[,3:863]<-lapply(genopheno[,3:863], factor)#convert marker data to factors
genopheno<-as.data.table(genopheno)
good.columns <- names(genopheno)[sapply(genopheno, nlevels) > 1] #if marker has only one level it gets filtered out as kruskal doesnt like it, in fact we have already filtered for snps with no difference between our isolates so this has no effect on our data
filtered.df <- genopheno %>% select(good.columns) #%>% is a pipe like |, converting back to dataframe?
filtered.df2 <-as.data.frame(cbind(genopheno[,c(1:2)],filtered.df))
filtered.df2[,c(1,2)]<-sapply(filtered.df2[,c(1,2)], as.numeric)# for kruskal testing variables have to be numeric
p.values<-as.vector(NA) #create an empty table for the p values as vectors. if its numeric p 
kk<-as.data.frame(NA) # create empty data frame with four columns and as many rows as many markers
kk[1:861,1:2]<-NA
kk[,1]<-colnames(filtered.df2[,3:863])
for (k in 1){ for (i in 3:863){
  test<-kruskal.test(filtered.df2[,1] ~ filtered.df2[,i], data = filtered.df2)
  Current.p.value <- test$p.value # Extract the p-value from the test
  p.values[i-2] <- Current.p.value}
  kk[,2]<-p.values 
  }# Add the p-value to the p.values vector
colnames(kk)[1]<-"snp:"
colnames(kk)[2]<-"ED50 pvalues:"
write.csv(kk,"kruskal_pvalues2022.csv")

testing<-as.data.frame(NA)
testing[1:861,1:2]<-NA
rownames(testing)<-rownames(kk)
colnames(testing)<-colnames(kk)
colnames(testing)[2]<-"ED50 pvaluesFDRcorrected:"
testing[,1]<-kk[,1]
for (i in 2){
  test<-p.adjust(kk[,i], method="fdr") #false discovery rate correction
  testing[,i]<-test}
write.csv(testing,"kruskal.test_pvaluesFDRcorrected2022test.csv")


#For ED10:
genopheno <- read_excel("outputED10_3.xlsx")
genopheno[,3:863]<-lapply(genopheno[,3:863], factor)#convert marker data to factors
genopheno<-as.data.table(genopheno)
good.columns <- names(genopheno)[sapply(genopheno, nlevels) > 1] #if marker has only one level it gets filtered out as kruskal doesnt like it, in fact we have already filtered for snps with no difference between our isolates so this has no effect on our data
filtered.df <- genopheno %>% select(good.columns) #%>% is a pipe like |, converting back to dataframe?
filtered.df2 <-as.data.frame(cbind(genopheno[,c(1:2)],filtered.df))
filtered.df2[,c(1,2)]<-sapply(filtered.df2[,c(1,2)], as.numeric)# for kruskal testing variables have to be numeric
p.values<-as.vector(NA) #create an empty table for the p values as vectors. if its numeric p 
kk10<-as.data.frame(NA) # create empty data frame with four columns and as many rows as many markers
kk10[1:861,1:2]<-NA
kk10[,1]<-colnames(filtered.df2[,3:863])
for (k in 1){ for (i in 3:863){
  test<-kruskal.test(filtered.df2[,1] ~ filtered.df2[,i], data = filtered.df2)
  Current.p.value <- test$p.value # Extract the p-value from the test
  p.values[i-2] <- Current.p.value}
  kk10[,2]<-p.values 
  }# Add the p-value to the p.values vector
colnames(kk10)[1]<-"snp:"
colnames(kk10)[2]<-"ED10_pvalues:"
write.csv(kk10,"kruskal_pvalues2022_ED10.csv")

testing<-as.data.frame(NA)
testing[1:861,1:2]<-NA
rownames(testing)<-rownames(kk10)
colnames(testing)<-colnames(kk10)
colnames(testing)[2]<-"ED10_pvaluesFDRcorrected:"
testing[,1]<-kk10[,1]
for (i in 2){
  test<-p.adjust(kk10[,i], method="fdr") #false discovery rate correction
  testing[,i]<-test}
write.csv(testing,"kruskal.test_pvaluesFDRcorrected2022test_ED10.csv")

#For ED90:
genopheno <- read_excel("outputED90_3.xlsx")
genopheno[,3:863]<-lapply(genopheno[,3:863], factor)#convert marker data to factors
genopheno<-as.data.table(genopheno)
good.columns <- names(genopheno)[sapply(genopheno, nlevels) > 1] #if marker has only one level it gets filtered out as kruskal doesnt like it, in fact we have already filtered for snps with no difference between our isolates so this has no effect on our data
filtered.df <- genopheno %>% select(good.columns) #%>% is a pipe like |, converting back to dataframe?
filtered.df2 <-as.data.frame(cbind(genopheno[,c(1:2)],filtered.df))
filtered.df2[,c(1,2)]<-sapply(filtered.df2[,c(1,2)], as.numeric)# for kruskal testing variables have to be numeric
p.values<-as.vector(NA) #create an empty table for the p values as vectors. if its numeric p 
kk90<-as.data.frame(NA) # create empty data frame with four columns and as many rows as many markers
kk90[1:861,1:2]<-NA
kk90[,1]<-colnames(filtered.df2[,3:863])
for (k in 1){ for (i in 3:863){
  test<-kruskal.test(filtered.df2[,1] ~ filtered.df2[,i], data = filtered.df2)
  Current.p.value <- test$p.value # Extract the p-value from the test
  p.values[i-2] <- Current.p.value}
  kk90[,2]<-p.values 
  }# Add the p-value to the p.values vector
colnames(kk90)[1]<-"snp:"
colnames(kk90)[2]<-"ED90_pvalues:"
write.csv(kk90,"kruskal_pvalues2022_ED90.csv")

testing<-as.data.frame(NA)
testing[1:861,1:2]<-NA
rownames(testing)<-rownames(kk90)
colnames(testing)<-colnames(kk90)
colnames(testing)[2]<-"ED90_pvaluesFDRcorrected:"
testing[,1]<-kk90[,1]
for (i in 2){
  test<-p.adjust(kk90[,i], method="fdr") #false discovery rate correction
  testing[,i]<-test}
write.csv(testing,"kruskal.test_pvaluesFDRcorrected2022test_ED90.csv")
```
Manhattam plot:
```R
setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/SNP calling")

install.packages("qqman")
library(dplyr)
library(qqman)
library(ggplot2)
library(ggpubr)
install.packages("readxl")
library(readxl)

man <- read_excel("EDvsGeno.xlsx")
str(man)
man$LG <-as.numeric(man$LG)
man$Estimated_positional_spacing <-as.numeric(man$Estimated_positional_spacing)
man <- na.omit(man)

#Uniform spacing
ED10_man_plot <- manhattan(man, chr="LG", bp="No.;", snp="snp1:", p="ED10_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED10", ylim= c(0,2.5) )

ED50_man_plot <- manhattan(man, chr="LG", bp="No.;", snp="snp1:", p="ED50_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED50", ylim= c(0,3.5) )

ED90_man_plot <- manhattan(man, chr="LG", bp="No.;", snp="snp1:", p="ED90_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED90", ylim= c(0,2.5) )

#Estimated positional spacing
ED10_man_plot <- manhattan(man, chr="LG", bp="Estimated_positional_spacing", snp="snp1:", p="ED10_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED10", ylim= c(0,2.5), xlab="Linkage group" )

ED50_man_plot <- manhattan(man, chr="LG", bp="Estimated_positional_spacing", snp="snp1:", p="ED50_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED50", ylim= c(0,3.5), xlab="Linkage group" )

ED90_man_plot <- manhattan(man, chr="LG", bp="Estimated_positional_spacing", snp="snp1:", p="ED90_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                    annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "ED90", ylim= c(0,2.5), xlab="Linkage group" )

#Linkage groups 3 and 7
ED10_man_plot <- manhattan(subset(man, LG==3), chr="LG", bp="Estimated_positional_spacing", snp="snp1:", p="ED10_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                           annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "Linkage group 3 ED10", xlim=c(32130008,37747052), ylim= c(0,2.5), xlab="", xaxt='n' )
Axis(side=1, labels=FALSE)
ED10_man_plot <- manhattan(subset(man, LG==7), chr="LG", bp="Estimated_positional_spacing", snp="snp1:", p="ED10_pvaluesFDRcorrected:",genomewideline = -log10(0.05),suggestiveline = FALSE,
                           annotateTop=TRUE, col = c("#cc1f56", "darkblue"),annotatePval=0.05, main = "Linkage group 7 ED10", xlim=c(49203000,52550000), ylim= c(0,2.5), xlab="", xaxt='n' )
Axis(side=1, labels=FALSE)
```





























































Annotate filtered VCF file for SNP effects (snpeff)

Construct database for annotation:
```bash
conda activate snpeff
scp -r /projects/oldhome/sobczm/bin/snpEff/snpEff.jar theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.
scp -r /projects/oldhome/sobczm/bin/snpEff/snpEff.config theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.
nano /home/theaven/scratch/apps/snp/snpEff.config

# Add the following lines to the section with databases:

##---
## EMR Databases
##----
## V. inaequalis passey genome
##GCA_003351075.1_ASM335107v1.genome: passey_scab

#download gene models:
wget -P /home/theaven/scratch/data/assembly/genome/venturia/inaequalis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/351/075/GCA_003351075.1_ASM335107v1/GCA_003351075.1_ASM335107v1_genomic.gtf.gz 
gunzip -c /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.gtf.gz > /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.gtf

Reference=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna
gtf=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.gtf
SnpEff=/home/theaven/scratch/apps/snp
protein=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_protein.faa
genbank=/home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.gbff
mkdir -p $SnpEff/data/GCA_003351075.1_ASM335107v1
cp $Reference $SnpEff/data/GCA_003351075.1_ASM335107v1/sequences.fa
cp $gtf $SnpEff/data/GCA_003351075.1_ASM335107v1/genes.gtf
##Build database using GFF3 annotation
cd $SnpEff
java -jar $SnpEff/snpEff.jar build -gtf22 -v GCA_003351075.1_ASM335107v1 2>log.txt
cd ~/scratch
```
Annotate VCF files
```bash
for vcf in $(ls snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/LLimon_SNPs_gatk_filtered_snps.vcf); do  
    filename=$(basename $vcf)
    Prefix=${filename%.vcf}
    OutDir=/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/joint
    mkdir $OutDir
    SnpEff=/home/theaven/scratch/apps/snp
    java -Xmx4g -jar $SnpEff/snpEff.jar -v -ud 0 GCA_003351075.1_ASM335107v1 $vcf > $OutDir/"$Prefix"_annotated.vcf
    mv snpEff_genes.txt $OutDir/snpEff_genes_"$Prefix".txt
    mv snpEff_summary.html $OutDir/snpEff_summary_"$Prefix".html
done
```
Create subsamples of SNPs containing those in a given category

```bash 
scp -r /projects/oldhome/sobczm/bin/snpEff/SnpSift.jar theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.
cd /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/joint
SnpEff=/home/theaven/scratch/apps/snp
#genic (includes 5', 3' UTRs)
java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has 'missense_variant') || (ANN[*].EFFECT has 'nonsense_variant') || (ANN[*].EFFECT has 'synonymous_variant') || (ANN[*].EFFECT has 'intron_variant') || (ANN[*].EFFECT has '5_prime_UTR_variant') || (ANN[*].EFFECT has '3_prime_UTR_variant')" LLimon_SNPs_gatk_filtered_snps_annotated.vcf > LLimon_SNPs_gatk_filtered_snps_genic.vcf
#coding
java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant') || (ANN[0].EFFECT has 'synonymous_variant')" LLimon_SNPs_gatk_filtered_snps_annotated.vcf > LLimon_SNPs_gatk_filtered_snps_coding.vcf
#non-synonymous
java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant')" LLimon_SNPs_gatk_filtered_snps_annotated.vcf > LLimon_SNPs_gatk_filtered_snps_nonsyn.vcf
#synonymous
java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'synonymous_variant')" LLimon_SNPs_gatk_filtered_snps_annotated.vcf > LLimon_SNPs_gatk_filtered_snps_syn.vcf
#Four-fold degenrate sites (output file suffix: 4fd)
```
Parse SnpEff annotated VCF file with only synonymous variants (produced by SnpSift) to retrieve only four-fold degenerate synonymous (silent) variants
```bash 
scp -r /projects/oldhome/sobczm/bin/popgen/summary_stats/parse_snpeff_synonymous.py theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.
cd /home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/joint
SnpEff=/home/theaven/scratch/apps/snp
Indir=/home/theaven/scratch/snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls/joint
python $SnpEff/parse_snpeff_synonymous.py $Indir/LLimon_SNPs_gatk_filtered_snps_syn.vcf


AllSnps=$(cat $Indir/LLimon_SNPs_gatk_filtered_snps_annotated.vcf | grep -v '#' | wc -l) #549,969
GeneSnps=$(cat $Indir/LLimon_SNPs_gatk_filtered_snps_genic.vcf | grep -v '#' | wc -l) #183,038
CdsSnps=$(cat $Indir/LLimon_SNPs_gatk_filtered_snps_coding.vcf | grep -v '#' | wc -l) #153,052
SynSnps=$(cat $Indir/LLimon_SNPs_gatk_filtered_snps_nonsyn.vcf | grep -v '#' | wc -l) #99,510
NonsynSnps=$(cat $Indir/LLimon_SNPs_gatk_filtered_snps_syn.vcf | grep -v '#' | wc -l) #53,542
printf "Comparison\$AllSnps\tGeneSnps\tCdsSnps\tSynSnps\tNonsynSnps\n"
printf "cohort_filtered_snps\t$AllSnps\t$GeneSnps\t$CdsSnps\t$SynSnps\t$NonsynSnps\n"
```
## Onemap
Onemap is a software to do genetic linkage analysis and to build genetic maps in experimental crosses: F2, backcrosses, RILs, and full-sib. Its stable version has been available at CRAN. Its last version was updated on 2013-09-09. However, new functions are being added for a new version. They are still in development and available at a github repository. One of these new functions called “vcf2raw” allows to convert a vcf file to an OneMap raw file.

With the new function vcf2raw it is possible to convert VCF file format to OneMap format for any of these experimental populations. Plus, it will keep the position information of the marker at the genome (if it is available in the VCF) and consider it when building the map.

```bash
#the best program to run R scripts in batch mode is Rscript
# installing Mamba for fasta downloading of packages in conda
conda install mamba -n base -c conda-forge -y
conda update conda -y
conda update --all
# Creating R environment in conda
mamba create -n R -c conda-forge r-base -y
#Activating R environment
conda activate R
mamba install -c conda-forge r-essentials
# Open R and install BiocManager and select a mirror to install the packages from. Use the following 
Screen -S R
R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos='https://cran.ma.imperial.ac.uk/')
BiocManager::install(version = "3.14")

setwd("/home/theaven/scratch/")
install.packages("onemap", repos='https://cran.ma.imperial.ac.uk/')
library("onemap")
```
snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
```R
#install onemap package
setwd("C:/Users/heavt/OneDrive - NIAB/Documents/R/bioinfo")
install.packages("onemap")
library("onemap")
#Instaling RSamtolls package
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.15")
a
BiocManager::install(c("Rsamtools"))
library(Rsamtools)
zipped_vcf <- bgzip("LLimon_SNPs_vcftools_gatk_filtered_snps_passed_diploidized.vcf", "LLimon.vcf.gz") #Compressing
idx <- indexTabix("LLimon.vcf.gz", "vcf") #Indexing

#vcf2raw(input = "LLimon.vcf.gz", output = "LLimon.raw", cross = "outcross", parent1 = "THSCAF28", parent2 = "THSCSP1") #function defunct
onemap_read_vcfR(
  vcf = "LLimon.vcf.gz.tbi",
  vcfR.object = "LLimon.raw",
  cross = c("outcross"),
  parent1 = "THSCAF28",
  parent2 = "THSCSP1",
  f1 = NULL,
  only_biallelic = TRUE,
  output_info_rds = NULL,
  verbose = TRUE
)

wget https://cran.r-project.org/src/contrib/Archive/onemap/onemap_2.1.0.tar.gz

packageurl <- "https://cran.r-project.org/src/contrib/Archive/onemap/onemap_2.1.0.tar.gz"
install.packages(packageurl, repos=NULL, type="source")

mkdir /home/theaven/scratch/apps/snp/vcfhunter
cd /home/theaven/scratch/apps/snp/vcfhunter
git clone https://github.com/SouthGreenPlatform/VcfHunter
```
venny (bioinfogp.cnb.csic.es) makes vennn diagrams for comparing snps in different genomes

home/hajduk/git_repos/scripts/hop_genomics/dart_filtering/dart_filter_batchmap2_2ndround.py

```bash
nano snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf
head -n 1000 snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf > test.vcf
grep -f pattern.txt test2.vcf > test2.txt
cat test2.txt | sed 's@\t0:@@g'

TAB=$'\t' 
cat test2.txt | sed "s/.*/${TAB}&/g" 
cat snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed.vcf | sed "s@${TAB}0:@${TAB}0/0:@g" | sed "s@${TAB}1:@${TAB}1/1:@g" >> snp_calling/venturia/inaequalis/LLimon/gatk/passey_haplotype_calls_model/LLimon_SNPs_vcftools_gatk_filtered_snps_passed_diploidized.vcf
```

















































KLARA pipeline:

## Annotate VCF files
```bash
scp -r /home/hajduk/git_repos/scripts/hop_genomics/dart_filtering/dart_filter_batchmap2_2ndround.py theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.

scp -r /projects/oldhome/armita/git_repos/emr_repos/scripts/popgen/snp/sub_vcf_parser.sh theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/snp/.
```
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
```bash
for x in $(awk '/>/{getline; print}' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fna); do
	wc -l
done

grep -w -A1 'contig_12' /home/theaven/scratch/data/assembly/genome/venturia/inaequalis/GCA_003351075.1_ASM335107v1_genomic.fasta | grep -v 'contig_12' | wc 
```