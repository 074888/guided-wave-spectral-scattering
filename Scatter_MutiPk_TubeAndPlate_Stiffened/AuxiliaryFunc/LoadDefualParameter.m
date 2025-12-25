function[GRE_C,GRE_Rou,SteelAloy1021_C,SteelAloy1021_Rou,Al_C,Al_Rou,Ok_C,Ok_Rou,NomalSteel_C,NomalSteel_Rou,Graphepoxy,Graphepoxy_Rou]=LoadDefualParameter
%Defual Parameter
%--------------------------------------------------------------------------
%GRE
GRE_Rou=1610;
C11=162e9;C12=10.6e9;C13=13e9;       C14=0;C15=0;C16=0;
C21=10.6e9;C22=15.3e9;C23=8.2e9;     C24=0;C25=0;C26=0;
C31=13e9;C32=8.2e9;C33=18.7e9;       C34=0;C35=0;C36=0;
    
C41=0;C42=0;C43=0;                  C44=4.4e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                  C54=0;C55=8.8e9;C56=0;
C61=0;C62=0;C63=0;                  C64=0;C65=0;C66=7.2e9;

GRE_C=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

%%
%SteelAloy1021
 SteelAloy1021_Rou=7850;
 Vs=3184.66;Vp=5957.96;
 miu=Vs^2.*SteelAloy1021_Rou;
 m=miu;
 lame=SteelAloy1021_Rou.*(Vp^2-2.*Vs^2);
 l=lame;
 tml=2.*miu+lame;
    
 C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
 C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
 C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
 C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
 C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
 C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

SteelAloy1021_C=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];

%%
%Al
    Al_Rou=2710;
    Vs=3093.85;Vp=6142.03;
    miu=Vs^2.*Al_Rou;
    m=miu;
    lame=Al_Rou.*(Vp^2-2.*Vs^2);
    l=lame;
    tml=2.*miu+lame;
    
    C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
    C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
    C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
    C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
    C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
    C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

Al_C=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
%%
%OK
Ok_Rou=597;
C11=8.61313e9;   C12=2.17462e9;  C13=2.77298e9;       C14=0;C15=0;C16=0;
C21=2.17462e9;   C22=1.73528e9;  C23=1.06095e9;       C24=0;C25=0;C26=0;
C31=2.77298e9;   C32=1.06095e9;  C33=2.40251e9;       C34=0;C35=0;C36=0;
    
C41=0;C42=0;C43=0;                                    C44=0.3e9;C45=0;C46=0;
C51=0;C52=0;C53=0;                                    C54=0;C55=0.89e9;C56=0;
C61=0;C62=0;C63=0;                                    C64=0;C65=0;C66=0.92e9;

Ok_C=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
%%
%Steel
 NomalSteel_Rou=7850;
 Vs=3203.8;Vp=5911.4;
 miu=Vs^2.*NomalSteel_Rou;
 m=miu;
 lame=NomalSteel_Rou.*(Vp^2-2.*Vs^2);
 l=lame;
 tml=2.*miu+lame;
    
 C11=tml;C12=l;C13=l;C14=0;C15=0;C16=0;
 C21=l;C22=tml;C23=l;C24=0;C25=0;C26=0;
 C31=l;C32=l;C33=tml;C34=0;C35=0;C36=0;
 C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
 C51=0;C52=0;C53=0;C54=0;C55=m;C56=0;
 C61=0;C62=0;C63=0;C64=0;C65=0;C66=m;

NomalSteel_C=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
%% ----
Graphepoxy_Rou=1800;
CN=5.51e9;

C11=160.73e9;C12=6.44e9;C13=6.44e9;      C14=0;C15=0;C16=0;
C21=6.44e9;C22=13.92e9;C23=CN;         C24=0;C25=0;C26=0;
C31=6.44e9;C32=CN;C33=13.92e9;        C34=0;C35=0;C36=0;    

C41=0;C42=0;C43=0;                       C44=5*(C22-C23);C45=0;C46=0;
C51=0;C52=0;C53=0;                       C54=0;C55=7.07e9;C56=0;
C61=0;C62=0;C63=0;                       C64=0;C65=0;C66=7.07e9;

Graphepoxy=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;];
%%
% %Untile
% 
%  C11=13.9;C12=7.78 ;C13=7.43;C14=0;C15=0;C16=0;
%  C21=6.9;C22=13.9;C23=6.9;C24=0;C25=0;C26=0;
%  C31=7.33;C32=6.9;C33=11.5;C34=0;C35=0;C36=0;
%  C41=0;C42=0;C43=0;C44=2.56;C45=0;C46=0;
%  C51=0;C52=0;C53=0;C54=0;C55=2.56;C56=0;
%  C61=0;C62=0;C63=0;C64=0;C65=0;C66=3.06;
% 
%  Rou6=7500;
% C6=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66;].*1e10;
% %%
% %Faker - SteelAloy1021 
%  Rou7=9850;
%  Vs=3184.66;Vp=5957.96;
%  miu=Vs^2.*SteelAloy1021_Rou;
%  m=miu;
%  lame=SteelAloy1021_Rou.*(Vp^2-2.*Vs^2);
%  l=lame;
%  tml=2.*miu+lame;
%     
%  C11=tml;C12=2*l;C13=2*l;C14=0;C15=0;C16=0;
%  C21=2*l;C22=tml;C23=l;C24=0;C25=0;C26=0;
%  C31=2*l;C32=l;C33=tml;C34=0;C35=0;C36=0;
%  C41=0;C42=0;C43=0;C44=m;C45=0;C46=0;
%  C51=0;C52=0;C53=0;C54=0;C55=3*m;C56=0;
%  C61=0;C62=0;C63=0;C64=0;C65=0;C66=2*m;
% 
% C7=[C11 C12 C13 C14 C15 C16;C21 C22 C23 C24 C25 C26;C31 C32 C33 C34 C35 C36;C41 C42 C43 C44 C45 C46;C51 C52 C53 C54 C55 C56;C61 C62 C63 C64 C65 C66];
%%
