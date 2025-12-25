clear;
close all;
tic
%% ----------------
[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;

%                       *           *
%                     *            *
%                   *            *
%                 *            *
% --------------*     2Tube   *
%---------------*           *              Single Layer
%-------1Plate--*         *
%---------------*      *
%---------------*  *
%----------------------------------    
%---------------  ~~~~~~~~~~~~~~~~~          
%---------------  ~~~~~~~~3Plate~~~~        Single Layer
%---------------  ~~~~~~~~~~~~~~~~~
%-----------------------------------
%% -----------------0.9e6:0.05e6:2.5e6;
Frequency_Loop=0.2e6:0.2e6:0.2e6;
Count=1;

for Frequency_Input=Frequency_Loop
%% Set Global Parameter 
%Frequency_Input=0.7e6;
N=100;
Cons=0;
PkPhiy=0;

MaxLayers=100;
%% Muti Para
Layers_1={Me4,Me4};                                                          %LayerMaterials
Ang_1=[0,0];                                                                 %Layers Angle
H_1=[0.001,0.0015];

Line_M_1=length(Layers_1);
GetPart_M_1=0.5;
%% Single 2
Layer_2=Me4;
Stiff_S_2=Layer_2{2};
Rou_S_2=Layer_2{1};

StifPhy_S_2=0;
h_2=0.001;

Line_S_2=length(h_2); 
GetPart_S_2=0.5;
%% Single 3
Layer_3=Me5;
% Stiff_3=Layer_3{2};
% Rou_S_3=Layer_3{1};
Rr_3=0.5;
StifPhy_S_3=0;
h_3=0.0015;

Line_S_3=length(h_3); 

S_cut_3=0.6; %Get 1/Line_S EigenValu
%% --------------------------------
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
    ,Force_Bc_xx_2,Force_Bc_yy_2,Force_Bc_zz_2,Force_Bc_yz_2,Force_Bc_xz_2,Force_Bc_xy_2]=Get_AcousticField_BySingleLayer(N,Cons,Frequency_Input,Stiff_S_2,Rou_S_2,StifPhy_S_2,PkPhiy,h_2,GetPart_S_2);
%% Get SingleLayers ③
[Ki_Fp_3,Ki_Bp_3,Ki_Fc_3,Ki_Bc_3,Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3...
    ,Force_Bp_xx_3,Force_Bp_yy_3,Force_Bp_zz_3,Force_Bp_yz_3,Force_Bp_xz_3,Force_Bp_xy_3...
    ,Force_Fp_xx_3,Force_Fp_yy_3,Force_Fp_zz_3,Force_Fp_yz_3,Force_Fp_xz_3,Force_Fp_xy_3...
    ,Force_Fc_xx_3,Force_Fc_yy_3,Force_Fc_zz_3,Force_Fc_yz_3,Force_Fc_xz_3,Force_Fc_xy_3...
    ,Force_Bc_xx_3,Force_Bc_yy_3,Force_Bc_zz_3,Force_Bc_yz_3,Force_Bc_xz_3,Force_Bc_xy_3]=Get_AcousticField_BySingle_Tube(N,Rr_3,Cons,Frequency_Input,Layer_3,StifPhy_S_3,h_3,S_cut_3);

%% GetAll Ori-Acoustic Field
%Normalizations-JAll:MutiLayers-1
[J1,JAll_Fp_1]=Normalize_M(Line_M_1,N,H_1,Vis_Fp_U_1,Vis_Fp_V_1,Vis_Fp_W_1,Force_Fp_xx_1,Force_Fp_xy_1,Force_Fp_xz_1);
[J2,JAll_Bp_1]=Normalize_M(Line_M_1,N,H_1,Vis_Bp_U_1,Vis_Bp_V_1,Vis_Bp_W_1,Force_Bp_xx_1,Force_Bp_xy_1,Force_Bp_xz_1);

[J3,JAll_Fc_1]=Normalize_M(Line_M_1,N,H_1,Vis_Fc_U_1,Vis_Fc_V_1,Vis_Fc_W_1,Force_Fc_xx_1,Force_Fc_xy_1,Force_Fc_xz_1);
[J4,JAll_Bc_1]=Normalize_M(Line_M_1,N,H_1,Vis_Bc_U_1,Vis_Bc_V_1,Vis_Bc_W_1,Force_Bc_xx_1,Force_Bc_xy_1,Force_Bc_xz_1);

%----------------------------------------------------------------------------------------------------------------
[J5,JAll_Fp_2]=Normalize_M(1,N,h_2,Vis_Fp_U_2,Vis_Fp_V_2,Vis_Fp_W_2,Force_Fp_xx_2,Force_Fp_xy_2,Force_Fp_xz_2);
[J6,JAll_Bp_2]=Normalize_M(1,N,h_2,Vis_Bp_U_2,Vis_Bp_V_2,Vis_Bp_W_2,Force_Bp_xx_2,Force_Bp_xy_2,Force_Bp_xz_2);

[J7,JAll_Fc_2]=Normalize_M(1,N,h_2,Vis_Fc_U_2,Vis_Fc_V_2,Vis_Fc_W_2,Force_Fc_xx_2,Force_Fc_xy_2,Force_Fc_xz_2);
[J8,JAll_Bc_2]=Normalize_M(1,N,h_2,Vis_Bc_U_2,Vis_Bc_V_2,Vis_Bc_W_2,Force_Bc_xx_2,Force_Bc_xy_2,Force_Bc_xz_2);

%----------------------------------------------------------------------------------------------------------------
[J9,JAll_Fp_3]=Normalize_M(1,N,h_3,Vis_Fp_U_3,Vis_Fp_V_3,Vis_Fp_W_3,Force_Fp_xx_3,Force_Fp_xy_3,Force_Fp_xz_3);
[J10,JAll_Bp_3]=Normalize_M(1,N,h_3,Vis_Bp_U_3,Vis_Bp_V_3,Vis_Bp_W_3,Force_Bp_xx_3,Force_Bp_xy_3,Force_Bp_xz_3);

[J11,JAll_Fc_3]=Normalize_M(1,N,h_3,Vis_Fc_U_3,Vis_Fc_V_3,Vis_Fc_W_3,Force_Fc_xx_3,Force_Fc_xy_3,Force_Fc_xz_3);
[J12,JAll_Bc_3]=Normalize_M(1,N,h_3,Vis_Bc_U_3,Vis_Bc_V_3,Vis_Bc_W_3,Force_Bc_xx_3,Force_Bc_xy_3,Force_Bc_xz_3);
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
%% Get Matrix of intergral
[~,D_O]=chebdif(N,1);
I = 1:N-1;

Ww_1 = cell(1, Line_M_1);    %get integral matrix
Ww_2 = cell(1, Line_S_2);
Ww_3 = cell(1, Line_S_3);

% ----1
for Lo=1:Line_M_1
    D_s=(2/H_1(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_1{Lo} = Di_s(1,:);
end
% ----2
for Lo=1:Line_S_2
    D_s=(2/h_2(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_2{Lo} = Di_s(1,:);
end
% ----3
for Lo=1:Line_S_3
    D_s=(2/h_3(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_3{Lo} = Di_s(1,:);
end
%%

Per_1=(1:N-1);
Per_2=(N+1:2*N-1);
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

        IA=Ww_1{1}*A(Per_1)+Ww_1{2}*A(Per_2);IB=Ww_1{1}*B(Per_1)+Ww_1{2}*B(Per_2);IC=Ww_1{1}*C(Per_1)+Ww_1{2}*C(Per_2);
        Ia=Ww_1{1}*a(Per_1)+Ww_1{2}*a(Per_2);Ib=Ww_1{1}*b(Per_1)+Ww_1{2}*b(Per_2);Ic=Ww_1{1}*c(Per_1)+Ww_1{2}*c(Per_2);

        K1(m,n)=IA+IB+IC;
        K1(m+Mode_N,n)=Ia+Ib+Ic;
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


        IA=Ww_1{1}*A(Per_1)+Ww_1{2}*A(Per_2);IB=Ww_1{1}*B(Per_1)+Ww_1{2}*B(Per_2);IC=Ww_1{1}*C(Per_1)+Ww_1{2}*C(Per_2);
        Ia=Ww_1{1}*a(Per_1)+Ww_1{2}*a(Per_2);Ib=Ww_1{1}*b(Per_1)+Ww_1{2}*b(Per_2);Ic=Ww_1{1}*c(Per_1)+Ww_1{2}*c(Per_2);

        L1(m,n)=IA+IB+IC;
        L1(m+Mode_N,n)=Ia+Ib+Ic;


    end
end

%%
%K2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Per_1,m)).*Force_Fpc_xx_2(Per_1,n);
        B=conj(Vis_Fpc_V_1(Per_1,m)).*Force_Fpc_xy_2(Per_1,n);
        C=conj(Vis_Fpc_W_1(Per_1,m)).*Force_Fpc_xz_2(Per_1,n);

        a=conj(Vis_Bpc_U_1(Per_1,m)).*Force_Fpc_xx_2(Per_1,n);
        b=conj(Vis_Bpc_V_1(Per_1,m)).*Force_Fpc_xy_2(Per_1,n);
        c=conj(Vis_Bpc_W_1(Per_1,m)).*Force_Fpc_xz_2(Per_1,n);

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);

        K2(m,n)=IA+IB+IC;
        K2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%L2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Per_1,m)).*Force_Bpc_xx_2(Per_1,n);
        B=conj(Vis_Fpc_V_1(Per_1,m)).*Force_Bpc_xy_2(Per_1,n);
        C=conj(Vis_Fpc_W_1(Per_1,m)).*Force_Bpc_xz_2(Per_1,n);

        a=conj(Vis_Bpc_U_1(Per_1,m)).*Force_Bpc_xx_2(Per_1,n);
        b=conj(Vis_Bpc_V_1(Per_1,m)).*Force_Bpc_xy_2(Per_1,n);
        c=conj(Vis_Bpc_W_1(Per_1,m)).*Force_Bpc_xz_2(Per_1,n);

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);

        L2(m,n)=IA+IB+IC;
        L2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%K3
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Per_2,m)).*Force_Fpc_xx_3(Per_1,n);
        B=conj(Vis_Fpc_V_1(Per_2,m)).*Force_Fpc_xy_3(Per_1,n);
        C=conj(Vis_Fpc_W_1(Per_2,m)).*Force_Fpc_xz_3(Per_1,n);

        a=conj(Vis_Bpc_U_1(Per_2,m)).*Force_Fpc_xx_3(Per_1,n);
        b=conj(Vis_Bpc_V_1(Per_2,m)).*Force_Fpc_xy_3(Per_1,n);
        c=conj(Vis_Bpc_W_1(Per_2,m)).*Force_Fpc_xz_3(Per_1,n);

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        K3(m,n)=IA+IB+IC;
        K3(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%L3        
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_1(Per_2,m)).*Force_Bpc_xx_3(Per_1,n);
        B=conj(Vis_Fpc_V_1(Per_2,m)).*Force_Bpc_xy_3(Per_1,n);
        C=conj(Vis_Fpc_W_1(Per_2,m)).*Force_Bpc_xz_3(Per_1,n);

        a=conj(Vis_Bpc_U_1(Per_2,m)).*Force_Bpc_xx_3(Per_1,n);
        b=conj(Vis_Bpc_V_1(Per_2,m)).*Force_Bpc_xy_3(Per_1,n);
        c=conj(Vis_Bpc_W_1(Per_2,m)).*Force_Bpc_xz_3(Per_1,n);

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        L3(m,n)=IA+IB+IC;
        L3(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%K4             
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_1(Per_1,m).*conj(Force_Fpc_xx_2(Per_1,n));
        B=Vis_Fpc_V_1(Per_1,m).*conj(Force_Fpc_xy_2(Per_1,n));
        C=Vis_Fpc_W_1(Per_1,m).*conj(Force_Fpc_xz_2(Per_1,n));

        a=Vis_Fpc_U_1(Per_1,m).*conj(Force_Bpc_xx_2(Per_1,n));
        b=Vis_Fpc_V_1(Per_1,m).*conj(Force_Bpc_xy_2(Per_1,n));
        c=Vis_Fpc_W_1(Per_1,m).*conj(Force_Bpc_xz_2(Per_1,n));

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);


        K4(n,m)=IA+IB+IC;
        K4(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L4
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_1(Per_1,m).*conj(Force_Fpc_xx_2(Per_1,n));
        B=Vis_Bpc_V_1(Per_1,m).*conj(Force_Fpc_xy_2(Per_1,n));
        C=Vis_Bpc_W_1(Per_1,m).*conj(Force_Fpc_xz_2(Per_1,n));

        a=Vis_Bpc_U_1(Per_1,m).*conj(Force_Bpc_xx_2(Per_1,n));
        b=Vis_Bpc_V_1(Per_1,m).*conj(Force_Bpc_xy_2(Per_1,n));
        c=Vis_Bpc_W_1(Per_1,m).*conj(Force_Bpc_xz_2(Per_1,n));

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);

        L4(n,m)=IA+IB+IC;
        L4(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%K5
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_2(Per_1,m).*conj(Force_Fpc_xx_2(Per_1,n));
        B=Vis_Fpc_V_2(Per_1,m).*conj(Force_Fpc_xy_2(Per_1,n));
        C=Vis_Fpc_W_2(Per_1,m).*conj(Force_Fpc_xz_2(Per_1,n));

        a=Vis_Fpc_U_2(Per_1,m).*conj(Force_Bpc_xx_2(Per_1,n));
        b=Vis_Fpc_V_2(Per_1,m).*conj(Force_Bpc_xy_2(Per_1,n));
        c=Vis_Fpc_W_2(Per_1,m).*conj(Force_Bpc_xz_2(Per_1,n));

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);

        K5(n,m)=IA+IB+IC;
        K5(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L5
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_2(Per_1,m).*conj(Force_Fpc_xx_2(Per_1,n));
        B=Vis_Bpc_V_2(Per_1,m).*conj(Force_Fpc_xy_2(Per_1,n));
        C=Vis_Bpc_W_2(Per_1,m).*conj(Force_Fpc_xz_2(Per_1,n));

        a=Vis_Bpc_U_2(Per_1,m).*conj(Force_Bpc_xx_2(Per_1,n));
        b=Vis_Bpc_V_2(Per_1,m).*conj(Force_Bpc_xy_2(Per_1,n));
        c=Vis_Bpc_W_2(Per_1,m).*conj(Force_Bpc_xz_2(Per_1,n));

        IA=Ww_2{1}*A(Per_1);IB=Ww_2{1}*B(Per_1);IC=Ww_2{1}*C(Per_1);
        Ia=Ww_2{1}*a(Per_1);Ib=Ww_2{1}*b(Per_1);Ic=Ww_2{1}*c(Per_1);

        L5(n,m)=IA+IB+IC;
        L5(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%K6
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_1(Per_2,m).*conj(Force_Fpc_xx_3(Per_1,n));
        B=Vis_Fpc_V_1(Per_2,m).*conj(Force_Fpc_xy_3(Per_1,n));
        C=Vis_Fpc_W_1(Per_2,m).*conj(Force_Fpc_xz_3(Per_1,n));

        a=Vis_Fpc_U_1(Per_2,m).*conj(Force_Bpc_xx_3(Per_1,n));
        b=Vis_Fpc_V_1(Per_2,m).*conj(Force_Bpc_xy_3(Per_1,n));
        c=Vis_Fpc_W_1(Per_2,m).*conj(Force_Bpc_xz_3(Per_1,n));

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        K6(n,m)=IA+IB+IC;
        K6(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L6
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_1(Per_2,m).*conj(Force_Fpc_xx_3(Per_1,n));
        B=Vis_Bpc_V_1(Per_2,m).*conj(Force_Fpc_xy_3(Per_1,n));
        C=Vis_Bpc_W_1(Per_2,m).*conj(Force_Fpc_xz_3(Per_1,n));

        a=Vis_Bpc_U_1(Per_2,m).*conj(Force_Bpc_xx_3(Per_1,n));
        b=Vis_Bpc_V_1(Per_2,m).*conj(Force_Bpc_xy_3(Per_1,n));
        c=Vis_Bpc_W_1(Per_2,m).*conj(Force_Bpc_xz_3(Per_1,n));

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        L6(n,m)=IA+IB+IC;
        L6(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%K7
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_3(Per_1,m).*conj(Force_Fpc_xx_3(Per_1,n));
        B=Vis_Fpc_V_3(Per_1,m).*conj(Force_Fpc_xy_3(Per_1,n));
        C=Vis_Fpc_W_3(Per_1,m).*conj(Force_Fpc_xz_3(Per_1,n));

        a=Vis_Fpc_U_3(Per_1,m).*conj(Force_Bpc_xx_3(Per_1,n));
        b=Vis_Fpc_V_3(Per_1,m).*conj(Force_Bpc_xy_3(Per_1,n));
        c=Vis_Fpc_W_3(Per_1,m).*conj(Force_Bpc_xz_3(Per_1,n));

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        K7(n,m)=IA+IB+IC;
        K7(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L7
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_3(Per_1,m).*conj(Force_Fpc_xx_3(Per_1,n));
        B=Vis_Bpc_V_3(Per_1,m).*conj(Force_Fpc_xy_3(Per_1,n));
        C=Vis_Bpc_W_3(Per_1,m).*conj(Force_Fpc_xz_3(Per_1,n));

        a=Vis_Bpc_U_3(Per_1,m).*conj(Force_Bpc_xx_3(Per_1,n));
        b=Vis_Bpc_V_3(Per_1,m).*conj(Force_Bpc_xy_3(Per_1,n));
        c=Vis_Bpc_W_3(Per_1,m).*conj(Force_Bpc_xz_3(Per_1,n));

        IA=Ww_3{1}*A(Per_1);IB=Ww_3{1}*B(Per_1);IC=Ww_3{1}*C(Per_1);
        Ia=Ww_3{1}*a(Per_1);Ib=Ww_3{1}*b(Per_1);Ic=Ww_3{1}*c(Per_1);

        L7(n,m)=IA+IB+IC;
        L7(n+Mode_N,m)=Ia+Ib+Ic;

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


%% ----Get Each Part
A=Sca(1:Mode_N,1:Mode_N);
B=Sca(1:Mode_N,1+Mode_N:2*Mode_N);
C=Sca(1:Mode_N,1+2*Mode_N:3*Mode_N);

D=Sca(1+Mode_N:2*Mode_N,1:Mode_N);
E=Sca(1+Mode_N:2*Mode_N,1+Mode_N:2*Mode_N);
F=Sca(1+Mode_N:2*Mode_N,1+2*Mode_N:3*Mode_N);

G=Sca(1+2*Mode_N:3*Mode_N,1:Mode_N);
H=Sca(1+2*Mode_N:3*Mode_N,1+Mode_N:2*Mode_N);
I=Sca(1+2*Mode_N:3*Mode_N,1+2*Mode_N:3*Mode_N);

% Tes=[A B C;D E F;G H I];
S11_2=A;S21_2=B;S31_2=C;
S12_2=D;S22_2=E;S32_2=F;
S13_2=G;S23_2=H;S33_2=I;

toc
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

Mode_N
