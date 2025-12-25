function [Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W...
    ,Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy...
    ,Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy...
    ,Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy...
    ,Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=Get_AcousticField_ByMutiLayer_Tube(MaxLayers,N,Rr,Consz,Frequency_Input,Layers,Ang,H,ComLine,~)                                      
%% --------------------
% Er=Er_Tolerence_Vote(1);Tolerance=Er_Tolerence_Vote(2);VoteTolerance=Er_Tolerence_Vote(3);
%     Er=1e-2;
%     Tolerance=1.5; how many are considered to be pied togerther s roots(Warning:Be careful of losing roots); 
%     VoteTolerance=4; how many are be consider to be throwed away;
    Er=1e-2;
    Tolerance=5; %how many are considered to be pied togerther s roots(Warning:Be careful of losing roots); 
    VoteTolerance=4; %how many are be consider to be throwed away;
tic
%%
%Set Global Parameter 

%The circular frequency which can be single Omega；
% Fi=0.01e6*(2*pi);
% Ti=0.05e6*(2*pi);
% Ri=2e6*(2*pi);
% Frequency_Input=2e6;
Fi=Frequency_Input*(2*pi);
Ti=Frequency_Input*(2*pi);
Ri=Frequency_Input*(2*pi);
OmegaLoop=Fi:Ti:Ri;
%%
%Set Material Parameter
% Layers={Me4,Me2,Me3,Me1,Me4,Me4,Me2,Me3,Me1,Me4};                        %LayerMaterials
% Ang=[45,45,0,0,0,45,45,0,0,0];                                           %Layers Angle
% H=[0.001,0.002,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001];

                                                     %LayerMaterials                                                               %Layers Angle
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
% Stiff={MaxLayers};
% for Lo=1:Line
%     [~,Stiff{Lo}]=TransStiff(stiff{Lo},Ang(Lo));                                  %Transform All Stiffness Martrix
% end
%Here Got All Need Parameters
% Layers Ang H Stifness Rou ;N
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
    if Lo>1
        Hall=0;

        for Loo=1:(Lo-1)
            Hall=H(Loo)+Hall;
        end
        Rr_Current=Rr+Hall;
    else
        Rr_Current=Rr;
    end

    [Q2,Q1,Q0,Bc2,Bc1,Bc0]=Get_LayerPk_Tube(Rr_Current,N,H(Lo),stiff{Lo},Ang(Lo),Consz);
    Q2All{Lo}=Q2;
    Q1All{Lo}=Q1;
    Q0All{Lo}=Q0;                                                          %Without Mrou
    Bc2All{Lo}=Bc2;
    Bc1All{Lo}=Bc1;
    Bc0All{Lo}=Bc0;
end
%Got All Q2 1 0,Bc2 1 0 Bc0 without w.^2*rou
%% Got Displacements Govering Eq Q2 Q1
Q2All_Dis={MaxLayers};
Q1All_Dis={MaxLayers};

for Lo=1:Line
    Q2All_Dis{Lo}=-Q2All{Lo}/Rou(Lo);
    Q1All_Dis{Lo}=-Q1All{Lo}/Rou(Lo);
end
%% Get Combine Matrixs-------------------------------------------------------
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
CQ2(3*N*(Line-1)+1,(Line-2)*3*N+1:Line*3*N)=[Q2All_Dis{Line-1}(N,:),-Q2All_Dis{Line}(1,:)];           %UpLayer Sub SelfLayer Displacement
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
    %% Substitute
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
    
    Kall=KiAll(1:length(KiAll)*ComLine);
    V3=V3o(:,1:length(KiAll)*ComLine);

%% ---------------Vote
    [Kall,V3]= Vote_Delet_saveOne(Er,Tolerance,VoteTolerance,Kall,V3);

end

%% ---All Mode 
[Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W]=SortK_WithDis_Tube_zxy(N,Line,Kall,V3);



[Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy]=GetAllForce_BYDis_Tube(Rr,N,Line,Consz,H,Ang,stiff,Ki_Bp,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W);
[Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy]=GetAllForce_BYDis_Tube(Rr,N,Line,Consz,H,Ang,stiff,Ki_Fp,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W);
[Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy]=GetAllForce_BYDis_Tube(Rr,N,Line,Consz,H,Ang,stiff,Ki_Fc,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W);
[Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=GetAllForce_BYDis_Tube(Rr,N,Line,Consz,H,Ang,stiff,Ki_Bc,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W);