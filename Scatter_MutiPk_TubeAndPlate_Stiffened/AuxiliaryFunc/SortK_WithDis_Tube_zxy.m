function [Ki_Fp,Ki_Bp,Ki_Fc,Ki_Bc,Vis_Fp_U_trans,Vis_Fp_V_trans,Vis_Fp_W_trans,Vis_Bp_U_trans,Vis_Bp_V_trans,Vis_Bp_W_trans,Vis_Bc_U_trans,Vis_Bc_V_trans,Vis_Bc_W_trans,Vis_Fc_U_trans,Vis_Fc_V_trans,Vis_Fc_W_trans]=SortK_WithDis_Tube_zxy(N,Lines,Ki_In,V3_In)
% N=20;Layers=4;Ki_In=Ki;V3_In=V3;
% Vis_Fp_U=[];
% Vis_Fp_V=[];
% Vis_Fp_W=[];

% Vis_Bp_U=[];
% Vis_Bp_V=[];
% Vis_Bp_W=[];
 
% Vis_Bc_U=[];
% Vis_Bc_V=[];
% Vis_Bc_W=[];
 
% Vis_Fc_U=[];
% Vis_Fc_V=[];
% Vis_Fc_W=[];
% Ki_In=Ki;V3_In=V3;
Er=1e-1;
%%
% Ki_Rall=Ki_In(abs(imag(Ki_In))<Er);     %Find All Real Root
% Ki_Call=Ki_In(abs(imag(Ki_In))>Er);     %Find All Complex Root

Ki_Rall_Index=find(abs(imag(Ki_In))<Er);           %Find All Real Root Index
Ki_Call_Index=find(abs(imag(Ki_In))>Er);           %Find All Complex Root Index

Ki_Rall=Ki_In(Ki_Rall_Index);                      %Real Ki by Index R
Ki_Call=Ki_In(Ki_Call_Index);                      %Comp Ki by Index C

Vis_KiRall=V3_In(:,Ki_Rall_Index);                 %Vis follow K
Vis_KiCall=V3_In(:,Ki_Call_Index);
%%
%Sort of Propogation
% Ki_Fp=Ki_Rall(real(Ki_Rall)>0);         %Fp is ForwardPropagation;Fc is Forward complex Ex;
% Ki_Bp=Ki_Rall(real(Ki_Rall)<0);
Ki_Fp_Index=find(real(Ki_Rall)>0);
Ki_Bp_Index=find(real(Ki_Rall)<0);

Ki_Fp=Ki_Rall(Ki_Fp_Index);
Ki_Bp=Ki_Rall(Ki_Bp_Index);

Vis_Fp=Vis_KiRall(:,Ki_Fp_Index);
Vis_Bp=Vis_KiRall(:,Ki_Bp_Index);

%Sort Of Complexmode
Ki_Fc_Index=find(imag(Ki_Call)>0);
Ki_Bc_Index=find(imag(Ki_Call)<0);

Ki_Fc=Ki_Call(Ki_Fc_Index);
Ki_Bc=Ki_Call(Ki_Bc_Index);
Vis_Fc=Vis_KiCall(:,Ki_Fc_Index);
Vis_Bc=Vis_KiCall(:,Ki_Bc_Index);
%%
%Sort
[~,Ki_Fc_Desindex]=sort(imag(Ki_Fc)-(real(Ki_Fc)>0),'ascend');  %虚部降序排列+虚部相等按照负实数大的在上？   Real(Ki_Fc) Can muti*10 to make sure that more secure
Ki_Fc=Ki_Fc(Ki_Fc_Desindex);
Vis_Fc=Vis_Fc(:,Ki_Fc_Desindex);

[~,Ki_Bc_Aesindex]=sort(imag(Ki_Bc)-(real(Ki_Bc)>0),'descend');      %虚部降序排列+虚部相等按照负实数大的在上？
Ki_Bc=Ki_Bc(Ki_Bc_Aesindex);
Vis_Bc=Vis_Bc(:,Ki_Bc_Aesindex);

[~,Ki_Fp_Ascindex]=sort(real(Ki_Fp),'descend');                       %实部降序排列+虚部相等按照负实数大的在上？
Ki_Fp=Ki_Fp(Ki_Fp_Ascindex);
Vis_Fp=Vis_Fp(:,Ki_Fp_Ascindex);

[~,Ki_Bp_Desindex]=sort(real(Ki_Bp),'ascend');                      %实部降序排列+虚部相等按照负实数大的在上？
Ki_Bp=Ki_Bp(Ki_Bp_Desindex);
Vis_Bp=Vis_Bp(:,Ki_Bp_Desindex);

%% -------
Vis_Fp_U=[];
Vis_Fp_V=[];
Vis_Fp_W=[];

Vis_Bp_U=[];
Vis_Bp_V=[];
Vis_Bp_W=[];

Vis_Bc_U=[];
Vis_Bc_V=[];
Vis_Bc_W=[];

Vis_Fc_U=[];
Vis_Fc_V=[];
Vis_Fc_W=[];
%%

for Lo=1:Lines
    Vis_Fp_U(N*(Lo-1)+1:N*Lo,:)=Vis_Fp(3*N*(Lo-1)+1:3*N*(Lo-1)+N,:);
    Vis_Fp_V(N*(Lo-1)+1:N*Lo,:)=Vis_Fp(3*N*(Lo-1)+N+1:3*N*(Lo-1)+2*N,:);
    Vis_Fp_W(N*(Lo-1)+1:N*Lo,:)=Vis_Fp(3*N*(Lo-1)+2*N+1:3*N*(Lo-1)+3*N,:);
end

for Lo=1:Lines
    Vis_Bp_U(N*(Lo-1)+1:N*Lo,:)=Vis_Bp(3*N*(Lo-1)+1:3*N*(Lo-1)+N,:);
    Vis_Bp_V(N*(Lo-1)+1:N*Lo,:)=Vis_Bp(3*N*(Lo-1)+N+1:3*N*(Lo-1)+2*N,:);
    Vis_Bp_W(N*(Lo-1)+1:N*Lo,:)=Vis_Bp(3*N*(Lo-1)+2*N+1:3*N*(Lo-1)+3*N,:);
end

for Lo=1:Lines
    Vis_Bc_U(N*(Lo-1)+1:N*Lo,:)=Vis_Bc(3*N*(Lo-1)+1:3*N*(Lo-1)+N,:);
    Vis_Bc_V(N*(Lo-1)+1:N*Lo,:)=Vis_Bc(3*N*(Lo-1)+N+1:3*N*(Lo-1)+2*N,:);
    Vis_Bc_W(N*(Lo-1)+1:N*Lo,:)=Vis_Bc(3*N*(Lo-1)+2*N+1:3*N*(Lo-1)+3*N,:);
end

for Lo=1:Lines
    Vis_Fc_U(N*(Lo-1)+1:N*Lo,:)=Vis_Fc(3*N*(Lo-1)+1:3*N*(Lo-1)+N,:);
    Vis_Fc_V(N*(Lo-1)+1:N*Lo,:)=Vis_Fc(3*N*(Lo-1)+N+1:3*N*(Lo-1)+2*N,:);
    Vis_Fc_W(N*(Lo-1)+1:N*Lo,:)=Vis_Fc(3*N*(Lo-1)+2*N+1:3*N*(Lo-1)+3*N,:);
end
%% ----
%Trans
Vis_Fp_W_trans=Vis_Fp_U;
Vis_Fp_U_trans=Vis_Fp_V;
Vis_Fp_V_trans=Vis_Fp_W;

Vis_Bp_W_trans=Vis_Bp_U;
Vis_Bp_U_trans=Vis_Bp_V;
Vis_Bp_V_trans=Vis_Bp_W;

Vis_Bc_W_trans=Vis_Bc_U;
Vis_Bc_U_trans=Vis_Bc_V;
Vis_Bc_V_trans=Vis_Bc_W;

Vis_Fc_W_trans=Vis_Fc_U;
Vis_Fc_U_trans=Vis_Fc_V;
Vis_Fc_V_trans=Vis_Fc_W;



