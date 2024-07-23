#!/bin/bash 

#   Analisis proyecto FONDECYT neuroCOVID 
#   Pablo Billeke 
#   pbilleke@udd.cl
#
#   PASO 1 : hacer las superficies corticales con freesurfer 
#
#   sh PASO1_freesurfer.sh --S=IDsub --G=EVAL_1 --DA=20082021	
#
#   V.1.1 09062022 -- add check correct data of acquisition  


# Argumentos 
## --DB=
DB=DBNC_03/neuroCOVID


##--G=  
GRUPO=DATA

##--SD=  
#SUBJECTS_DIR=/Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/T1w/${SUJETO}
#/Volumes/$DB/DATA/FreesurferSubject

##--S= 
SUJETO=

DA=
DAi=
T1=
T2=

arguments=($@)
index=0
na=${#arguments[@]}



while [ ${index} -lt ${na} ]; do
	AR=${arguments[index]}
	case ${AR} in
		--G=*)
		GRUPO=${AR/*=/""}
		;;
		#--SD=*)
		#SUBJECTS_DIR=${AR/*=/""}
		#;;		
		--S=*)
		SUJETO=${AR/*=/""}
		;;	
		--DB=*)
		DB=${AR/*=/""}
		;;
		--DA=*)
		DA=${AR/*=/""}
		;;
		--DAi=*)
		DAi=${AR/*=/""}
		;;
		--T1=*)
		T1=${AR/*=/""}
		;;
		--T2=*)
		T2=${AR/*=/""}
		;;
	esac
	
	index=$((index + 1))
done

SUBJECTS_DIR=$DB/${GRUPO}/${SUJETO}/T1w/${SUJETO}


echo 'PROYECTO neuroCOVID
Subject ID		'$SUJETO'
Data of adquisition      '$DA'
Subject Freesurfer Directory		'$SUBJECTS_DIR'
	  
PASO1_HCP_freesurfer.sh  '$arguments'
	  
	  '  >  $DB/${GRUPO}/${SUJETO}/$SUJETO.txt


if [ -z "${DAi}" ]; then
	  echo 'no DAi'
else
	## fMRI file 
	if [ -z "${T1}" ]; then
	archivos=(`ls $DB/${GRUPO}/${SUJETO}/MRI/*_t1_mprage_sag_p2_iso_*.nii.gz`)	
	else
	archivos=(`ls $DB/${GRUPO}/${SUJETO}/MRI/${T1}`)	
	fi
	# avoid motion correct file form SCANER 
	archivo=${archivos[${DAi}]}	
 	DA1=${archivo:6:2}
 	DA2=${archivo:4:2}
 	DA3=${archivo:0:4}
	DA=${DA1}${DA2}${DA3}
	DAf=${DA3}${DA2}${DA1}
fi  

if [ ! -z "${DA}" ]; then
 	DA1=${archivo:0:2}
 	DA2=${archivo:2:2}
 	DA3=${archivo:4:4}
	DAf=${DA3}${DA2}${DA1}
fi


	  
field_maps=(`ls $DB/${GRUPO}/${SUJETO}/MRI/*${DAf}*field_map_*.nii.gz`)

field_map_M1=${field_maps[0]}  #`ls /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/*field_map_10.nii.gz`
field_map_M2=${field_maps[1]} #`ls /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/*field_map_10a.nii.gz`

fslmerge -t $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_field_map_Mag.nii.gz  ${field_map_M1}   ${field_map_M2}

cp ${field_maps[2]}   $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_field_map_F.nii.gz 





#rm `ls /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/*field_map_11.nii.gz`

#cp `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_DM*.nii.gz`  /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/fMRI_DM.nii.gz 
#rm `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_DM*.nii.gz`

#cp `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_PT*.nii.gz`  /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/fMRI_PT.nii.gz 
#rm `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_PT*.nii.gz`

if [ -z "${T1}" ]; then
	  echo 'looking for T1 files'
	  cp `ls $DB/${GRUPO}/${SUJETO}/MRI/*_t1_mprage_sag_p2_iso_*.nii.gz`  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T1.nii.gz 
	  cp `ls $DB/${GRUPO}/${SUJETO}/MRI/*_t1_mprage_sag_p2_iso_*.json`  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T1.json
	  #rm `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_t1_mprage_sag_p2_iso_*.nii.gz`
else
	   T1=$(echo "$T1"| sed 's/.nii.gz//g')
       echo "T1 file: ${T1}"
       cp $DB/${GRUPO}/${SUJETO}/MRI/${T1}.nii.gz  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T1.nii.gz 
       cp $DB/${GRUPO}/${SUJETO}/MRI/${T1}.json  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T1.json

fi



if [ -z "${T2}" ]; then
	  echo 'looking for T2 files'
cp `ls $DB/${GRUPO}/${SUJETO}/MRI/*_t2_spc_sag_p2_iso*.nii.gz`  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T2.nii.gz 
cp `ls $DB/${GRUPO}/${SUJETO}/MRI/*_t2_spc_sag_p2_iso*.json`  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T2.json
else
	   T2=$(echo "$T2"| sed 's/.nii.gz//g')
       echo "T2 file: ${T2}"
       cp $DB/${GRUPO}/${SUJETO}/MRI/${T2}.nii.gz  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T2.nii.gz 
       cp $DB/${GRUPO}/${SUJETO}/MRI/${T2}.json  $DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_T2.json

fi

###  Agregar los cambios de nobre de T1 y T2 

PreFreeSurferPipelineBatch.sh --Subjlist=$SUJETO --DA=${DA} --StudyFolder=$DB/${GRUPO}/

FreeSurferPipelineBatch.sh --Subjlist=$SUJETO --DA=${DA} --StudyFolder=$DB/${GRUPO}/

PostFreeSurferPipelineBatch.sh --Subjlist=$SUJETO --DA=${DA} --StudyFolder=$DB/${GRUPO}/

# sinmbin 


 


#headreco all --no-cat --noclean /Volumes/$DB/${GRUPO}/${SUJETO}/Simnibs/MESH /Volumes/$DB/${GRUPO}/${SUJETO}/T1w/T1w_acpc_dc_restore.nii.gz /Volumes/$DB/${GRUPO}/${SUJETO}/T1w/T2w_acpc_dc_restore.nii.gz
#mkdir /Volumes/'$DB/${GRUPO}/${SUJETO}'/Simnibs
#headreco all --no-cat --noclean /Volumes/'$DB/${GRUPO}/${SUJETO}'/Simnibs/MESH /Volumes/'$DB/${GRUPO}/${SUJETO}'/T1w/T1w_acpc_dc_restore.nii.gz /Volumes/'$DB/${GRUPO}/${SUJETO}'/T1w/T2w_acpc_dc_restore.nii.gz








#mkdir ${SUBJECTS_DIR}/${SUJETO}
#mkdir ${SUBJECTS_DIR}/${SUJETO}/mri
#mri_convert /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/T1.nii.gz   ${SUBJECTS_DIR}/${SUJETO}/mri/001.mgz

#recon-all -all -subjid ${SUJETO}

#mri_watershed -surf ${SUBJECTS_DIR}/${SUJETO}/bem/${SUJETO}  ${SUBJECTS_DIR}/${SUJETO}/mri/001.mgz /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/T1_brain.mgz

#mri_convert ${SUBJECTS_DIR}/${SUJETO}/mri/brain.mgz  /Volumes/$DB/DATA/FONDECYT_i2014/${GRUPO}/${SUJETO}/MRI/T1_brain_fs.nii.gz


echo '                                    '
echo '              \|/ ____ \|/          ' 
echo '               @~/ ,. \~@           '
echo '              /_( \__/ )_\          '
echo '                 \__U_/             '
echo '                                    '
echo '      neuroCICS                     '
echo '                                    '
echo '  Ufff ...  TERMINADO...            '
echo '                                    '
echo '  PASO1_neuroCOVID_.sh  '$@' '
echo '                                    '
echo '                                    '
echo '  Revisa que no haya errores antes de seguir'
echo '                                    '
echo '                                    '
echo '#########  ejecutar SIMNIBS en forma manual: ######                                    '
echo '                                    '
echo 'mkdir '$DB/${GRUPO}/${SUJETO}'/Simnibs'
echo 'cd '$DB/${GRUPO}/${SUJETO}'/Simnibs'
echo 'headreco all --no-cat --noclean MESH ../T1w/T1w_acpc_dc_restore.nii.gz ../T1w/T2w_acpc_dc_restore.nii.gz'
echo '                                    '
echo '##################################################'
