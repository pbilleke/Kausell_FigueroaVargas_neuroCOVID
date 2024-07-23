# a simple batch to extract five-layer- anatomy  using simnibs for headmodel for EEG-source recosntruction 

 
G=EVAL_1

for S in L_GM_04061960 #in MTVV_27111974 #JFSO_05061967 #CDPR_25031986  #MLAD_09021957 #JAPV_03111995  #GAQJ_21061987  #JAZV_27081991 # AGBB_26121972 UENM_22121979 #  31 32 33 34 35 36 37 38 39 40  # 21 22 23 24 25 26 27 28 29 30 # 11 12 13 14 15 16 17 18 19 20 # 01 02 03 04 05 06 07 08 09 10 
do 


cd /Volumes/DB_neuroCICS_02/datos_investigadores/neuroCOVID/${G}/${S}

mkdir Simnibs

cd Simnibs

headreco all --no-cat --noclean MESH ../T1w/T1w_acpc_dc_restore.nii.gz ../T1w/T2w_acpc_dc_restore.nii.gz

done



#G=EVAL_1
#S=MPMM_22111977

#wb_command -metric-merge /Volumes/DB_neuroCICS_02/datos_investigadores/neuroCOVID/${G}/${S}/MNINonLinear/Native/${S}.LR.MyelinMap_BC.native.func.gii -metric /Volumes/DB_neuroCICS_02/datos_investigadores/neuroCOVID/${G}/${S}/MNINonLinear/Native/${S}.L.MyelinMap_BC.native.func.gii -metric /Volumes/DB_neuroCICS_02/datos_investigadores/neuroCOVID/${G}/${S}/MNINonLinear/Native/${S}.R.MyelinMap_BC.native.func.gii 


