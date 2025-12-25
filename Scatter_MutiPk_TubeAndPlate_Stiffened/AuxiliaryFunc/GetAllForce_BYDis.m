function [Force_Bp_xx,Force_Bp_yy,Force_Bp_zz,Force_Bp_yz,Force_Bp_xz,Force_Bp_xy]=GetAllForce_BYDis(N,Line,Cons,H,Ang,stiff,Ki_Bp,Vis_Bp_U,Vis_Bp_V,Vis_Bp_W)
%% ----------
%Can pre-allocated memory to improve speed
%Which_Mode=Which;
Force_Bp_xx=[];
Force_Bp_yy=[];
Force_Bp_zz=[];

Force_Bp_yz=[];
Force_Bp_xz=[];
Force_Bp_xy=[];

if Line==1
    for Lo=1:Line
        U=Vis_Bp_U((Lo-1)*N+1:Lo*N,:);V=Vis_Bp_V((Lo-1)*N+1:Lo*N,:);W=Vis_Bp_W((Lo-1)*N+1:Lo*N,:);                                %Set Single LayerDisplacement；
        h=H(Lo);
%       Stiffness=stiff;                                                                                                  %Set Single thicness Stiffness；
        [~,Stiffness] = TransStiff(stiff,Ang);
        [Force_xx,Force_yy,Force_zz,Force_yz,Force_xz,Force_xy]=GetForce_ByDis(U,V,W,N,h,Cons,Stiffness,Ki_Bp);                   %Get Single layer Force

        Force_Bp_xx=[Force_Bp_xx;Force_xx];
        Force_Bp_yy=[Force_Bp_yy;Force_yy];
        Force_Bp_zz=[Force_Bp_zz;Force_zz];

        Force_Bp_yz=[Force_Bp_yz;Force_yz];
        Force_Bp_xz=[Force_Bp_xz;Force_xz];
        Force_Bp_xy=[Force_Bp_xy;Force_xy];
    end
else
    for Lo=1:Line
        U=Vis_Bp_U((Lo-1)*N+1:Lo*N,:);V=Vis_Bp_V((Lo-1)*N+1:Lo*N,:);W=Vis_Bp_W((Lo-1)*N+1:Lo*N,:);                                %Set Single LayerDisplacement；
        h=H(Lo);
%       Stiffness=stiff{Lo};                                                                                         %Set Single thicness Stiffness；
        [~,Stiffness] = TransStiff(stiff{Lo},Ang(Lo));
        [Force_xx,Force_yy,Force_zz,Force_yz,Force_xz,Force_xy]=GetForce_ByDis(U,V,W,N,h,Cons,Stiffness,Ki_Bp);                   %Get Single layer Force

        Force_Bp_xx=[Force_Bp_xx;Force_xx];
        Force_Bp_yy=[Force_Bp_yy;Force_yy];
        Force_Bp_zz=[Force_Bp_zz;Force_zz];

        Force_Bp_yz=[Force_Bp_yz;Force_yz];
        Force_Bp_xz=[Force_Bp_xz;Force_xz];
        Force_Bp_xy=[Force_Bp_xy;Force_xy];
    end
end
end
%%