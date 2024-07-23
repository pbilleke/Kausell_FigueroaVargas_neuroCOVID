% create EV for fMRI analises 
clear
Sub={'A_KD_21021997'
'AAAS_13071969'
'AAMV_27011994'
'AGBB_26121972'
'ASCS_31121976'
'BBMA_19041977'
'BCUV_02091982'
'C_DR_18111995'
'CACB_27091965'
'CACV_10101997'
'CAMO_08111988'
'CARM_14011974'
'CAWG_08021975'
'CDPQ_08041963'
'CDPR_25031986'
'CEBT_30091989'
'CECC_06081986'
'CEZM_26121994'
'CJGV_24021957'
'CMCO_17051975'
'CMLL_11051985'
'COGC_18022000'
'CRCM_04051980'
'D_OD_06071998'
'D_TB_12031991'
'DACA_13031990'
'DALR_20071983'
'DEYJ_15041983'
'DFCM_04071987'
'DJGC_05081982'
'EERV_01041955'
'EFHB_26121994'
'ELFN_09021961'
'FABN_19111984'
'FAPN_12111974'
'FFGV_27111965'
'FJAM_10012001'
'FRCA_12081956'
'GADM_08111983'
'GAQJ_21061987'
'GISV_16041998'
'GJBA_03051990'
'IABF_16091997'
'IABM_03061982'
'IASA_27071979'
'J_BF_06111999'
'JAPV_03111995'
'JAZV_27081991'
'JCZD_03071963'
'JDRP_06081956'
'JFFA_04101976'
'JFSO_05061967'
'JGRF_24091991'
'JMRR_10111976'
'KECT_07071995'
'L_GM_04061960'
'LAAB_29101982'
'LDEV_31011988'
'LMRG_21041962'
'MAEM_17051957'
'MAPC_24021963'
'MCAG_07091991'
'MDMM_22111977'
'MDTR_16071990'
'MEPM_02121959'
'MFCM_21011984'
'MFSM_02021973'
'MGRN_22101979'
'MJCS_29091978'
'MJLV_09041981'
'MLAD_09021957'
'MLCB_11041981'
'MMST_26121997'
'MPMM_22111977'
'MTVV_27111974'
'MVMR_11091989'
'NDJA_20011972'
'NFLC_08021988'
'OAPC_01041962'
'PACD_27061966'
'PNPM_09071972'
'PNSF_04121988'
'R_PL_21091980'
'RABG_09091981'
'RALF_14041986'
'RAPA_19121977'
'RASG_07061964'
'REOO_10011989'
'RFCR_12111978'
'RSVT_17091955'
'SAAA_10051991'
'SAFN_03091963'
'SAJC_22021972'
'SAVS_23061979'
'SLEP_30121949'
'TICV_14072000'
'UENM_22121979'
'VAPH_11101985'
'YJLS_05101987'
'YVSH_02051983'
}';


COVID=[1
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
1]';

ANOSMIA=[1
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
    1
    1
    0
    0
    0
    0
    0
    0]';
    
    HOSPITAL=[0
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
    0]';
    
    TIEMPO=[26
    7
    1
    2
    5
    2
    1
    11
    5
    1
    11
    8
    12
    3
    14
    8
    5
    2
    13
    7
    5
    15
    1
    5
    4
    10
    13
    13
    10
    16
    6
    14
    14
    16
    24
    11
    3
    5
    7
    4
    4
    7
    4
    13
    9
    8
    12
    13
    7
    6
    8
    13
    10
    12
    4
    12
    4
    12
    14
    14
    5
    9
    1
    5
    5
    6
    7
    3
    9
    3
    13
    11
    9
    1
    13
    3
    8
    11
    8
    3
    17
    2
    5
    14
    4
    5
    13
    6
    6
    14
    9
    7
    14
    9
    3
    7
    2
    1
    4
    8]';
    
    
    EDAD = [25
    52
    27
    49
    45
    44
    39
    36
    56
    25
    33
    47
    48
    49
    35
    32
    36
    28
    64
    46
    36
    21
    41
    24
    31
    32
    39
    39
    34
    39
    66
    27
    60
    37
    49
    56
    19
    65
    38
    34
    24
    27
    24
    39
    47
    22
    26
    30
    57
    65
    45
    55
    30
    45
    27
    61
    39
    33
    59
    64
    60
    30
    46
    33
    63
    37
    48
    42
    43
    41
    64
    40
    25
    44
    47
    24
    49
    35
    59
    56
    50
    38
    43
    40
    35
    44
    58
    32
    43
    66
    30
    59
    51
    42
    53
    22
    42
    36
    34
    38]';
    %
    %%
    no_indx = false(size(Sub));  
    for excluded = {'JAPV_03111995'  , 'JCZD_03071963','MLAD_09021957' ,'NDJA_20011972'};
    
        paso = ifcellis(Sub,  excluded{1})  ; 
        no_indx = no_indx + paso;
    
    end
    no_indx= logical(no_indx);
    
    
    Sub([no_indx])=[];
    
    %%
    % Sub([no_indx | ~COVID])=[];
      ANOSMIA([no_indx ]) = [];
      COVID([no_indx ]) = [];
      HOSPITAL([no_indx ]) = [];
      TIEMPO([no_indx ]) = [];
      EDAD([no_indx ]) = [];
    % 
    
    
    % Sub = Sub(43:end)
    ifjags=true;
    pc = computer;
    switch pc
        case 'MACI64'
    
        RUTA='/Volumes/KINGSTON/neuroCOVID/DATA';
        GIT='/Users/pablobilleke/Documents/GitHub/neuroCOVID/MRI'
        case ''
        RUTA='/media/neurocics/KINGSTON/neuroCOVID/DATA';
        GIT='/home/neurocics/Documents/GitHub/neuroCOVID/MRI'
    end
%%
ns=1;
no=[];
nr=0;
for iSUB = Sub
nr=nr+1;
PAT=iSUB{1}; % PAT='JFFA_04101976'

if exist( [ RUTA '/' PAT '/LOG/jags_stat.mat'],'file')>0
    disp([ 'listo ' PAT ] )
    load([ RUTA '/' PAT '/LOG/jags_stat.mat'])
    alls(ns) = samples;
    H(ns) = HOSPITAL(nr);
    A(ns) = ANOSMIA(nr);
    E(ns) = EDAD(nr);
    Ti(ns) = TIEMPO(nr);
    Co(ns) = COVID(nr);
    nnr(ns) = nr;
    ns=ns+1;
end
if exist( [ RUTA '/' PAT '/LOG/jags_stat2.mat'],'file')>0
    disp([ 'listo ' PAT ] )
    load([ RUTA '/' PAT '/LOG/jags_stat2.mat'])
    alls(ns) = samples  ;
    H(ns) = HOSPITAL(nr);
    A(ns) = ANOSMIA(nr);
    E(ns) = EDAD(nr);
    Ti(ns) = TIEMPO(nr);
    Co(ns) = COVID(nr);
    nnr(ns) = nr;
    ns=ns+1;
end
end

%%

for ns =  1:188

alpha_a (ns) = mean(alls(ns).alpha_a(:));
alpha_r (ns) = mean(alls(ns).alpha_r(:));

end



alpha_r = alpha_r./(alpha_a+alpha_r);
%alpha_r = alpha_a;
alpha_r = (alpha_r-mean(alpha_r))/std((alpha_r));
alpha_a = (alpha_a-mean(alpha_a))/std((alpha_a));

[a1 ] = fitglm([ Co' A'  H' E' Ti' ], alpha_r') % 


for ns = 1:96
alpha_a9(ns) = mean(alpha_a(nnr==ns));
alpha_r9(ns) = mean(alpha_r(nnr==ns));
end

alpha_r9 = alpha_r9./(alpha_a9+alpha_r9);
%alpha_r = alpha_a;
alpha_r9 = (alpha_r9-mean(alpha_r9))/std((alpha_r9));
alpha_a9 = (alpha_a9-mean(alpha_a9))/std((alpha_a9));

[a1 ] = fitglm([ COVID' ANOSMIA'  HOSPITAL' EDAD' TIEMPO' ], alpha_r9') % 

