clear;
close all;

tic
%% -----------------------------
[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;

% --------------*      
%---------------*         
%-------1Plate--*
%---------------*    
%---------------*
%---------------*    
%--------------- ===============*         
%--------------- =======2Plate  *     Muti layer
%--------------- ===============*
%----------------===============*
%% -----------------0.9e6:0.05e6:2.5e6;
Frequency_Loop=0.2e6:0.2e6:0.2e6;
Count=1;

%% （1）Set Global Parameter 
%Frequency_Input=0.7e6;
N=25;
Cons=0;

PkPhiy=0;
MaxLayers=100;
%% （2）Muti Para
Layer_M={Me9,Me9,Me9,Me9,Me9,Me9,Me9,Me9,Me9,Me9,Me9,Me9};                                                        
Ang_M=[0,0,0,0,0,0,0,0,0,0,0,0];                                                               
H_M=[0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.00015,0.00015];

% Layer_M={Me4,Me4,Me4,Me4};                                                          
% Ang_M=[0,90,0,90];                                                                 
% H_M=[0.0005,0.0005,0.0005,0.0005];

Line_M=length(H_M);
Cut_M=0.2;
%% （3）Shao Para 
Layer_S={Me9,Me9,Me9,Me9,Me9,Me9};                                                        
Ang_S=[0,0,0,0,0,0];                                                               
H_S=[0.0001,0.0001,0.0001,0.0001,0.0001,0.0001];

% Layer_S={Me4,Me4};                                                          %LayerMaterials
% Ang_S=[0,90];                                                                 %Layers Angle
% H_S=[0.0005,0.0005];

Line_S=length(H_S);
Cut_S=0.2;
%% （4）TogeLayers Fir To End
TogeLayers=[6,12];

%% Detach TogeLayers is Correct

%%

%% --------------------------------


for Frequency_Input=Frequency_Loop

%% Get MutiLayers
[Ki_Fp_M,Ki_Bp_M,Ki_Fc_M,Ki_Bc_M,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M...
    ,Force_Bp_xx_M,Force_Bp_yy_M,Force_Bp_zz_M,Force_Bp_yz_M,Force_Bp_xz_M,Force_Bp_xy_M...
    ,Force_Fp_xx_M,Force_Fp_yy_M,Force_Fp_zz_M,Force_Fp_yz_M,Force_Fp_xz_M,Force_Fp_xy_M...
    ,Force_Fc_xx_M,Force_Fc_yy_M,Force_Fc_zz_M,Force_Fc_yz_M,Force_Fc_xz_M,Force_Fc_xy_M...
    ,Force_Bc_xx_M,Force_Bc_yy_M,Force_Bc_zz_M,Force_Bc_yz_M,Force_Bc_xz_M,Force_Bc_xy_M]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layer_M,Ang_M,PkPhiy,H_M,Cut_M);
%% Get SingleLayers
[Ki_Fp_S,Ki_Bp_S,Ki_Fc_S,Ki_Bc_S,Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S...
    ,Force_Bp_xx_S,Force_Bp_yy_S,Force_Bp_zz_S,Force_Bp_yz_S,Force_Bp_xz_S,Force_Bp_xy_S...
    ,Force_Fp_xx_S,Force_Fp_yy_S,Force_Fp_zz_S,Force_Fp_yz_S,Force_Fp_xz_S,Force_Fp_xy_S...
    ,Force_Fc_xx_S,Force_Fc_yy_S,Force_Fc_zz_S,Force_Fc_yz_S,Force_Fc_xz_S,Force_Fc_xy_S...
    ,Force_Bc_xx_S,Force_Bc_yy_S,Force_Bc_zz_S,Force_Bc_yz_S,Force_Bc_xz_S,Force_Bc_xy_S]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layer_S,Ang_S,PkPhiy,H_S,Cut_S);
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
[J1,JAll_Fp_M]=Normalize_M(Line_M,N,H_M,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M);
[J2,JAll_Bp_M]=Normalize_M(Line_M,N,H_M,Vis_Bp_U_M,Vis_Bp_V_M,Vis_Bp_W_M,Force_Bp_xx_M,Force_Bp_xy_M,Force_Bp_xz_M);

[J3,JAll_Fc_M]=Normalize_M(Line_M,N,H_M,Vis_Fc_U_M,Vis_Fc_V_M,Vis_Fc_W_M,Force_Fc_xx_M,Force_Fc_xy_M,Force_Fc_xz_M);
[J4,JAll_Bc_M]=Normalize_M(Line_M,N,H_M,Vis_Bc_U_M,Vis_Bc_V_M,Vis_Bc_W_M,Force_Bc_xx_M,Force_Bc_xy_M,Force_Bc_xz_M);

%----------------------------------------------------------------------------------------------------------------
[J5,JAll_Fp_S]=Normalize_M(Line_S,N,H_S,Vis_Fp_U_S,Vis_Fp_V_S,Vis_Fp_W_S,Force_Fp_xx_S,Force_Fp_xy_S,Force_Fp_xz_S);
[J6,JAll_Bp_S]=Normalize_M(Line_S,N,H_S,Vis_Bp_U_S,Vis_Bp_V_S,Vis_Bp_W_S,Force_Bp_xx_S,Force_Bp_xy_S,Force_Bp_xz_S);

[J7,JAll_Fc_S]=Normalize_M(Line_S,N,H_S,Vis_Fc_U_S,Vis_Fc_V_S,Vis_Fc_W_S,Force_Fc_xx_S,Force_Fc_xy_S,Force_Fc_xz_S);
[J8,JAll_Bc_S]=Normalize_M(Line_S,N,H_S,Vis_Bc_U_S,Vis_Bc_V_S,Vis_Bc_W_S,Force_Bc_xx_S,Force_Bc_xy_S,Force_Bc_xz_S);
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
Mode_N=min(min(Fp_Mode_S+Fc_Mode_S,Bp_Mode_S+Bc_Mode_S),min(Fp_Mode_M+Fc_Mode_M,Bp_Mode_M+Bc_Mode_M));
%% Get Martrix of integrals_S
[~,D_O]=chebdif(N,1);
Ww_s={};
I = 1:N-1;

for Lo=1:Line_S
    D_s=(2/H_S(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_s{Lo} = Di_s(1,:);
end
% Get Martrix of integrals_M
[~,D_O]=chebdif(N,1);
Ww_m={};
I = 1:N-1;

for Lo=1:Line_M
    D_s=(2/H_M(Lo))*D_O(:,:,1);
    Di_s = inv(D_s(I,I));
    Ww_m{Lo} = Di_s(1,:);
end
%%
TogeLayer_N=((TogeLayers(1)-1)*N+1):TogeLayers(2)*N;
%%



%% K1
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=conj(Vis_Fpc_U_M(:,m)).*Force_Fpc_xx_M(:,n);
        B=conj(Vis_Fpc_V_M(:,m)).*Force_Fpc_xy_M(:,n);
        C=conj(Vis_Fpc_W_M(:,m)).*Force_Fpc_xz_M(:,n);

        a=conj(Vis_Bpc_U_M(:,m)).*Force_Fpc_xx_M(:,n);
        b=conj(Vis_Bpc_V_M(:,m)).*Force_Fpc_xy_M(:,n);
        c=conj(Vis_Bpc_W_M(:,m)).*Force_Fpc_xz_M(:,n);
        
        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M
        IA=Ww_m{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_m{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_m{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_m{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_m{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_m{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
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
        
        
        A=conj(Vis_Fpc_U_M(:,m)).*Force_Bpc_xx_M(:,n);
        B=conj(Vis_Fpc_V_M(:,m)).*Force_Bpc_xy_M(:,n);
        C=conj(Vis_Fpc_W_M(:,m)).*Force_Bpc_xz_M(:,n);

        a=conj(Vis_Bpc_U_M(:,m)).*Force_Bpc_xx_M(:,n);
        b=conj(Vis_Bpc_V_M(:,m)).*Force_Bpc_xy_M(:,n);
        c=conj(Vis_Bpc_W_M(:,m)).*Force_Bpc_xz_M(:,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_M
        IA=Ww_m{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_m{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_m{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_m{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_m{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_m{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
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
        
        
        A=conj(Vis_Fpc_U_M(TogeLayer_N,m)).*Force_Fpc_xx_S(:,n);
        B=conj(Vis_Fpc_V_M(TogeLayer_N,m)).*Force_Fpc_xy_S(:,n);
        C=conj(Vis_Fpc_W_M(TogeLayer_N,m)).*Force_Fpc_xz_S(:,n);

        a=conj(Vis_Bpc_U_M(TogeLayer_N,m)).*Force_Fpc_xx_S(:,n);
        b=conj(Vis_Bpc_V_M(TogeLayer_N,m)).*Force_Fpc_xy_S(:,n);
        c=conj(Vis_Bpc_W_M(TogeLayer_N,m)).*Force_Fpc_xz_S(:,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
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
        
        A=conj(Vis_Fpc_U_M(TogeLayer_N,m)).*Force_Bpc_xx_S(:,n);
        B=conj(Vis_Fpc_V_M(TogeLayer_N,m)).*Force_Bpc_xy_S(:,n);
        C=conj(Vis_Fpc_W_M(TogeLayer_N,m)).*Force_Bpc_xz_S(:,n);

        a=conj(Vis_Bpc_U_M(TogeLayer_N,m)).*Force_Bpc_xx_S(:,n);
        b=conj(Vis_Bpc_V_M(TogeLayer_N,m)).*Force_Bpc_xy_S(:,n);
        c=conj(Vis_Bpc_W_M(TogeLayer_N,m)).*Force_Bpc_xz_S(:,n);

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L2(m,n)=IA_All+IB_All+IC_All;
        L2(m+Mode_N,n)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K3
for n=1:Mode_N
    for m=1:Mode_N
        
        
        A=Vis_Fpc_U_M(TogeLayer_N,m).*conj(Force_Fpc_xx_S(:,n));
        B=Vis_Fpc_V_M(TogeLayer_N,m).*conj(Force_Fpc_xy_S(:,n));
        C=Vis_Fpc_W_M(TogeLayer_N,m).*conj(Force_Fpc_xz_S(:,n));

        a=Vis_Fpc_U_M(TogeLayer_N,m).*conj(Force_Bpc_xx_S(:,n));
        b=Vis_Fpc_V_M(TogeLayer_N,m).*conj(Force_Bpc_xy_S(:,n));
        c=Vis_Fpc_W_M(TogeLayer_N,m).*conj(Force_Bpc_xz_S(:,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        K3(n,m)=IA_All+IB_All+IC_All;
        K3(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%L3        
for m=1:Mode_N
    for n=1:Mode_N
        
        A=Vis_Bpc_U_M(TogeLayer_N,m).*conj(Force_Fpc_xx_S(:,n));
        B=Vis_Bpc_V_M(TogeLayer_N,m).*conj(Force_Fpc_xy_S(:,n));
        C=Vis_Bpc_W_M(TogeLayer_N,m).*conj(Force_Fpc_xz_S(:,n));

        a=Vis_Bpc_U_M(TogeLayer_N,m).*conj(Force_Bpc_xx_S(:,n));
        b=Vis_Bpc_V_M(TogeLayer_N,m).*conj(Force_Bpc_xy_S(:,n));
        c=Vis_Bpc_W_M(TogeLayer_N,m).*conj(Force_Bpc_xz_S(:,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L3(n,m)=IA_All+IB_All+IC_All;
        L3(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%%
%K4             
for m=1:Mode_N
    for n=1:Mode_N
        
        
        A=Vis_Fpc_U_S(:,m).*conj(Force_Fpc_xx_S(:,n));
        B=Vis_Fpc_V_S(:,m).*conj(Force_Fpc_xy_S(:,n));
        C=Vis_Fpc_W_S(:,m).*conj(Force_Fpc_xz_S(:,n));

        a=Vis_Fpc_U_S(:,m).*conj(Force_Bpc_xx_S(:,n));
        b=Vis_Fpc_V_S(:,m).*conj(Force_Bpc_xy_S(:,n));
        c=Vis_Fpc_W_S(:,m).*conj(Force_Bpc_xz_S(:,n));


        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
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

        A=Vis_Bpc_U_S(:,m).*conj(Force_Fpc_xx_S(:,n));
        B=Vis_Bpc_V_S(:,m).*conj(Force_Fpc_xy_S(:,n));
        C=Vis_Bpc_W_S(:,m).*conj(Force_Fpc_xz_S(:,n));

        a=Vis_Bpc_U_S(:,m).*conj(Force_Bpc_xx_S(:,n));
        b=Vis_Bpc_V_S(:,m).*conj(Force_Bpc_xy_S(:,n));
        c=Vis_Bpc_W_S(:,m).*conj(Force_Bpc_xz_S(:,n));

        IA_All=0;IB_All=0;IC_All=0;
        Ia_All=0;Ib_All=0;Ic_All=0;
        for Lo=1:Line_S
        IA=Ww_s{Lo}*A(( N*(Lo-1)+1 ): (Lo*N-1) );IB=Ww_s{Lo}*B(( N*(Lo-1)+1 ): (Lo*N-1) );IC=Ww_s{Lo}*C(( N*(Lo-1)+1 ): (Lo*N-1) );
        Ia=Ww_s{Lo}*a(( N*(Lo-1)+1 ): (Lo*N-1) );Ib=Ww_s{Lo}*b(( N*(Lo-1)+1 ): (Lo*N-1) );Ic=Ww_s{Lo}*c(( N*(Lo-1)+1 ): (Lo*N-1) );
        IA_All=IA_All+IA;IB_All=IB_All+IB;IC_All=IC_All+IC;
        Ia_All=Ia_All+Ia;Ib_All=Ib_All+Ib;Ic_All=Ic_All+Ic;
        end

        L4(n,m)=IA_All+IB_All+IC_All;
        L4(n+Mode_N,m)=Ia_All+Ib_All+Ic_All;

    end
end
%% ------------------
Aa=[L1 -K2;L3 -K4];
Bb=[-K1 L2;-K3 L4];
%% -------------------
Sca=pinv(Aa)*Bb;
SCA=abs(Sca).^2;
%% -------------------
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
Wica=length(Fin_Scatter);
for Lo=1:Wica

    sum(Fin_Scatter(:,Lo))
end

for Lo=1:Wica

    sum(Fin_Scatter(Lo,:))
end