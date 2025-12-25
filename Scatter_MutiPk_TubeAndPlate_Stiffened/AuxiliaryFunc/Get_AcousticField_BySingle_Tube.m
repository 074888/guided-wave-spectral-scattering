function [Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W...
    ,Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy...
    ,Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy...
    ,Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy...
    ,Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=Get_AcousticField_BySingle_Tube(N,Rr,Consz,Frequency_Input,Layer,Ang,h,ComLine)                                      
%% --------------------
    Er=1e-2;
    Tolerance=5;
    VoteTolerance=4;
%% --------------------
%% Set Parameter
GetPart=ComLine;
Th_A=Rr;
Th_B=Th_A+h;
Meterial=Layer;

[~,Stiffness] = TransStiff(Meterial{2},Ang);  
Rou= Meterial{1};
%%
[cheb_x,D]=chebdif(N,2);
Cheb_r=(h.*cheb_x+Th_A+Th_B)/2;
Dro1=diag(Cheb_r.^-1);
Dro2=diag(Cheb_r.^-2);
Di1=(2/h)*D(:,:,1);
Di2=((2/h)^2)*D(:,:,2);

Fir=Frequency_Input;     Fir=Fir.*(2*pi);
Tir=Frequency_Input;     Tir=Tir.*(2*pi);
Rir=Frequency_Input;     Rir=Rir.*(2*pi);
% %% Get Q-210 Erro!
% 
%     A_2=Dro1*Stiffness(5,5)*Dro1*-1;
%     A_1=Stiffness(3,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(6,5)*(Dro1*-Consz)+Dro1*(Stiffness(5,1)*(Dro1*1i)+Stiffness(5,3)*1i*Di1+Stiffness(5,6)*-Consz*eye(N))+(Stiffness(3,5)-Stiffness(1,5))*Dro1*1i;
%     A_0=Stiffness(3,1)*((-Dro2)+Dro1*Di1)+(Stiffness(3,3)*Di2)+Stiffness(3,6)*(1i*Consz*Di1)+ Stiffness(6,1)*(Dro1*1i*Consz)+Stiffness(6,3)*1i*Consz*Di1+Stiffness(6,6)*-(Consz.^2)*eye(N)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*(Dro1)+(Stiffness(3,3)-Stiffness(1,3))*Di1+(Stiffness(3,6)-Stiffness(1,6))*1i*Consz*eye(N));
% 
%     B_2=Dro1*Stiffness(5,1)*Dro1*-1;
%     B_1=Stiffness(3,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,1)*Dro1*(-Consz)+Dro1*Stiffness(5,4)*(-Consz)+Dro1*Stiffness(5,5)*(1i*Di1-Dro1*1i)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*Dro1*1i);
%     B_0=Stiffness(3,4)*1i*Consz*Di1+Stiffness(3,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(6,4)*(-Consz.^2)*eye(N)+Stiffness(6,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*1i*Consz*eye(N)+(Stiffness(3,5)-Stiffness(1,5))*(Di1-Dro1));
% 
%     C_2=Dro1*Stiffness(5,4)*Dro1*-1;
%     C_1=Stiffness(3,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,4)*Dro1*-Consz+Dro1*(Stiffness(5,2)*-Consz*eye(N)+Stiffness(5,6)*1i*Dro1)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*Dro1*1i);
%     C_0=Stiffness(3,2)*1i*Consz*Di1+Stiffness(3,6)*Di2+Stiffness(6,2)*-Consz.^2*eye(N)+Stiffness(6,6)*1i*Consz*Di1+Dro1*((Stiffness(3,2)-Stiffness(1,2))*1i*Consz*eye(N)+(Stiffness(3,6)-Stiffness(1,6))*Dro1);
% 
% 
% %%
% 
%     D_2=Dro1*Stiffness(1,5)*Dro1*-1;
%     D_1=Stiffness(5,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(4,5)*(Dro1*-Consz)+Dro1*(Stiffness(1,1)*(Dro1*1i)+Stiffness(1,3)*1i*Di1+Stiffness(1,6)*-Consz*eye(N))+2*Dro1*(Stiffness(5,5))*Dro1*1i;
%     D_0=Stiffness(5,1)*((-Dro2)+Dro1*Di1)+(Stiffness(5,3)*Di2)+Stiffness(5,6)*(1i*Consz*Di1)+ Stiffness(4,1)*(Dro1*1i*Consz)+Stiffness(4,3)*1i*Consz*Di1+Stiffness(4,6)*-(Consz.^2)*eye(N)+2*Dro1*(Stiffness(5,1)*(Dro1)+Stiffness(5,3)*Di1+Stiffness(5,6)*1i*Consz*eye(N));
% 
%     E_2=Dro1*Stiffness(1,1)*Dro1*-1;
%     E_1=Stiffness(5,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,1)*Dro1*(-Consz)+Dro1*Stiffness(1,4)*(-Consz)+Dro1*Stiffness(1,5)*(1i*Di1-Dro1*1i)+Dro1*((2*Stiffness(5,1))*Dro1*1i);
%     E_0=Stiffness(5,4)*1i*Consz*Di1+Stiffness(5,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(4,4)*(-Consz.^2)*eye(N)+Stiffness(4,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((2*Stiffness(5,4))*1i*Consz*eye(N)+(2*Stiffness(5,5))*(Di1-Dro1));
% 
%     F_2=Dro1*Stiffness(1,4)*Dro1*-1;
%     F_1=Stiffness(5,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,4)*Dro1*-Consz+Dro1*(Stiffness(1,2)*-Consz*eye(N)+Stiffness(1,6)*1i*Dro1)+Dro1*((2*Stiffness(5,4))*Dro1*1i);
%     F_0=Stiffness(5,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(4,2)*-Consz.^2*eye(N)+Stiffness(4,6)*1i*Consz*Di1+Dro1*((2*Stiffness(5,2))*1i*Consz*eye(N)+(2*Stiffness(5,6))*Dro1);
% 
% 
% %%
%     G_2=Dro1*Stiffness(4,5)*Dro1*-1;
%     G_1=Stiffness(6,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(2,5)*(Dro1*-Consz)+Dro1*(Stiffness(4,1)*(Dro1*1i)+Stiffness(6,3)*1i*Di1+Stiffness(4,6)*-Consz*eye(N))+(2*Stiffness(6,5))*Dro1*1i;
%     G_0=Stiffness(6,1)*((-Dro2)+Dro1*Di1)+(Stiffness(6,3)*Di2)+Stiffness(6,6)*(1i*Consz*Di1)+ Stiffness(2,1)*(Dro1*1i*Consz)+Stiffness(2,3)*1i*Consz*Di1+Stiffness(2,6)*-(Consz.^2)*eye(N)+Dro1*((2*Stiffness(6,1))*(Dro1)+(2*Stiffness(6,3))*Di1+(2*Stiffness(6,6))*1i*Consz*eye(N));
% 
%     H_2=Dro1*Stiffness(4,1)*Dro1*-1;
%     H_1=Stiffness(6,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,1)*Dro1*(-Consz)+Dro1*Stiffness(4,4)*(-Consz)+Dro1*Stiffness(4,5)*(1i*Di1-Dro1*1i)+Dro1*((2*Stiffness(6,1))*Dro1*1i);
%     H_0=Stiffness(6,4)*1i*Consz*Di1+Stiffness(6,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(2,4)*(-Consz.^2)*eye(N)+Stiffness(2,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((2*Stiffness(6,4))*1i*Consz*eye(N)+(2*Stiffness(6,5))*(Di1-Dro1));
% 
%     I_2=Dro1*(Stiffness(4,4)*Dro1*-1);
%     I_1=Stiffness(5,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,4)*Dro1*-Consz+Dro1*(Stiffness(4,2)*-Consz*eye(N)+Stiffness(4,6)*1i*Dro1)+Dro1*(Stiffness(6,4)*Dro1*1i);
%     I_0=Stiffness(5,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(2,2)*-Consz.^2*eye(N)+Stiffness(2,6)*1i*Consz*Di1+Dro1*(Stiffness(6,2)*1i*Consz*eye(N)+Stiffness(6,6)*Dro1);

%% Another one 
% Get Q-210 R
% 

    A_2=Dro1*Stiffness(5,5)*Dro1*-1;
    A_1=Stiffness(3,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(6,5)*(Dro1*-Consz)+Dro1*(Stiffness(5,1)*(Dro1*1i)+Stiffness(5,3)*1i*Di1+Stiffness(5,6)*-Consz*eye(N))+(Stiffness(3,5)-Stiffness(1,5))*Dro1*1i;
    A_0=Stiffness(3,1)*((-Dro2)+Dro1*Di1)+(Stiffness(3,3)*Di2)+Stiffness(3,6)*(1i*Consz*Di1)+ Stiffness(6,1)*(Dro1*1i*Consz)+Stiffness(6,3)*1i*Consz*Di1+Stiffness(6,6)*-(Consz.^2)*eye(N)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*(Dro1)+(Stiffness(3,3)-Stiffness(1,3))*Di1+(Stiffness(3,6)-Stiffness(1,6))*1i*Consz*eye(N));

    B_2=Dro1*Stiffness(5,1)*Dro1*-1;
    B_1=Stiffness(3,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,1)*Dro1*(-Consz)+Dro1*Stiffness(5,4)*(-Consz)+Dro1*Stiffness(5,5)*(1i*Di1-Dro1*1i)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*Dro1*1i);
    B_0=Stiffness(3,4)*1i*Consz*Di1+Stiffness(3,5)*(Di2-(Dro1*Di1))+Stiffness(6,4)*(-Consz.^2)*eye(N)+Stiffness(6,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*1i*Consz*eye(N)+(Stiffness(3,5)-Stiffness(1,5))*(Di1-Dro1));

    C_2=Dro1*Stiffness(5,4)*Dro1*-1;
    C_1=Stiffness(3,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,4)*Dro1*-Consz+Dro1*(Stiffness(5,2)*-Consz*eye(N)+Stiffness(5,6)*1i*Dro1)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*Dro1*1i);
    C_0=Stiffness(3,2)*1i*Consz*Di1+Stiffness(3,6)*Di2+Stiffness(6,2)*-Consz.^2*eye(N)+Stiffness(6,6)*1i*Consz*Di1+Dro1*((Stiffness(3,2)-Stiffness(1,2))*1i*Consz*eye(N)+(Stiffness(3,6)-Stiffness(1,6))*Di1);


% Theta
%√ 
    D_2=Dro1*Stiffness(1,5)*Dro1*-1;
    D_1=Stiffness(5,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(4,5)*(Dro1*-Consz)+Dro1*(Stiffness(1,1)*(Dro1*1i)+Stiffness(1,3)*1i*Di1+Stiffness(1,6)*-Consz*eye(N))+2*Dro1*(Stiffness(5,5))*Dro1*1i;
    D_0=Stiffness(5,1)*((-Dro2)+Dro1*Di1)+(Stiffness(5,3)*Di2)+Stiffness(5,6)*(1i*Consz*Di1)+ Stiffness(4,1)*(Dro1*1i*Consz)+Stiffness(4,3)*1i*Consz*Di1+Stiffness(4,6)*-(Consz.^2)*eye(N)+2*Dro1*(Stiffness(5,1)*(Dro1)+Stiffness(5,3)*Di1+Stiffness(5,6)*1i*Consz*eye(N));

    E_2=Dro1*Stiffness(1,1)*Dro1*-1;
    E_1=Stiffness(5,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,1)*Dro1*(-Consz)+Dro1*Stiffness(1,4)*(-Consz)+Dro1*Stiffness(1,5)*(1i*Di1-Dro1*1i)+Dro1*((2*Stiffness(5,1))*Dro1*1i) +Stiffness(4,1)*Dro1*-Consz;
    E_0=Stiffness(5,4)*1i*Consz*Di1+Stiffness(5,5)*(Di2-(Dro1*Di1))+Stiffness(4,4)*(-Consz.^2)*eye(N)+Stiffness(4,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((2*Stiffness(5,4))*1i*Consz*eye(N)+(2*Stiffness(5,5))*(Di1-Dro1));

    F_2=Dro1*Stiffness(1,4)*Dro1*-1;
    F_1=Stiffness(5,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,4)*Dro1*-Consz+Dro1*(Stiffness(1,2)*-Consz*eye(N)+Stiffness(1,6)*1i*Dro1)+Dro1*((2*Stiffness(5,4))*Dro1*1i);
    F_0=Stiffness(5,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(4,2)*-Consz.^2*eye(N)+Stiffness(4,6)*1i*Consz*Di1+Dro1*((2*Stiffness(5,2))*1i*Consz*eye(N)+(2*Stiffness(5,6))*Dro1);


%Z
    G_2=Dro1*Stiffness(4,5)*Dro1*-1;
    G_1=Stiffness(6,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(2,5)*(Dro1*-Consz)+Dro1*(Stiffness(4,1)*(Dro1*1i)+Stiffness(4,3)*1i*Di1+Stiffness(4,6)*-Consz*eye(N))+Dro1*(Stiffness(6,5))*Dro1*1i;
    G_0=Stiffness(6,1)*((-Dro2)+Dro1*Di1)+(Stiffness(6,3)*Di2)+Stiffness(6,6)*(1i*Consz*Di1)+ Stiffness(2,1)*(Dro1*1i*Consz)+Stiffness(2,3)*1i*Consz*Di1+Stiffness(2,6)*-(Consz.^2)*eye(N)+Dro1*((Stiffness(6,1))*(Dro1)+(Stiffness(6,3))*Di1+(Stiffness(6,6))*1i*Consz*eye(N));

    H_2=Dro1*Stiffness(4,1)*Dro1*-1;
    H_1=Stiffness(6,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,1)*Dro1*(-Consz)+Dro1*Stiffness(4,4)*(-Consz)+Dro1*Stiffness(4,5)*(1i*Di1-Dro1*1i)+Dro1*((Stiffness(6,1))*Dro1*1i);
    H_0=Stiffness(6,4)*1i*Consz*Di1+Stiffness(6,5)*(Di2-(Dro1*Di1))+Stiffness(2,4)*(-Consz.^2)*eye(N)+Stiffness(2,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((Stiffness(6,4))*1i*Consz*eye(N)+(Stiffness(6,5))*(Di1-Dro1));

    I_2=Dro1*(Stiffness(4,4)*Dro1*-1);
    I_1=Stiffness(6,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,4)*Dro1*-Consz+Dro1*(Stiffness(4,2)*-Consz*eye(N)+Stiffness(4,6)*1i*Dro1)+Dro1*(Stiffness(6,4)*Dro1*1i);
    I_0=Stiffness(6,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(2,2)*-Consz.^2*eye(N)+Stiffness(2,6)*1i*Consz*Di1+Dro1*(Stiffness(6,2)*1i*Consz*eye(N)+Stiffness(6,6)*Dro1);

    %% --
%%
    Q2=[A_2 B_2 C_2; D_2 E_2 F_2;G_2 H_2 I_2];
    Q1=[A_1 B_1 C_1; D_1 E_1 F_1;G_1 H_1 I_1];
    Q0=[A_0 B_0 C_0; D_0 E_0 F_0;G_0 H_0 I_0];

    %% Bc 210
    Bca2=zeros(N);
    Bcb2=zeros(N);
    Bcc2=zeros(N);
    Bcd2=zeros(N);
    Bce2=zeros(N);
    Bcf2=zeros(N);
    Bcg2=zeros(N);
    Bch2=zeros(N);
    Bci2=zeros(N);
    Bc2=[Bca2 Bcb2 Bcc2;Bcd2 Bce2 Bcf2;Bcg2 Bch2 Bci2];

    Bca1=Stiffness(3,5)*Dro1*1i;
    Bcb1=Stiffness(3,1)*Dro1*1i;
    Bcc1=Stiffness(3,4)*Dro1*1i;
    Bcd1=Stiffness(5,5)*Dro1*1i;
    Bce1=Stiffness(5,1)*Dro1*1i;
    Bcf1=Stiffness(5,4)*Dro1*1i;
    Bcg1=Stiffness(6,5)*Dro1*1i;
    Bch1=Stiffness(6,1)*Dro1*1i;
    Bci1=Stiffness(6,4)*Dro1*1i;
    Bc1=[Bca1 Bcb1 Bcc1;Bcd1 Bce1 Bcf1;Bcg1 Bch1 Bci1];

    Bca0=Stiffness(3,1)*Dro1+Stiffness(3,3)*Di1+Stiffness(3,6)*1i*Consz*eye(N);
    Bcb0=Stiffness(3,4)*1i*Consz+Stiffness(3,5)*(Di1-Dro1);
    Bcc0=Stiffness(3,2)*1i*Consz*eye(N)+Stiffness(3,6)*Di1;
    Bcd0=Stiffness(5,1)*Dro1+Stiffness(5,3)*Di1+Stiffness(5,6)*1i*Consz*eye(N);
    Bce0=Stiffness(5,4)*1i*Consz+Stiffness(5,5)*(Di1-Dro1);   
    Bcf0=Stiffness(5,2)*1i*Consz*eye(N)+Stiffness(5,6)*Di1;  
    Bcg0=Stiffness(6,1)*Dro1+Stiffness(6,3)*Di1+Stiffness(6,6)*1i*Consz*eye(N);
    Bch0=Stiffness(6,4)*1i*Consz+Stiffness(6,5)*(Di1-Dro1);
    Bci0=Stiffness(6,2)*1i*Consz*eye(N)+Stiffness(6,6)*Di1;
    Bc0=[Bca0 Bcb0 Bcc0;Bcd0 Bce0 Bcf0;Bcg0 Bch0 Bci0];


%% Substitude Q2 Q1 Q0 By BC Conditions
Q2(1,:)=Bc2(1,:);
Q2(N,:)=Bc2(N,:);
Q2(N+1,:)=Bc2(N+1,:);
Q2(2*N,:)=Bc2(2*N,:);
Q2(2*N+1,:)=Bc2(2*N+1,:);
Q2(3*N,:)=Bc2(3*N,:);

Q1(1,:)=Bc1(1,:);
Q1(N,:)=Bc1(N,:);
Q1(N+1,:)=Bc1(N+1,:);
Q1(2*N,:)=Bc1(2*N,:);
Q1(2*N+1,:)=Bc1(2*N+1,:);
Q1(3*N,:)=Bc1(3*N,:);

Q0(1,:)=Bc0(1,:);
Q0(N,:)=Bc0(N,:);
Q0(N+1,:)=Bc0(N+1,:);
Q0(2*N,:)=Bc0(2*N,:);
Q0(2*N+1,:)=Bc0(2*N+1,:);
Q0(3*N,:)=Bc0(3*N,:);

M1=eye(N);M1(1,:)=0;M1(N,:)=0;
M=[M1 zeros(N) zeros(N);zeros(N) M1 zeros(N);zeros(N) zeros(N) M1 ];
R=Rou*M;
%%
for Omega=Fir:Tir:Rir
    Q00=Q0+Omega.^2*R;
    %%
    %Quadeig
    [V3_All, KAll] = quadeig(Q2, Q1, Q00);

%     figure
%     image(abs(Q2));
%     figure
%     image(abs(Q1));
%     figure
%     image(abs(Q00));

    Kall=KAll(1:fix(GetPart*length(KAll)));
    V3=V3_All(:,1:fix(GetPart*length(KAll)));
% ------------------------Vote
    [Kall,V3]= Vote_Delet_saveOne(Er,Tolerance,VoteTolerance,Kall,V3);

end

%% ---All Mode 
[Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W]=SortK_WithDis_Tube_zxy(N,1,Kall,V3);

[Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy]=GetAllForce_BYDis_Tube(Rr,N,1,Consz,h,Ang,Stiffness,Ki_Bp,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W);
[Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy]=GetAllForce_BYDis_Tube(Rr,N,1,Consz,h,Ang,Stiffness,Ki_Fp,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W);
[Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy]=GetAllForce_BYDis_Tube(Rr,N,1,Consz,h,Ang,Stiffness,Ki_Fc,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W);
[Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=GetAllForce_BYDis_Tube(Rr,N,1,Consz,h,Ang,Stiffness,Ki_Bc,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W);