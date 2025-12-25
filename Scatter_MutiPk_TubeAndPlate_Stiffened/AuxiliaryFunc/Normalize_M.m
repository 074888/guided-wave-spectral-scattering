function [J,JAll]=Normalize_M(Line,N,H,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M)
%%
Vis_Fp_U_M=conj(Vis_Fp_U_M);
Vis_Fp_V_M=conj(Vis_Fp_V_M);
Vis_Fp_W_M=conj(Vis_Fp_W_M);
%%
J={};

for Lo=1:Line
    %XY-Layer_N;
    XY=Vis_Fp_U_M(N*(Lo-1)+1:N*Lo,:).*Force_Fp_xx_M(N*(Lo-1)+1:N*Lo,:)+Vis_Fp_V_M(N*(Lo-1)+1:N*Lo,:).*Force_Fp_xy_M(N*(Lo-1)+1:N*Lo,:)+Vis_Fp_W_M(N*(Lo-1)+1:N*Lo,:).*Force_Fp_xz_M(N*(Lo-1)+1:N*Lo,:);
    %------------------------------ Get Differential Martrix
    h=H(Lo);
    [~,D]=chebdif(N,1);
    D=(2/h)*D(:,:,1);
    I = 1:N-1;
    Di = inv(D(I,I)); Ww = Di(1,:);
    %------------------------------
    [~,col]=size(XY);

    % Cal The N Mode J of LayerN
    J_Layern=[];
    for xycol=1:col

        ThXY=Ww*XY(1:N-1,xycol);    
        J_Layern=[J_Layern ThXY];
    end
    J{Lo}=J_Layern;
end
JAll(1:col)=0;
for Lo=1:Line
    JAll=J{Lo}+JAll;
end
JAll=sqrt(abs(JAll));