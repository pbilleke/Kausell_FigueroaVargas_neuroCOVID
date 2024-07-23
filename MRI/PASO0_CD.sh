#!/bin/bash 

#   Analisis neuroCOVID
#       sacado del FONDECYT inicio 11140535
#
#
#   Pablo Billeke 
#   pbilleke@udd.cl
#
#   PASO 0: readout DICOM and tranform then to nii 
#           for MAc 0S with 
#                    - MRIcroGL
#                    - FSL 
#                    - freesurfer 
#                    - HCP
#
#  sh PASO0.sh  --S=subject_ID	
#  16 julio 2021




##--G=  
GRUPO=DATA
DA=
##--SD=  
##--S= 
SUJETO=001

DB=/Volumes/DBNC_03/neuroCOVID
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
	esac
	
	index=$((index + 1))
done

SUBJECTS_DIR=$DB/${GRUPO}/${SUJETO}/T1w/${SUJETO}
SUB_NAME=(`ls -d $DB/${GRUPO}/${SUJETO}/*_*_*`)

echo ' neuroCICS   :)
Subject ID		'$SUJETO'
Subject Freesurfer Directory		'$SUBJECTS_DIR'
Subject_Name   '$SUB_NAME'
	  
PASO=_CD.sh  '$arguments'
	  
	  '  >  $DB/${GRUPO}/${SUJETO}/$SUJETO.txt
	  
	  
	  
##  DICOM 2 niftti 
mkdir   $DB/${GRUPO}
mkdir   $DB/${GRUPO}/${SUJETO}
mkdir   $DB/${GRUPO}/${SUJETO}/MRI


DICOM=(`ls -d /Volumes/*/DICOM`)
echo ""
echo ""
echo ""
echo ""
echo "***************************######################################"
echo "***************************######################################"
echo "***************************######################################"
echo "***"
echo "***"
echo "***  REBIZA QUE EL DIRECTORIO SEA DEL DISCO CORRECTO !!!!"
echo "***       "
echo "***  DIR:     " $DICOM
echo "***"
echo "***"
echo "***************************######################################"
echo "***************************######################################"
echo "***************************######################################"
echo ""
echo ""
echo ""
echo ""
cp `ls /Volumes/*/README.TXT` $DB/${GRUPO}/${SUJETO}/${SUJETO}_data.txt

cp -r $DICOM  $DB/${GRUPO}/${SUJETO}/MRI

SUB_NAME=$DB/${GRUPO}/${SUJETO}/MRI
	  
/Applications/osx/MRIcroGL.app/Contents/MacOS/dcm2niix -z y -f "%t_%p_%s" "$DB/${GRUPO}/${SUJETO}/MRI"



sudo rm -R ${SUB_NAME}/DICOM



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
echo '  PASO=_CD.sh  '$@' '
echo '                                    '
echo '                                    '
echo '  Revisa que no haya errores antes de seguir'
echo '                                    '
echo '                                    '




