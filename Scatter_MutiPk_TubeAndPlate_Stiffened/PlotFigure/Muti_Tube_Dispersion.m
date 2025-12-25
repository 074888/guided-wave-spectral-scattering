clear;close all;clc

[SteelAlloy1020,AlumiuumAlloy110,Oak,GRERokhlin2011,Steel,Tungsten,Tai,Graphite0,GRERokhlin2011_90,Graphepoxy]=LoadDefualMaterial;                                  %Load Materials
Me1=SteelAlloy1020;Me2=AlumiuumAlloy110;Me3=Oak;Me4=GRERokhlin2011;Me5=Steel;
Me6=Tungsten;Me7=Tai;Me8=Graphite0;Me9=GRERokhlin2011_90;
Me10=Graphepoxy;
%% ---
N=30;
Rr = 0.5;
Consz = 0;
Layers = {Me1,Me4,Me1};
Ang = [0 0 0];
H = [0.001 0.0001 0.001];
ComLine = 0.8;


% 0.01e6:0.01e6:0.2e6
0.05e6:0.05e6:0.5e6;
for Frequency_Input = 0.1e6
[Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U,Vis_Fp_V,Vis_Fp_W,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W,Vis_Bc_U,Vis_Bc_V,Vis_Bc_W,Vis_Fc_U,Vis_Fc_V,Vis_Fc_W...
    ,Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy...
    ,Force_Fp_xx,Force_Fp_yy,Force_Fp_zz,Force_Fp_yz,Force_Fp_xz,Force_Fp_xy...
    ,Force_Fc_xx,Force_Fc_yy,Force_Fc_zz,Force_Fc_yz,Force_Fc_xz,Force_Fc_xy...
    ,Force_Bc_xx,Force_Bc_yy,Force_Bc_zz,Force_Bc_yz,Force_Bc_xz,Force_Bc_xy]=Get_AcousticField_ByMutiLayer_Tube(100,N,Rr,Consz,Frequency_Input,Layers,Ang,H,ComLine);


     figure(10)
%      plot(Frequency_Input,2*pi*Frequency_Input./Ki_Fp,".b",Color=[0 0.4470 0.7410]);hold on
        plot(Frequency_Input,Ki_Fp,"*b",Color=[0 0.4470 0.7410],MarkerSize=10);hold on
     

        [eige,eign,r,U,T,Un,Tn,na,ns,nsh]=circumferential1(Frequency_Input,[Rr,Rr+H(1),Rr+H(1)+H(2),Rr+H(1)+H(2)+H(3)],[1,8,1],50);
        eige_fp = eige(abs(imag(eige))<0.01);
             figure(10)
     plot(Frequency_Input,eige_fp,"or",Marker="o",MarkerSize=10,Color=[0.6350 0.0780 0.1840]);hold on
%      plot(Frequency_Input,2*pi*Frequency_Input./eige_fp,"or",Marker="o",MarkerSize=6,Color=[0.6350 0.0780 0.1840]);hold on
     grid on
    xlabel("频率（Mhz）");
    ylabel("传播模的波数");

end
    eige_fc = eige(abs(imag(eige))>0.01);
    figure(11)
    plot(real(eige_fc),imag(eige_fc),"or",Marker="o",MarkerSize=6,Color=[0.6350 0.0780 0.1840]);hold on
    plot(real(eige_fc),imag(eige_fc),"or",Marker="o",MarkerSize=8,Color=[0.6350 0.0780 0.1840]);hold on

        figure(11)
    plot(real(Ki_Fc),imag(Ki_Fc),"*b",Marker="*",MarkerSize=4,Color=[0 0.4470 0.7410]);hold on
    grid on

    xlabel("波数的实部")
    ylabel("波数的虚部")
% 
grid minor