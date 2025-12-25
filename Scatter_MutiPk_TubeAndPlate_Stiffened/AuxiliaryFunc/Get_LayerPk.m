function [Q2,Q1,Q0,Bc2,Bc1,Bc0]=Get_LayerPk(N,h,Stiff,Ang,Cons)

%%
[~,Stiffness] = TransStiff(Stiff,Ang);
[~,D]=chebdif(N,2);
Di1=(2/h)*D(:,:,1);
Di2=(2/h)^2*D(:,:,2);
%%

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
