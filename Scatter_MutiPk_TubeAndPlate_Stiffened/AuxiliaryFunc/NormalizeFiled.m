function [Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M]=NormalizeFiled(JAll,Vis_Fp_U_M,Vis_Fp_V_M,Vis_Fp_W_M,Force_Fp_xx_M,Force_Fp_xy_M,Force_Fp_xz_M)
%%
Vis_Fp_U_M=Vis_Fp_U_M./JAll;
Vis_Fp_V_M=Vis_Fp_V_M./JAll;
Vis_Fp_W_M=Vis_Fp_W_M./JAll;


Force_Fp_xx_M=Force_Fp_xx_M./JAll;
Force_Fp_xy_M=Force_Fp_xy_M./JAll;
Force_Fp_xz_M=Force_Fp_xz_M./JAll;
%%