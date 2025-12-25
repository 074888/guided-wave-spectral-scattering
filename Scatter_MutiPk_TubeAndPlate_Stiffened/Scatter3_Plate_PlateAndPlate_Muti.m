clear;
close all;
tic
%% ----------------
[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;

% --------------*===============*        
%---------------*===============*           
%-------1Plate--*     2Plate    *     Single Layer   
%---------------*===============*      
%---------------*===============*  
%--------------- ===============*    
%--------------- ===============*         
%---------------        3Plate  *     Single layer
%--------------- ===============*
%----------------===============*
%% Set Global Parameter 
%Frequency_Input=0.7e6;
%% -----------------0.9e6:0.05e6:2.5e6;
Frequency_Loop=0.5e6:0.5e6:0.5e6;

N=30;
Cons=0;
PkPhiy=0;


MaxLayers=100;
Count=1;
%% Muti Para1
Layers_1={Me4,Me4,Me4,Me4};                                                          %LayerMaterials
Ang_1=[0,0,0,0];                                                                    %Layers Angle
H_1=[0.0005,0.0005,0.0005,0.0005];

Line_M_1=length(H_1);
GetPart_M_1=0.25;
%% Muti Para2
Layers_2={Me4,Me4};
Ang_2=[0,0];  
H_2=[0.0005,0.0005];

Line_M_2=length(H_2);
GetPart_M_2=0.25;
%% Muti Para3
Layers_3={Me4,Me4};
Ang_3=[0,0];  
H_3=[0.0005,0.0005];

Line_M_3=length(H_3);
GetPart_M_3=0.25;
%% （4）TogeLayers Fir To End
TogeLayers_U=[1,2];

TogeLayers_D=[max(TogeLayers_U)+1,Line_M_1];
% ------------------------------
for Frequency_Input=Frequency_Loop
%% Get MutiLayers ①
[Ki_Fp_1,Ki_Bp_1,Ki_Fc_1,Ki_Bc_1,Vis_Fp_U_1,Vis_Fp_V_1,Vis_Fp_W_1,Vis_Bp_U_1,Vis_Bp_V_1,Vis_Bp_W_1,Vis_Bc_U_1,Vis_Bc_V_1,Vis_Bc_W_1,Vis_Fc_U_1,Vis_Fc_V_1,Vis_Fc_W_1...
    ,Force_Bp_xx_1,Force_Bp_yy_1,Force_Bp_zz_1,Force_Bp_yz_1,Force_Bp_xz_1,Force_Bp_xy_1...
    ,Force_Fp_xx_1,Force_Fp_yy_1,Force_Fp_zz_1,Force_Fp_yz_1,Force_Fp_xz_1,Force_Fp_xy_1...
    ,Force_Fc_xx_1,Force_Fc_yy_1,Force_Fc_zz_1,Force_Fc_yz_1,Force_Fc_xz_1,Force_Fc_xy_1...
    ,Force_Bc_xx_1,Force_Bc_yy_1,Force_Bc_zz_1,Force_Bc_yz_1,Force_Bc_xz_1,Force_Bc_xy_1]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layers_1,Ang_1,PkPhiy,H_1,GetPart_M_1);
%% Get SingleLayers ②
[Ki_Fp_2,Ki_Bp_2,Ki_Fc_2,Ki_Bc_2,Vis_Fp_U_2,Vis_Fp_V_2,Vis_Fp_W_2,Vis_Bp_U_2,Vis_Bp_V_2,Vis_Bp_W_2,Vis_Bc_U_2,Vis_Bc_V_2,Vis_Bc_W_2,Vis_Fc_U_2,Vis_Fc_V_2,Vis_Fc_W_2...
    ,Force_Bp_xx_2,Force_Bp_yy_2,Force_Bp_zz_2,Force_Bp_yz_2,Force_Bp_xz_2,Force_Bp_xy_2...
    ,Force_Fp_xx_2,Force_Fp_yy_2,Force_Fp_zz_2,Force_Fp_yz_2,Force_Fp_xz_2,Force_Fp_xy_2...
    ,Force_Fc_xx_2,Force_Fc_yy_2,Force_Fc_zz_2,Force_Fc_yz_2,Force_Fc_xz_2,Force_Fc_xy_2...
    ,Force_Bc_xx_2,Force_Bc_yy_2,Force_Bc_zz_2,Force_Bc_yz_2,Force_Bc_xz_2,Force_Bc_xy_2]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layers_2,Ang_2,PkPhiy,H_2,GetPart_M_2);
%% Get SingleLayers ③
[Ki_Fp_3,Ki_Bp_3,Ki_Fc_3,Ki_Bc_3,Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3...
    ,Force_Bp_xx_3,Force_Bp_yy_3,Force_Bp_zz_3,Force_Bp_yz_3,Force_Bp_xz_3,Force_Bp_xy_3...
    ,Force_Fp_xx_3,Force_Fp_yy_3,Force_Fp_zz_3,Force_Fp_yz_3,Force_Fp_xz_3,Force_Fp_xy_3...
    ,Force_Fc_xx_3,Force_Fc_yy_3,Force_Fc_zz_3,Force_Fc_yz_3,Force_Fc_xz_3,Force_Fc_xy_3...
    ,Force_Bc_xx_3,Force_Bc_yy_3,Force_Bc_zz_3,Force_Bc_yz_3,Force_Bc_xz_3,Force_Bc_xy_3]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layers_3,Ang_3,PkPhiy,H_3,GetPart_M_3);
%% GetAll Ori-Acoustic Field
%Normalizations-JAll:MutiLayers-1
[J1,JAll_Fp_1]=Normalize_M(Line_M_1,N,H_1,Vis_Fp_U_1,Vis_Fp_V_1,Vis_Fp_W_1,Force_Fp_xx_1,Force_Fp_xy_1,Force_Fp_xz_1);
[J2,JAll_Bp_1]=Normalize_M(Line_M_1,N,H_1,Vis_Bp_U_1,Vis_Bp_V_1,Vis_Bp_W_1,Force_Bp_xx_1,Force_Bp_xy_1,Force_Bp_xz_1);

[J3,JAll_Fc_1]=Normalize_M(Line_M_1,N,H_1,Vis_Fc_U_1,Vis_Fc_V_1,Vis_Fc_W_1,Force_Fc_xx_1,Force_Fc_xy_1,Force_Fc_xz_1);
[J4,JAll_Bc_1]=Normalize_M(Line_M_1,N,H_1,Vis_Bc_U_1,Vis_Bc_V_1,Vis_Bc_W_1,Force_Bc_xx_1,Force_Bc_xy_1,Force_Bc_xz_1);

%----------------------------------------------------------------------------------------------------------------
[J5,JAll_Fp_2]=Normalize_M(Line_M_2,N,H_2,Vis_Fp_U_2,Vis_Fp_V_2,Vis_Fp_W_2,Force_Fp_xx_2,Force_Fp_xy_2,Force_Fp_xz_2);
[J6,JAll_Bp_2]=Normalize_M(Line_M_2,N,H_2,Vis_Bp_U_2,Vis_Bp_V_2,Vis_Bp_W_2,Force_Bp_xx_2,Force_Bp_xy_2,Force_Bp_xz_2);

[J7,JAll_Fc_2]=Normalize_M(Line_M_2,N,H_2,Vis_Fc_U_2,Vis_Fc_V_2,Vis_Fc_W_2,Force_Fc_xx_2,Force_Fc_xy_2,Force_Fc_xz_2);
[J8,JAll_Bc_2]=Normalize_M(Line_M_2,N,H_2,Vis_Bc_U_2,Vis_Bc_V_2,Vis_Bc_W_2,Force_Bc_xx_2,Force_Bc_xy_2,Force_Bc_xz_2);

%----------------------------------------------------------------------------------------------------------------
[J9 ,JAll_Fp_3]=Normalize_M(Line_M_3,N,H_3,Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Force_Fp_xx_3,Force_Fp_xy_3,Force_Fp_xz_3);
[J10,JAll_Bp_3]=Normalize_M(Line_M_3,N,H_3,Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Force_Bp_xx_3,Force_Bp_xy_3,Force_Bp_xz_3);

[J11,JAll_Fc_3]=Normalize_M(Line_M_3,N,H_3,Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3,Force_Fc_xx_3,Force_Fc_xy_3,Force_Fc_xz_3);
[J12,JAll_Bc_3]=Normalize_M(Line_M_3,N,H_3,Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Force_Bc_xx_3,Force_Bc_xy_3,Force_Bc_xz_3);
%% Nomalize Acoustic Field-ByJAll-[M-S]
%1;
[Vis_Fp_U_1,Vis_Fp_V_1,Vis_Fp_W_1,Force_Fp_xx_1,Force_Fp_xy_1,Force_Fp_xz_1]=NormalizeFiled(JAll_Fp_1,Vis_Fp_U_1,Vis_Fp_V_1,Vis_Fp_W_1,Force_Fp_xx_1,Force_Fp_xy_1,Force_Fp_xz_1);
[Vis_Bp_U_1,Vis_Bp_V_1,Vis_Bp_W_1,Force_Bp_xx_1,Force_Bp_xy_1,Force_Bp_xz_1]=NormalizeFiled(JAll_Bp_1,Vis_Bp_U_1,Vis_Bp_V_1,Vis_Bp_W_1,Force_Bp_xx_1,Force_Bp_xy_1,Force_Bp_xz_1);

[Vis_Fc_U_1,Vis_Fc_V_1,Vis_Fc_W_1,Force_Fc_xx_1,Force_Fc_xy_1,Force_Fc_xz_1]=NormalizeFiled(JAll_Fc_1,Vis_Fc_U_1,Vis_Fc_V_1,Vis_Fc_W_1,Force_Fc_xx_1,Force_Fc_xy_1,Force_Fc_xz_1);
[Vis_Bc_U_1,Vis_Bc_V_1,Vis_Bc_W_1,Force_Bc_xx_1,Force_Bc_xy_1,Force_Bc_xz_1]=NormalizeFiled(JAll_Bc_1,Vis_Bc_U_1,Vis_Bc_V_1,Vis_Bc_W_1,Force_Bc_xx_1,Force_Bc_xy_1,Force_Bc_xz_1);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%2
[Vis_Fp_U_2,Vis_Fp_V_2,Vis_Fp_W_2,Force_Fp_xx_2,Force_Fp_xy_2,Force_Fp_xz_2]=NormalizeFiled(JAll_Fp_2,Vis_Fp_U_2,Vis_Fp_V_2,Vis_Fp_W_2,Force_Fp_xx_2,Force_Fp_xy_2,Force_Fp_xz_2);
[Vis_Bp_U_2,Vis_Bp_V_2,Vis_Bp_W_2,Force_Bp_xx_2,Force_Bp_xy_2,Force_Bp_xz_2]=NormalizeFiled(JAll_Bp_2,Vis_Bp_U_2,Vis_Bp_V_2,Vis_Bp_W_2,Force_Bp_xx_2,Force_Bp_xy_2,Force_Bp_xz_2);

[Vis_Fc_U_2,Vis_Fc_V_2,Vis_Fc_W_2,Force_Fc_xx_2,Force_Fc_xy_2,Force_Fc_xz_2]=NormalizeFiled(JAll_Fc_2,Vis_Fc_U_2,Vis_Fc_V_2,Vis_Fc_W_2,Force_Fc_xx_2,Force_Fc_xy_2,Force_Fc_xz_2);
[Vis_Bc_U_2,Vis_Bc_V_2,Vis_Bc_W_2,Force_Bc_xx_2,Force_Bc_xy_2,Force_Bc_xz_2]=NormalizeFiled(JAll_Bc_2,Vis_Bc_U_2,Vis_Bc_V_2,Vis_Bc_W_2,Force_Bc_xx_2,Force_Bc_xy_2,Force_Bc_xz_2);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%3
[Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Force_Fp_xx_3,Force_Fp_xy_3,Force_Fp_xz_3]=NormalizeFiled(JAll_Fp_3,Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Force_Fp_xx_3,Force_Fp_xy_3,Force_Fp_xz_3);
[Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Force_Bp_xx_3,Force_Bp_xy_3,Force_Bp_xz_3]=NormalizeFiled(JAll_Bp_3,Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Force_Bp_xx_3,Force_Bp_xy_3,Force_Bp_xz_3);

[Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3,Force_Fc_xx_3,Force_Fc_xy_3,Force_Fc_xz_3]=NormalizeFiled(JAll_Fc_3,Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3,Force_Fc_xx_3,Force_Fc_xy_3,Force_Fc_xz_3);
[Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Force_Bc_xx_3,Force_Bc_xy_3,Force_Bc_xz_3]=NormalizeFiled(JAll_Bc_3,Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Force_Bc_xx_3,Force_Bc_xy_3,Force_Bc_xz_3);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%% Get Length;
Fp_Mode_1=length(Ki_Fp_1);
Fc_Mode_1=length(Ki_Fc_1);

Bp_Mode_1=length(Ki_Bp_1);
Bc_Mode_1=length(Ki_Bc_1);
%------------------------
Fp_Mode_2=length(Ki_Fp_2);
Fc_Mode_2=length(Ki_Fc_2);

Bp_Mode_2=length(Ki_Bp_2);
Bc_Mode_2=length(Ki_Bc_2);
%------------------------
Fp_Mode_3=length(Ki_Fp_3);
Fc_Mode_3=length(Ki_Fc_3);

Bp_Mode_3=length(Ki_Bp_3);
Bc_Mode_3=length(Ki_Bc_3);
%% Combine Acoustic field
% 1---
Vis_Fpc_U_1=[Vis_Fp_U_1 Vis_Fc_U_1];
Vis_Fpc_V_1=[Vis_Fp_V_1 Vis_Fc_V_1];
Vis_Fpc_W_1=[Vis_Fp_W_1 Vis_Fc_W_1];

Vis_Bpc_U_1=[Vis_Bp_U_1 Vis_Bc_U_1];
Vis_Bpc_V_1=[Vis_Bp_V_1 Vis_Bc_V_1];
Vis_Bpc_W_1=[Vis_Bp_W_1 Vis_Bc_W_1];

Force_Fpc_xx_1=[Force_Fp_xx_1 Force_Fc_xx_1];
Force_Fpc_xy_1=[Force_Fp_xy_1 Force_Fc_xy_1];
Force_Fpc_xz_1=[Force_Fp_xz_1 Force_Fc_xz_1];

Force_Bpc_xx_1=[Force_Bp_xx_1 Force_Bc_xx_1];
Force_Bpc_xy_1=[Force_Bp_xy_1 Force_Bc_xy_1];
Force_Bpc_xz_1=[Force_Bp_xz_1 Force_Bc_xz_1];
% 2---
Vis_Fpc_U_2=[Vis_Fp_U_2 Vis_Fc_U_2];
Vis_Fpc_V_2=[Vis_Fp_V_2 Vis_Fc_V_2];
Vis_Fpc_W_2=[Vis_Fp_W_2 Vis_Fc_W_2];

Vis_Bpc_U_2=[Vis_Bp_U_2 Vis_Bc_U_2];
Vis_Bpc_V_2=[Vis_Bp_V_2 Vis_Bc_V_2];
Vis_Bpc_W_2=[Vis_Bp_W_2 Vis_Bc_W_2];

Force_Fpc_xx_2=[Force_Fp_xx_2 Force_Fc_xx_2];
Force_Fpc_xy_2=[Force_Fp_xy_2 Force_Fc_xy_2];
Force_Fpc_xz_2=[Force_Fp_xz_2 Force_Fc_xz_2];

Force_Bpc_xx_2=[Force_Bp_xx_2 Force_Bc_xx_2];
Force_Bpc_xy_2=[Force_Bp_xy_2 Force_Bc_xy_2];
Force_Bpc_xz_2=[Force_Bp_xz_2 Force_Bc_xz_2];
% 3---
Vis_Fpc_U_3=[Vis_Fp_U_3 Vis_Fc_U_3];
Vis_Fpc_V_3=[Vis_Fp_V_3 Vis_Fc_V_3];
Vis_Fpc_W_3=[Vis_Fp_W_3 Vis_Fc_W_3];

Vis_Bpc_U_3=[Vis_Bp_U_3 Vis_Bc_U_3];
Vis_Bpc_V_3=[Vis_Bp_V_3 Vis_Bc_V_3];
Vis_Bpc_W_3=[Vis_Bp_W_3 Vis_Bc_W_3];

Force_Fpc_xx_3=[Force_Fp_xx_3 Force_Fc_xx_3];
Force_Fpc_xy_3=[Force_Fp_xy_3 Force_Fc_xy_3];
Force_Fpc_xz_3=[Force_Fp_xz_3 Force_Fc_xz_3];

Force_Bpc_xx_3=[Force_Bp_xx_3 Force_Bc_xx_3];
Force_Bpc_xy_3=[Force_Bp_xy_3 Force_Bc_xy_3];
Force_Bpc_xz_3=[Force_Bp_xz_3 Force_Bc_xz_3];

Count=Count+1;
end
%% LikeCalLam -------------------------------------------------------------------------------------------------------------------------------------------
%% Max Layer Mode
Mode_N_1=min(Fp_Mode_1+Fc_Mode_1,Bp_Mode_1+Bc_Mode_1);
Mode_N_2=min(Fp_Mode_2+Fc_Mode_2,Bp_Mode_2+Bc_Mode_2);
Mode_N_3=min(Fp_Mode_3+Fc_Mode_3,Bp_Mode_3+Bc_Mode_3);

Mode_N=min(Mode_N_2,Mode_N_3);
Mode_N=min(Mode_N_1,Mode_N);
%% Get Matrix of intergral
[~,D_O]=chebdif(N,1);
I = 1:N-1;

Ww_1 = cell(1, Line_M_1);    %get integral matrix
Ww_2 = cell(1, Line_M_2);
Ww_3 = cell(1, Line_M_3);

% ----1
for Lo=1:Line_M_1
    D_s=(2/H_1(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_1{Lo} = Di_s(1,:);
end
% ----2
for Lo=1:Line_M_2
    D_s=(2/H_2(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_2{Lo} = Di_s(1,:);
end
% ----3
for Lo=1:Line_M_3
    D_s=(2/H_3(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_3{Lo} = Di_s(1,:);
end
%%
TogeLayer_N_U=((TogeLayers_U(1)-1)*N+1):TogeLayers_U(2)*N;
TogeLayer_N_D=(1:length(TogeLayers_D)*N);

Layer1_Down_N=(TogeLayers_D(1)-1)*N+1:TogeLayers_D(2)*N;
%%

%K1
for m=1:Mode_N
    for n=1:Mode_N
        

        A=conj(Vis_Fpc_U_1(:,m)).*Force_Fpc_xx_1(:,n);
        B=conj(Vis_Fpc_V_1(:,m)).*Force_Fpc_xy_1(:,n);
        C=conj(Vis_Fpc_W_1(:,m)).*Force_Fpc_xz_1(:,n);

        a=conj(Vis_Bpc_U_1(:,m)).*Force_Fpc_xx_1(:,n);
        b=conj(Vis_Bpc_V_1(:,m)).*Force_Fpc_xy_1(:,n);
        c=conj(Vis_Bpc_W_1(:,m)).*Force_Fpc_xz_1(:,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;

        for Lo=1:Line_M_1
        IA=Ww_1{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_1{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_1{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_1{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_1{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_1{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K1(m,n)=IA_All+IB_All+IC_All;
        K1(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;
    end
end
%%
%L1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(:,m)).*Force_Bpc_xx_1(:,n);
        B=conj(Vis_Fpc_V_1(:,m)).*Force_Bpc_xy_1(:,n);
        C=conj(Vis_Fpc_W_1(:,m)).*Force_Bpc_xz_1(:,n);

        a=conj(Vis_Bpc_U_1(:,m)).*Force_Bpc_xx_1(:,n);
        b=conj(Vis_Bpc_V_1(:,m)).*Force_Bpc_xy_1(:,n);
        c=conj(Vis_Bpc_W_1(:,m)).*Force_Bpc_xz_1(:,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;

        for Lo=1:Line_M_1
        IA=Ww_1{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_1{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_1{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_1{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_1{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_1{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L1(m,n)=IA_All+IB_All+IC_All;
        L1(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;
    end
end

%%
%K2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(TogeLayer_N_U,m)).*Force_Fpc_xx_2(TogeLayer_N_U,n);
        B=conj(Vis_Fpc_V_1(TogeLayer_N_U,m)).*Force_Fpc_xy_2(TogeLayer_N_U,n);
        C=conj(Vis_Fpc_W_1(TogeLayer_N_U,m)).*Force_Fpc_xz_2(TogeLayer_N_U,n);

        a=conj(Vis_Bpc_U_1(TogeLayer_N_U,m)).*Force_Fpc_xx_2(TogeLayer_N_U,n);
        b=conj(Vis_Bpc_V_1(TogeLayer_N_U,m)).*Force_Fpc_xy_2(TogeLayer_N_U,n);
        c=conj(Vis_Bpc_W_1(TogeLayer_N_U,m)).*Force_Fpc_xz_2(TogeLayer_N_U,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K2(m,n)=IA_All+IB_All+IC_All;
        K2(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;
    end
end
%%
%L2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(TogeLayer_N_U,m)).*Force_Bpc_xx_2(TogeLayer_N_U,n);
        B=conj(Vis_Fpc_V_1(TogeLayer_N_U,m)).*Force_Bpc_xy_2(TogeLayer_N_U,n);
        C=conj(Vis_Fpc_W_1(TogeLayer_N_U,m)).*Force_Bpc_xz_2(TogeLayer_N_U,n);

        a=conj(Vis_Bpc_U_1(TogeLayer_N_U,m)).*Force_Bpc_xx_2(TogeLayer_N_U,n);
        b=conj(Vis_Bpc_V_1(TogeLayer_N_U,m)).*Force_Bpc_xy_2(TogeLayer_N_U,n);
        c=conj(Vis_Bpc_W_1(TogeLayer_N_U,m)).*Force_Bpc_xz_2(TogeLayer_N_U,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L2(m,n)=IA_All+IB_All+IC_All;
        L2(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;
    end
end
%%
%K3
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Layer1_Down_N,m)).*Force_Fpc_xx_3(TogeLayer_N_D,n);
        B=conj(Vis_Fpc_V_1(Layer1_Down_N,m)).*Force_Fpc_xy_3(TogeLayer_N_D,n);
        C=conj(Vis_Fpc_W_1(Layer1_Down_N,m)).*Force_Fpc_xz_3(TogeLayer_N_D,n);

        a=conj(Vis_Bpc_U_1(Layer1_Down_N,m)).*Force_Fpc_xx_3(TogeLayer_N_D,n);
        b=conj(Vis_Bpc_V_1(Layer1_Down_N,m)).*Force_Fpc_xy_3(TogeLayer_N_D,n);
        c=conj(Vis_Bpc_W_1(Layer1_Down_N,m)).*Force_Fpc_xz_3(TogeLayer_N_D,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K3(m,n)=IA_All+IB_All+IC_All;
        K3(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L3        
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Layer1_Down_N,m)).*Force_Bpc_xx_3(TogeLayer_N_D,n);
        B=conj(Vis_Fpc_V_1(Layer1_Down_N,m)).*Force_Bpc_xy_3(TogeLayer_N_D,n);
        C=conj(Vis_Fpc_W_1(Layer1_Down_N,m)).*Force_Bpc_xz_3(TogeLayer_N_D,n);

        a=conj(Vis_Bpc_U_1(Layer1_Down_N,m)).*Force_Bpc_xx_3(TogeLayer_N_D,n);
        b=conj(Vis_Bpc_V_1(Layer1_Down_N,m)).*Force_Bpc_xy_3(TogeLayer_N_D,n);
        c=conj(Vis_Bpc_W_1(Layer1_Down_N,m)).*Force_Bpc_xz_3(TogeLayer_N_D,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L3(m,n)=IA_All+IB_All+IC_All;
        L3(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K4             
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_1(TogeLayer_N_U,m).*conj(Force_Fpc_xx_2(TogeLayer_N_U,n));
        B=Vis_Fpc_V_1(TogeLayer_N_U,m).*conj(Force_Fpc_xy_2(TogeLayer_N_U,n));
        C=Vis_Fpc_W_1(TogeLayer_N_U,m).*conj(Force_Fpc_xz_2(TogeLayer_N_U,n));

        a=Vis_Fpc_U_1(TogeLayer_N_U,m).*conj(Force_Bpc_xx_2(TogeLayer_N_U,n));
        b=Vis_Fpc_V_1(TogeLayer_N_U,m).*conj(Force_Bpc_xy_2(TogeLayer_N_U,n));
        c=Vis_Fpc_W_1(TogeLayer_N_U,m).*conj(Force_Bpc_xz_2(TogeLayer_N_U,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K4(n,m)=IA_All+IB_All+IC_All;
        K4(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L4
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_1(TogeLayer_N_U,m).*conj(Force_Fpc_xx_2(TogeLayer_N_U,n));
        B=Vis_Bpc_V_1(TogeLayer_N_U,m).*conj(Force_Fpc_xy_2(TogeLayer_N_U,n));
        C=Vis_Bpc_W_1(TogeLayer_N_U,m).*conj(Force_Fpc_xz_2(TogeLayer_N_U,n));

        a=Vis_Bpc_U_1(TogeLayer_N_U,m).*conj(Force_Bpc_xx_2(TogeLayer_N_U,n));
        b=Vis_Bpc_V_1(TogeLayer_N_U,m).*conj(Force_Bpc_xy_2(TogeLayer_N_U,n));
        c=Vis_Bpc_W_1(TogeLayer_N_U,m).*conj(Force_Bpc_xz_2(TogeLayer_N_U,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L4(n,m)=IA_All+IB_All+IC_All;
        L4(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K5
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_2(TogeLayer_N_U,m).*conj(Force_Fpc_xx_2(TogeLayer_N_U,n));
        B=Vis_Fpc_V_2(TogeLayer_N_U,m).*conj(Force_Fpc_xy_2(TogeLayer_N_U,n));
        C=Vis_Fpc_W_2(TogeLayer_N_U,m).*conj(Force_Fpc_xz_2(TogeLayer_N_U,n));

        a=Vis_Fpc_U_2(TogeLayer_N_U,m).*conj(Force_Bpc_xx_2(TogeLayer_N_U,n));
        b=Vis_Fpc_V_2(TogeLayer_N_U,m).*conj(Force_Bpc_xy_2(TogeLayer_N_U,n));
        c=Vis_Fpc_W_2(TogeLayer_N_U,m).*conj(Force_Bpc_xz_2(TogeLayer_N_U,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K5(n,m)=IA_All+IB_All+IC_All;
        K5(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L5
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_2(TogeLayer_N_U,m).*conj(Force_Fpc_xx_2(TogeLayer_N_U,n));
        B=Vis_Bpc_V_2(TogeLayer_N_U,m).*conj(Force_Fpc_xy_2(TogeLayer_N_U,n));
        C=Vis_Bpc_W_2(TogeLayer_N_U,m).*conj(Force_Fpc_xz_2(TogeLayer_N_U,n));

        a=Vis_Bpc_U_2(TogeLayer_N_U,m).*conj(Force_Bpc_xx_2(TogeLayer_N_U,n));
        b=Vis_Bpc_V_2(TogeLayer_N_U,m).*conj(Force_Bpc_xy_2(TogeLayer_N_U,n));
        c=Vis_Bpc_W_2(TogeLayer_N_U,m).*conj(Force_Bpc_xz_2(TogeLayer_N_U,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_2
        IA=Ww_2{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_2{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_2{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_2{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_2{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_2{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L5(n,m)=IA_All+IB_All+IC_All;
        L5(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K6
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_1(Layer1_Down_N,m).*conj(Force_Fpc_xx_3(TogeLayer_N_D,n));
        B=Vis_Fpc_V_1(Layer1_Down_N,m).*conj(Force_Fpc_xy_3(TogeLayer_N_D,n));
        C=Vis_Fpc_W_1(Layer1_Down_N,m).*conj(Force_Fpc_xz_3(TogeLayer_N_D,n));

        a=Vis_Fpc_U_1(Layer1_Down_N,m).*conj(Force_Bpc_xx_3(TogeLayer_N_D,n));
        b=Vis_Fpc_V_1(Layer1_Down_N,m).*conj(Force_Bpc_xy_3(TogeLayer_N_D,n));
        c=Vis_Fpc_W_1(Layer1_Down_N,m).*conj(Force_Bpc_xz_3(TogeLayer_N_D,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K6(n,m)=IA_All+IB_All+IC_All;
        K6(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L6
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_1(Layer1_Down_N,m).*conj(Force_Fpc_xx_3(TogeLayer_N_D,n));
        B=Vis_Bpc_V_1(Layer1_Down_N,m).*conj(Force_Fpc_xy_3(TogeLayer_N_D,n));
        C=Vis_Bpc_W_1(Layer1_Down_N,m).*conj(Force_Fpc_xz_3(TogeLayer_N_D,n));

        a=Vis_Bpc_U_1(Layer1_Down_N,m).*conj(Force_Bpc_xx_3(TogeLayer_N_D,n));
        b=Vis_Bpc_V_1(Layer1_Down_N,m).*conj(Force_Bpc_xy_3(TogeLayer_N_D,n));
        c=Vis_Bpc_W_1(Layer1_Down_N,m).*conj(Force_Bpc_xz_3(TogeLayer_N_D,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L6(n,m)=IA_All+IB_All+IC_All;
        L6(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K7
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_3(TogeLayer_N_U,m).*conj(Force_Fpc_xx_3(TogeLayer_N_U,n));
        B=Vis_Fpc_V_3(TogeLayer_N_U,m).*conj(Force_Fpc_xy_3(TogeLayer_N_U,n));
        C=Vis_Fpc_W_3(TogeLayer_N_U,m).*conj(Force_Fpc_xz_3(TogeLayer_N_U,n));

        a=Vis_Fpc_U_3(TogeLayer_N_U,m).*conj(Force_Bpc_xx_3(TogeLayer_N_U,n));
        b=Vis_Fpc_V_3(TogeLayer_N_U,m).*conj(Force_Bpc_xy_3(TogeLayer_N_U,n));
        c=Vis_Fpc_W_3(TogeLayer_N_U,m).*conj(Force_Bpc_xz_3(TogeLayer_N_U,n));


        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K7(n,m)=IA_All+IB_All+IC_All;
        K7(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L7
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_3(TogeLayer_N_U,m).*conj(Force_Fpc_xx_3(TogeLayer_N_U,n));
        B=Vis_Bpc_V_3(TogeLayer_N_U,m).*conj(Force_Fpc_xy_3(TogeLayer_N_U,n));
        C=Vis_Bpc_W_3(TogeLayer_N_U,m).*conj(Force_Fpc_xz_3(TogeLayer_N_U,n));

        a=Vis_Bpc_U_3(TogeLayer_N_U,m).*conj(Force_Bpc_xx_3(TogeLayer_N_U,n));
        b=Vis_Bpc_V_3(TogeLayer_N_U,m).*conj(Force_Bpc_xy_3(TogeLayer_N_U,n));
        c=Vis_Bpc_W_3(TogeLayer_N_U,m).*conj(Force_Bpc_xz_3(TogeLayer_N_U,n));


        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M_3
        IA=Ww_3{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_3{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_3{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_3{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_3{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_3{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L7(n,m)=IA_All+IB_All+IC_All;
        L7(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%% ------------------
ZMode=zeros(2*Mode_N,Mode_N);
Aa=[L1 -K2 -K3;L4 -K5 ZMode;L6 ZMode -K7];
Bb=[-K1 L2 L3;-K4 L5 ZMode;-K6 ZMode L7];
%% -------------------
Sca=pinv(Aa)*Bb;
SCA=abs(Sca).^2;

L_mode1=1:Fp_Mode_1;
L_mode2=1:Fp_Mode_2;
L_mode3=1:Fp_Mode_3;

A=SCA(L_mode1,L_mode1);
B=SCA(L_mode1,L_mode2+Mode_N);
C=SCA(L_mode1,L_mode3+Mode_N*2);

D=SCA(L_mode2+Mode_N,L_mode1);
E=SCA(L_mode2+Mode_N,L_mode2+Mode_N);
F=SCA(L_mode2+Mode_N,L_mode3+Mode_N*2);

G=SCA(L_mode3+Mode_N*2,L_mode1);
H=SCA(L_mode3+Mode_N*2,L_mode2+Mode_N);
I=SCA(L_mode3+Mode_N*2,L_mode3+Mode_N*2);


Fin_Scatter(1:(Fp_Mode_1+Fp_Mode_2+Fp_Mode_3)+2,1:(Fp_Mode_1+Fp_Mode_2+Fp_Mode_3)+2)=0;
Fin_Scatter(L_mode1,L_mode1)=A;
Fin_Scatter(L_mode1,L_mode2+1+Fp_Mode_1)=B;
Fin_Scatter(L_mode1,L_mode3+1+1+Fp_Mode_1+Fp_Mode_2)=C;

Fin_Scatter(L_mode2+1+Fp_Mode_1,L_mode1)=D;
Fin_Scatter(L_mode2+1+Fp_Mode_1,L_mode2+1+Fp_Mode_1)=E;
Fin_Scatter(L_mode2+1+Fp_Mode_1,L_mode3+1+1+Fp_Mode_1+Fp_Mode_2)=F;

Fin_Scatter(L_mode3+1+1+Fp_Mode_1+Fp_Mode_2,L_mode1)=G;
Fin_Scatter(L_mode3+1+1+Fp_Mode_1+Fp_Mode_2,L_mode2+1+Fp_Mode_1)=H;
Fin_Scatter(L_mode3+1+1+Fp_Mode_1+Fp_Mode_2,L_mode3+1+1+Fp_Mode_1+Fp_Mode_2)=I;
%% Inspection 1
Wica=length(Fin_Scatter);
for Lo=1:Wica

    sum(Fin_Scatter(:,Lo))
end

for Lo=1:Wica

    sum(Fin_Scatter(Lo,:))
end

%%
for Lo=1:Wica

    sum(Fin_Scatter(:,Lo))
end

for Lo=1:Wica

    sum(Fin_Scatter(Lo,:))
end

