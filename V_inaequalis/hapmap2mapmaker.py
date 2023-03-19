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
