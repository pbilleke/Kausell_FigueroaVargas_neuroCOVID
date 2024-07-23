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
% ANOSMIA([no_indx | ~COVID]) = [];
% %COVID([no_indx | ~COVID]) = [];
% HOSPITAL([no_indx | ~COVID]) = [];
% TIEMPO([no_indx | ~COVID]) = [];
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
ns=0;
no=[];
for iSUB = Sub
ns=ns+1;
PAT=iSUB{1}; % PAT='JFFA_04101976'

if exist( [ RUTA '/' PAT '/LOG/jags_stat2.mat'],'file')>0
    disp([ 'listo ' PAT ] )
    %load([ RUTA '/' PAT '/LOG/jags_stat2.mat'])
    %alls2(ns) = samples  ;
    %clear samples 
    continue
end



disp([ '>>>>>>>>>>>   ' PAT '   <<<<<<<<<<<<' ] )
%% Read out option form  .txt file 
FILE_txt =ls_lan([ RUTA '/' PAT '/LOG/*behav*_output_RvL_file.txt']);
if isempty(FILE_txt)
    disp(['no hay BEHAVE para ' PAT])
    no = [no ns];
    continue
end



clear RT 


Tabla =readtable(FILE_txt{1},...
    'Delimiter','\t','ReadVariableNames',true);

RT.est = repelem(Tabla.nt',3);
RT.OTHER.nt(1:numel(RT.est)) = repelem(Tabla.nt',3);
RT.OTHER.buena(1:numel(RT.est)) = repelem(Tabla.buena',3);
RT.OTHER.Bd1(1:numel(RT.est)) = repelem(Tabla.Bd1',3);
RT.OTHER.Bd2(1:numel(RT.est)) = repelem(Tabla.Bd2',3);
RT.OTHER.Resp(1:numel(RT.est)) = repelem(Tabla.Resp',3);
RT.OTHER.F(1:numel(RT.est)) = repelem(Tabla.F',3);
RT.OTHER.prob(1:numel(RT.est)) = repelem(Tabla.prob',3);
RT.OTHER.ttp(1:numel(RT.est)) = repelem(Tabla.ttp',3);
RT.OTHER.ttr(1:numel(RT.est)) = repelem(Tabla.ttr',3);
RT.OTHER.ttF(1:numel(RT.est)) = repelem(Tabla.ttF',3);

%% fix proble in early version of RL.sce

if (sum(RT.est==30)+sum(RT.est==31))==0
    estF =RT.OTHER.F;
    estF(estF==1)=31;estF(estF==0)=30;
    RT.est(3:3:end) = estF(3:3:end); 
    
end

%% fitted a simple Reward lera ning for estract Predicition error and learning signal
%  using JAGS 
if ifjags
nchains  = 3; % How Many Chains?
nburnin  = 50000; % How Many Burn-in Samples?
nsamples = 1000;  % How Many Recorded Samples?


firts = find(([1 diff(Tabla.prob)'] ~= 0 )|([1 diff(Tabla.buena)'] ~= 0 ));
firstT=zeros(size(Tabla.nt));
firstT(firts(1:2:end))=1;

% Create a single structure that has the data for all observed JAGS nodes
DJ.nT = numel(Tabla.nt);
DJ.feedback = Tabla.F;
DJ.y = single(Tabla.Resp==1);
DJ.Bd1 = Tabla.Bd1;
DJ.Bd2 = Tabla.Bd2;
DJ.firstT = firstT;

% Set initial values for latent variable in each chain
init0=[];
init0(1).beta0=0;init0(2).beta0=-1;init0(3).beta0=1;
init0(1).beta1=0;init0(2).beta1=1;init0(3).beta1=1; 
init0(1).alpha_r=0.5;init0(2).alpha_r=0.7;init0(3).alpha_r=0.5; 
init0(1).alpha_a=0.2;init0(2).alpha_a=0.4;init0(3).alpha_a=0.3;
init0(1).rew=0.2;init0(2).rew=1;init0(3).rew=0.5;
init0(1).gamma=0.2;init0(2).gamma=1;init0(3).gamma=0.5;

% fitting
%  U[i] <- V.1[i]  * Pi.1[i]  - V.2[i] * Pi.2[i]
tic
cd(GIT)
doparallel = 0;
fprintf( 'Running JAGS\n' );
[samples, stats ] = matjags( ...
        DJ, ...
        fullfile(GIT, 'model_rL_learn_1a.txt'), ...
        init0, ...
        'doparallel' , doparallel, ...
        'nchains', nchains,...
        'nburnin', nburnin,...
        'nsamples', nsamples, ...
        'thin', 50, ...
        'monitorparams', {'beta0','beta1','alpha_r','alpha_a','rew','gamma','delta_a','delta_r','U','V.1','Pi.1','V.2','Pi.2'  }, ...
        'savejagsoutput' , 0 , ...
        'verbosity' , 1 , ...
        'cleanup' , 0  );
toc

%   %%
% % |samples.theta| contains a matrix of samples where each row corresponds to the samples from a single MCMC chain
% figure(1);clf;hold on;
% eps=.01;bins=[eps:eps:1-eps];
% count=hist(samples.alpha_r,bins);
% count=count/sum(count)/eps;
% ph=plot(bins,count,'k-');
% set(gca,'box','on','fontsize',14);
% xlabel('Rate','fontsize',16);
% ylabel('Posterior Density','fontsize',16);
% 
% %% Analyze summary statistics
% % |stats.mean| and |stats.std| contain the mean and standard deviation of the posterior distribution for each latent variable that 
% % was monitored. For example, we can read out the mean and std of theta:
% stats.mean.theta
% stats.std.theta
% 
% %% Analyze the Rhat value
% stats.Rhat.beta0
delta_a=[];delta_r=[];
delta_a(1:3000,1:size(samples.delta_a,3)) = reshape(samples.delta_a, [ 3000 size(samples.delta_a,3)]); 
delta_a= median(delta_a);
delta_r(1:3000,1:size(samples.delta_r,3)) = reshape(samples.delta_r, [ 3000 size(samples.delta_r,3)]); 
delta_r= median(delta_r);

alpha_a=[];alpha_r=[];
alpha_a(1:3000,size(samples.alpha_a,3)) = reshape(samples.alpha_a, [ 3000 size(samples.alpha_a,3)]); 
alpha_a= median(alpha_a);
alpha_r(1:3000,1:size(samples.alpha_r,3)) = reshape(samples.alpha_r, [ 3000 size(samples.alpha_r,3)]); 
alpha_r= median(alpha_r);


RT.OTHER.LearningSignal = (delta_a(2:end).*Tabla.F')+(delta_r(2:end).*(1-Tabla.F'));
RT.OTHER.LearningSignal_dm = [0 RT.OTHER.LearningSignal(1:end-1)];
RT.OTHER.LearningSignal_dm_c = [0 RT.OTHER.LearningSignal(1:end-1)].* (-1*(Tabla.Resp==2)' + 1*(Tabla.Resp==1)');

RT.OTHER.LearningSignal = repelem(RT.OTHER.LearningSignal,3);
RT.OTHER.LearningSignal_dm = abs(repelem(RT.OTHER.LearningSignal_dm,3));
RT.OTHER.LearningSignal_dm_c = repelem(RT.OTHER.LearningSignal_dm_c,3);

try
RT.OTHER.PredictionError= (delta_a(2:end).*Tabla.F'/alpha_a)+(delta_r(2:end).*(1-Tabla.F')/alpha_r);
RT.OTHER.PredictionError = repelem(RT.OTHER.PredictionError,3);
RT.OTHER.PredictionError = RT.OTHER.PredictionError .* (-1*(RT.OTHER.Resp==2) + 1*(RT.OTHER.Resp==1));
end

%plot(squeeze(median(median(samples.U,2),1)))

U = [];
U(1:3000,1:size(samples.U,3)) = reshape(samples.U, [ 3000 size(samples.U,3)]); 
U = median(U);



RT.OTHER.Utility_c = U .* (-1*(Tabla.Resp==2)' + 1*(Tabla.Resp==1)');
RT.OTHER.Utility_c = repelem(RT.OTHER.Utility_c,3);

RT.OTHER.Utility_c  = normal_z(RT.OTHER.Utility_c);
RT.OTHER.Utility_c(RT.OTHER.Utility_c<-3)=-3;
RT.OTHER.Utility_c(RT.OTHER.Utility_c>3)=3;

% RT.OTHER.V1 = repelem( stats.mean.V_1 , 3);
% RT.OTHER.V2 = repelem( stats.mean.V_2 , 3);
% RT.OTHER.Vc = (RT.OTHER.V1-RT.OTHER.V2) .* (-1*(RT.OTHER.Resp==2) + 1*(RT.OTHER.Resp==1));
% RT.OTHER.Pi1 = repelem( stats.mean.Pi_1 , 3);
% RT.OTHER.Pi2 = repelem( stats.mean.Pi_2 , 3);
% RT.OTHER.Pic = (RT.OTHER.Pi1-RT.OTHER.Pi2) .* (-1*(RT.OTHER.Resp==2) + 1*(RT.OTHER.Resp==1));

%% 

save([ RUTA '/' PAT '/LOG/jags_stat2.mat'],'RT','stats','samples','U' )
end
end


