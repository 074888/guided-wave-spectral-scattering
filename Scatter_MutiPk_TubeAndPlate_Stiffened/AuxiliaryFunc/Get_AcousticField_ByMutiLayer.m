function [Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W...
    ,Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy...
    ,Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy...
    ,Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy...
    ,Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=Get_AcousticField_ByMutiLayer(MaxLayers,N,Cons,Frequency_Input,Layers,Ang,PkPhiy,H,Sub_Muti)

%%
% Set Global Parameter 
% MaxLayers=100;
% N=20;
% Cons=10;
%The circular frequency which can be single Omega；
Fi=Frequency_Input*(2*pi);
Ti=Frequency_Input*(2*pi);
Ri=Frequency_Input*(2*pi);
OmegaLoop=Fi:Ti:Ri;

%%
%Set Material Parameter
% Layers={Me4,Me2,Me3,Me1,Me4,Me4,Me2,Me3,Me1,Me4};                           %LayerMaterials
% Ang=[45,45,0,0,0,45,45,0,0,0];                                              %Layers Angle
% H=[0.001,0.002,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001];

% Layers={Me1,Me1,Me1};                                                     %LayerMaterials
% Ang=[0,00,0];                                                                %Layers Angle
Ang=Ang+PkPhiy;
% H=[0.002,0.001,0.002];
%%
Line=length(Layers);

stiff={MaxLayers};                                                             %All Stiffness,Rou from Layers
Rou=MaxLayers;
for Lo=1:Line
    stiff(Lo)=Layers{Lo}(2);
end

for Lo=1:Line
    Rou(Lo)=Layers{Lo}{1};
end
%%
%Detect Is Right Dimension
E = isequal(length(Ang), length(stiff), length(H), length(Rou),length(Layers));
if E
    disp('You Can Run')
else
    disp('Enter Correct Parameter')
end

%%

%%
%Get identity Density Matrixs
M=eye(N);M(1,:)=0;M(N,:)=0;
Mi=[M zeros(N) zeros(N);zeros(N) M zeros(N);zeros(N) zeros(N) M ];
%%
%Got Every Layers Q2 1 0 And Bc2 1 0;
Q0All={MaxLayers};
Q1All={MaxLayers};
Q2All={MaxLayers};
Bc0All={MaxLayers};
Bc1All={MaxLayers};
Bc2All={MaxLayers};

for Lo=1:Line
    [Q2,Q1,Q0,Bc2,Bc1,Bc0]=Get_LayerPk(N,H(Lo),stiff{Lo},Ang(Lo),Cons);
    Q2All{Lo}=Q2;
    Q1All{Lo}=Q1;
    Q0All{Lo}=Q0;                                                          %Without Mrou
    Bc2All{Lo}=Bc2;
    Bc1All{Lo}=Bc1;
    Bc0All{Lo}=Bc0;
end
%Got All Q2 1 0,Bc2 1 0 Bc0 without w.^2*rou
%%
%Got Displacements Govering Eq Q2 Q1
Q2All_Dis={MaxLayers};
Q1All_Dis={MaxLayers};


for Lo=1:Line
    Q2All_Dis{Lo}=-Q2All{Lo}/Rou(Lo);
    Q1All_Dis{Lo}=-Q1All{Lo}/Rou(Lo);
end
%%
%Get Combine Matrixs-------------------------------------------------------
CQ2=zeros(Line*3*N);
CQ1=zeros(Line*3*N);

%--------------------------------------------------------------------------
Wind=1:3*N;
for Li=1:Line
    CQ2(Wind+((Li-1)*3*N),Wind+((Li-1)*3*N))=Q2All{Li};
    CQ1(Wind+((Li-1)*3*N),Wind+((Li-1)*3*N))=Q1All{Li};
    %         CQ0(Wind+((Li-1)*2*N),Wind+((Li-1)*2*N))=Q0All{Li};
end

%%
%Replace Correspond Row By continuous condition
%%
%CQ2
%First ：The Layer1
CQ2(1,1:3*N)=Bc2All{1}(1,1:3*N);
CQ2(N,1:3*N)=Bc2All{1}(N+1,1:3*N);
CQ2(N+1,1:3*N)=Bc2All{1}(2*N+1,1:3*N);

CQ2(2*N,1:2*3*N)=[Bc2All{1}(N,:),-Bc2All{2}(1,:)];
CQ2(2*N+1,1:2*3*N)=[Bc2All{1}(2*N,:),-Bc2All{2}(N+1,:)];
CQ2(3*N,1:2*3*N)=[Bc2All{1}(3*N,:),-Bc2All{2}(2*N+1,:)];

%Third ：The LayerN(Last)
CQ2(3*N*(Line-1)+1,(Line-2)*3*N+1:Line*3*N)=[Q2All_Dis{Line-1}(N,:),-Q2All_Dis{Line}(1,:)];     %UpLayer Sub SelfLayer Displacement
CQ2(3*N*(Line-1)+N,(Line-2)*3*N+1:Line*3*N)=[Q2All_Dis{Line-1}(2*N,:),-Q2All_Dis{Line}(N+1,:)];
CQ2(3*N*(Line-1)+N+1,(Line-2)*3*N+1:Line*3*N)=[Q2All_Dis{Line-1}(3*N,:),-Q2All_Dis{Line}(2*N+1,:)];

CQ2(3*N*(Line-1)+2*N,(Line-1)*3*N+1:Line*3*N)=Bc2All{Line}(N,1:3*N);
CQ2(3*N*(Line-1)+2*N+1,(Line-1)*3*N+1:Line*3*N)=Bc2All{Line}(2*N,1:3*N);
CQ2(3*N*(Line-1)+3*N,(Line-1)*3*N+1:Line*3*N)=Bc2All{Line}(3*N,1:3*N);
%--------------------------------------------------------------------------
%The General Layers
GL=[1 N N+1 2*N 2*N+1 3*N];

if Line>2
    disp('Layers>2')
    for Li=2:Line-1
        CQ2((Li-1)*3*N+GL(1),((Li-2)*3*N)+1:Li*3*N)=[Q2All_Dis{Li-1}(N,:), -Q2All_Dis{Li}(1,:)];              %Loop from layers2
        CQ2((Li-1)*3*N+GL(2),((Li-2)*3*N)+1:Li*3*N)=[Q2All_Dis{Li-1}(2*N,:), -Q2All_Dis{Li}(N+1,:)];
        CQ2((Li-1)*3*N+GL(3),((Li-2)*3*N)+1:Li*3*N)=[Q2All_Dis{Li-1}(3*N,:), -Q2All_Dis{Li}(2*N+1,:)];
        
        CQ2((Li-1)*3*N+GL(4),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc2All{Li}(N,Wind), -Bc2All{Li+1}(1,Wind)];
        CQ2((Li-1)*3*N+GL(5),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc2All{Li}(2*N,Wind), -Bc2All{Li+1}(N+1,Wind)];
        CQ2((Li-1)*3*N+GL(6),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc2All{Li}(3*N,Wind), -Bc2All{Li+1}(2*N+1,Wind)];
        
    end
elseif Line==2
    disp('Layers=2')
else
    disp('Pls Layer=1 ')
end
%%
%CQ1
%First ：The Layer1
CQ1(1,1:3*N)=Bc1All{1}(1,1:3*N);
CQ1(N,1:3*N)=Bc1All{1}(N+1,1:3*N);
CQ1(N+1,1:3*N)=Bc1All{1}(2*N+1,1:3*N);

CQ1(2*N,1:2*3*N)=[Bc1All{1}(N,:),-Bc1All{2}(1,:)];
CQ1(2*N+1,1:2*3*N)=[Bc1All{1}(2*N,:),-Bc1All{2}(N+1,:)];
CQ1(3*N,1:2*3*N)=[Bc1All{1}(3*N,:),-Bc1All{2}(2*N+1,:)];

%Third ：The LayerN(Last)
CQ1(3*N*(Line-1)+1,(Line-2)*3*N+1:Line*3*N)=[Q1All_Dis{Line-1}(N,:),-Q1All_Dis{Line}(1,:)];     %UpLayer Sub SelfLayer Displacement
CQ1(3*N*(Line-1)+N,(Line-2)*3*N+1:Line*3*N)=[Q1All_Dis{Line-1}(2*N,:),-Q1All_Dis{Line}(N+1,:)];
CQ1(3*N*(Line-1)+N+1,(Line-2)*3*N+1:Line*3*N)=[Q1All_Dis{Line-1}(3*N,:),-Q1All_Dis{Line}(2*N+1,:)];

CQ1(3*N*(Line-1)+2*N,(Line-1)*3*N+1:Line*3*N)=Bc1All{Line}(N,1:3*N);
CQ1(3*N*(Line-1)+2*N+1,(Line-1)*3*N+1:Line*3*N)=Bc1All{Line}(2*N,1:3*N);
CQ1(3*N*(Line-1)+3*N,(Line-1)*3*N+1:Line*3*N)=Bc1All{Line}(3*N,1:3*N);
%----------------------------------------------------------------------
%The General Layers
GL=[1 N N+1 2*N 2*N+1 3*N];

if Line>2
%disp('Layers>2')
    for Li=2:Line-1
        CQ1((Li-1)*3*N+GL(1),((Li-2)*3*N)+1:Li*3*N)=[Q1All_Dis{Li-1}(N,:), -Q1All_Dis{Li}(1,:)];                      %Loop from layers2
        CQ1((Li-1)*3*N+GL(2),((Li-2)*3*N)+1:Li*3*N)=[Q1All_Dis{Li-1}(2*N,:), -Q1All_Dis{Li}(N+1,:)];
        CQ1((Li-1)*3*N+GL(3),((Li-2)*3*N)+1:Li*3*N)=[Q1All_Dis{Li-1}(3*N,:), -Q1All_Dis{Li}(2*N+1,:)];
        
        CQ1((Li-1)*3*N+GL(4),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc1All{Li}(N,Wind), -Bc1All{Li+1}(1,Wind)];
        CQ1((Li-1)*3*N+GL(5),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc1All{Li}(2*N,Wind), -Bc1All{Li+1}(N+1,Wind)];
        CQ1((Li-1)*3*N+GL(6),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc1All{Li}(3*N,Wind), -Bc1All{Li+1}(2*N+1,Wind)];
    end
elseif Line==2
%     disp('Layers==2')
else
%     disp('Pls Layer=1 ')
end
%%
%%
CQ0=zeros(Line*3*N);
Q0All_Dis={MaxLayers};
% 0.001e6*(2*pi):0.001e6*(2*pi):0.5e6*(2*pi)
% 0.3e6*(2*pi)
for Omega=OmegaLoop
    
    for Ro=1:Line
        
        CQ0(Wind+((Ro-1)*3*N),Wind+((Ro-1)*3*N))=Q0All{Ro}+(Omega.^2).*(Mi.*Rou(Ro));
        Q0All_Dis{Ro}=-(Q0All{Ro}+(Omega.^2).*(Mi.*Rou(Ro)))./Rou(Ro);                                  %Speed Up
        
    end
    %%
    %First ：The Layer1
    CQ0(1,1:3*N)=Bc0All{1}(1,1:3*N);
    CQ0(N,1:3*N)=Bc0All{1}(N+1,1:3*N);
    CQ0(N+1,1:3*N)=Bc0All{1}(2*N+1,1:3*N);
    
    CQ0(2*N,1:2*3*N)=[Bc0All{1}(N,:),-Bc0All{2}(1,:)];
    CQ0(2*N+1,1:2*3*N)=[Bc0All{1}(2*N,:),-Bc0All{2}(N+1,:)];
    CQ0(3*N,1:2*3*N)=[Bc0All{1}(3*N,:),-Bc0All{2}(2*N+1,:)];
    
    %Third ：The LayerN(Last)
    CQ0(3*N*(Line-1)+1,(Line-2)*3*N+1:Line*3*N)=[Q0All_Dis{Line-1}(N,:),-Q0All_Dis{Line}(1,:)];                 %UpLayer Sub SelfLayer Displacement
    CQ0(3*N*(Line-1)+N,(Line-2)*3*N+1:Line*3*N)=[Q0All_Dis{Line-1}(2*N,:),-Q0All_Dis{Line}(N+1,:)];
    CQ0(3*N*(Line-1)+N+1,(Line-2)*3*N+1:Line*3*N)=[Q0All_Dis{Line-1}(3*N,:),-Q0All_Dis{Line}(2*N+1,:)];         %Speed Up
    
    CQ0(3*N*(Line-1)+2*N,(Line-1)*3*N+1:Line*3*N)=Bc0All{Line}(N,1:3*N);
    CQ0(3*N*(Line-1)+2*N+1,(Line-1)*3*N+1:Line*3*N)=Bc0All{Line}(2*N,1:3*N);
    CQ0(3*N*(Line-1)+3*N,(Line-1)*3*N+1:Line*3*N)=Bc0All{Line}(3*N,1:3*N);
    %----------------------------------------------------------------------
    %The General Layers
    GL=[1 N N+1 2*N 2*N+1 3*N];
    if Line>2

        for Li=2:Line-1
            CQ0((Li-1)*3*N+GL(1),((Li-2)*3*N)+1:Li*3*N)=[Q0All_Dis{Li-1}(N,:), -Q0All_Dis{Li}(1,:)];                      %Loop from layers2
            CQ0((Li-1)*3*N+GL(2),((Li-2)*3*N)+1:Li*3*N)=[Q0All_Dis{Li-1}(2*N,:), -Q0All_Dis{Li}(N+1,:)];
            CQ0((Li-1)*3*N+GL(3),((Li-2)*3*N)+1:Li*3*N)=[Q0All_Dis{Li-1}(3*N,:), -Q0All_Dis{Li}(2*N+1,:)];
            
            CQ0((Li-1)*3*N+GL(4),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc0All{Li}(N,Wind), -Bc0All{Li+1}(1,Wind)];
            CQ0((Li-1)*3*N+GL(5),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc0All{Li}(2*N,Wind), -Bc0All{Li+1}(N+1,Wind)];
            CQ0((Li-1)*3*N+GL(6),((Li-2)*3*N)+3*N+1:((Li-1)*3*N)+6*N)=[Bc0All{Li}(3*N,Wind), -Bc0All{Li+1}(2*N+1,Wind)];
        end
    elseif Line==2

    else
    end

    %%
    [V3o, KiAll] = quadeig(CQ2, CQ1, CQ0);
    
    Ki=KiAll(1:fix(length(KiAll)*Sub_Muti));
    V3=V3o(:,1:fix(length(KiAll)*Sub_Muti));
end
%%
[Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W]=SortK_WithDis(N,Line,Ki,V3);
Ki_Fp(2) = [];Vis_Fp_U(:,2)=[];Vis_Fp_V(:,2)=[];Vis_Fp_W(:,2)=[];  Ki_Bp(2) = [];Vis_Bp_U(:,2)=[];Vis_Bp_V(:,2)=[];Vis_Bp_W(:,2)=[];%This is a temporary method to delete sh mode
%Get 
% Ki_Fp     Ki_Bp       Ki_Fc     Ki_Fc

% Vis_Fp_U=[];Vis_Fp_V=[];Vis_Fp_W=[];

% Vis_Bp_U=[];Vis_Bp_V=[];Vis_Bp_W=[];

% Vis_Bc_U=[];Vis_Bc_V=[];Vis_Bc_W=[];

% Vis_Fc_U=[];Vis_Fc_V=[];Vis_Fc_W=[];
%%

%%
%Get Force Fp----
%%
%Get Force_Bp
[Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy]=GetAllForce_BYDis(N,Line,Cons,H,Ang,stiff,Ki_Bp,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W);
[Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy]=GetAllForce_BYDis(N,Line,Cons,H,Ang,stiff,Ki_Fp,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W);
[Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy]=GetAllForce_BYDis(N,Line,Cons,H,Ang,stiff,Ki_Fc,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W);
[Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=GetAllForce_BYDis(N,Line,Cons,H,Ang,stiff,Ki_Bc,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W);




