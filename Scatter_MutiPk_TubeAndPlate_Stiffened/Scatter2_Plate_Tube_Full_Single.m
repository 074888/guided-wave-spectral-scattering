clear;
close all;
tic
%% ----------------
[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;

%---------------*===============*  
%                               *    
%                               *         
%   1Plate      3Tube           *     Single layer
%                               *
%----------------===============*
%% -----------------0.9e6:0.05e6:2.5e6;
Frequency_Loop=1e6:1e6:1e6;
Count=1;

for Frequency_Input=Frequency_Loop
%% Set Global Parameter 
%Frequency_Input=0.7e6;
N=50;
Cons=0;
PkPhiy=0;

MaxLayers=100;
%% L Para
Stiff_L=Me9{2};
Rou_L = Me9{1};

StifPhy_L=0;
h_L=0.002;
L_cut=0.5; %Get 1/Line_R EigenValue

%% R Para Stiff,Rou,StifPhy
Layer_R=Me9;

Rr=0.5;
StifPhy_R=0;
h_R=0.002;
R_cut=0.6; %Get 1/Line_R EigenValue

%% --------------------------------

%% Get MutiLayers
%% Get SingleLayers
[Ki_Fp_L,Ki_Bp_L,Ki_Fc_L,Ki_Bc_L,Vis_Fp_U_L,Vis_Fp_V_L,Vis_Fp_W_L,Vis_Bp_U_L,Vis_Bp_V_L,Vis_Bp_W_L,Vis_Bc_U_L,Vis_Bc_V_L,Vis_Bc_W_L,Vis_Fc_U_L,Vis_Fc_V_L,Vis_Fc_W_L...
    ,Force_Bp_xx_L,Force_Bp_yy_L,Force_Bp_zz_L,Force_Bp_yz_L,Force_Bp_xz_L,Force_Bp_xy_L...
    ,Force_Fp_xx_L,Force_Fp_yy_L,Force_Fp_zz_L,Force_Fp_yz_L,Force_Fp_xz_L,Force_Fp_xy_L...
    ,Force_Fc_xx_L,Force_Fc_yy_L,Force_Fc_zz_L,Force_Fc_yz_L,Force_Fc_xz_L,Force_Fc_xy_L...
    ,Force_Bc_xx_L,Force_Bc_yy_L,Force_Bc_zz_L,Force_Bc_yz_L,Force_Bc_xz_L,Force_Bc_xy_L]=Get_AcousticField_BySingleLayer(N,Cons,Frequency_Input,Stiff_L,Rou_L,StifPhy_L,PkPhiy,h_L,L_cut);
%% Get SingleLayers_Tube
[Ki_Fp_R,Ki_Bp_R,Ki_Fc_R,Ki_Bc_R,Vis_Fp_U_R,Vis_Fp_V_R,Vis_Fp_W_R,Vis_Bp_U_R,Vis_Bp_V_R,Vis_Bp_W_R,Vis_Bc_U_R,Vis_Bc_V_R,Vis_Bc_W_R,Vis_Fc_U_R,Vis_Fc_V_R,Vis_Fc_W_R...
    ,Force_Bp_xx_R,Force_Bp_yy_R,Force_Bp_zz_R,Force_Bp_yz_R,Force_Bp_xz_R,Force_Bp_xy_R...
    ,Force_Fp_xx_R,Force_Fp_yy_R,Force_Fp_zz_R,Force_Fp_yz_R,Force_Fp_xz_R,Force_Fp_xy_R...
    ,Force_Fc_xx_R,Force_Fc_yy_R,Force_Fc_zz_R,Force_Fc_yz_R,Force_Fc_xz_R,Force_Fc_xy_R...
    ,Force_Bc_xx_R,Force_Bc_yy_R,Force_Bc_zz_R,Force_Bc_yz_R,Force_Bc_xz_R,Force_Bc_xy_R]=Get_AcousticField_BySingle_Tube(N,Rr,Cons,Frequency_Input,Layer_R,StifPhy_R,h_R,R_cut);


%% GetAll Ori-Acoustic Field
%Normalizations-JAll:MutiLayers
[J1,JAll_Fp_L]=Normalize_M(1,N,h_L,Vis_Fp_U_L,Vis_Fp_V_L,Vis_Fp_W_L,Force_Fp_xx_L,Force_Fp_xy_L,Force_Fp_xz_L);
[J2,JAll_Bp_L]=Normalize_M(1,N,h_L,Vis_Bp_U_L,Vis_Bp_V_L,Vis_Bp_W_L,Force_Bp_xx_L,Force_Bp_xy_L,Force_Bp_xz_L);

[J3,JAll_Fc_L]=Normalize_M(1,N,h_L,Vis_Fc_U_L,Vis_Fc_V_L,Vis_Fc_W_L,Force_Fc_xx_L,Force_Fc_xy_L,Force_Fc_xz_L);
[J4,JAll_Bc_L]=Normalize_M(1,N,h_L,Vis_Bc_U_L,Vis_Bc_V_L,Vis_Bc_W_L,Force_Bc_xx_L,Force_Bc_xy_L,Force_Bc_xz_L);

%----------------------------------------------------------------------------------------------------------------
[J5,JAll_Fp_R]=Normalize_M(1,N,h_R,Vis_Fp_U_R,Vis_Fp_V_R,Vis_Fp_W_R,Force_Fp_xx_R,Force_Fp_xy_R,Force_Fp_xz_R);
[J6,JAll_Bp_R]=Normalize_M(1,N,h_R,Vis_Bp_U_R,Vis_Bp_V_R,Vis_Bp_W_R,Force_Bp_xx_R,Force_Bp_xy_R,Force_Bp_xz_R);

[J7,JAll_Fc_R]=Normalize_M(1,N,h_R,Vis_Fc_U_R,Vis_Fc_V_R,Vis_Fc_W_R,Force_Fc_xx_R,Force_Fc_xy_R,Force_Fc_xz_R);
[J8,JAll_Bc_R]=Normalize_M(1,N,h_R,Vis_Bc_U_R,Vis_Bc_V_R,Vis_Bc_W_R,Force_Bc_xx_R,Force_Bc_xy_R,Force_Bc_xz_R);
%% Nomalize Acoustic Field-ByJAll-[M-S]
%4 Muti;
[Vis_Fp_U_L,Vis_Fp_V_L,Vis_Fp_W_L,Force_Fp_xx_L,Force_Fp_xy_L,Force_Fp_xz_L]=NormalizeFiled(JAll_Fp_L,Vis_Fp_U_L,Vis_Fp_V_L,Vis_Fp_W_L,Force_Fp_xx_L,Force_Fp_xy_L,Force_Fp_xz_L);
[Vis_Bp_U_L,Vis_Bp_V_L,Vis_Bp_W_L,Force_Bp_xx_L,Force_Bp_xy_L,Force_Bp_xz_L]=NormalizeFiled(JAll_Bp_L,Vis_Bp_U_L,Vis_Bp_V_L,Vis_Bp_W_L,Force_Bp_xx_L,Force_Bp_xy_L,Force_Bp_xz_L);

[Vis_Fc_U_L,Vis_Fc_V_L,Vis_Fc_W_L,Force_Fc_xx_L,Force_Fc_xy_L,Force_Fc_xz_L]=NormalizeFiled(JAll_Fc_L,Vis_Fc_U_L,Vis_Fc_V_L,Vis_Fc_W_L,Force_Fc_xx_L,Force_Fc_xy_L,Force_Fc_xz_L);
[Vis_Bc_U_L,Vis_Bc_V_L,Vis_Bc_W_L,Force_Bc_xx_L,Force_Bc_xy_L,Force_Bc_xz_L]=NormalizeFiled(JAll_Bc_L,Vis_Bc_U_L,Vis_Bc_V_L,Vis_Bc_W_L,Force_Bc_xx_L,Force_Bc_xy_L,Force_Bc_xz_L);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%4 Single;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
[Vis_Fp_U_R,Vis_Fp_V_R,Vis_Fp_W_R,Force_Fp_xx_R,Force_Fp_xy_R,Force_Fp_xz_R]=NormalizeFiled(JAll_Fp_R,Vis_Fp_U_R,Vis_Fp_V_R,Vis_Fp_W_R,Force_Fp_xx_R,Force_Fp_xy_R,Force_Fp_xz_R);
[Vis_Bp_U_R,Vis_Bp_V_R,Vis_Bp_W_R,Force_Bp_xx_R,Force_Bp_xy_R,Force_Bp_xz_R]=NormalizeFiled(JAll_Bp_R,Vis_Bp_U_R,Vis_Bp_V_R,Vis_Bp_W_R,Force_Bp_xx_R,Force_Bp_xy_R,Force_Bp_xz_R);

[Vis_Fc_U_R,Vis_Fc_V_R,Vis_Fc_W_R,Force_Fc_xx_R,Force_Fc_xy_R,Force_Fc_xz_R]=NormalizeFiled(JAll_Fc_R,Vis_Fc_U_R,Vis_Fc_V_R,Vis_Fc_W_R,Force_Fc_xx_R,Force_Fc_xy_R,Force_Fc_xz_R);
[Vis_Bc_U_R,Vis_Bc_V_R,Vis_Bc_W_R,Force_Bc_xx_R,Force_Bc_xy_R,Force_Bc_xz_R]=NormalizeFiled(JAll_Bc_R,Vis_Bc_U_R,Vis_Bc_V_R,Vis_Bc_W_R,Force_Bc_xx_R,Force_Bc_xy_R,Force_Bc_xz_R);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%% Get All Normalize Acous Field;
Fp_Lode_L=length(Ki_Fp_L);
Fc_Lode_L=length(Ki_Fc_L);

Bp_Lode_L=length(Ki_Bp_L);
Bc_Lode_L=length(Ki_Bc_L);
%------------------------
Fp_Lode_R=length(Ki_Fp_R);
Fc_Lode_R=length(Ki_Fc_R);

Bp_Lode_R=length(Ki_Bp_R);
Bc_Lode_R=length(Ki_Bc_R);
%%
% [~,D_O]=chebdif(N,1);
% 
% D_R=(2/h)*D_O(:,:,1);
% D_L=(2/sum(H))*D_O(:,:,1);
% I = 1:N-1;
% Di_R = inv(D_R(I,I)); Ww_R = Di_R(1,:);
% Di_L = inv(D_L(I,I)); Ww_L = Di_L(1,:);
%% Combine Acoustic field
Vis_Fpc_U_L=[Vis_Fp_U_L Vis_Fc_U_L];
Vis_Fpc_V_L=[Vis_Fp_V_L Vis_Fc_V_L];
Vis_Fpc_W_L=[Vis_Fp_W_L Vis_Fc_W_L];

Vis_Bpc_U_L=[Vis_Bp_U_L Vis_Bc_U_L];
Vis_Bpc_V_L=[Vis_Bp_V_L Vis_Bc_V_L];
Vis_Bpc_W_L=[Vis_Bp_W_L Vis_Bc_W_L];

Force_Fpc_xx_L=[Force_Fp_xx_L Force_Fc_xx_L];
Force_Fpc_xy_L=[Force_Fp_xy_L Force_Fc_xy_L];
Force_Fpc_xz_L=[Force_Fp_xz_L Force_Fc_xz_L];

Force_Bpc_xx_L=[Force_Bp_xx_L Force_Bc_xx_L];
Force_Bpc_xy_L=[Force_Bp_xy_L Force_Bc_xy_L];
Force_Bpc_xz_L=[Force_Bp_xz_L Force_Bc_xz_L];
%--------------------------------------------------------------------------
Vis_Fpc_U_R=[Vis_Fp_U_R Vis_Fc_U_R];
Vis_Fpc_V_R=[Vis_Fp_V_R Vis_Fc_V_R];
Vis_Fpc_W_R=[Vis_Fp_W_R Vis_Fc_W_R];

Vis_Bpc_U_R=[Vis_Bp_U_R Vis_Bc_U_R];
Vis_Bpc_V_R=[Vis_Bp_V_R Vis_Bc_V_R];
Vis_Bpc_W_R=[Vis_Bp_W_R Vis_Bc_W_R];

Force_Fpc_xx_R=[Force_Fp_xx_R Force_Fc_xx_R];
Force_Fpc_xy_R=[Force_Fp_xy_R Force_Fc_xy_R];
Force_Fpc_xz_R=[Force_Fp_xz_R Force_Fc_xz_R];

Force_Bpc_xx_R=[Force_Bp_xx_R Force_Bc_xx_R];
Force_Bpc_xy_R=[Force_Bp_xy_R Force_Bc_xy_R];
Force_Bpc_xz_R=[Force_Bp_xz_R Force_Bc_xz_R];

Count=Count+1;
end
%% LikeCalLam -------------------------------------------------------------------------------------------------------------------------------------------
%% Max Single Layer Mode
Mode_N=min(Fp_Lode_R+Fc_Lode_R,Bp_Lode_R+Bc_Lode_R);

% Mode_N=50;
%% Get Matrix of intergral
[Single_Iz,D_O]=chebdif(N,1);
Single_Iz=Single_Iz.*(h_R/2);

D_R=(2/h_R)*D_O(:,:,1);
I = 1:N-1;
Di_R = inv(D_R(I,I)); Ww_R = Di_R(1,:);
%%
Per_1=(1:N-1);
%%
%K1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_L(:,m)).*Force_Fpc_xx_L(:,n);
        B=conj(Vis_Fpc_V_L(:,m)).*Force_Fpc_xy_L(:,n);
        C=conj(Vis_Fpc_W_L(:,m)).*Force_Fpc_xz_L(:,n);

        a=conj(Vis_Bpc_U_L(:,m)).*Force_Fpc_xx_L(:,n);
        b=conj(Vis_Bpc_V_L(:,m)).*Force_Fpc_xy_L(:,n);
        c=conj(Vis_Bpc_W_L(:,m)).*Force_Fpc_xz_L(:,n);

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        K1(m,n)=IA+IB+IC;
        K1(m+Mode_N,n)=Ia+Ib+Ic;
    end
end
%%
%L1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_L(:,m)).*Force_Bpc_xx_L(:,n);
        B=conj(Vis_Fpc_V_L(:,m)).*Force_Bpc_xy_L(:,n);
        C=conj(Vis_Fpc_W_L(:,m)).*Force_Bpc_xz_L(:,n);

        a=conj(Vis_Bpc_U_L(:,m)).*Force_Bpc_xx_L(:,n);
        b=conj(Vis_Bpc_V_L(:,m)).*Force_Bpc_xy_L(:,n);
        c=conj(Vis_Bpc_W_L(:,m)).*Force_Bpc_xz_L(:,n);


        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        L1(m,n)=IA+IB+IC;
        L1(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%K2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_L(Per_1,m)).*Force_Fpc_xx_R(Per_1,n);
        B=conj(Vis_Fpc_V_L(Per_1,m)).*Force_Fpc_xy_R(Per_1,n);
        C=conj(Vis_Fpc_W_L(Per_1,m)).*Force_Fpc_xz_R(Per_1,n);

        a=conj(Vis_Bpc_U_L(Per_1,m)).*Force_Fpc_xx_R(Per_1,n);
        b=conj(Vis_Bpc_V_L(Per_1,m)).*Force_Fpc_xy_R(Per_1,n);
        c=conj(Vis_Bpc_W_L(Per_1,m)).*Force_Fpc_xz_R(Per_1,n);

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        K2(m,n)=IA+IB+IC;
        K2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%L2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_L(Per_1,m)).*Force_Bpc_xx_R(Per_1,n);
        B=conj(Vis_Fpc_V_L(Per_1,m)).*Force_Bpc_xy_R(Per_1,n);
        C=conj(Vis_Fpc_W_L(Per_1,m)).*Force_Bpc_xz_R(Per_1,n);

        a=conj(Vis_Bpc_U_L(Per_1,m)).*Force_Bpc_xx_R(Per_1,n);
        b=conj(Vis_Bpc_V_L(Per_1,m)).*Force_Bpc_xy_R(Per_1,n);
        c=conj(Vis_Bpc_W_L(Per_1,m)).*Force_Bpc_xz_R(Per_1,n);

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        L2(m,n)=IA+IB+IC;
        L2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%K3
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_L(Per_1,m).*conj(Force_Fpc_xx_R(Per_1,n));
        B=Vis_Fpc_V_L(Per_1,m).*conj(Force_Fpc_xy_R(Per_1,n));
        C=Vis_Fpc_W_L(Per_1,m).*conj(Force_Fpc_xz_R(Per_1,n));

        a=Vis_Fpc_U_L(Per_1,m).*conj(Force_Bpc_xx_R(Per_1,n));
        b=Vis_Fpc_V_L(Per_1,m).*conj(Force_Bpc_xy_R(Per_1,n));
        c=Vis_Fpc_W_L(Per_1,m).*conj(Force_Bpc_xz_R(Per_1,n));

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        K3(n,m)=IA+IB+IC;
        K3(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L3        
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_L(Per_1,m).*conj(Force_Fpc_xx_R(Per_1,n));
        B=Vis_Bpc_V_L(Per_1,m).*conj(Force_Fpc_xy_R(Per_1,n));
        C=Vis_Bpc_W_L(Per_1,m).*conj(Force_Fpc_xz_R(Per_1,n));

        a=Vis_Bpc_U_L(Per_1,m).*conj(Force_Bpc_xx_R(Per_1,n));
        b=Vis_Bpc_V_L(Per_1,m).*conj(Force_Bpc_xy_R(Per_1,n));
        c=Vis_Bpc_W_L(Per_1,m).*conj(Force_Bpc_xz_R(Per_1,n));

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        L3(n,m)=IA+IB+IC;
        L3(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%K4             
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_R(Per_1,m).*conj(Force_Fpc_xx_R(Per_1,n));
        B=Vis_Fpc_V_R(Per_1,m).*conj(Force_Fpc_xy_R(Per_1,n));
        C=Vis_Fpc_W_R(Per_1,m).*conj(Force_Fpc_xz_R(Per_1,n));

        a=Vis_Fpc_U_R(Per_1,m).*conj(Force_Bpc_xx_R(Per_1,n));
        b=Vis_Fpc_V_R(Per_1,m).*conj(Force_Bpc_xy_R(Per_1,n));
        c=Vis_Fpc_W_R(Per_1,m).*conj(Force_Bpc_xz_R(Per_1,n));

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);


        K4(n,m)=IA+IB+IC;
        K4(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L4
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_R(:,m).*conj(Force_Fpc_xx_R(:,n));
        B=Vis_Bpc_V_R(:,m).*conj(Force_Fpc_xy_R(:,n));
        C=Vis_Bpc_W_R(:,m).*conj(Force_Fpc_xz_R(:,n));

        a=Vis_Bpc_U_R(:,m).*conj(Force_Bpc_xx_R(:,n));
        b=Vis_Bpc_V_R(:,m).*conj(Force_Bpc_xy_R(:,n));
        c=Vis_Bpc_W_R(:,m).*conj(Force_Bpc_xz_R(:,n));

        IA=Ww_R*A(Per_1);IB=Ww_R*B(Per_1);IC=Ww_R*C(Per_1);
        Ia=Ww_R*a(Per_1);Ib=Ww_R*b(Per_1);Ic=Ww_R*c(Per_1);

        L4(n,m)=IA+IB+IC;
        L4(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%% ------------------
Aa=[L1 -K2;L3 -K4];
Bb=[-K1 L2;-K3 L4];
%% -------------------
Sca=pinv(Aa)*Bb;
SCA=abs(Sca).^2;
%%
Z=Sca;
ERF=1e-2;
Ki_F_L=[Ki_Fp_L;Ki_Fc_L];
Ki_B_L=[Ki_Fp_L;Ki_Fc_L];

Ki_F_R=[Ki_Fp_R;Ki_Fc_R];
Ki_B_R=[Ki_Fp_R;Ki_Fc_R];

kvect1=[Ki_F_L(1:Mode_N);Ki_B_L(1:Mode_N)];
kvect2=[Ki_F_R(1:Mode_N);Ki_B_R(1:Mode_N)];

kvect1=kvect1(1:Mode_N);
kvect2=kvect2(1:Mode_N);

%-----------------------
Z1=Z(1:length(kvect1),1:length(kvect1));
Z2=Z(1:length(kvect1),length(kvect1)+1:length(kvect1)+length(kvect2));
Z3=Z(length(kvect1)+1:length(kvect1)+length(kvect2),1:length(kvect1));
Z4=Z(length(kvect1)+1:length(kvect1)+length(kvect2),length(kvect1)+1:length(kvect1)+length(kvect2));

g4=find(abs(imag(kvect1))>ERF);
g2=find(abs(imag(kvect2))>ERF);
Z1(:,g4)=0;Z1(g4,:)=0;Z2(:,g2)=0;Z2(g4,:)=0;Z3(:,g4)=0;Z3(g2,:)=0;Z4(:,g2)=0;Z4(g2,:)=0;
% g4=6:length(kvect1);g2=6:length(kvect2);
% Z1(:,g4)=[];Z1(g4,:)=[];Z2(:,g2)=[];Z2(g4,:)=[];Z3(:,g4)=[];Z3(g2,:)=[];Z4(:,g2)=[];Z4(g2,:)=[];
Z=[Z1,Z2;Z3,Z4];

scat_Rp=abs(Z).^2;
%% Combine All
MLine=length(Ki_Fp_L);
SLine=length(Ki_Fp_R);
Fin_Rcatter=zeros(MLine+SLine+1);

Fin_Rcatter(1:MLine,1:MLine)=scat_Rp(1:MLine,1:MLine);
Fin_Rcatter(MLine+1+1:MLine+SLine+1,1:MLine)=scat_Rp(Mode_N+1:Mode_N+SLine,1:MLine);
Fin_Rcatter(1:MLine,MLine+1+1:MLine+SLine+1)=scat_Rp(1:MLine,Mode_N+1:Mode_N+SLine);
Fin_Rcatter(MLine+1+1:MLine+SLine+1,MLine+1+1:MLine+SLine+1)=scat_Rp(Mode_N+1:Mode_N+SLine,Mode_N+1:Mode_N+SLine);


%% Inspection 1
Wica=5;
for Lo=1:Wica

    sum(Fin_Rcatter(:,Lo))
end

for Lo=1:Wica

    sum(Fin_Rcatter(Lo,:))
end

%%
for Lo=1:Wica

    sum(Fin_Rcatter(:,Lo))
end

for Lo=1:Wica

    sum(Fin_Rcatter(Lo,:))
end

