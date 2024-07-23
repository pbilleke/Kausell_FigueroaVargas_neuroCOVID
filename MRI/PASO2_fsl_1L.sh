#   Analisis proyecto neuroCOVID
#   V.1  -- 09.02.2022
#          
#   Pablo Billeke 
#   pbilleke@udd.cl
#
#   PASO 2 : fsf primer nivel, se requiere tener lo EV  ya hechos
#            en .../GRUPO/SUJETO/log/EV_xx
#            Usar LAN toolbox para MATLAB, el ejemplos de script esta en:
#            			.../log2EVS.m
#
#  sh PASO2_fsl_1L.sh --S=S_Fi_001	--T=FB  # [FB  Po PT]
#  sh PASO2_fsl_1L.sh --S=S_Fi_001	--ALL   # para las tres tareas
 
# Argumentos 
##--G=  
GRUPO=DATA

## --T=
TASK=RL

##--S= 
SUJETO=P_Fi_00x

## --DB=
DB=KINGSTON/neuroCOVID

## --BET=
BET=T1_brain.nii.gz

##--S_C   para ahcer el corregistro a la suoperficie segun archivo de freesurfer en la parte de sujeto $SUBJECTS_DIR
S_C=1

## --FEAT=1
FEAT=1

## --ifBET
doBET=0

##--SD=    // freesurfer substdir!!!
SUBJECTS_DIR=/Volumes/$DB/DATA/FreesurferSubject

##--ALL
ALL=0

arguments=($@)
index=0
na=${#arguments[@]}


while [ ${index} -lt ${na} ]; do
	AR=${arguments[index]}
	case ${AR} in
		--G=*)
		GRUPO=${AR/*=/""}
		;;
		--MODEL=*)
		MODEL=${AR/*=/""}
		;;
		--T=*)
		TASK=${AR/*=/""}
		;;		
		--S=*)
		SUJETO=${AR/*=/""}
		;;	
		--DB=*)
		DB=${AR/*=/""}
		;;	
		--BET=*)
		BET=${AR/*=/""}
		;;
		--doBET)
		doBET=1
		;;
		--DA=*)
		DA=${AR/*=/""}
		;;
		--FEAT=*)
		FEAT=${AR/*=/""}
		;;		
		--SD=*)
		SUBJECTS_DIR=${AR/*=/""}
		;;
		--ALL)
		ALL=1
		;;
	esac
	
	index=$((index + 1))
done

# MODEL
MODEL="$( echo "${MODEL}" | sed -e 's#'.fsf'##' )"

	

#mkdir  /Volumes/$DB/$GRUPO/$SUJETO/FEAT


## BRAIN EXTRACTION 
if [ ${doBET} -eq 1 ]; then
echo ' BET  '
/usr/local/fsl/bin/bet /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/T1 /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/T1_brain -B -f 0.45 -g 0
BET=T1_brain
echo ' BET .... done '
fi





if [ -z "${DAi}" ]; then
	  echo 'no DAi'
else
	## fMRI file 
	archivos=(`ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_t1_mprage_sag_p2_iso_*.nii.gz`)
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







## fMRI file 
archivos=(`ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_200X30_RS*.nii.gz`)
# avoid motion correct file form SCANER 
archivo=${archivos[0]}

cp   ${archivo}  /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_fMRI_RL.nii.gz
#rm `ls /Volumes/$DB/${GRUPO}/${SUJETO}/MRI/*_fMRI_DM*.nii.gz`
fMRI_FILE="/Volumes/$DB/${GRUPO}/${SUJETO}/MRI/${SUJETO}_${DA}_fMRI_RL.nii.gz"

BET="/Volumes/$DB/${GRUPO}/${SUJETO}/MRI/${DA}_pro/T1w/T1w_acpc_dc_restore_brain.nii.gz"
OUT="/Volumes/$DB/${GRUPO}/${SUJETO}/MRI/${DA}_pro/FEAT/${MODEL}"

if [ ${FEAT} -eq 1 ]; then

echo '' 
echo 'Sujeto  :        '$SUJETO
echo '        TASK     =      '${TASK}
echo '        FILE     =      '${fMRI_FILE}
echo '        MODEL     =      '${MODEL}
echo '        BET     =      '${BET}
echo '        OUT     =      '${OUT}
fslhd $fMRI_FILE > borrame

# MAC casa pablo
#TR="$( awk '/pixdim4        /{printf $2}' borrame )"
#NS="$( awk '/dim4           /{printf $2}' borrame )" 
#NS="$( echo "$NS" | sed -e 's#'$TR'##' )"

# MAC UDD 
TR="$( awk '/pixdim4/{printf $2}' borrame )"
NS="$( awk '/dim4/{printf $2}' borrame )" 
NS="$( echo "$NS" | sed -e 's#'$TR'##' )"

echo '        TR       =      '${TR}
echo '        Scanners =      '$NS
echo '' 

rm borrame

mkdir /Volumes/$DB/$GRUPO/$SUJETO/MRI/${DA}_pro/
mkdir /Volumes/$DB/$GRUPO/$SUJETO/MRI/${DA}_pro/FEAT/
rm -r -f /Volumes/$DB/$GRUPO/$SUJETO/MRI/${DA}_pro/FEAT/${MODEL}.feat

sed -e 's@GGGG@'$GRUPO'@g' \
	-e 's@DBDB@'$DB'@g' \
	-e 's@BETBET@'$BET'@g' \
	-e 's@TASKFILE@'$fMRI_FILE'@g' \
	-e 's@GGGG@'$GRUPO'@g'\
	-e 's@TRTRTR@'${TR}'@g' \
	-e 's@OUTOUT@'${OUT}'@g' \
	-e 's@NSNSNS@'${NS}'@g' \
	-e 's@MODELMODEL@'${MODEL}'@g' \
	-e 's@SSSS@'$SUJETO'@g' </Users/pablobilleke/Documents/GitHub/neuroCOVID/MRI/${MODEL}.fsf> /Volumes/$DB/$GRUPO/$SUJETO/MRI/${DA}_pro/FEAT/${MODEL}.fsf


feat /Volumes/$DB/$GRUPO/$SUJETO/MRI/${DA}_pro/FEAT/${MODEL}.fsf

echo '        feat TERMINADO '
echo '' 
fi


