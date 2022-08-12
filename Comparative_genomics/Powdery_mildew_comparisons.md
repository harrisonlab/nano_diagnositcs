# Powdery mildew comparative genomics pipeline

Documentation of analysis and commands used for comparative genomics work as part of Nano Diagnostics PhD.

Genomes assembled and annotated in nano_diagnostics/P_aphanis, nano_diagnostics/P_leucotricha and nano_diagnostics/B_graminis were used alongside genomes downloaded from NCBI for the following analysis.

All the following commands were executed on the Crop Diversity HPC from the folder /home/theaven/scratch unless stated otherwise.

## Collecting data

Genomes were initially downloaded to the NIAB HPC, these were subsequently moved to the Crop Diversity HPC and all data in the /data/scratch/heavet directory of the NIAB HPC has since been deleted to save space.

Our powdery mildew genomes:
```bash
mkdir -p /data/scratch/heavet/assembly/genome/Podosphaera/aphanis
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.fna
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenSCOTT2020_1.fna
cp /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/THeavenp11_1.fna
cp /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.1.fsa_nt /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.fna
```

Downloaded powdery mildew genomes:
```bash
#wheat powdery  mildew genome
wget -P assembly/genome/NCBI/erysiphales/B_graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz

#grape powdery mildew genome
wget -P assembly/genome/NCBI/erysiphales/E_necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna.gz


wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pisi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/208/805/GCA_000208805.1_ASM20880v1/GCA_000208805.1_ASM20880v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pisi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/214/055/GCA_000214055.1_ASM21405v1/GCA_000214055.1_ASM21405v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/pisi/*.gz

wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/016/906/895/GCA_016906895.1_ASM1690689v1/GCA_016906895.1_ASM1690689v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/795/GCA_000798795.1_ASM79879v1/GCA_000798795.1_ASM79879v1_genomic.fna.gz   
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/775/GCA_000798775.1_ASM79877v1/GCA_000798775.1_ASM79877v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/755/GCA_000798755.1_ASM79875v1/GCA_000798755.1_ASM79875v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/735/GCA_000798735.1_ASM79873v1/GCA_000798735.1_ASM79873v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/necator/*.gz

wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pulchra https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/918/395/GCA_002918395.1_ASM291839v1/GCA_002918395.1_ASM291839v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/*.gz

wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/235/GCA_003611235.1_ASM361123v1/GCA_003611235.1_ASM361123v1_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/195/GCA_003611195.1_ASM361119v1/GCA_003611195.1_ASM361119v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/215/GCA_003611215.1_ASM361121v1/GCA_003611215.1_ASM361121v1_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/*.gz

wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/006/912/115/GCA_006912115.1_ASM691211v1/GCA_006912115.1_ASM691211v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/*.gz

wget -P /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/610/855/GCA_003610855.1_ASM361085v1/GCA_003610855.1_ASM361085v1_genomic.fna.gz   
gunzip /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/*.gz

wget -P /data/scratch/heavet/assembly/genome/Oidium/heveae https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/957/845/GCA_003957845.1_ASM395784v1/GCA_003957845.1_ASM395784v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Oidium/heveae/*.gz

wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/239/735/GCA_900239735.1_BGH_DH14_v4/GCA_900239735.1_BGH_DH14_v4_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/638/725/GCA_900638725.1_BGH_K1_v2/GCA_900638725.1_BGH_K1_v2_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/418/435/GCA_000418435.1_Bgt_454_newbler_assembly/GCA_000418435.1_Bgt_454_newbler_assembly_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/401/675/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/441/875/GCA_000441875.1_Bgt_70_1/GCA_000441875.1_Bgt_70_1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/417/865/GCA_000417865.1_Bgt_94202_1/GCA_000417865.1_Bgt_94202_1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/417/025/GCA_000417025.1_ASM41702v1/GCA_000417025.1_ASM41702v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/519/115/GCA_900519115.1_Bgt_genome_v3.16/GCA_900519115.1_Bgt_genome_v3.16_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/905/067/625/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Blumeria/graminis/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/xanthii https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/010/015/925/GCA_010015925.1_POXAN_niab_assembly/GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Podosphaera/xanthii https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/884/795/GCA_014884795.1_ASM1488479v1/GCA_014884795.1_ASM1488479v1_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/xanthii/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/cerasi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/398/735/GCA_018398735.1_WSU_PS_Poc_1.0/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.gz
```
Secalis genomes
```bash
for Assembly in $(ls /home/theaven/scratch/assembly/metagenome/blumeria/graminis/secalis/*/SPAdes/256935*/filtered_contigs/S*contigs_min_500bp.fasta); do
Outname=$(echo $Assembly|rev|cut -f1 -d '/'|rev|sed 's@.fasta@.c.fna@g')
cp $Assembly data/assembly/genome/Blumeria/graminis/$Outname
done
```
```bash
conda activate quast
    for Assembly in $(ls data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna); do
      ProgDir=apps/quast
      OutDir=$(dirname $Assembly)/quast
      echo $Assembly
      echo $OutDir
      sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#2538596
    for Assembly in $(ls data/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fna); do
      ProgDir=apps/quast
      OutDir=$(dirname $Assembly)/quast
      echo $Assembly
      echo $OutDir
      sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#2538597
conda deactivate
```
Download host genomes:
```bash
#Apple
cp /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /data/scratch/heavet/assembly/genome/malus/domestica/GDDH13_1-1_formatted.fna

#Strawberry
cp /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta /data/scratch/heavet/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.fna

#Raspberry
cp /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fna

wget -P /data/scratch/heavet/assembly/genome/rubus/idaeus/media-5.fna.gz https://www.biorxiv.org/content/biorxiv/early/2019/02/18/546135/DC5/embed/media-5.gz?download=true
gunzip /data/scratch/heavet/assembly/genome/rubus/idaeus/*.gz

wget -P /data/scratch/heavet/assembly/genome/rubus/occidentalis/Rubus_occ_V3_10-12-17.fna.gz https://www.rosaceae.org/rosaceae_downloads/Rubus_occidentalis/Rubus_occidentalis-genome.v3.0/assembly/Rubus_occ_V3_10-12-17.fasta.gz
gunzip /data/scratch/heavet/assembly/genome/rubus/occidentalis/*.gz

#Barley GCA_904849725.1
wget -P /data/scratch/heavet/assembly/genome/hordeum/vulgare/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/849/725/GCA_904849725.1_MorexV3_pseudomolecules_assembly/GCA_904849725.1_MorexV3_pseudomolecules_assembly_genomic.fna.gz  
gunzip /data/scratch/heavet/assembly/genome/hordeum/vulgare/*.gz

#Rye GCA_016097815.1 - powdery mildew raw data available but not assembly :( https://www.ncbi.nlm.nih.gov/sra/?term=SRP062198+secalis - menardo
wget -P /data/scratch/heavet/assembly/genome/secale/cereale/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/016/097/815/GCA_016097815.1_HAU_Weining_v1.0/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/secale/cereale/*.gz

#Triticale - no genome available

#Wheat GCA_018294505.1
wget -P /data/scratch/heavet/assembly/genome/triticum/aestivum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/294/505/GCA_018294505.1_IWGSC_CS_RefSeq_v2.1/GCA_018294505.1_IWGSC_CS_RefSeq_v2.1_genomic.fna.gz  
gunzip /data/scratch/heavet/assembly/genome/triticum/aestivum/*.gz

#Grapevine  GCA_000003745.2
wget -P /data/scratch/heavet/assembly/genome/vitus/vinifera/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/003/745/GCA_000003745.2_12X/GCA_000003745.2_12X_genomic.fna.gz   
gunzip /data/scratch/heavet/assembly/genome/vitus/vinifera/*.gz

#Pea    GCA_900700895.2
wget -P /data/scratch/heavet/assembly/genome/pisum/sativum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/700/895/GCA_900700895.2_Pisum_sativum_v1a/GCA_900700895.2_Pisum_sativum_v1a_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/pisum/sativum/*.gz

#Flowering Dogwood - no genome available

#Sow thistle - no genome available

#Tobacco    GCA_000715135.1
wget -P /data/scratch/heavet/assembly/genome/nicotiana/tabacum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/715/135/GCA_000715135.1_Ntab-TN90/GCA_000715135.1_Ntab-TN90_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/nicotiana/tabacum/*.gz

#Arabidopsis    GCA_000001735.2
wget -P /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/735/GCA_000001735.2_TAIR10.1/GCA_000001735.2_TAIR10.1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/*.gz

#Phlox paniculata - no genome available

#Rubber tree    GCA_001654055.1
wget -P /data/scratch/heavet/assembly/genome/hevea/brasiliensis/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/654/055/GCA_001654055.1_ASM165405v1/GCA_001654055.1_ASM165405v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/hevea/brasiliensis/*.gz

#Tomato     GCA_000188115.3
wget -P /data/scratch/heavet/assembly/genome/solanum/lycopersicum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/188/115/GCA_000188115.3_SL3.0/GCA_000188115.3_SL3.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/solanum/lycopersicum/*.gz

#Sweet cherry   GCA_002207925.1
wget -P /data/scratch/heavet/assembly/genome/prunus/avium/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/207/925/GCA_002207925.1_PAV_r1.0/GCA_002207925.1_PAV_r1.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/prunus/avium/*.gz

#Cucumber   GCA_000004075.3
wget -P /data/scratch/heavet/assembly/genome/cucumis/sativus/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/004/075/GCA_000004075.3_Cucumber_9930_V3/GCA_000004075.3_Cucumber_9930_V3_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/cucumis/sativus/*.gz

#Courgette  GCA_002806865.2
wget -P /data/scratch/heavet/assembly/genome/cucurbita/pepo/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/806/865/GCA_002806865.2_ASM280686v2/GCA_002806865.2_ASM280686v2_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/cucurbita/pepo/*.gz
```
Outgroup genomes downloaded:
```bash
mkdir -p assembly/genome/NCBI/S.cerevisiae
cd assembly/genome/NCBI/S.cerevisiae
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.fna.gz
gunzip GCF_000146045.2_R64_genomic.fna.gz
mkdir -p /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae
cp /projects/nano_diagnostics/assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae/GCF_000146045.2_R64_genomic.d.fna
```

Transfering data from NIAB hpc to Crop diversity hpc:

Genomes:
```bash
Arabidopsis/    erysiphales/    hevea/          Oidium/         rubus/          Sporidiobolus/
Blumeria/       Erysiphe/       hordeum/        pisum/          Saccharomyces/  Sporobolomyces/
cucumis/        fragaria/       malus/          Podosphaera/    secale/         triticum/
cucurbita/      Golovinomyces/  nicotiana/      prunus/         solanum/        vitus/

mkdir Arabidopsis/
  mkdir thaliana
mkdir hevea/
  mkdir brasiliensis
mkdir Oidium/
  mkdir heveae/
  mkdir neolycopersicim/
mkdir rubus/
  mkdir idaeus
  mkdir occidentalis
mkdir Sporidiobolus/
  mkdir pararoseus/  
  mkdir salmonicolor/
mkdir Blumeria/
  mkdir graminis
mkdir Erysiphe/ 
  mkdir necator
  mkdir pisi
  mkdir pulchra
mkdir hordeum/ 
  mkdir vulgare
mkdir pisum/ 
  mkdir sativum       
mkdir Saccharomyces/ 
  mkdir cerevisiae
mkdir Sporobolomyces/
  mkdir roseus
mkdir cucumis/
  mkdir sativus
mkdir fragaria/  
 mkdir vesca
 mkdir ananassa
mkdir malus/
  mkdir domestica
mkdir Podosphaera/  
  mkdir cerasi
  mkdir leucotricha
  mkdir xanthii
  mkdir aphanis
mkdir secale/
  mkdir cereale
mkdir triticum/
  mkdir aestivum
mkdir cucurbita/
  mkdir pepo
mkdir Golovinomyces/ 
  mkdir cichoracearum 
  mkdir magnicellulatus
mkdir nicotiana/
  mkdir tabacum     
mkdir prunus/ 
  mkdir avium     
mkdir solanum/
  mkdir lycopersicum      
mkdir vitus/
  mkdir vinifera

mkdir /home/theaven/scratch/data/assembly/genome/Erysiphe/alphitoides
mkdir /home/theaven/scratch/data/assembly/genome/Golovinomyces/magnicellulatus

scp -r /data/scratch/heavet/assembly/genome/vitus/vinifera/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/vitus/vinifera 
scp -r /data/scratch/heavet/assembly/genome/solanum/lycopersicum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/solanum/lycopersicum
scp -r /data/scratch/heavet/assembly/genome/prunus/avium/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/prunus/avium
scp -r /data/scratch/heavet/assembly/genome/nicotiana/tabacum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/nicotiana/tabacum
scp -r /data/scratch/heavet/assembly/genome/triticum/aestivum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/triticum/aestivum 
scp -r /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Saccharomyces/cerevisiae
scp -r /data/scratch/heavet/assembly/genome/pisum/sativum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/pisum/sativum 
scp -r /data/scratch/heavet/assembly/genome/hordeum/vulgare/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hordeum/vulgare
scp -r /data/scratch/heavet/assembly/genome/hevea/brasiliensis/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hevea/brasiliensis
scp -r /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Arabidopsis/thaliana 
scp -r /data/scratch/heavet/assembly/genome/fragaria/ananassa/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/ananassa 
scp -r /data/scratch/heavet/assembly/genome/fragaria/vesca/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/vesca
scp -r /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporobolomyces/roseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/pararoseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/salmonicolor
scp -r /data/scratch/heavet/assembly/genome/rubus/occidentalis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/occidentalis
scp -r /data/scratch/heavet/assembly/genome/rubus/idaeus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/idaeus 
scp -r /data/scratch/heavet/assembly/genome/Oidium/heveae/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/heveae 
scp -r /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/neolycopersicim
scp -r /data/scratch/heavet/assembly/genome/Blumeria/graminis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Blumeria/graminis
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pisi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pisi 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/necator/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/necator 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pulchra
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/cichoracearum
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/magnicellulatus
scp -r /data/scratch/heavet/assembly/genome/secale/cereale/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/secale/cereale
scp -r /data/scratch/heavet/assembly/genome/cucurbita/pepo/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucurbita/pepo
scp -r /data/scratch/heavet/assembly/genome/malus/domestica/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/malus/domestica
scp -r /data/scratch/heavet/assembly/genome/cucumis/sativus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucumis/sativus
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/xanthii/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha

#non-mildew genomes:
mkdir -p /home/theaven/scratch/data/assembly/genome/amorphotheca/resinae
cd /home/theaven/scratch/data/assembly/genome/amorphotheca/resinae
#Amorphotheca resinae:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/019/875/GCA_003019875.1_Amore1/GCA_003019875.1_Amore1_genomic.fna.gz 
#Amorphotheca resinae:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/167/515/GCA_018167515.1_ASM1816751v1/GCA_018167515.1_ASM1816751v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/amorphotheca/araneosa
cd /home/theaven/scratch/data/assembly/genome/amorphotheca/araneosa
#Amorphotheca araneosa:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/988/855/GCA_003988855.1_ASM398885v1/GCA_003988855.1_ASM398885v1_genomic.fna.gz  
mkdir -p /home/theaven/scratch/data/assembly/genome/ascocoryne/sarcoides
cd /home/theaven/scratch/data/assembly/genome/ascocoryne/sarcoides
#Ascocoryne sarcoides
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/328/965/GCA_000328965.1_ASM32896v1/GCA_000328965.1_ASM32896v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/chlorociboria/aeruginascens
cd /home/theaven/scratch/data/assembly/genome/chlorociboria/aeruginascens
#Chlorociboria aeruginascens
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/276/475/GCA_002276475.2_Chloro_aeru_v2/GCA_002276475.2_Chloro_aeru_v2_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/Glarea/lozoyensis
cd /home/theaven/scratch/data/assembly/genome/Glarea/lozoyensis
#Glarea lozoyensis
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/409/485/GCA_000409485.1_GLAREA/GCA_000409485.1_GLAREA_genomic.fna.gz
mkdir -p /home/theaven/scratch/data/assembly/genome/marssonina/brunnea
cd /home/theaven/scratch/data/assembly/genome/marssonina/brunnea
#Marssonina brunnea f. sp. multigermtubi
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/298/775/GCA_000298775.1_ASM29877v1/GCA_000298775.1_ASM29877v1_genomic.fna.gz
mkdir -p /home/theaven/scratch/data/assembly/genome/neobulgaria/alba
cd /home/theaven/scratch/data/assembly/genome/neobulgaria/alba
#Neobulgaria alba
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/988/965/GCA_003988965.1_ASM398896v1/GCA_003988965.1_ASM398896v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/oidiodendron/maius
cd /home/theaven/scratch/data/assembly/genome/oidiodendron/maius
#Oidiodendron maius
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/827/325/GCA_000827325.1_Oidiodendron_maius_Zn_v1.0/GCA_000827325.1_Oidiodendron_maius_Zn_v1.0_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/phialocephala/scopiformis
cd /home/theaven/scratch/data/assembly/genome/phialocephala/scopiformis
#Phialocephala scopiformis
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/500/285/GCA_001500285.1_Phisc1/GCA_001500285.1_Phisc1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/phialocephala/1
cd /home/theaven/scratch/data/assembly/genome/phialocephala/1
#Phialocephala
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/073/065/GCA_900073065.1_PAC_version_1/GCA_900073065.1_PAC_version_1_genomic.fna.gz 
gunzip /home/theaven/scratch/data/assembly/genome/*/*/*.gz

cd ~/scratch
mkdir -p data/assembly/genome/Quercus/robur
cd data/assembly/genome/Quercus/robur
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/932/294/415/GCA_932294415.1_dhQueRobu3.1/GCA_932294415.1_dhQueRobu3.1_genomic.fna.gz 
gunzip *.gz 
cd ~/scratch
mkdir -p data/assembly/genome/Capsicum/annuum
cd data/assembly/genome/Capsicum/annuum
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/878/395/GCA_002878395.3_UCD10Xv1.1/GCA_002878395.3_UCD10Xv1.1_genomic.fna.gz
gunzip *.gz 
cd ~/scratch
mkdir -p data/assembly/genome/Morus/alba
cd data/assembly/genome/Morus/alba
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/012/066/045/GCA_012066045.3_ASM1206604v3/GCA_012066045.3_ASM1206604v3_genomic.fna.gz 
gunzip *.gz 
cd ~/scratch
```

ls data/assembly/genome/Erysiphe/alphitoides/*.f*
ls data/assembly/genome/leveillula/taurica/*.f*
ls data/assembly/genome/parauncinula/polyspora/*.f* #genome not available from ENA as paper claims
ls data/assembly/genome/phyllactinia/moricola/*.f*
ls data/assembly/genome/pleochaeta/shiraiana/*.f*
ls data/assembly/genome/Golovinomyces/orontii/*.f*

ls data/assembly/genome/mollisia/scopiformis/*.f*
ls data/assembly/genome/drepanopeziza/brunnea/*.f*

ls data/assembly/genome/amorphotheca/resinae/*.f*
ls data/assembly/genome/arachnopeziza/araneosa/*.f*
ls data/assembly/genome/ascocoryne/sarcoides/*.f*
ls data/assembly/genome/chlorociboria/aeruginascens/*.f*
ls data/assembly/genome/Glarea/lozoyensis/*.f* 
ls data/assembly/genome/marssonina/brunnea/*.f*
ls data/assembly/genome/neobulgaria/alba/*.f*
ls data/assembly/genome/oidiodendron/maius/*.f*
ls data/assembly/genome/phialocephala/scopiformis/*.f*
ls data/assembly/genome/phialocephala/1/*.f* 

ls data/assembly/genome/Quercus/robur/*.f* 
ls data/assembly/genome/Capsicum/annuum/*.f* 
ls data/assembly/genome/Morus/alba/*.f* 

## Phylogeny

### Maximum likelihood phylogenetic tree - BUSCOs

A phylogenetic tree from powdery mildew species and their host species was generated using just the draft genomes (genomes that still don’t have the annotations yet).

### BUSCO

BUSCO was run to predict conserved genes:
```bash
#BUSCO has errors when using .mod.fna files due to the | symbol
while read file; do
  echo "$file"
  Out=$(echo $file|sed 's@.mod.fna@.c.fna@g')
  echo $Out
  sed 's/|kraken:taxid|/ /g' $file > $Out
done < piped.txt

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=fungi_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2734247,51,53,56,58,60,62, 3057144-164
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2462675-2462728, 2487763-8, 2488333-2488367, 2569867-71, 3057102-122
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463015-2463068,2488280-2488332, 2569873-77, 3057081-101
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463069-2463122, 2487770-2487809, 2569879-83, 3057123-143
conda deactivate
exit
echo finished





for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
    sleep 30
done
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
    sleep 30
done
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
    sleep 30
done
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=fungi_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
    sleep 30
done
#3057167-
```

Short summary files from BUSCo run directories were copied to another directory in order to generate BUSCO plots:

```bash

mkdir -p gene_pred/busco_summaries/plant
mkdir -p gene_pred/busco_summaries/ascomycota
mkdir -p gene_pred/busco_summaries/leotiomycetes
for file in $(ls gene_pred/*/*/*/BUSCO/viridiplantae_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/plant/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/ascomycota_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/ascomycota/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/leotiomycetes_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/leotiomycetes/.;
done
```
Complete BUSCO genes were extracted from the output of BUsco runs:
```bash
#Mildew BUSCOs:
for file in $(ls gene_pred/Podosphaera/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Erysiphe/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Blumeria/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Golovinomyces/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Oidium/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done

#Host BUSCOs:
for file in $(ls gene_pred/Arabidopsis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/malus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/secale/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/vitus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/fragaria/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/nicotiana/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/solanum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/prunus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucumis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hevea/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/rubus/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucurbita/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hordeum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/pisum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/triticum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
```
BUSCOs that were only present in less than 3 genomes were filtered out:

```bash
#Mildew BUSCOs:
sort analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt
grep -v " 2 " analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt | grep -v " 1 " > analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt
awk '{print $2}' analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt > analysis/phylogeny/busco/mildew_leotiomycetes_final_buscos_ids.txt

#Host BUSCOs:
sort analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt
grep -v " 2 " analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt | grep -v " 1 " > analysis/phylogeny/busco/host_viridiplantae_final_busco_ids.txt
awk '{print $2}' analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/host_viridiplantae_final_buscos_ids.txt
```
Genes (both nucleotides and amino acids) were copied to a different directory. - Note that the gene names for each BUSCO output are only indetified by BUSCO id with either faa or fna extenstions. If you try to copy them directly to a single directory, you will likely overwrite all the files and end up with only the last set of files. Therefore each BUSCO gene for each genome was assigned a unique name and then all were merged together, writing them to a single busco id file. Ssequence nameS (fasta header) were edited so to include organism identifiers.

NOTE:.fna files containing nucleotide information will not be created by busco unless --augustus parameter is used (has not been here).
```bash
#For pathogen; Blumeria Erysiphe Podosphaera Golovinomyces Oidium and Saccharomyces outgroup 

mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt

for dir in $(ls -d gene_pred/S*/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}  
#  done
done


#For hosts; Arabidopsis malus secale vitus fragaria nicotiana solanum prunus cucumis hevea rubus cucurbita hordeum pisum triticum

mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_aa
mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_nt

for dir in $(ls -d gene_pred/v*/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}  
#  done
done
exit 
exit
exit
```
Now that BUSCO genes have been named uniquely for each genome analysed they were copied into a single .fasta file one for each gene.
```bash
screen -S comps
srun -p long  --mem 10G --pty bash
cd /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
buscos=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_final_buscos_ids.txt
lines=$(cat $buscos)
for line in $lines; do
  for faa in $(ls *_$line.faa); do
  echo $faa
  output=$(echo $line)_aa.fasta
  echo $output
  cat $faa >> $output
  done
done
#rm *.faa

cd /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa
buscos=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_final_buscos_ids.txt
lines=$(cat $buscos)
for line in $lines; do
  for faa in $(ls *_$line.faa); do
  echo $faa
  output=$(echo $line)_aa.fasta
  echo $output
  cat $faa >> $output
  done
done
exit
exit
#rm *.faa
```
Submit alignment for single copy busco genes with a hit in each organism
```bash 
conda activate mafft

  AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
  cd $AlignDir
  ProgDir=/home/theaven/scratch/apps/phylogeny
  sbatch $ProgDir/sub_mafft_alignment.sh $AlignDir
#2569979, 2859967

  AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa
  cd $AlignDir
  ProgDir=/home/theaven/scratch/apps/phylogeny
  sbatch $ProgDir/sub_mafft_alignment.sh $AlignDir
#2569980, 2859968
conda deactivate

cd ~/scratch  
```
create a folder for each gene
```bash
for gene in $(ls /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_aa_aligned.fasta@@g')
  mkdir /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/$ID
  for file in $(ls $gene); do
    cp $file /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/$ID
  done
done

for gene in $(ls /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_aa_aligned.fasta@@g')
  mkdir /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
  for file in $(ls $gene); do
    cp $file /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
  done
done

rm 
```
NOT APPLICABLE TO PEPTIDE SEQUENCES, NUCLEOTIDE ONLY:
```bash
scp -r /home/gomeza/git_repos/scripts/neonectria_ditissima/Popgen_analysis/phylogenetics/calculate_nucleotide_diversity.py theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/phylogeny/. 

screen -S dendropy 
srun -p long  --mem 50G --pty bash
conda activate dendropy3
AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
ProgDir=/home/theaven/scratch/apps/phylogeny
cd $AlignDir
python $ProgDir/calculate_nucleotide_diversity.py "*aligned.fasta"
conda deactivate

screen -S dendropy2 
srun -p long  --mem 50G --pty bash
conda activate dendropy3
AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa
ProgDir=/home/theaven/scratch/apps/phylogeny
cd $AlignDir
python $ProgDir/calculate_nucleotide_diversity.py "*aligned.fasta"
conda deactivate

```
Trimming sequence alignments using Trim-Al
```bash
Note - automated1 mode is optimised for ML tree reconstruction
conda activate trimal
  OutDir=analysis/popgen/busco_phylogeny/trimmed_alignments
  mkdir -p $OutDir
  for Alignment in $(ls /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*_aligned.fasta); do
    TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
    echo $Alignment
    trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
  done
conda deactivate
```
Arabidopsis/     Erysiphe/        malus/           P_leucotricha/   secale/          vitus/
Blumeria/        fragaria/        nicotiana/       Podosphaera/     solanum/
busco_summaries/ Golovinomyces/   Oidium/          prunus/          Sporidiobolus/
cucumis/         hevea/           P_aphanis/       rubus/           Sporobolomyces/
cucurbita/       hordeum/         pisum/           Saccharomyces/   triticum/




















































# After this point pipeline is work in progress
### Predector
```bash
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/

screen -S PREDECTOR
srun -p long  --mem 100G --cpus-per-task=16 --nodelist=n19-32-192-malekith --pty bash
srun -p himem  --mem 100G --cpus-per-task=16 --nodelist=n19-64-3072-thanos --pty bash
srun -p himem  --mem 100G --cpus-per-task=16 --nodelist=n17-28-1536-apollo --pty bash
conda activate predector
for proteome in $(ls /home/theaven/scratch/gene_pred/*/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/*.fasta); do
Dir=$(echo $proteome|cut -f1,2,3,4,5,6,7 -d '/')/predector
mkdir $Dir
cd $Dir
LD_LIBRARY_PATH=/mnt/shared/scratch/theaven/apps/conda/envs/predector/lib
nextflow run \
  -profile c16,r64 \
  -resume \
  -r 1.2.6 \
  -with-conda /mnt/shared/scratch/theaven/apps/conda/envs/predector \
  ccdmb/predector \
  --proteome $proteome 2>&1 | tee -a predector_report.txt
cd ~/scratch
LD_LIBRARY_PATH=/opt/slurm/latest/lib64
done
conda deactivate
exit
exit
#1.2.6, 1.1.0-beta.1, 1.2.5, 1.1.0, 1.2.4, 1.1.1, 1.2.0-beta

screen -S PREDECTOR2
srun -p long  --mem 100G --nodelist=n19-32-192-malekith --cpus-per-task=16 --pty bash
conda activate predector
for proteome in $(ls /home/theaven/scratch/gene_pred/*/THeavenp11_1/codingquarry/rep_modeling/final/*.fasta); do
Dir=$(echo $proteome|cut -f1,2,3,4,5,6,7 -d '/')/predectorvm
mkdir $Dir
cd $Dir
nextflow run \
  -profile c16,r64 \
  -resume \
  -r 1.2.6 \
  --software-version 1.0 \
  -with-conda /mnt/shared/scratch/theaven/apps/conda/envs/predector \
  ccdmb/predector \
  --proteome $proteome 2>&1 | tee -a predector_report_1.2.0-beta.txt
cd ~/scratch
done
conda deactivate
exit
exit
#1.2.0-beta run, then 1.2.6 in the same directory, with software version 1.0 vs 1.0.3 for other 5 only 1.2.6, gets to apoplastp however with same pepstats error - p11 - issue cannot be replicated with bash .command.run - localizer not yet run
#doesnt work with long nodes? no p11 1.2.0-beta was with long??? no reason why not other >:(
#cannot switch versions midway through run, going from 1.2.0-beta with deepsig complete to 1.2.6 results in processes set back to 0%
#where 1.2.0-beta passes deepsig, fails to call pepstats however pepstats process has completed successfully, failure is with localizer????
#deepsig failure is related to nvidia driver library, are some of the cluster nodes using different gpus therefore depends which node you are randomly assigned to? p11 1.2.0-beta that passed deepsig was on n19-32-192-malekith

conda activate predector
for proteome in $(ls /home/theaven/scratch/gene_pred/*/*/codingquarry/rep_modeling/final/*.fasta); do
ProgDir=/home/theaven/scratch/apps/predector
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6
sleep 30
done
conda deactivate
#2860718,21,25,26,27,28, 2864314-19
#3038774-9
#3038780-5,6,7

for file in $(ls gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv); do
Organism=$(echo $file|cut -f2 -d '/')
Strain=$(echo $file|cut -f3 -d '/')
OutDir=$(dirname $file)
echo ${Organism}-${Strain}
cp $file ${OutDir}/${Organism}-${Strain}-ranked.tsv
done

#bash .command.run from localizer error gives:
Error calling pepstats: [Errno 14] Bad address: '/mnt/shared/scratch/theaven/apps/conda/envs/predector/bin/pepstats'
parallel: This job failed:
run $PARALLEL_TMP





Error executing process > 'localizer (1)'

Caused by:
  Process `localizer (1)` terminated with an error exit status (1)

Command executed:

  run () {
      set -e
      TMP="tmp$$"
      LOCALIZER.py -e -i "$1" -o "${TMP}" 1>&2
      cat "${TMP}/Results.txt"

      rm -rf -- "${TMP}"
  }
  export -f run

  CHUNKSIZE="$(decide_task_chunksize.sh in.fasta "16" 100)"

  parallel         --halt now,fail=1         --joblog log.txt         -j "16"         -N "${CHUNKSIZE}"         --line-buffer          --recstart '>'         --cat          run     < in.fasta     | cat > out.txt

  predutils r2js         --pipeline-version "1.2.6"         --software-version "1.0.3"         -o out.ldjson         localizer out.txt in.fasta

Command exit status:
  1

Command output:
  (empty)

Command error:
  Error calling pepstats: [Errno 14] Bad address: '/mnt/shared/scratch/theaven/apps/conda/envs/predector/bin/pepstats'
  parallel: This job failed:
  run $PARALLEL_TMP

Work dir:
  /mnt/shared/scratch/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/predector/work/56/028613a1f49d89b03656d56521de3b

Tip: you can replicate the issue by changing to the process work dir and entering the command `bash .command.run`


################################################################################################

Error executing process > 'apoplastp (2)'

Caused by:
  Process `apoplastp (2)` terminated with an error exit status (1)

Command executed:

  run () {
      set -e
      TMPFILE="tmp$$"
      ApoplastP.py -s -i "$1" -o "${TMPFILE}" 1>&2
      cat "${TMPFILE}"

      rm -f "${TMPFILE}"
  }
  export -f run

  CHUNKSIZE="$(decide_task_chunksize.sh in.fasta "16" 100)"

  parallel         --halt now,fail=1         --joblog log.txt         -j "16"         -N "${CHUNKSIZE}"         --line-buffer          --recstart '>'         --cat          run     < in.fasta     | cat > out.txt

  predutils r2js         --pipeline-version "1.2.6"         --software-version "1.0"         -o out.ldjson         apoplastp out.txt in.fasta

Command exit status:
  1

Command output:
  (empty)

Command error:
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/pargMmug

  -----------------
  ApoplastP results were saved to output file: tmp3994337
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parQcdBG

  -----------------
  ApoplastP results were saved to output file: tmp3994376
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parON0ug

  -----------------
  ApoplastP results were saved to output file: tmp3994324
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parpldTY

  -----------------
  ApoplastP results were saved to output file: tmp3994404
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parucnbK

  -----------------
  ApoplastP results were saved to output file: tmp3994421
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/pariyCte

  -----------------
  ApoplastP results were saved to output file: tmp3994352
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parCHBd0

  -----------------
  ApoplastP results were saved to output file: tmp3994308
  -----------------

  ApoplastP is running for 100 proteins given in FASTA file /tmp/theaven_2853922/parfqJdN

 -----------------

  Error calling pepstats: [Errno 14] Bad address: '/mnt/shared/scratch/theaven/apps/conda/envs/predector/bin/pepstats'
  parallel: This job failed:
  run $PARALLEL_TMP

Work dir:
  /mnt/shared/scratch/theaven/gene_pred/P_leucotricha/THeavenp11_1/predectorvm/work/f7/f0c2d6180c5920e9b9d809745789de

Tip: you can try to figure out what's wrong by changing to the process work dir and showing the script file named `.command.sh`

```

### Signal-P
```bash
#input used had problem NCBI genes removed in previous section
conda activate Java11

  for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed3.pep.fasta); do
  ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
  SplitDir=$(dirname $Proteome | sed 's/final/final_edited_genes_split/g')
  mkdir -p $SplitDir
  $ProgDir/splitfile_500.py --inp_fasta $Proteome --out_dir $SplitDir --out_base P_aphanis_THeavenDRCT72020_1_final_preds # Splits input fasta in 500 genes files
  done

  for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_edited_genes_split/*_final_preds_*); do
    OutDir=gene_pred/P_aphanis/THeavenDRCT72020_1/signalp
    sbatch /home/heavet/git_repos/tools/seq_tools/Feature_annotation/pred_signalP.sh $File signalp-4.1 $OutDir
  done
  #14431-14466

  for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_edited_genes_split/*_final_preds_*); do
  InName=$(echo $File | rev | cut -d "/" -f1 | rev)
  echo $InName
  OutFile=$(echo $InName | sed s/.fa//)
  echo $OutFile
  /data/scratch/gomeza/prog/signalp/signalp-4.1/signalp-4.1 -t euk -f summary -c 70 $File > "$OutFile"_sp.txt
  echo '----------------------------------------------------------------------' >> "$OutFile"_sp.txt
  done

  mv P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/.


  for OutFile in $(ls P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt); do
  /home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation/sigP_4.1_parser.py --inp_fasta gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta --inp_sigP "$OutFile"_sp.txt --out_tab "$OutFile"_sp.tab --out_fasta "$OutFile"_sp.aa --out_neg "$OutFile"_sp_neg.aa
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-4.1 # Recommended for fungi
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-5.0
  done
  ```
### Effector-P
```bash
#input used had problem NCBI genes removed in previous section
mkdir -p /scratch/projects/heavet/gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P
srun -p short -J signal-P --mem 100G --pty bash
cd /scratch/projects/heavet
conda activate Java11
python /scratch/software/EffectorP-2.0/Scripts/EffectorP.py -o gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.txt -E gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.fa -i gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed3.pep.fasta
```
### pylogenetics
```bash
realphy https://github.com/harrisonlab/pseudomonas/blob/master/phylogenetics/Realphy_commands



```
### Signal-P
```bash
conda activate Java11

  for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do
  ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
  SplitDir=$(dirname $Proteome | sed 's/final/final_genes_split/g')
  mkdir -p $SplitDir
  $ProgDir/splitfile_500.py --inp_fasta $Proteome --out_dir $SplitDir --out_base P_aphanis_THeavenDRCT72020_1_final_preds # Splits input fasta in 500 genes files
  done
  for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/*_final_preds_*); do
  InName=$(echo $File | rev | cut -d "/" -f1 | rev)
  echo $InName
  OutFile=$(echo $InName | sed s/.fa//)
  echo $OutFile
  signalp-4.1 -t euk -f summary -c 70 $File > "$OutFile"_sp.txt
  echo '----------------------------------------------------------------------' >> "$OutFile"_sp.txt
  done
  mv P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/.


  for OutFile in $(ls P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final_genes_split/P_aphanis_THeavenDRCT72020_1_final_preds*sp.txt); do
  /home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation/sigP_4.1_parser.py --inp_fasta gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta --inp_sigP "$OutFile"_sp.txt --out_tab "$OutFile"_sp.tab --out_fasta "$OutFile"_sp.aa --out_neg "$OutFile"_sp_neg.aa
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-4.1 # Recommended for fungi
  #sbatch $ProgDir/sub_signalP.sh $File $OutDir signalp-5.0
  done
#788728-788763

OutDir=$(dirname $Proteome | sed 's/codingquarry/signalp/g'| sed 's/final/split/g')

Change output directory name to "final_genes_signalp-4.1" mv gene_pred/F.oxysporum_fsp_fragariae_signalp-4.1 gene_pred/final_genes_signalp-4.1

Need to combine the output of the first signal-P run

for Strain in DSA14_003; do for SplitDir in $(ls -d gene_pred/final_genes_split/F.oxysporum_fsp_fragariae/$Strain/flye); do Strain=$(echo $SplitDir | rev |cut -d '/' -f2 | rev) Organism=$(echo $SplitDir | rev |cut -d '/' -f3 | rev) InStringAA='' InStringNeg='' InStringTab='' InStringTxt='' SigpDir=final_genes_signalp-4.1 for GRP in $(ls -l $SplitDir/final_preds.fa | rev | cut -d '' -f1 | rev | sort -n); do InStringAA="$InStringAA gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp.aa"; InStringNeg="$InStringNeg gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp_neg.aa"; InStringTab="$InStringTab gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""sp.tab"; InStringTxt="$InStringTxt gene_pred/$SigpDir/$Organism/$Strain/"$Organism""$Strain"final_preds$GRP""_sp.txt"; done cat $InStringAA > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.aa cat $InStringNeg > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_neg_sp.aa tail -n +2 -q $InStringTab > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.tab cat $InStringTxt > gene_pred/$SigpDir/$Organism/$Strain/"$Strain"_final_sp.txt done done

Having flye in directory path caused small issues therefore I stopped including it from here Things may be in the wrong directory - use "mv" command to change directory names


  signalp-4.1 -t euk -f summary -c 70 $File > "$OutFile"_sp.txt
  echo '----------------------------------------------------------------------' >> "$OutFile"_sp.txt
  PathToAnnotateSigP=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
  $PathToAnnotateSigP/sigP_4.1_parser.py --inp_sigP "$OutFile"_sp.txt --out_tab "$OutFile"_sp.tab --out_fasta "$OutFile"_sp.aa --out_neg "$OutFile"_sp_neg.aa -$

```

### TMHMM
Identify transmembrane proteins
```bash
for Proteome in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta); do 
  ProgDir=/home/heavet/git_repos/tools/seq_tools/Feature_annotation
  OutDir=$(dirname $Proteome | sed 's/codingquarry/TMHMM/g')
  sbatch $ProgDir/TMHMM.sh $Proteome $OutDir
done 
#788768

Proteins with transmembrane domains were removed from lists of Signal peptide containing proteins

for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/TMHMM/rep_modeling/787033/final/TM_genes_neg.txt); do
TmHeaders=$(echo "$File" | sed 's/neg.txt/neg_headers.txt/g')
cat $File | cut -f1 > $TmHeaders
SigP=$(ls gene_pred/final_genes_signalp-4.1/$Organism/$Strain/*_final_sp.aa)
OutDir=$(dirname $SigP)
ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
$ProgDir/extract_from_fasta.py --fasta $SigP --headers $TmHeaders > $OutDir/"$Strain"_final_sp_no_trans_mem.aa
cat $OutDir/"$Strain"_final_sp_no_trans_mem.aa | grep '>' | wc -l
done
```
### Effector-P
```bash
mkdir -p gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P
srun -p short  --mem 100G --pty bash
EffectorP.py -o gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.txt -E gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.fa -i gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/787033/final/final_genes_appended_renamed.pep.fasta

for File in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/Effector-P/P_aphanis_THeavenDRCT72020_1_EffectorP.txt); do
  Headers=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_headers.txt/g')
  cat $File | grep 'Effector' | cut -f1 > $Headers
  Secretome=$(ls gene_pred/final_genes_signalp-4.1/F.oxysporum_fsp_fragariae/DSA14_003/DSA14_003_final_sp_no_trans_mem.aa)
  OutFile=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted.aa/g')
  ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Feature_annotation
  $ProgDir/extract_from_fasta.py --fasta $Secretome --headers $Headers > $OutFile
  OutFileHeaders=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted_headers.txt/g')
  cat $OutFile | grep '>' | tr -d '>' > $OutFileHeaders
  cat $OutFileHeaders | wc -l
  Gff=$(ls gene_pred/codingquary/F.oxysporum_fsp_fragariae/DSA14_003/flye/final/final_genes_appended_renamed.gff3)
  EffectorP_Gff=$(echo "$File" | sed 's/_EffectorP.txt/_EffectorP_secreted.gff/g')
  $ProgDir/extract_gff_for_sigP_hits.pl $OutFileHeaders $Gff effectorP ID > $EffectorP_Gff
  cat $EffectorP_Gff | grep -w 'gene' | wc -l
done > tmp.txt
```
### Looking for transcription factors
```bash
conda activate predector2.7
  for Interpro in $(ls gene_pred/*/*/interproscan/NRI/*_interproscan.tsv); do
    Organism=$(echo $Interpro | rev | cut -f5 -d '/' | rev)
    Strain=$(echo $Interpro | rev | cut -f4 -d '/' | rev)
    echo "$Organism - $Strain"
    OutDir=gene_pred/$Organism/$Strain/transcription_factors
    mkdir -p $OutDir
    ProgDir=/home/theaven/scratch/apps/tools
    python2.7 $ProgDir/interpro2TFs.py --InterPro $Interpro > $OutDir/"$Strain"_TF_domains.tsv
    echo "$Organism - $Strain " >> TFreport.txt
    printf "total number of transcription factors: \t" >> TFreport.txt
    cat $OutDir/"$Strain"_TF_domains.tsv | cut -f1 | sort | uniq > $OutDir/"$Strain"_TF_gene_headers.txt
    cat $OutDir/"$Strain"_TF_gene_headers.txt | wc -l >> TFreport.txt 
    # Gene ID rather than transcript ID
    cat $OutDir/"$Strain"_TF_gene_headers.txt | sed -e "s/.t.*//g" > $OutDir/"$Strain"_TF_geneid_headers.txt
  done
conda deactivate
```
P_aphanis - THeavenDRCT72020_1
total number of transcription factors:  1162
P_aphanis - THeavenDRCT72021_1
total number of transcription factors:  1034
P_aphanis - THeavenSCOTT2020_1
total number of transcription factors:  1035
P_leucotricha - THeavenp11_1
total number of transcription factors:  996
P_leucotricha - THeavenpOGB2019_1
total number of transcription factors:  1018
P_leucotricha - THeavenpOGB2021_1
total number of transcription factors:  994

### Sectretome
Proteins with a predicted signal peptide and no predicted transmembrane domains were extracted.
```bash
conda activate predector2.7
for file in $(ls gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv); do
  Organism=$(echo $file|cut -f2 -d '/')
  Strain=$(echo $file|cut -f3 -d '/')
  echo "$Organism - $Strain"
  Proteome=$(ls /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
  Sequential_Proteome=$(dirname $Proteome)/${Strain}.pep.fasta
  Outfile=$(dirname $file)/${Strain}_secretome.tsv
  Outfile2=$(dirname $file)/${Strain}_secretome.pep.fasta
  rm $Outfile
  rm $Outfile2
  head -n 1 $file >> $Outfile
  awk '$25==1' $file |awk '$27==0' |awk '$28==0' >> $Outfile
#  perl -MBio::SeqIO -e 'my $seqin = Bio::SeqIO->new(-fh => \*STDIN, -format => 'fasta'); while (my $seq = $seqin->next_seq) { print ">",$seq->id,"\n",$seq->seq,"\n"; }' < $Proteome > $Sequential_Proteome
  cat $Outfile | cut -f1 | grep -A 1 -f - $Sequential_Proteome >> $Outfile2
done
conda  deactivate
```

### SSCP
Small cysteine rich proteins were identified within proteomes. These proteins may be identified by EffectorP, but this approach allows direct control over what constitutes a SSCP.

```bash
conda activate predector2.7
for Proteome in $(ls /home/theaven/scratch/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
Organism=$(echo $Proteome|cut -f6 -d '/')
Strain=$(echo $Proteome|cut -f7 -d '/')
echo "$Organism - $Strain"
OutDir=gene_pred/$Organism/$Strain/sscp
mkdir $OutDir
ProgDir=/home/theaven/scratch/apps/tools
python2.7 $ProgDir/sscp_filter.py --inp_fasta $Proteome --max_length 300 --threshold 3 --out_fasta $OutDir/"$Strain"_sscp_all_results.fa
cat $OutDir/"$Strain"_sscp_all_results.fa | grep 'Yes' > $OutDir/"$Strain"_sscp.fa
echo "$Organism - $Strain " >> sscpreport.txt
printf "number of SSC-rich genes:\t" >> sscpreport.txt
cat $OutDir/"$Strain"_sscp.fa | grep '>' | tr -d '>' | cut -f1 -d '.' | sort | uniq | wc -l >> sscpreport.txt
done
conda deactivate
```
P_aphanis - THeavenDRCT72020_1
number of SSC-rich genes:       739
P_aphanis - THeavenDRCT72021_1
number of SSC-rich genes:       695
P_aphanis - THeavenSCOTT2020_1
number of SSC-rich genes:       596
P_leucotricha - THeavenp11_1
number of SSC-rich genes:       1173
P_leucotricha - THeavenpOGB2019_1
number of SSC-rich genes:       1247
P_leucotricha - THeavenpOGB2021_1
number of SSC-rich genes:       1109

### CAZY proteins
Carbohydrte active enzymes were idnetified using CAZYfollowing recomendations at http://csbl.bmb.uga.edu/dbCAN/download/readme.txt :
```bash
conda activate cazy
for Proteome in $(ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
Organism=$(echo $Proteome|cut -f2 -d '/')
Strain=$(echo $Proteome|cut -f3 -d '/')
echo "$Organism - $Strain"
OutDir=gene_pred/$Organism/$Strain/cazy
mkdir $OutDir
Prefix="$Strain"_CAZY
CazyHmm=apps/tools/dbCAN/dbCAN/dbCAN-fam-HMMs.txt
ProgDir=/home/theaven/scratch/apps/tools
sbatch $ProgDir/hmm_scan.sh $CazyHmm $Proteome $Prefix $OutDir
done
#3054426-31
conda deactivate
```
The Hmm parser was used to filter hits by an E-value of E1x10-5 or E1x10-e3 if they had a hit over a length of X %.

Those proteins with a signal peptide were extracted from the list and gff files representing these proteins made.
```bash
for File in $(ls gene_pred/*/*/cazy/*CAZY.out.dm); do
Organism=$(echo $File|cut -f2 -d '/')
Strain=$(echo $File|cut -f3 -d '/')
echo "$Organism - $Strain"
OutDir=$(dirname $File)
ProgDir=/home/theaven/scratch/apps/tools/dbCAN/dbCAN
$ProgDir/hmmscan-parser.sh $OutDir/"$Strain"_CAZY.out.dm > $OutDir/"$Strain"_CAZY.out.dm.ps
CazyHeaders=$(echo $File | sed 's/.out.dm/_headers.txt/g')
rm $OutDir/"$Strain"_CAZY.out.dm.ps.f
awk '$5<0.00000000000000001' $OutDir/"$Strain"_CAZY.out.dm.ps |awk '$10>0.45' >> $OutDir/"$Strain"_CAZY.out.dm.ps.f #For fungi, use E-value < 1e-17 and coverage > 0.45
cat $OutDir/"$Strain"_CAZY.out.dm.ps.f | cut -f3 | sort | uniq > $CazyHeaders
echo $CazyHeaders
head $CazyHeaders
Gff=$(ls gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3)
CazyGff=${OutDir}/${Strain}_CAZY.gff
ProgDir=/home/theaven/scratch/apps/tools
$ProgDir/extract_gff_for_sigP_hits.pl $CazyHeaders $Gff CAZyme ID > $CazyGff
echo $CazyGff
head $CazyGff
SecretedProts=gene_pred/${Organism}/${Strain}/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta
SecretedHeaders=$(echo $SecretedProts | sed 's/.pep.fasta/_headers.txt/g')
cat $SecretedProts | grep '>' | tr -d '>' > $SecretedHeaders
CazyGffSecreted=$OutDir/${Strain}_CAZY_secreted.gff
$ProgDir/extract_gff_for_sigP_hits.pl $SecretedHeaders $CazyGff Secreted_CAZyme ID > $CazyGffSecreted
echo $CazyGffSecreted
head $CazyGffSecreted
cat $CazyGffSecreted | grep -w 'mRNA' | cut -f9 | tr -d 'ID=' | cut -f1 -d ';' > $OutDir/"$Strain"_CAZY_secreted_headers.txt

echo "$Organism - $Strain" >> cazyreport.txt
echo "number of CAZY proteins identified:" >> cazyreport.txt
cat $CazyHeaders | wc -l >> cazyreport.txt
echo "number of CAZY genes identified:" >> cazyreport.txt
cat $CazyGff | grep -w 'gene' | wc -l >> cazyreport.txt
echo "number of Secreted CAZY proteins identified:">> cazyreport.txt
cat $OutDir/"$Strain"_CAZY_secreted_headers.txt | wc -l >> cazyreport.txt
echo "number of Secreted CAZY genes identified:">> cazyreport.txt
cat $CazyGffSecreted | grep -w 'gene' | wc -l >> cazyreport.txt
done
```

P_aphanis - THeavenDRCT72020_1
number of CAZY proteins identified:
138
number of CAZY genes identified:
138
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58
P_aphanis - THeavenDRCT72021_1
number of CAZY proteins identified:
190
number of CAZY genes identified:
190
number of Secreted CAZY proteins identified:
89
number of Secreted CAZY genes identified:
89
P_aphanis - THeavenSCOTT2020_1
number of CAZY proteins identified:
139
number of CAZY genes identified:
139
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58
P_leucotricha - THeavenp11_1
number of CAZY proteins identified:
144
number of CAZY genes identified:
144
number of Secreted CAZY proteins identified:
57
number of Secreted CAZY genes identified:
57
P_leucotricha - THeavenpOGB2019_1
number of CAZY proteins identified:
170
number of CAZY genes identified:
170
number of Secreted CAZY proteins identified:
66
number of Secreted CAZY genes identified:
66
P_leucotricha - THeavenpOGB2021_1
number of CAZY proteins identified:
145
number of CAZY genes identified:
145
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58

```bash
conda activate predector2.7
for File in $(ls gene_pred/*/*/cazy/*_CAZY.out.dm.ps.f); do
Organism=$(echo $File|cut -f2 -d '/')
Strain=$(echo $File|cut -f3 -d '/')
echo "$Organism - $Strain"
OutDir=$(dirname $File)
Secreted=$(ls gene_pred/${Organism}/${Strain}/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome_headers.txt)
Gff=$(ls gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3)
ProgDir=/home/theaven/scratch/apps/tools/CAZY
python2.7 $ProgDir/summarise_CAZY.py --cazy $File --inp_secreted $Secreted --inp_gff $Gff --summarise_family --trim_gene_id 2 --kubicek_2014
done
conda deactivate
```
P_aphanis - THeavenDRCT72020_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

P_aphanis - THeavenDRCT72021_1
B-Galactosidases - 1
Polygalacturonase - 1
A-Arabinosidases - 2
Xylanases - 2
Polygalacturonate lyases - 2
A-Galactosidases - 1
B-Glycosidases - 1
Cellulases - 4
other - 75

P_aphanis - THeavenSCOTT2020_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

P_leucotricha - THeavenp11_1
A-Galactosidases - 1
Cellulases - 2
other - 53
Polygalacturonase - 1

P_leucotricha - THeavenpOGB2019_1
A-Galactosidases - 1
Cellulases - 2
other - 62
Polygalacturonase - 1

P_leucotricha - THeavenpOGB2021_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

### Secondary metabolites (Antismash and SMURF)
Antismash was run to identify clusters of secondary metabolite genes within the genome. Antismash was run using the webserver at: http://antismash.secondarymetabolites.org Results of web-annotation of gene clusters within the assembly were downloaded to the following directories:
```bash
/home/theaven/scratch/gene_pred/*/*/antismash/
```

SMURF was also run to identify secondary metabolite gene clusters.

Genes needed to be parsed into a specific tsv format prior to submission on the SMURF webserver.

```bash
conda activate predector2.7
for File in $(ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3); do
  Organism=$(echo $File|cut -f2 -d '/')
  Strain=$(echo $File|cut -f3 -d '/')
  echo "$Organism - $Strain"
  OutDir=gene_pred/$Organism/$Strain/smurf
  mkdir $OutDir
  ProgDir=/home/theaven/scratch/apps/tools/secondary_metabolites
  python2.7 $ProgDir/gff2smurf.py --gff $File > $OutDir/${Strain}_genes_smurf.tsv
  cp $OutDir/"$Strain"_genes_smurf.tsv .
done
conda deactivate
```
SMURF server shutdown?

## Orthology analysis

### Format fasta files
```bash
  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=All6_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Aphanis_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Leucotricha_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Besthost_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Bestspecies_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

Taxon_code=ST20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=ST21
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=RA20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP19
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP21
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
```
For all 6:
OrthoFinder assigned 102145 genes (96.4% of total) to 18296 orthogroups. Fifty percent of all genes were in orthogroups with 6 or more genes (G50 was 6) and were contained in the largest 5190 orthogroups (O50 was 5190). There were 7207 orthogroups with all species present and 4800 of these consisted entirely of single-copy genes.

For the 3 P.aphanis:
OrthoFinder assigned 46655 genes (95.0% of total) to 12465 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 4271 orthogroups (O50 was 4271). There were 8930 orthogroups with all species present and 6370 of these consisted entirely of single-copy genes.

For the 3 P.leucotricha:
OrthoFinder assigned 55528 genes (97.7% of total) to 16217 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 6625 orthogroups (O50 was 6625). There were 14129 orthogroups with all species present and 11463 of these consisted entirely of single-copy genes.

For the best aphanis and leucotricha assembly
OrthoFinder assigned 31680 genes (87.4% of total) to 9601 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 2854 orthogroups (O50 was 2854). There were 8142 orthogroups with all species present and 6069 of these consisted entirely of single-copy genes.

For the best genome from apple, strawberry and raspberry
OrthoFinder assigned 46194 genes (89.8% of total) to 11482 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 3951 orthogroups (O50 was 3951). There were 7504 orthogroups with all species present and 5537 of these consisted entirely of single-copy genes.

### Filter proteins into good an poor sets
```bash
for WorkDir in $(ls -d analysis/orthology/orthofinder/*); do
ProgDir=/home/heavet/git_repos/tools/gene_prediction
Input_dir=$WorkDir/formatted
Min_length=10
Max_percent_stops=20
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
$ProgDir/orthomclFilterFasta.pl $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file
done
```
### Orthofinder
```bash
scp -r /projects/nano_diagnostics/analysis/orthology theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/analysis/.
```
```bash
  ProjDir=/projects/nano_diagnostics
  cd $ProjDir

screen -S orthofinder
srun -p himem -J orthofinder --cpus-per-task=144 --pty bash
conda activate orthofinder2.7
for analysis in $(ls -d analysis/orthology/orthofinder/*); do
cd $analysis
orthofinder -f formatted -t 144 -a 10 2>&1 | tee -a orthofinder_report.txt
cd $ProjDir
done
conda deactivate


```
### Extracting fasta files for orthogroups
```bash
conda activate orthofinder2.7
for WorkDir in $(ls -d analysis/orthology/orthofinder/All6_isolates); do
ProgDir=/home/heavet/git_repos/tools/gene_prediction
OrthogroupsTxt=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta
OutDir=$WorkDir/orthogroups_fasta
mkdir -p $OutDir
python $ProgDir/orthoMCLgroups2fasta.py --orthogroups $OrthogroupsTxt --fasta $GoodProts --out_dir $OutDir
done
conda deactivate
```
#### Orthogroups only containing P. leucotricha genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/leucotricha_unique
Uniq_leucotricha_groups=$UniqDir/leucotricha_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -v -e 'RA20' | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -e 'AP19' | grep -e 'AP20' | grep -e 'AP21'> $Uniq_leucotricha_groups
echo "The number of orthogroups unique to podosphaera leucotricha are:"
cat $Uniq_leucotricha_groups | wc -l
echo "The following number genes from apple 2019 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP19' | wc -l
echo "The following number genes from apple 2020 2020 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP20' | wc -l
echo "The following number genes from apple 2021 2021 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP21' | wc -l
done
```
The number of orthogroups unique to podosphaera leucotricha are:
4478
The following number genes from apple 2019 are contained in these orthogorups:
5152
The following number genes from apple 2020 2020 are contained in these orthogorups:
5175
The following number genes from apple 2021 2021 are contained in these orthogorups:
5169

#### Orthogroups only containing P. aphanis genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/aphanis_unique
Uniq_aphanis_groups=$UniqDir/aphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'RA20' | grep -e 'ST20' | grep -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_aphanis_groups
echo "The number of orthogroups unique to podosphaera aphanis are:"
cat $Uniq_aphanis_groups | wc -l
echo "The following number genes from raspberry are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'RA20' | wc -l
echo "The following number genes from Strawberry 2020 are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'ST20' | wc -l
echo "The following number genes from strawberry 2021 are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'ST21' | wc -l
done
```
The number of orthogroups unique to podosphaera aphanis are:
1361
The following number genes from raspberry are contained in these orthogorups:
2067
The following number genes from Strawberry 2020 are contained in these orthogorups:
2058
The following number genes from strawberry 2021 are contained in these orthogorups:
1860

#### Orthogroups only containing P. aphanis strawberry genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/strawberryaphanis_unique
Uniq_strawberryaphanis_groups=$UniqDir/strawberryaphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -v -e 'RA20' | grep -e 'ST20' | grep -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_strawberryaphanis_groups
echo "The number of orthogroups unique to strawberry podosphaera aphanis are:"
cat $Uniq_strawberryaphanis_groups | wc -l
echo "The following number genes from Strawberry 2020 are contained in these orthogorups:"
cat $Uniq_strawberryaphanis_groups | grep -o -e 'ST20' | wc -l
echo "The following number genes from strawberry 2021 are contained in these orthogorups:"
cat $Uniq_strawberryaphanis_groups | grep -o -e 'ST21' | wc -l
done
```
The number of orthogroups unique to strawberry podosphaera aphanis are:
1399
The following number genes from Strawberry 2020 are contained in these orthogorups:
1582
The following number genes from strawberry 2021 are contained in these orthogorups:
1573

#### Orthogroups only containing P. aphanis raspberry genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/raspberryaphanis_unique
Uniq_raspberryaphanis_groups=$UniqDir/raspberryaphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'RA20' | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_raspberryaphanis_groups
echo "The number of orthogroups unique to raspberry podosphaera aphanis are:"
cat $Uniq_raspberryaphanis_groups | wc -l
echo "The following number genes from raspberry are contained in these orthogorups:"
cat $Uniq_raspberryaphanis_groups | grep -o -e 'RA20' | wc -l
done
```
The number of orthogroups unique to raspberry podosphaera aphanis are:
899
The following number genes from raspberry are contained in these orthogorups:
995





```bash
#Phyllactinia moricola (powdery mildews)
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/019/455/665/GCA_019455665.1_ASM1945566v1/GCA_019455665.1_ASM1945566v1_genomic.fna.gz 
#Pleochaeta shiraiana (powdery mildews) 
 https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/019/455/505/GCA_019455505.1_ASM1945550v1/GCA_019455505.1_ASM1945550v1_genomic.fna.gz 
#Leveillula taurica 
 ftp://ftp.ebi.ac.uk/pub/databases/ena/wgs/public/cad/CADEPA01.dat.gz
 https://www.ebi.ac.uk/ena/browser/view/CADEPA010000000
#Parauncinula polyspora

https://www.ebi.ac.uk/ena/browser/view/PRJEB29715?show=reads




```
```bash
conda activate repeatmasking
for Assembly in $(ls mildews/*f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/rep_modeling
    mkdir -p $OutDir
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir $ID
done
#19926-77
conda deactivate
conda activate transposonpsi
for Assembly in $(ls mildews/Podosphaeracerasii*.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/transposonPSI
    mkdir -p $OutDir
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir $ID
done
#19977-20033, 20042-20094,20114
conda deactivate

for Assembly in $(ls mildews/Podosphaeracerasii*.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
RepMaskGff=mildews/$ID/repeatmasking/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=mildews/$ID/repeatmasking/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
echo $ID"\n" >> mildews/repeatreport.txt
printf "The number of bases masked by RepeatMasker:\t" >> mildews/repeatreport.txt
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
printf "The number of bases masked by TransposonPSI:\t" >> mildews/repeatreport.txt
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
printf "The total number of masked bases are:\t" >> mildews/repeatreport.txt
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
done



screen -S transposonpsi
srun -p long  --mem-per-cpu=10G --cpus-per-task=4 --pty bash
conda activate transposonpsi
cd /projects/nano_diagnostics/mildews/Podosphaeracerasii_GCA_018398735/repeatmasking/transposonPSI

InFile=/projects/nano_diagnostics/mildews/Podosphaeracerasii_GCA_018398735.1_WSU_PS_Poc_1.0_genomic.1c.fna
Strain=Podosphaera_cerasii_GCA_018398735
echo ${Strain}

cp $InFile ${Strain}_contigs_unmasked.fa

# The full path is needed
/home/gomeza/miniconda3/envs/general_tools/share/transposonPSI/transposonPSI.pl ${Strain}_contigs_unmasked.fa nuc

./transposonPSI.pl ${Strain}_contigs_unmasked.fa nuc

mkdir -p $OutDir
cp -r $WorkDir/* $OutDir/.

rm -r $WorkDir


#!/usr/bin/env perl
use strict;
use FindBin;
use lib ("$FindBin::Bin/PerlLib");
use Fasta_reader;
use File::Basename;
use Cwd;

my $tempDir = "transposonPSI.$$.$hostname.tmp";
mkdir ($tempDir) or die "Error, cannot mkdir $tempDir"

scp -r Podosphaera_cerasii_GCA_018398735_contigs_unmasked.fa theaven@gruffalo.cropdiversity.ac.uk:projects/niab/theaven/scratch

/home/theaven/scratch/apps/tools/transposonPSI.pl ${Strain}_contigs_unmasked.fa nuc

find -name 'Fasta_Reader.pm' -print 2>/dev/null
```