function [Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W...
    ,Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy...
    ,Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy...
    ,Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy...
    ,Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=Get_AcousticField_BySingleLayer(N,Cons,Frequency_Input,Stiff,Rou,StifPhy,PkPhiy,h,Line)


%%
% [Cs1,Rou1,Cs2,Rou2,Cs3,Rou3,Cs4,Rou4,Cs5,Rou5,Cs6,Rou6,Cs7,Rou7]=LoadDefualParameter;
% % Cs1(6,6)=1000.530000000000000e+10;
% Cc=Cs7;Rour=Rou7;

% [eigen,r,U,T]=lambobliq_Tes(1e6,[0,0.002],9,100,1,Cc,Rour);
% tic
%%
% Cons=1;
% Stiff=Cc;          
% Rou=Rour;
% StifPhy=0;
% N=15;

StifPhy=StifPhy+PkPhiy;
% h=0.002;

Fir=Frequency_Input.*2*pi;
Tir=Frequency_Input.*2*pi;
Rir=Frequency_Input.*2*pi;
%%
[~,Stiffness] = TransStiff(Stiff,StifPhy);  %Trans Stiffness of Z
% [C_F]=TransCoor(Cc,90,90,0,90,0,90,0,90,90);%Input tow Coordinate system included angle
% Stiffness = Cs1;
[~,D]=chebdif(N,2);
Di1=(2/h)*D(:,:,1);
Di2=(2/h)^2*D(:,:,2);

%%
%Q2
A2=(Stiffness(1,1).*-1)*eye(N);
B2=(Stiffness(1,6).*-1)*eye(N);
C2=(Stiffness(1,5).*-1)*eye(N);

D2=(Stiffness(6,1).*-1)*eye(N);
E2=(Stiffness(6,6).*-1)*eye(N);
F2=(Stiffness(6,5).*-1)*eye(N);

G2=(Stiffness(5,1).*-1)*eye(N);
H2=(Stiffness(5,6).*-1)*eye(N);
I2=(Stiffness(5,5).*-1)*eye(N);

Q2=[A2 B2 C2; D2 E2 F2;G2 H2 I2];
%%
%Q1
A1=(Stiffness(1,5).*Di1.*1i)*eye(N)+(Stiffness(1,6).*-1.*Cons)*eye(N)+(Stiffness(6,1).*-1.*Cons)*eye(N)+(Stiffness(5,1).*Di1.*1i)*eye(N);
B1=(Stiffness(1,2).*-1.*Cons)*eye(N)+(Stiffness(1,4).*Di1.*1i)*eye(N)+(Stiffness(6,6).*-1.*Cons)*eye(N)+(Stiffness(5,6).*Di1.*1i)*eye(N);
C1=(Stiffness(1,3).*Di1.*1i)*eye(N)+(Stiffness(1,4).*-1.*Cons)*eye(N)+(Stiffness(6,5).*-1.*Cons)*eye(N)+(Stiffness(5,5).*Di1.*1i)*eye(N);

D1=(Stiffness(6,5).*Di1.*1i)*eye(N)+(Stiffness(6,6).*-1.*Cons)*eye(N)+(Stiffness(2,1).*-1.*Cons)*eye(N)+(Stiffness(4,1).*Di1.*1i)*eye(N);
E1=(Stiffness(6,2).*-1.*Cons)*eye(N)+(Stiffness(6,4).*Di1.*1i)*eye(N)+(Stiffness(2,6).*-1.*Cons)*eye(N)+(Stiffness(4,6).*Di1.*1i)*eye(N);
F1=(Stiffness(6,3).*Di1.*1i)*eye(N)+(Stiffness(6,4).*-1.*Cons)*eye(N)+(Stiffness(2,5).*-1.*Cons)*eye(N)+(Stiffness(4,5).*Di1.*1i)*eye(N);

G1=(Stiffness(5,5).*Di1.*1i)*eye(N)+(Stiffness(5,6).*-1.*Cons)*eye(N)+(Stiffness(4,1).*-1.*Cons)*eye(N)+(Stiffness(3,1).*Di1.*1i)*eye(N);
H1=(Stiffness(5,2).*-1.*Cons)*eye(N)+(Stiffness(5,4).*Di1.*1i)*eye(N)+(Stiffness(4,6).*-1.*Cons)*eye(N)+(Stiffness(3,6).*Di1.*1i)*eye(N);
I1=(Stiffness(5,3).*Di1.*1i)*eye(N)+(Stiffness(5,4).*-1.*Cons)*eye(N)+(Stiffness(4,5).*-1.*Cons)*eye(N)+(Stiffness(3,5).*Di1.*1i)*eye(N);

Q1=[A1 B1 C1; D1 E1 F1;G1 H1 I1];
%%
%Q0
A0=(Stiffness(6,5).*1i.*Cons.*Di1)*eye(N)+(Stiffness(6,6).*-1.*Cons.^2)*eye(N)+(Stiffness(5,5).*Di2)*eye(N)+(Stiffness(5,6).*1i.*Cons.*Di1)*eye(N);
B0=(Stiffness(6,2).*-1.*Cons.^2)*eye(N)+(Stiffness(6,4).*1i.*Cons.*Di1)*eye(N)+(Stiffness(5,2).*1i.*Cons.*Di1)*eye(N)+(Stiffness(5,4).*Di2)*eye(N);
C0=(Stiffness(6,3).*1i.*Cons.*Di1)*eye(N)+(Stiffness(6,4).*-1.*Cons.^2)*eye(N)+(Stiffness(5,3).*Di2)*eye(N)+(Stiffness(5,4).*1i.*Cons.*Di1)*eye(N);

D0=(Stiffness(2,5).*1i.*Cons.*Di1)*eye(N)+(Stiffness(2,6).*-1.*Cons.^2)*eye(N)+(Stiffness(4,5).*Di2)*eye(N)+(Stiffness(4,6).*1i.*Cons.*Di1)*eye(N);
E0=(Stiffness(2,2).*-1.*Cons.^2)*eye(N)+(Stiffness(2,4).*1i.*Cons.*Di1)*eye(N)+(Stiffness(4,2).*1i.*Cons.*Di1)*eye(N)+(Stiffness(4,4).*Di2)*eye(N);
F0=(Stiffness(2,3).*1i.*Cons.*Di1)*eye(N)+(Stiffness(2,4).*-1.*Cons.^2)*eye(N)+(Stiffness(4,3).*Di2)*eye(N)+(Stiffness(4,4).*1i.*Cons.*Di1)*eye(N);

G0=(Stiffness(4,5).*1i.*Cons.*Di1)*eye(N)+(Stiffness(4,6).*-1.*Cons.^2)*eye(N)+(Stiffness(3,5).*Di2)*eye(N)+(Stiffness(3,6).*1i.*Cons.*Di1)*eye(N);
H0=(Stiffness(4,2).*-1.*Cons.^2)*eye(N)+(Stiffness(4,4).*1i.*Cons.*Di1)*eye(N)+(Stiffness(3,2).*1i.*Cons.*Di1)*eye(N)+(Stiffness(3,4).*Di2)*eye(N);
I0=(Stiffness(4,3).*1i.*Cons.*Di1)*eye(N)+(Stiffness(4,4).*-1.*Cons.^2)*eye(N)+(Stiffness(3,3).*Di2)*eye(N)+(Stiffness(3,4).*1i.*Cons.*Di1)*eye(N);

Q0=[A0 B0 C0; D0 E0 F0;G0 H0 I0];
%%


%%
%BC Condition
%BC2
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
%%
%BC1
Bca1=(Stiffness(5,1).*1i)*eye(N);
Bcb1=(Stiffness(5,6).*1i)*eye(N);
Bcc1=(Stiffness(5,5).*1i)*eye(N);

Bcd1=(Stiffness(4,1).*1i)*eye(N);
Bce1=(Stiffness(4,6).*1i)*eye(N);
Bcf1=(Stiffness(4,5).*1i)*eye(N);

Bcg1=(Stiffness(3,1).*1i)*eye(N);
Bch1=(Stiffness(3,6).*1i)*eye(N);
Bci1=(Stiffness(3,5).*1i)*eye(N);

Bc1=[Bca1 Bcb1 Bcc1;Bcd1 Bce1 Bcf1;Bcg1 Bch1 Bci1];
%%
%BC0
Bca0=(Stiffness(5,5).*Di1)*eye(N)+(Stiffness(5,6).*1i.*Cons)*eye(N);
Bcb0=(Stiffness(5,4).*Di1)*eye(N)+(Stiffness(5,2).*1i.*Cons)*eye(N);
Bcc0=(Stiffness(5,3).*Di1)*eye(N)+(Stiffness(5,4).*1i.*Cons)*eye(N);

Bcd0=(Stiffness(4,5).*Di1)*eye(N)+(Stiffness(4,6).*1i.*Cons)*eye(N);
Bce0=(Stiffness(4,4).*Di1)*eye(N)+(Stiffness(4,2).*1i.*Cons)*eye(N);
Bcf0=(Stiffness(4,3).*Di1)*eye(N)+(Stiffness(4,4).*1i.*Cons)*eye(N);

Bcg0=(Stiffness(3,5).*Di1)*eye(N)+(Stiffness(3,6).*1i.*Cons)*eye(N);
Bch0=(Stiffness(3,4).*Di1)*eye(N)+(Stiffness(3,2).*1i.*Cons)*eye(N);
Bci0=(Stiffness(3,3).*Di1)*eye(N)+(Stiffness(3,4).*1i.*Cons)*eye(N);

Bc0=[Bca0 Bcb0 Bcc0;Bcd0 Bce0 Bcf0;Bcg0 Bch0 Bci0];
%%
%%
%Substitude Q2 Q1 Q0 By BC Conditions
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


for Omega=Fir:Tir:Rir
    Q00=Q0+Omega.^2*R;
    %%
    %Quadeig
    [V3o, KiAll] = quadeig(Q2, Q1, Q00);

%     figure
%     image(abs(Q2));
%     figure
%     image(abs(Q1));
%     figure
%     image(abs(Q00));

    Ki=KiAll(1:fix(length(KiAll)*Line));
    V3=V3o(:,1:fix(length(KiAll)*Line));
end
%%
[Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W]=SortK_WithDis(N,1,Ki,V3);
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
[Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy]=GetAllForce_BYDis(N,1,Cons,h,StifPhy,Stiff,Ki_Bp,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W);
[Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy]=GetAllForce_BYDis(N,1,Cons,h,StifPhy,Stiff,Ki_Fp,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W);
[Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy]=GetAllForce_BYDis(N,1,Cons,h,StifPhy,Stiff,Ki_Fc,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W);
[Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=GetAllForce_BYDis(N,1,Cons,h,StifPhy,Stiff,Ki_Bc,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W);

