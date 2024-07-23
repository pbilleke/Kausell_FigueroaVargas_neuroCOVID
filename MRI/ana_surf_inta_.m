clear

%camino='/Volumes/DBNC_03/neuroCOVID/DATA/';

switch computer
    case ''
camino='/media/neurocics/KINGSTON/neuroCOVID/DATA/';
    case 'MACI64'
camino='/Volumes/KINGSTON/neuroCOVID/DATA/';
end


Sub={'sub-001'
... % 
'sub-100'
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

KOR = [6
6
5 % NA
5
5
3
5
6
5
5
4
5
5
5
5
6
6
5
6
6
5
6
6
6
5
5
5
5
5
3
5
5
2
5
5
6
6
5
6
5
6
6
5
4
5 % na
6
6
6
5
6
6
4
5
6
5
6
6
6
6
5
5
6
6
5
5
3
6
6
6
5
5
6
5
5
6
6
5
5
6
5
6
6
5
5
6
6
6
6
6
5
4
5
4
4
6
6
6
5
6
6]';


%%

FS='';FSK='164'
%fsaverage_LR32k
Sujetos_l_S=cell(1,numel(Sub));
Sujetos_r_S=cell(1,numel(Sub));
Sujetos_l_T=cell(1,numel(Sub));
Sujetos_r_T=cell(1,numel(Sub));
Sujetos_l_M=cell(1,numel(Sub));
Sujetos_r_M=cell(1,numel(Sub));
Sujetos_l_A=cell(1,numel(Sub));
Sujetos_r_A=cell(1,numel(Sub));

nodata= [];
for s=1:numel(Sub)
    % s =13
    DA = ls_lan([ camino  Sub{s} '/MRI/' Sub{s} '_*_T1.nii.gz'  ]);
    try
    DA = DA{1}(end-17:end-10);
    end
    if exist([ camino  Sub{s} '/MRI/' DA '_pro'  ],'dir')==7  && exist([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/fsaverage' FS  ],'dir')==7
        try
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.L.pial.' FSK 'k_fs_LR.surf.gii'  ]);
       % disp(E)
        Sujetos_l_S{s} = [ E(1:end-1)];
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.R.pial.' FSK 'k_fs_LR.surf.gii'  ]);
        Sujetos_r_S{s} = [ E(1:end-1)];
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.L.thickness.' FSK 'k_fs_LR.shape.gii' ]);
        Sujetos_l_T{s} = [ E(1:end-1)];
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.R.thickness.' FSK 'k_fs_LR.shape.gii' ]);
        Sujetos_r_T{s} = [ E(1:end-1)];
        
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.L.MyelinMap.' FSK 'k_fs_LR.func.gii' ]);
        Sujetos_l_M{s} = [ E(1:end-1)];
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.R.MyelinMap.' FSK 'k_fs_LR.func.gii' ]);
        Sujetos_r_M{s} = [ E(1:end-1)];

        %SLEP_30121949.R.ArealDistortion_FS.164k_fs_LR.shape.gii

        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.L.ArealDistortion_FS.' FSK 'k_fs_LR.shape.gii' ]);
        Sujetos_l_A{s} = [ E(1:end-1)];
        E =ls([ camino  Sub{s} '/MRI/' DA '_pro/MNINonLinear/' FS '*.R.ArealDistortion_FS.' FSK 'k_fs_LR.shape.gii' ]);
        Sujetos_r_A{s} = [ E(1:end-1)];

        catch
            disp(['falta ' Sub{s}  '- mn>' num2str(s)  ])
            nodata = [ nodata s]
        end
    elseif exist([ camino  Sub{s} '/MNINonLinear/' FS  ],'dir')==7
       try
       ls([ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.R.pial.' FSK 'k_fs_LR.surf.gii'  ])
        
        Sujetos_l_S{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.L.pial.' FSK 'k_fs_LR.surf.gii'  ];
        Sujetos_r_S{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.R.pial.' FSK 'k_fs_LR.surf.gii'  ];
        Sujetos_l_T{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.L.thickness.' FSK 'k_fs_LR.shape.gii'  ];
        Sujetos_r_T{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.R.thickness.' FSK 'k_fs_LR.shape.gii'  ];
        Sujetos_l_M{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.L.MyelinMap.' FSK 'k_fs_LR.func.gii'  ];
        Sujetos_r_M{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.R.MyelinMap.' FSK 'k_fs_LR.func.gii'  ];
        Sujetos_l_A{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.L.ArealDistortion_FS.' FSK 'k_fs_LR.shape.gii'  ];
        Sujetos_r_A{s} = [ camino  Sub{s} '/MNINonLinear/' FS  Sub{s} '.R.ArealDistortion_FS.' FSK 'k_fs_LR.shape.gii'  ];
       
       catch
        disp(['falta ' Sub{s}  '->' num2str(s)  ])
        nodata = [ nodata s];
       end


    else
        disp(['falta ' Sub{s}  '->' num2str(s)  ])
        nodata = [ nodata s];
    end

end



nocovid = find(COVID==0);

%nodata = unique([ nodata nocovid]);


Sujetos_l_S(nodata)=[];
Sujetos_r_S(nodata)=[];
Sujetos_l_T(nodata)=[];
Sujetos_r_T(nodata)=[];
Sujetos_l_M(nodata)=[];
Sujetos_r_M(nodata)=[];
Sujetos_l_A(nodata)=[];
Sujetos_r_A(nodata)=[];


Sf_b = [ Sujetos_l_S', Sujetos_r_S' ];
St_b = [ Sujetos_l_T', Sujetos_r_T' ];
Sm_b = [ Sujetos_l_M', Sujetos_r_M' ];
Sa_b = [ Sujetos_l_A', Sujetos_r_A' ];


%SurfStatView( SurfStatReadData(St_b), SurfStatReadSurf(Sf_b) , 'Cort Thick (mm), FreeSurfer data' );
%%
%avsurf = SurfStatAvSurf( Sf_b);
%SurfStatWriteSurf([ '/Volumes/KINGSTON/neuroCOVID/DATA/av100s' FSK '.obj' ], avsurf );
avsurf = SurfStatReadSurf([ '/Volumes/KINGSTON/neuroCOVID/DATA/av100s' FSK '.obj' ] );
%mask = SurfStatMaskCut( avsurf );
%SurfStatView( mask, avsurf, 'Masked average surface' );
%%


%mask = SurfStatMaskCut( s );

%maskb =  SurfStatROI( [0; -10; 5], 25, avsurf) == 0;
%SurfStatView( maskb, avsurf, 'Masked average surface -brainstem' );


Y=SurfStatReadData( St_b);
Ya=SurfStatReadData( Sa_b);
Ym=SurfStatReadData( Sm_b);
%

%Smooth
Ys = SurfStatSmooth(Y,avsurf,5);
Yms = SurfStatSmooth(Ym,avsurf,5);
Yas = SurfStatSmooth(Ya,avsurf,5);
%%
%meanthick = mean( ( Y ) );
%SurfStatView( meanthick, s , 'Mean thickness (mm), n=16' );

D = (ANOSMIA.*COVID)'
D(nodata)  = []
AN  = term(D, 'ANOSMIA');

D = COVID'
D(nodata)  = []
CV  = term(D, 'COVID');

D = (HOSPITAL.*COVID)'
D(nodata)  = []
HO  = term(D, 'HOSPITAL');

D = normal_z(TIEMPO)'
D(nodata)  = []
TI  = term(D, 'TIEMPO');

D = normal_z(EDAD)'
D(nodata)  = []
ED = term(D, 'EDAD');






M1= 1 + CV + AN + HO + TI + ED 
image(M1)

%
%

%C_PSU_H = C_PSU;
%C_PSU_H(SEXO.M==0) =0;
%% Grosor 
slm = SurfStatLinMod( Ys, M1, avsurf );
slm_anosmia = SurfStatT( slm,[0 0 -1  0  0 0 0 ]);

figure
SurfStatView( slm_anosmia.t, avsurf , 'T grosor (n=100) Anosmia' );

%
resels = SurfStatResels( slm_anosmia)

  
stat_threshold( resels, length(slm_anosmia.t), 1, slm_anosmia.df )
 

[ pval, peak, clus ] = SurfStatP(slm_anosmia,[],0.001);
realp = min(clus.P)  
unique(clus.P(clus.P<0.05)') 
realz = clus.nverts(clus.P==realp)
figure
SurfStatView( pval, avsurf , 'Anomia (CTD<0.001)' );


