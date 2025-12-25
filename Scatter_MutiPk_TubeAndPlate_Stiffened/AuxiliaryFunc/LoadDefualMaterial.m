function[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,WX,GRERokhlin2011_90,Graphepoxy,Graphepoxy_90,Unname...
    ,IsoPlate]=LoadDefualMaterial
%% GRERokhlin2011
Rou=1610;
C11=162e9;C12=10.6e9;C13=13e9;           C14=0;C15=0;C16=0;
C21=10.6e9;C22=15.3e9;C23=8.2e9;         C24=0;C25=0;C26=0;
C31=13e9;C32=8.2e9;C33=18.7e9;           C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=4.4e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=8.8e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=7.2e9;

C1=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

GRERokhlin2011{1}=Rou;
GRERokhlin2011{2}=C1;
% [~,GRERokhlin2011{2}] = TransStiff(GRERokhlin2011{2},90);
%% Oak

Rou=597;
C11=8.61313e9;  C12=2.17462e9;  C13=2.77298e9;       C14=0;C15=0;C16=0;
C21=2.17462e9;     C22=1.73528e9;  C23=1.06095e9;       C24=0;C25=0;C26=0;
C31=2.77298e9;       C32=1.06095e9;      C33=2.40251e9;       C34=0;C35=0;C36=0;
    
C41=0;C42=0;C43=0;                  C44=0.3e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                  C54=0;C55=0.89e9;C56=0;
C61=0;C62=0;C63=0;                  C64=0;C65=0;C66=0.92e9;

C4=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

Oak{1}=Rou;
Oak{2}=C4;
%% SteelAloy1021
 Rou=7850;
%  Vs=3184.66;Vp=5957.96;
 Vs=3203.8;Vp=5911.4;
 miu=Vs^2.*Rou;
 m=miu;
 lame=Rou.*(Vp^2-2.*Vs^2);
 l=lame;
 tml=2.*miu+lame;
    
 C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
 C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
 C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
 C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
 C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
 C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C2=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
SteelAlloy1020{1}=Rou;
SteelAlloy1020{2}=C2;
%% AlumiuumAlloy110
    Rou=2710;
    Vs=3093.85;Vp=6142.03;
    miu=Vs^2.*Rou;
    m=miu;
    lame=Rou.*(Vp^2-2.*Vs^2);
    l=lame;
    tml=2.*miu+lame;
    
    C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
    C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
    C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
    C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
    C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
    C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C3=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
AlumiuumAlloy110{1}=Rou;
AlumiuumAlloy110{2}=C3;
%% Steel              5911.4 3203.8 7850  5940  3200 7850
    Rou=7850;
    Vs=3200;Vp=5940;
    miu=Vs^2.*Rou;
    m=miu;
    lame=Rou.*(Vp^2-2.*Vs^2);
    l=lame;
    tml=2.*miu+lame;
    
    C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
    C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
    C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
    C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
    C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
    C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C5=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
Steel{1}=Rou;
Steel{2}=C5;
%% Tungsten             5460   2620 19300
    Rou=19300;
    Vs=2620;Vp=5460;
    miu=Vs^2.*Rou;
    m=miu;
    lame=Rou.*(Vp^2-2.*Vs^2);
    l=lame;
    tml=2.*miu+lame;
    
    C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
    C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
    C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
    C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
    C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
    C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C6=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
Tungsten{1}=Rou;
Tungsten{2}=C6;
%% Tai 6070   3125 4540
    Rou=4540;
    Vs=3125;Vp=6070;
    miu=Vs^2.*Rou;
    m=miu;
    lame=Rou.*(Vp^2-2.*Vs^2);
    l=lame;
    tml=2.*miu+lame;
    
    C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
    C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
    C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
    C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
    C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
    C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C7=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
Tai{1}=Rou;
Tai{2}=C7;
%% Wx
Rou=1580;
C11=16.7853e9;C12=4.83132e9;C13=4.83132e9;         C14=0;C15=0;C16=0;
C21=4.83132e9;C22=10.1818e9;C23=4.02797e9;            C24=0;C25=0;C26=0;
C31=4.83132;C32=4.02797e9;C33=10.1818e9;           C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=5*(C22-C23);C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=4.5e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=4.5e9;

C8=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

WX{1}=Rou;
WX{2}=C8;
%% GreRokhlin2011_90
Rou=1610;
C11=15.3e9;C12=10.6e9;C13=8.2e9;         C14=0;C15=0;C16=0;
C21=10.6e9;C22=162e9;C23=13e9;           C24=0;C25=0;C26=0;
C31=8.2e9;C32=13e9;C33=18.7e9;           C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=8.8e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=4.4e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=7.2e9;

C1=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

GRERokhlin2011_90{1}=Rou;
GRERokhlin2011_90{2}=C1;
% [~,GRERokhlin2011_90{2}] = TransStiff(GRERokhlin2011_90{2},90);
%% Graphepoxy
Rou=1800;
CN=5.51e9;

C11=160.73e9;C12=6.44e9;C13=6.44e9;      C14=0;C15=0;C16=0;
C21=6.44e9;C22=13.92e9;C23=CN;         C24=0;C25=0;C26=0;
C31=6.44e9;C32=CN;C33=13.92e9;        C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=5*(C22-C23);C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=7.07e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=7.07e9;

C10=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

Graphepoxy{1}=Rou;
Graphepoxy{2}=C10;
%% Graphepoxy_90
Rou=1800;
CN=5.51e9;

C11=13.92e9;C12=6.92e9;C13=6.92e9;      C14=0;C15=0;C16=0;
C21=6.92e9;C22=13.92e9;C23=CN;         C24=0;C25=0;C26=0;
C31=6.92e9;C32=CN;C33=13.92e9;        C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=5*(C22-C23);C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=3.5e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=3.5e9;

C10=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

Graphepoxy_90{1}=Rou;
Graphepoxy_90{2}=C10;
%% Unname
Rou=4640;

C11=30.1e9;C12=16.1e9;C13=11.1e9;           C14=0;C15=0;C16=0;
C21=16.1e9;C22=58e9;C23=8e9;         C24=0;C25=0;C26=0;
C31=11.1e9;C32=8e9;C33=42.9e9;           C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=16.9e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=20.6e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=15.8e9;

C11=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

Unname{1}=Rou;
Unname{2}=C11;
%% Iso Plate
Rou=2800;

Vs=3100;Vp=6400;
miu=Vs^2.*Rou;
m=miu;
lame=Rou.*(Vp^2-2.*Vs^2);
l=lame;
tml=2.*miu+lame;

C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

C12=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

IsoPlate{1}=Rou;
IsoPlate{2}=C12;