function [Q2,Q1,Q0,Bc2,Bc1,Bc0]=Get_LayerPk_Tube(Rr,N,h,Stiff,StifPhy,Consz)
%% ---
[cheb_x,D]=chebdif(N,2);
Cheb_r=(h.*cheb_x+2*Rr+h)/2;
% Dr=diag(Cheb_r);
Dro1=diag(Cheb_r.^-1);
Dro2=diag(Cheb_r.^-2);
Di1=(2/h)*D(:,:,1);
Di2=((2/h)^2)*D(:,:,2);

[~,Stiffness] = TransStiff(Stiff,StifPhy);

%% Get Q-210
% 
%% Q2
%     E_2=Stiffness(5,5)*Dro1*-1;
%     E_1=Stiffness(3,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(6,5)*(Dro1*-Consz)+Dro1*(Stiffness(5,1)*(Dro1*1i)+Stiffness(5,3)*1i*Di1+Stiffness(5,6)*-Consz*eye(N))+(Stiffness(3,5)-Stiffness(1,5))*Dro1*1i;
%     E_0=Stiffness(3,1)*((-Dro2)+Dro1*Di1)+(Stiffness(3,3)*Di2)+Stiffness(3,6)*(1i*Consz*Di1)+ Stiffness(6,1)*(Dro1*1i*Consz)+Stiffness(6,3)*1i*Consz*Di1+Stiffness(6,6)*-(Consz.^2)*eye(N)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*(Dro1)+(Stiffness(3,3)-Stiffness(1,3))*Di1+(Stiffness(3,6)-Stiffness(1,6))*1i*Consz*eye(N));
% 
%     F_2=Dro1*Stiffness(5,1)*Dro1*-1;
%     F_1=Stiffness(3,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,1)*Dro1*(-Consz)+Dro1*Stiffness(5,4)*(-Consz)+Dro1*Stiffness(5,5)*(1i*Di1-Dro1*1i)+Dro1*((Stiffness(3,1)-Stiffness(1,1))*Dro1*1i);
%     F_0=Stiffness(3,4)*1i*Consz*Di1+Stiffness(3,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(6,4)*(-Consz.^2)*eye(N)+Stiffness(6,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*1i*Consz*eye(N)+(Stiffness(3,5)-Stiffness(1,5))*(Di1-Dro1));
% 
%     D_2=Stiffness(5,4)*Dro1*-1;
%     D_1=Stiffness(3,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(6,4)*Dro1*-Consz+Dro1*(Stiffness(5,2)*-Consz*eye(N)+Stiffness(5,6)*1i*Dro1)+Dro1*((Stiffness(3,4)-Stiffness(1,4))*Dro1*1i);
%     D_0=Stiffness(3,2)*1i*Consz*Di1+Stiffness(3,6)*Di2+Stiffness(6,2)*-Consz.^2*eye(N)+Stiffness(6,6)*1i*Consz*Di1+Dro1*((Stiffness(3,2)-Stiffness(1,2))*1i*Consz*eye(N)+(Stiffness(3,6)-Stiffness(1,6))*Dro1);
% %%
% 
%     H_2=Dro1*Stiffness(1,5)*Dro1*-1;
%     H_1=Stiffness(5,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(4,5)*(Dro1*-Consz)+Dro1*(Stiffness(1,1)*(Dro1*1i)+Stiffness(1,3)*1i*Di1+Stiffness(1,6)*-Consz*eye(N))+2*Dro1*(Stiffness(5,5))*Dro1*1i;
%     H_0=Stiffness(5,1)*((-Dro2)+Dro1*Di1)+(Stiffness(5,3)*Di2)+Stiffness(5,6)*(1i*Consz*Di1)+ Stiffness(4,1)*(Dro1*1i*Consz)+Stiffness(4,3)*1i*Consz*Di1+Stiffness(4,6)*-(Consz.^2)*eye(N)+2*Dro1*(Stiffness(5,1)*(Dro1)+Stiffness(5,3)*Di1+Stiffness(5,6)*1i*Consz*eye(N));
% 
%     I_2=Dro1*Stiffness(1,1)*Dro1*-1;
%     I_1=Stiffness(5,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,1)*Dro1*(-Consz)+Dro1*Stiffness(1,4)*(-Consz)+Dro1*Stiffness(1,5)*(1i*Di1-Dro1*1i)+Dro1*((2*Stiffness(5,1))*Dro1*1i);
%     I_0=Stiffness(5,4)*1i*Consz*Di1+Stiffness(5,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(4,4)*(-Consz.^2)*eye(N)+Stiffness(4,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((2*Stiffness(5,4))*1i*Consz*eye(N)+(2*Stiffness(5,5))*(Di1-Dro1));
% 
%     G_2=Stiffness(1,4)*Dro1*-1;
%     G_1=Stiffness(5,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(4,4)*Dro1*-Consz+Dro1*(Stiffness(1,2)*-Consz*eye(N)+Stiffness(1,6)*1i*Dro1)+Dro1*((2*Stiffness(5,4))*Dro1*1i);
%     G_0=Stiffness(5,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(4,2)*-Consz.^2*eye(N)+Stiffness(4,6)*1i*Consz*Di1+Dro1*((2*Stiffness(5,2))*1i*Consz*eye(N)+(2*Stiffness(5,6))*Dro1);
% 
% 
% %%
%     B_2=Stiffness(4,5)*Dro1*-1;
%     B_1=Stiffness(6,5)*(-Dro2*1i+Dro1*1i*Di1)+Stiffness(2,5)*(Dro1*-Consz)+Dro1*(Stiffness(4,1)*(Dro1*1i)+Stiffness(6,3)*1i*Di1+Stiffness(4,6)*-Consz*eye(N))+(2*Stiffness(6,5))*Dro1*1i;
%     B_0=Stiffness(6,1)*((-Dro2)+Dro1*Di1)+(Stiffness(6,3)*Di2)+Stiffness(6,6)*(1i*Consz*Di1)+ Stiffness(2,1)*(Dro1*1i*Consz)+Stiffness(2,3)*1i*Consz*Di1+Stiffness(2,6)*-(Consz.^2)*eye(N)+Dro1*((2*Stiffness(6,1))*(Dro1)+(2*Stiffness(6,3))*Di1+(2*Stiffness(6,6))*1i*Consz*eye(N));
% 
%     C_2=Dro1*Stiffness(4,1)*Dro1*-1;
%     C_1=Stiffness(6,1)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,1)*Dro1*(-Consz)+Dro1*Stiffness(4,4)*(-Consz)+Dro1*Stiffness(4,5)*(1i*Di1-Dro1*1i)+Dro1*((2*Stiffness(6,1))*Dro1*1i);
%     C_0=Stiffness(6,4)*1i*Consz*Di1+Stiffness(6,5)*(Di2-(-Dro2+Dro1*Di1))+Stiffness(2,4)*(-Consz.^2)*eye(N)+Stiffness(2,5)*(1i*Consz*Dro1-Dro1*1i*Consz)+Dro1*((2*Stiffness(6,4))*1i*Consz*eye(N)+(2*Stiffness(6,5))*(Di1-Dro1));
% 
%     A_2=Dro1*(Stiffness(4,4)*Dro1*-1);
%     A_1=Stiffness(5,4)*((-Dro2)*1i+Dro1*1i*Di1)+Stiffness(2,4)*Dro1*-Consz+Dro1*(Stiffness(4,2)*-Consz*eye(N)+Stiffness(4,6)*1i*Dro1)+Dro1*(Stiffness(6,4)*Dro1*1i);
%     A_0=Stiffness(5,2)*1i*Consz*Di1+Stiffness(5,6)*Di2+Stiffness(2,2)*-Consz.^2*eye(N)+Stiffness(2,6)*1i*Consz*Di1+Dro1*(Stiffness(6,2)*1i*Consz*eye(N)+Stiffness(6,6)*Dro1);
%%
%     Q2=[A_2 B_2 C_2; D_2 E_2 F_2;G_2 H_2 I_2];
%     Q1=[A_1 B_1 C_1; D_1 E_1 F_1;G_1 H_1 I_1];
%     Q0=[A_0 B_0 C_0; D_0 E_0 F_0;G_0 H_0 I_0];
%     %% Bc 210
%     Bce2=zeros(N);
%     Bcf2=zeros(N);
%     Bcd2=zeros(N);
% 
%     Bch2=zeros(N);
%     Bci2=zeros(N);
%     Bcg2=zeros(N);
% 
%     Bcb2=zeros(N);
%     Bcc2=zeros(N);
%     Bca2=zeros(N);
%     Bc2=[Bca2 Bcb2 Bcc2;Bcd2 Bce2 Bcf2;Bcg2 Bch2 Bci2];
% 
%     Bce1=Stiffness(3,5)*Dro1*1i;
%     Bcf1=Stiffness(3,1)*Dro1*1i;
%     Bcd1=Stiffness(3,4)*Dro1*1i;
% 
%     Bch1=Stiffness(5,5)*Dro1*1i;
%     Bci1=Stiffness(5,1)*Dro1*1i;
%     Bcg1=Stiffness(5,4)*Dro1*1i;
% 
%     Bcb1=Stiffness(6,5)*Dro1*1i;
%     Bcc1=Stiffness(6,1)*Dro1*1i;
%     Bca1=Stiffness(6,4)*Dro1*1i;
%     Bc1=[Bca1 Bcb1 Bcc1;Bcd1 Bce1 Bcf1;Bcg1 Bch1 Bci1];
% 
%     Bce0=Stiffness(3,1)*Dro1+Stiffness(3,3)*Di1+Stiffness(3,6)*1i*Consz*eye(N);
%     Bcf0=Stiffness(3,4)*1i*Consz+Stiffness(3,5)*(Di1-Dro1);
%     Bcd0=Stiffness(3,2)*1i*Consz*eye(N)+Stiffness(3,6)*Di1;
% 
%     Bch0=Stiffness(5,1)*Dro1+Stiffness(5,3)*Di1+Stiffness(5,6)*1i*Consz*eye(N);
%     Bci0=Stiffness(5,4)*1i*Consz+Stiffness(5,5)*(Di1-Dro1);   
%     Bcg0=Stiffness(5,2)*1i*Consz*eye(N)+Stiffness(5,6)*Di1;  
% 
%     Bcb0=Stiffness(6,1)*Dro1+Stiffness(6,3)*Di1+Stiffness(6,6)*1i*Consz*eye(N);
%     Bcc0=Stiffness(6,4)*1i*Consz+Stiffness(6,5)*(Di1-Dro1);
%     Bca0=Stiffness(6,2)*1i*Consz*eye(N)+Stiffness(6,6)*Di1;
%     Bc0=[Bca0 Bcb0 Bcc0;Bcd0 Bce0 Bcf0;Bcg0 Bch0 Bci0];

%% Get Q-210 Erro!

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


%%
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