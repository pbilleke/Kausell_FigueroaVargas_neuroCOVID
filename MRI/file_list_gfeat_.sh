# create file list for GFEAT 
declare -a List_pat=(
A_KD_21021997
AAAS_13071969
AAMV_27011994
AGBB_26121972
ASCS_31121976
BBMA_19041977
BCUV_02091982
C_DR_18111995
CACB_27091965
CACV_10101997
CAMO_08111988
CARM_14011974
CAWG_08021975
CDPQ_08041963
CDPR_25031986
CEBT_30091989
CECC_06081986
CEZM_26121994
CJGV_24021957
CMCO_17051975
CMLL_11051985
COGC_18022000
CRCM_04051980
D_OD_06071998
D_TB_12031991
DACA_13031990
DALR_20071983
DEYJ_15041983
DFCM_04071987
DJGC_05081982
EERV_01041955
EFHB_26121994
ELFN_09021961
FABN_19111984
FAPN_12111974
FFGV_27111965
FJAM_10012001
FRCA_12081956
GADM_08111983
GAQJ_21061987
GISV_16041998
GJBA_03051990
IABF_16091997
IABM_03061982
IASA_27071979
J_BF_06111999
JAPV_03111995
JAZV_27081991
JCZD_03071963
JDRP_06081956
JFFA_04101976 
JFSO_05061967
JGRF_24091991
JMRR_10111976
KECT_07071995
L_GM_04061960
LAAB_29101982
LDEV_31011988
LMRG_21041962
MAEM_17051957
MAPC_24021963
MCAG_07091991
MDMM_22111977
MDTR_16071990
MEPM_02121959
MFCM_21011984
MFSM_02021973
MGRN_22101979
MJCS_29091978
MJLV_09041981
MLAD_09021957
MLCB_11041981
MMST_26121997
MPMM_22111977
MTVV_27111974
MVMR_11091989
NDJA_20011972
NFLC_08021988
OAPC_01041962
PACD_27061966
PNPM_09071972
PNSF_04121988
R_PL_21091980
RABG_09091981
RALF_14041986
RAPA_19121977
RASG_07061964
REOO_10011989
RFCR_12111978
RSVT_17091955
SAAA_10051991
SAFN_03091963
SAJC_22021972
SAVS_23061979
SLEP_30121949
TICV_14072000
UENM_22121979
VAPH_11101985
YJLS_05101987
YVSH_02051983 #100
     )
		 
declare -a List_H=( # pacientes hospitalizados 
0
0
0
0
1
0
0
0
0
0
1
1
1
0
0
1
0
0
1
1
0
0
0
0
0
0
1
0
1
0
0
0
1
0
0
1
0
0
1
0
0
0
0
1
1
0
0
0
0
0
1
1
0
1
0
1
0
0
1
1
0
1
0
0
0
1
0
0
0
0
1
1
0
1
1
0
0
0
1
0
0
0
0
1
0
0
1
0
1
1
0
0
1
1
0
0
0
0
0
0)		 
		 
declare -a List_A=( # pacientes Anosmia
1
0
1
0
1
1
0
1
0
0
1
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
1
1
1
1
1
0
1
1
1
1
1
0
0
1
1
0
0
1
1
1
1
1
0
1
1
0
1
1
0
1
1
0
1
1
0
0
1
1
1
1
0
0
0
0
1
0
0
0
0
1
0
0
0
0
1
0
0
1
1
0
0
0
0
1
1
0
0
0
0
0
0
)	
	 
declare -a List_Edad=( # edad de los añciente para la priemra evaluacion 		 
-1.3448
0.8373
-1.1832
0.5948
0.2716
0.1907
-0.2134
-0.4558
1.1606
-1.3448
-0.6983
0.4332
0.5140
0.5948
-0.5366
-0.7791
-0.4558
-1.1024
1.8071
0.3524
-0.4558
-1.6681
-0.0517
-1.4256
-0.8599
-0.7791
-0.2134
-0.2134
-0.6175
-0.2134
1.9687
-1.1832
1.4838
-0.3750
0.5948
1.1606
-1.8297
1.8879
-0.2942
-0.6175
-1.4256
-1.1832
-1.4256
-0.2134
0.4332
-1.5873
-1.2640
-0.9407
1.2414
1.8879
0.2716
1.0797
-0.9407
0.2716
-1.1832
1.5646
-0.2134
-0.6983
1.4030
1.8071
1.4838
-0.9407
0.3524
-0.6983
1.7263
-0.3750
0.5140
0.0291
0.1099
-0.0517
1.8071
-0.1325
-1.3448
0.1907
0.4332
-1.4256
0.5948
-0.5366
1.4030
1.1606
0.6756
-0.2942
0.1099
-0.1325
-0.5366
0.1907
1.3222
-0.7791
0.1099
1.9687
-0.9407
1.4030
0.7565
0.0291
0.9181
-1.5873
0.0291
-0.4558
-0.6175
-0.2942
)	 

declare -a List_FC=( # meses desde el diagnistico z-score
3.6030
-0.2193
-1.4263
-1.2252
-0.6216
-1.2252
-1.4263
0.5854
-0.6216
-1.4263
0.5854
-0.0181
0.7866
-1.0240
1.1889
-0.0181
-0.6216
-1.2252
0.9878
-0.2193
-0.6216
1.3901
-1.4263
-0.6216
-0.8228
0.3842
0.9878
0.9878
0.3842
1.5913
-0.4205
1.1889
1.1889
1.5913
3.2007
0.5854
-1.0240
-0.6216
-0.2193
-0.8228
-0.8228
-0.2193
-0.8228
0.9878
0.1831
-0.0181
0.7866
0.9878
-0.2193
-0.4205
-0.0181
0.9878
0.3842
0.7866
-0.8228
0.7866
-0.8228
0.7866
1.1889
1.1889
-0.6216
0.1831
-1.4263
-0.6216
-0.6216
-0.4205
-0.2193
-1.0240
0.1831
-1.0240
0.9878
0.5854
0.1831
-1.4263
0.9878
-1.0240
-0.0181
0.5854
-0.0181
-1.0240
1.7925
-1.2252
-0.6216
1.1889
-0.8228
-0.6216
0.9878
-0.4205
-0.4205
1.1889
0.1831
-0.2193
1.1889
0.1831
-1.0240
-0.2193
-1.2252
-1.4263
-0.8228
-0.0181
)





declare -a List_CV=( # diagnistico de covid
1
1
1
1
1
1
1
1
1
0
1
1
0
0
1
1
0
0
1
1
1
1
1
0
1
0
0
0
1
1
1
1
1
1
0
1
1
1
1
1
0
1
1
1
1
1
1
1
1
1
1
1
1
1
0
1
1
1
1
1
0
1
1
0
0
1
1
1
1
0
1
1
0
1
1
0
1
0
1
0
0
0
0
1
1
1
1
1
1
1
1
0
1
1
0
0
1
1
0
1)

         MODEL= #MODEL_feed_PE_sinR #MODEL_feed_simple
		 MODELsR= #MODEL_feed_PE_sinR
		 DB=KINGSTON
		 GRUPO=DATA


		 arguments=($@)
		 index=0
		 na=${#arguments[@]}
		 while [ ${index} -lt ${na} ]; do
		 	AR=${arguments[index]}
		 	case ${AR} in
		 		--MODEL=*)
		 		MODEL=${AR/*=/""}
		 		;;
	 			--MODELsR=*)
	 			MODELsR=${AR/*=/""}
		
		 	esac
		 	index=$((index + 1))
		 done	


		 # delete .fsf in MODEL variable 
		 MODEL="$( echo "${MODEL}" | sed -e 's#'.fsf'##' )"
		 # delete .fsf in MODELsR variable 
		 MODELsR="$( echo "${MODELsR}" | sed -e 's#'.fsf'##' )"

         echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
		 echo 'MODEL='${MODEL}
         echo 'MODELsR='${MODELsR}
         echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
		 
		 
		 
		 
		 

		 DA=()
		 FI=()
		 index=0
		 
		 
		 
		 ## COPy reg
		 
		 for i in `seq 0 100`
		 do
         if [ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI ]; then 
		 #cd /Volumes/GoogleDrive-103235447575506129142/Mi\ unidad/DATA/PARTICIPANTES/${List_pat[$i]}/MRI/
		 cd /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/
		 args+=("$i")
		 T1s=(`ls ${List_pat[$i]}*T1.nii.gz`)
		 FI[i]=${T1s[0]}
		 DA[i]="$( echo "${FI[i]}" | sed -e 's#'${List_pat[$i]}_'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'T1.nii.gz'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'_'##' )"
		 #echo ${DA[i]}

		 if [ ! -z ${MODELsR} ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat ]; ## &&  
			#[ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODELsR}.feat/reg ]; 
		    then #
			 
		 
			 echo 'Coping reg '${List_pat[$i]}
			 
			 #rm -R "/Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/.feat"
			 
			 cp -pPR "/Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat/reg" "/Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODELsR}.feat/" 
			 
			 cp -pPR "/Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat/reg_standard" "/Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODELsR}.feat/" 			 
		 
	     fi
		 
		 
	     fi

		 done
		 
		 
		 
		 
		 
		 ## file list
		 index=0
		 echo '------------------------FILES LISTA--------------------------'
		 for i in `seq 0 100`
		 do

			 
         if [ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI ]; then 
		 #cd /Volumes/GoogleDrive-103235447575506129142/Mi\ unidad/DATA/PARTICIPANTES/${List_pat[$i]}/MRI/
		 cd /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/
		 args+=("$i")
		 T1s=(`ls ${List_pat[$i]}*T1.nii.gz`)
		 FI[i]=${T1s[0]}
		 DA[i]="$( echo "${FI[i]}" | sed -e 's#'${List_pat[$i]}_'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'T1.nii.gz'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'_'##' )"
		 #echo ${DA[i]}
		 
		 if [ -z ${MODELsR} ] && 
			[ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT ] || 
			[ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat ]; 
		    then
		    echo '#set feat_files('${index}') "/Volumes/'${DB}'/neuroCOVID/DATA/'${List_pat[$i]}'/MRI/'${DA[i]}'_pro/FEAT/'${MODEL}'.feat" # <<<<<<<<<<<<< SIN FEAT '
		 fi
		 
		 
		 if [ -z ${MODELsR} ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat ]; 
		    then
			 index=$((index + 1))
			 echo    'set feat_files('${index}') "/Volumes/'${DB}'/neuroCOVID/DATA/'${List_pat[$i]}'/MRI/'${DA[i]}'_pro/FEAT/'${MODEL}'.feat"'
			 if [ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat/reg ]; then 
				 echo '<<<<<<<<<<<<< SIN .REG '
			 fi
			 if [ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat/stats ]; then
				 echo '<<<<<<<<<<<<< SIN .STATS '
			 fi
		 fi
		 
		 if [ -z ${MODELsR} ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT ] && 
			[ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat ] && 
			[ ! -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat/stats ]; then
			 index=$((index + 1))
			 echo    'falta stats'${List_pat[$i]}
		 fi
		 
		 
	     fi

		 done
		 
		 
		 ## for EV1 mean
		 index=0
		 echo '------------------------EVs--------------------------'
		 for i in `seq 0 100`
		 do
         if [ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI ]; then 
		 #cd /Volumes/GoogleDrive-103235447575506129142/Mi\ unidad/DATA/PARTICIPANTES/${List_pat[$i]}/MRI/
		 cd /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/
		 args+=("$i")
		 T1s=(`ls ${List_pat[$i]}*T1.nii.gz`)
		 FI[i]=${T1s[0]}
		 DA[i]="$( echo "${FI[i]}" | sed -e 's#'${List_pat[$i]}_'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'T1.nii.gz'##' )"
		 DA[i]="$( echo "${DA[i]}" | sed -e 's#'_'##' )"
		 #echo ${DA[i]}
		 
		 if [ -z ${MODELsR} ] && [ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT ] && [ -d /Volumes/${DB}/neuroCOVID/DATA/${List_pat[$i]}/MRI/${DA[i]}_pro/FEAT/${MODEL}.feat ]; then
			 index=$((index + 1))
			 
			 echo    'set fmri(evg'${index}'.1) 1' 
			 echo    'set fmri(evg'${index}'.2) '${List_CV[$i]} 
			 echo    'set fmri(evg'${index}'.3) '${List_H[$i]} 
			 echo    'set fmri(evg'${index}'.4) '${List_A[$i]} 
			 echo    'set fmri(evg'${index}'.5) '${List_FC[$i]} 
			 echo    'set fmri(evg'${index}'.6) '${List_Edad[$i]} 
			 #set feat_files('${index}') "/Volumes/${DB}/neuroCOVID/DATA/'${List_pat[$i]}'/MRI/'${DA[i]}'_pro/FEAT/'${MODEL}'.feat"'
		 fi
		 
	     fi

		 done		 
		 
		 
		 
		 echo 'DONE'
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 