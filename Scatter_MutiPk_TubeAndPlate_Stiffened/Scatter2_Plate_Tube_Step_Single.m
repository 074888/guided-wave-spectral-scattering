clear;
close all;
tic
%% ----------------
[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;

% --------------*     
%---------------*                   
%-------1Tube --*   
%---------------*                  
%---------------*===============*  
%---------------                *    
%---------------                *         
%---------------      3Tube     *     Single layer
%---------------                *
%----------------===============*
%% -----------------0.9e6:0.05e6:2.5e6;
Frequency_Loop=0.5e6:0.5e6:0.5e6;
Count=1;

for Frequency_Input=Frequency_Loop
%% Set Global Parameter 
%Frequency_Input=0.7e6;
N=35;
Cons=0;
PkPhiy=0;

MaxLayers=100;
%% Muti Para
Layers={Me9,Me9};                                                          %LayerMaterials
Ang=[0,0];                                                                 %Layers Angle
H=[0.002,0.001];
Line_M=length(H);

%% Single Para Stiff,Rou,StifPhy
Layer=Me9;

Rr=0.5;
StifPhy_S=0;
h=0.001;
S_cut=0.6; %Get 1/Line_S EigenValue

%% --------------------------------

%% Get MutiLayers
[Ki_Fp_M,Ki_Bp_M,Ki_Fc_M,Ki_Bc_M,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M...
    ,Force_Bp_xx_M,Force_Bp_yy_M,Force_Bp_zz_M,Force_Bp_yz_M,Force_Bp_xz_M,Force_Bp_xy_M...
    ,Force_Fp_xx_M,Force_Fp_yy_M,Force_Fp_zz_M,Force_Fp_yz_M,Force_Fp_xz_M,Force_Fp_xy_M...
    ,Force_Fc_xx_M,Force_Fc_yy_M,Force_Fc_zz_M,Force_Fc_yz_M,Force_Fc_xz_M,Force_Fc_xy_M...
    ,Force_Bc_xx_M,Force_Bc_yy_M,Force_Bc_zz_M,Force_Bc_yz_M,Force_Bc_xz_M,Force_Bc_xy_M]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layers,Ang,PkPhiy,H,Line_M);
%% Get SingleLayers_Tube
[Ki_Fp_S,Ki_Bp_S,Ki_Fc_S,Ki_Bc_S,Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S...
    ,Force_Bp_xx_S,Force_Bp_yy_S,Force_Bp_zz_S,Force_Bp_yz_S,Force_Bp_xz_S,Force_Bp_xy_S...
    ,Force_Fp_xx_S,Force_Fp_yy_S,Force_Fp_zz_S,Force_Fp_yz_S,Force_Fp_xz_S,Force_Fp_xy_S...
    ,Force_Fc_xx_S,Force_Fc_yy_S,Force_Fc_zz_S,Force_Fc_yz_S,Force_Fc_xz_S,Force_Fc_xy_S...
    ,Force_Bc_xx_S,Force_Bc_yy_S,Force_Bc_zz_S,Force_Bc_yz_S,Force_Bc_xz_S,Force_Bc_xy_S]=Get_AcousticField_BySingle_Tube(N,Rr,Cons,Frequency_Input,Layer,StifPhy_S,h,S_cut);

%% Ki_Fp     Ki_Bp       Ki_Fc     Ki_Fc

% Vis_Fp_U=[];Vis_Fp_V=[];Vis_Fp_W=[];

% Vis_Bp_U=[];Vis_Bp_V=[];Vis_Bp_W=[];

% Vis_Bc_U=[];Vis_Bc_V=[];Vis_Bc_W=[];

% Vis_Fc_U=[];Vis_Fc_V=[];Vis_Fc_W=[];

%% Plot Dis_Force

% [ZAll]=Get_ChebLine(N,MaxLayers,H,Line_M);  %input N,Line H output NeededPlotZ

% [Zall]=Get_ChebLine(N,MaxLayers,h,1);       %input N,Line H output NeededPlotZ

%% GetAll Ori-Acoustic Field
%Normalizations-JAll:MutiLayers
[J1,JAll_Fp_M]=Normalize_M(Line_M,N,H,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M);
[J2,JAll_Bp_M]=Normalize_M(Line_M,N,H,Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Force_Bp_xx_M,Force_Bp_xy_M,Force_Bp_xz_M);

[J3,JAll_Fc_M]=Normalize_M(Line_M,N,H,Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M,Force_Fc_xx_M,Force_Fc_xy_M,Force_Fc_xz_M);
[J4,JAll_Bc_M]=Normalize_M(Line_M,N,H,Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Force_Bc_xx_M,Force_Bc_xy_M,Force_Bc_xz_M);

%----------------------------------------------------------------------------------------------------------------
[J5,JAll_Fp_S]=Normalize_M(1,N,h,Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Force_Fp_xx_S,Force_Fp_xy_S,Force_Fp_xz_S);
[J6,JAll_Bp_S]=Normalize_M(1,N,h,Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Force_Bp_xx_S,Force_Bp_xy_S,Force_Bp_xz_S);

[J7,JAll_Fc_S]=Normalize_M(1,N,h,Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S,Force_Fc_xx_S,Force_Fc_xy_S,Force_Fc_xz_S);
[J8,JAll_Bc_S]=Normalize_M(1,N,h,Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Force_Bc_xx_S,Force_Bc_xy_S,Force_Bc_xz_S);
%% Nomalize Acoustic Field-ByJAll-[M-S]
%4 Muti;
[Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M]=NormalizeFiled(JAll_Fp_M,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M);
[Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Force_Bp_xx_M,Force_Bp_xy_M,Force_Bp_xz_M]=NormalizeFiled(JAll_Bp_M,Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Force_Bp_xx_M,Force_Bp_xy_M,Force_Bp_xz_M);

[Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M,Force_Fc_xx_M,Force_Fc_xy_M,Force_Fc_xz_M]=NormalizeFiled(JAll_Fc_M,Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M,Force_Fc_xx_M,Force_Fc_xy_M,Force_Fc_xz_M);
[Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Force_Bc_xx_M,Force_Bc_xy_M,Force_Bc_xz_M]=NormalizeFiled(JAll_Bc_M,Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Force_Bc_xx_M,Force_Bc_xy_M,Force_Bc_xz_M);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%4 Single;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
[Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Force_Fp_xx_S,Force_Fp_xy_S,Force_Fp_xz_S]=NormalizeFiled(JAll_Fp_S,Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Force_Fp_xx_S,Force_Fp_xy_S,Force_Fp_xz_S);
[Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Force_Bp_xx_S,Force_Bp_xy_S,Force_Bp_xz_S]=NormalizeFiled(JAll_Bp_S,Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Force_Bp_xx_S,Force_Bp_xy_S,Force_Bp_xz_S);

[Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S,Force_Fc_xx_S,Force_Fc_xy_S,Force_Fc_xz_S]=NormalizeFiled(JAll_Fc_S,Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S,Force_Fc_xx_S,Force_Fc_xy_S,Force_Fc_xz_S);
[Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Force_Bc_xx_S,Force_Bc_xy_S,Force_Bc_xz_S]=NormalizeFiled(JAll_Bc_S,Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Force_Bc_xx_S,Force_Bc_xy_S,Force_Bc_xz_S);
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%% Get All Normalize Acous Field;
Fp_Mode_M=length(Ki_Fp_M);
Fc_Mode_M=length(Ki_Fc_M);

Bp_Mode_M=length(Ki_Bp_M);
Bc_Mode_M=length(Ki_Bc_M);
%------------------------
Fp_Mode_S=length(Ki_Fp_S);
Fc_Mode_S=length(Ki_Fc_S);

Bp_Mode_S=length(Ki_Bp_S);
Bc_Mode_S=length(Ki_Bc_S);
%%
[Single_Iz,D_O]=chebdif(N,1);
Single_Iz=Single_Iz.*(h/2);

D_s=(2/h)*D_O(:,:,1);
D_m=(2/sum(H))*D_O(:,:,1);
I = 1:N-1;
Di_s = inv(D_s(I,I)); Ww_s = Di_s(1,:);
Di_m = inv(D_m(I,I)); Ww_m = Di_m(1,:);
%% Combine Acoustic field
Vis_Fpc_U_M=[Vis_Fp_U_M Vis_Fc_U_M];
Vis_Fpc_V_M=[Vis_Fp_V_M Vis_Fc_V_M];
Vis_Fpc_W_M=[Vis_Fp_W_M Vis_Fc_W_M];

Vis_Bpc_U_M=[Vis_Bp_U_M Vis_Bc_U_M];
Vis_Bpc_V_M=[Vis_Bp_V_M Vis_Bc_V_M];
Vis_Bpc_W_M=[Vis_Bp_W_M Vis_Bc_W_M];

Force_Fpc_xx_M=[Force_Fp_xx_M Force_Fc_xx_M];
Force_Fpc_xy_M=[Force_Fp_xy_M Force_Fc_xy_M];
Force_Fpc_xz_M=[Force_Fp_xz_M Force_Fc_xz_M];

Force_Bpc_xx_M=[Force_Bp_xx_M Force_Bc_xx_M];
Force_Bpc_xy_M=[Force_Bp_xy_M Force_Bc_xy_M];
Force_Bpc_xz_M=[Force_Bp_xz_M Force_Bc_xz_M];
%--------------------------------------------------------------------------
Vis_Fpc_U_S=[Vis_Fp_U_S Vis_Fc_U_S];
Vis_Fpc_V_S=[Vis_Fp_V_S Vis_Fc_V_S];
Vis_Fpc_W_S=[Vis_Fp_W_S Vis_Fc_W_S];

Vis_Bpc_U_S=[Vis_Bp_U_S Vis_Bc_U_S];
Vis_Bpc_V_S=[Vis_Bp_V_S Vis_Bc_V_S];
Vis_Bpc_W_S=[Vis_Bp_W_S Vis_Bc_W_S];

Force_Fpc_xx_S=[Force_Fp_xx_S Force_Fc_xx_S];
Force_Fpc_xy_S=[Force_Fp_xy_S Force_Fc_xy_S];
Force_Fpc_xz_S=[Force_Fp_xz_S Force_Fc_xz_S];

Force_Bpc_xx_S=[Force_Bp_xx_S Force_Bc_xx_S];
Force_Bpc_xy_S=[Force_Bp_xy_S Force_Bc_xy_S];
Force_Bpc_xz_S=[Force_Bp_xz_S Force_Bc_xz_S];

Count=Count+1;
end
%% LikeCalLam -------------------------------------------------------------------------------------------------------------------------------------------
%% Max Single Layer Mode
Mode_N=min(Fp_Mode_S+Fc_Mode_S,Bp_Mode_S+Bc_Mode_S);

% Mode_N=50;
%% Get Matrix of intergral
[Single_Iz,D_O]=chebdif(N,1);
Single_Iz=Single_Iz.*(h/2);

D_s=(2/h)*D_O(:,:,1);
D_m=(2/sum(H))*D_O(:,:,1);
I = 1:N-1;
Di_s = inv(D_s(I,I)); Ww_s = Di_s(1,:);
Di_m = inv(D_m(I,I)); Ww_m = Di_m(1,:);
%%
Per_Layer=2;
Per_N=((Per_Layer-1)*N)+1:(Per_Layer*N-1);
Per_1=(1:N-1);
Per_2=(N+1:2*N-1);
%%

%K1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_M(:,m)).*Force_Fpc_xx_M(:,n);
        B=conj(Vis_Fpc_V_M(:,m)).*Force_Fpc_xy_M(:,n);
        C=conj(Vis_Fpc_W_M(:,m)).*Force_Fpc_xz_M(:,n);

        a=conj(Vis_Bpc_U_M(:,m)).*Force_Fpc_xx_M(:,n);
        b=conj(Vis_Bpc_V_M(:,m)).*Force_Fpc_xy_M(:,n);
        c=conj(Vis_Bpc_W_M(:,m)).*Force_Fpc_xz_M(:,n);

        IA=Ww_s*A(Per_1)+Ww_s*A(Per_2);IB=Ww_s*B(Per_1)+Ww_s*B(Per_2);IC=Ww_s*C(Per_1)+Ww_s*C(Per_2);
        Ia=Ww_s*a(Per_1)+Ww_s*a(Per_2);Ib=Ww_s*b(Per_1)+Ww_s*b(Per_2);Ic=Ww_s*c(Per_1)+Ww_s*c(Per_2);

        K1(m,n)=IA+IB+IC;
        K1(m+Mode_N,n)=Ia+Ib+Ic;
    end
end
%%
%L1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_M(:,m)).*Force_Bpc_xx_M(:,n);
        B=conj(Vis_Fpc_V_M(:,m)).*Force_Bpc_xy_M(:,n);
        C=conj(Vis_Fpc_W_M(:,m)).*Force_Bpc_xz_M(:,n);

        a=conj(Vis_Bpc_U_M(:,m)).*Force_Bpc_xx_M(:,n);
        b=conj(Vis_Bpc_V_M(:,m)).*Force_Bpc_xy_M(:,n);
        c=conj(Vis_Bpc_W_M(:,m)).*Force_Bpc_xz_M(:,n);


        IA=Ww_s*A(Per_1)+Ww_s*A(Per_2);IB=Ww_s*B(Per_1)+Ww_s*B(Per_2);IC=Ww_s*C(Per_1)+Ww_s*C(Per_2);
        Ia=Ww_s*a(Per_1)+Ww_s*a(Per_2);Ib=Ww_s*b(Per_1)+Ww_s*b(Per_2);Ic=Ww_s*c(Per_1)+Ww_s*c(Per_2);

        L1(m,n)=IA+IB+IC;
        L1(m+Mode_N,n)=Ia+Ib+Ic;


    end
end

%%
%K2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_M(Per_2,m)).*Force_Fpc_xx_S(Per_1,n);
        B=conj(Vis_Fpc_V_M(Per_2,m)).*Force_Fpc_xy_S(Per_1,n);
        C=conj(Vis_Fpc_W_M(Per_2,m)).*Force_Fpc_xz_S(Per_1,n);

        a=conj(Vis_Bpc_U_M(Per_2,m)).*Force_Fpc_xx_S(Per_1,n);
        b=conj(Vis_Bpc_V_M(Per_2,m)).*Force_Fpc_xy_S(Per_1,n);
        c=conj(Vis_Bpc_W_M(Per_2,m)).*Force_Fpc_xz_S(Per_1,n);

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);

        K2(m,n)=IA+IB+IC;
        K2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%L2
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_M(Per_2,m)).*Force_Bpc_xx_S(Per_1,n);
        B=conj(Vis_Fpc_V_M(Per_2,m)).*Force_Bpc_xy_S(Per_1,n);
        C=conj(Vis_Fpc_W_M(Per_2,m)).*Force_Bpc_xz_S(Per_1,n);

        a=conj(Vis_Bpc_U_M(Per_2,m)).*Force_Bpc_xx_S(Per_1,n);
        b=conj(Vis_Bpc_V_M(Per_2,m)).*Force_Bpc_xy_S(Per_1,n);
        c=conj(Vis_Bpc_W_M(Per_2,m)).*Force_Bpc_xz_S(Per_1,n);

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);

        L2(m,n)=IA+IB+IC;
        L2(m+Mode_N,n)=Ia+Ib+Ic;

    end
end
%%
%K3
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_M(Per_2,m).*conj(Force_Fpc_xx_S(Per_1,n));
        B=Vis_Fpc_V_M(Per_2,m).*conj(Force_Fpc_xy_S(Per_1,n));
        C=Vis_Fpc_W_M(Per_2,m).*conj(Force_Fpc_xz_S(Per_1,n));

        a=Vis_Fpc_U_M(Per_2,m).*conj(Force_Bpc_xx_S(Per_1,n));
        b=Vis_Fpc_V_M(Per_2,m).*conj(Force_Bpc_xy_S(Per_1,n));
        c=Vis_Fpc_W_M(Per_2,m).*conj(Force_Bpc_xz_S(Per_1,n));

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);

        K3(n,m)=IA+IB+IC;
        K3(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L3        
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=Vis_Bpc_U_M(Per_2,m).*conj(Force_Fpc_xx_S(Per_1,n));
        B=Vis_Bpc_V_M(Per_2,m).*conj(Force_Fpc_xy_S(Per_1,n));
        C=Vis_Bpc_W_M(Per_2,m).*conj(Force_Fpc_xz_S(Per_1,n));

        a=Vis_Bpc_U_M(Per_2,m).*conj(Force_Bpc_xx_S(Per_1,n));
        b=Vis_Bpc_V_M(Per_2,m).*conj(Force_Bpc_xy_S(Per_1,n));
        c=Vis_Bpc_W_M(Per_2,m).*conj(Force_Bpc_xz_S(Per_1,n));

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);

        L3(n,m)=IA+IB+IC;
        L3(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%K4             
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=Vis_Fpc_U_S(Per_1,m).*conj(Force_Fpc_xx_S(Per_1,n));
        B=Vis_Fpc_V_S(Per_1,m).*conj(Force_Fpc_xy_S(Per_1,n));
        C=Vis_Fpc_W_S(Per_1,m).*conj(Force_Fpc_xz_S(Per_1,n));

        a=Vis_Fpc_U_S(Per_1,m).*conj(Force_Bpc_xx_S(Per_1,n));
        b=Vis_Fpc_V_S(Per_1,m).*conj(Force_Bpc_xy_S(Per_1,n));
        c=Vis_Fpc_W_S(Per_1,m).*conj(Force_Bpc_xz_S(Per_1,n));

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);


        K4(n,m)=IA+IB+IC;
        K4(n+Mode_N,m)=Ia+Ib+Ic;

    end
end
%%
%L4
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Bpc_U_S(:,m).*conj(Force_Fpc_xx_S(:,n));
        B=Vis_Bpc_V_S(:,m).*conj(Force_Fpc_xy_S(:,n));
        C=Vis_Bpc_W_S(:,m).*conj(Force_Fpc_xz_S(:,n));

        a=Vis_Bpc_U_S(:,m).*conj(Force_Bpc_xx_S(:,n));
        b=Vis_Bpc_V_S(:,m).*conj(Force_Bpc_xy_S(:,n));
        c=Vis_Bpc_W_S(:,m).*conj(Force_Bpc_xz_S(:,n));

        IA=Ww_s*A(Per_1);IB=Ww_s*B(Per_1);IC=Ww_s*C(Per_1);
        Ia=Ww_s*a(Per_1);Ib=Ww_s*b(Per_1);Ic=Ww_s*c(Per_1);

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
Ki_F_M=[Ki_Fp_M;Ki_Fc_M];
Ki_B_M=[Ki_Fp_M;Ki_Fc_M];

Ki_F_S=[Ki_Fp_S;Ki_Fc_S];
Ki_B_S=[Ki_Fp_S;Ki_Fc_S];

kvect1=[Ki_F_M(1:Mode_N);Ki_B_M(1:Mode_N)];
kvect2=[Ki_F_S(1:Mode_N);Ki_B_S(1:Mode_N)];

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

scat_Sp=abs(Z).^2;
%% Combine All
MLine=length(Ki_Fp_M);
SLine=length(Ki_Fp_S);
Fin_Scatter=zeros(MLine+SLine+1);

Fin_Scatter(1:MLine,1:MLine)=scat_Sp(1:MLine,1:MLine);
Fin_Scatter(MLine+1+1:MLine+SLine+1,1:MLine)=scat_Sp(Mode_N+1:Mode_N+SLine,1:MLine);
Fin_Scatter(1:MLine,MLine+1+1:MLine+SLine+1)=scat_Sp(1:MLine,Mode_N+1:Mode_N+SLine);
Fin_Scatter(MLine+1+1:MLine+SLine+1,MLine+1+1:MLine+SLine+1)=scat_Sp(Mode_N+1:Mode_N+SLine,Mode_N+1:Mode_N+SLine);


%% Inspection 1
Wica=5;
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

