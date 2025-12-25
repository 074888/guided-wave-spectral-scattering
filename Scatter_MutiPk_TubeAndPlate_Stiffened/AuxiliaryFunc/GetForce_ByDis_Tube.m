function [Force_xx,Force_yy,Force_zz,Force_yz,Force_xz,Force_xy]=GetForce_ByDis_Tube(Lo,Rr,U,V,W,N,H,Consz,Stiffness,kx)
%% u v w对应 sitar z r；

    if Lo>1
        Hall=0;

        for Loo=1:(Lo-1)
            Hall=H(Loo)+Hall;
        end
        Rr_Current=Rr+Hall;
    else
        Rr_Current=Rr;
    end

h=H(Lo);
%%
[cheb_x,D]=chebdif(N,2);
Cheb_r=(h.*cheb_x+2*Rr_Current+h)/2;

Dro1=diag(Cheb_r.^-1);
% Dro2=diag(Cheb_r.^-2);
Di1=(2/h)*D(:,:,1);
% Di2=((2/h)^2)*D(:,:,2);
[~,Co]=size(U);

Uk=[];Vk=[];Wk=[];
for Lo=1:Co
    Uk(:,Lo)=U(:,Lo).*kx(Lo); % @
    Vk(:,Lo)=V(:,Lo).*kx(Lo); % z
    Wk(:,Lo)=W(:,Lo).*kx(Lo); % r

end
%% xyz correspond @ z r
% Force_xx=(Stiffness(1,1).*Uk.*1i)+(Stiffness(1,2).*V.*1i.*Cons)+(Stiffness(1,3).*Di1*W)+(Stiffness(1,4).*Di1*V+Stiffness(1,4).*W.*1i.*Cons)+(Stiffness(1,5).*Di1*U+Stiffness(1,5).*Wk.*1i)+(Stiffness(1,6).*U.*1i.*Cons+Stiffness(1,6).*Vk.*1i);
% Force_yy=(Stiffness(2,1).*Uk.*1i)+(Stiffness(2,2).*V.*1i.*Cons)+(Stiffness(2,3).*Di1*W)+(Stiffness(2,4).*Di1*V+Stiffness(2,4).*W.*1i.*Cons)+(Stiffness(2,5).*Di1*U+Stiffness(2,5).*Wk.*1i)+(Stiffness(2,6).*U.*1i.*Cons+Stiffness(2,6).*Vk.*1i);
% Force_zz=(Stiffness(3,1).*Uk.*1i)+(Stiffness(3,2).*V.*1i.*Cons)+(Stiffness(3,3).*Di1*W)+(Stiffness(3,4).*Di1*V+Stiffness(3,4).*W.*1i.*Cons)+(Stiffness(3,5).*Di1*U+Stiffness(3,5).*Wk.*1i)+(Stiffness(3,6).*U.*1i.*Cons+Stiffness(3,6).*Vk.*1i);
% 
% Force_yz=(Stiffness(4,1).*Uk.*1i)+(Stiffness(4,2).*V.*1i.*Cons)+(Stiffness(4,3).*Di1*W)+(Stiffness(4,4).*Di1*V+Stiffness(4,4).*W.*1i.*Cons)+(Stiffness(4,5).*Di1*U+Stiffness(4,5).*Wk.*1i)+(Stiffness(4,6).*U.*1i.*Cons+Stiffness(4,6).*Vk.*1i);
% Force_xz=(Stiffness(5,1).*Uk.*1i)+(Stiffness(5,2).*V.*1i.*Cons)+(Stiffness(5,3).*Di1*W)+(Stiffness(5,4).*Di1*V+Stiffness(5,4).*W.*1i.*Cons)+(Stiffness(5,5).*Di1*U+Stiffness(5,5).*Wk.*1i)+(Stiffness(5,6).*U.*1i.*Cons+Stiffness(5,6).*Vk.*1i);
% Force_xy=(Stiffness(6,1).*Uk.*1i)+(Stiffness(6,2).*V.*1i.*Cons)+(Stiffness(6,3).*Di1*W)+(Stiffness(6,4).*Di1*V+Stiffness(6,4).*W.*1i.*Cons)+(Stiffness(6,5).*Di1*U+Stiffness(6,5).*Wk.*1i)+(Stiffness(6,6).*U.*1i.*Cons+Stiffness(6,6).*Vk.*1i);

%% Dro1 is martrixs 123 654

Force_xx=Stiffness(1,1)*Dro1*1i*Uk+Stiffness(1,4)*1i*Consz.*U+Stiffness(1,5)*Di1*U-Dro1*U+Stiffness(1,2)*1i*Consz.*V+Stiffness(1,4)*Dro1*1i*Vk+Stiffness(1,6)*Di1*V+Stiffness(1,1)*Dro1*W+Stiffness(1,3)*Di1*W+Stiffness(1,5)*Dro1*1i*Wk+Stiffness(1,6)*1i*Consz*W;
Force_yy=Stiffness(2,1)*Dro1*1i*Uk+Stiffness(2,4)*1i*Consz.*U+Stiffness(2,5)*Di1*U-Dro1*U+Stiffness(2,2)*1i*Consz.*V+Stiffness(2,4)*Dro1*1i*Vk+Stiffness(2,6)*Di1*V+Stiffness(2,1)*Dro1*W+Stiffness(2,3)*Di1*W+Stiffness(2,5)*Dro1*1i*Wk+Stiffness(2,6)*1i*Consz*W;
Force_zz=Stiffness(3,1)*Dro1*1i*Uk+Stiffness(3,4)*1i*Consz.*U+Stiffness(3,5)*Di1*U-Dro1*U+Stiffness(3,2)*1i*Consz.*V+Stiffness(3,4)*Dro1*1i*Vk+Stiffness(3,6)*Di1*V+Stiffness(3,1)*Dro1*W+Stiffness(3,3)*Di1*W+Stiffness(3,5)*Dro1*1i*Wk+Stiffness(3,6)*1i*Consz*W;

Force_yz=Stiffness(6,1)*Dro1*1i*Uk+Stiffness(6,4)*1i*Consz.*U+Stiffness(6,5)*Di1*U-Dro1*U+Stiffness(6,2)*1i*Consz.*V+Stiffness(6,4)*Dro1*1i*Vk+Stiffness(6,6)*Di1*V+Stiffness(6,1)*Dro1*W+Stiffness(6,3)*Di1*W+Stiffness(6,5)*Dro1*1i*Wk+Stiffness(6,6)*1i*Consz*W;
Force_xz=Stiffness(5,1)*Dro1*1i*Uk+Stiffness(5,4)*1i*Consz.*U+Stiffness(5,5)*Di1*U-Dro1*U+Stiffness(5,2)*1i*Consz.*V+Stiffness(5,4)*Dro1*1i*Vk+Stiffness(5,6)*Di1*V+Stiffness(5,1)*Dro1*W+Stiffness(5,3)*Di1*W+Stiffness(5,5)*Dro1*1i*Wk+Stiffness(5,6)*1i*Consz*W;
Force_xy=Stiffness(4,1)*Dro1*1i*Uk+Stiffness(4,4)*1i*Consz.*U+Stiffness(4,5)*Di1*U-Dro1*U+Stiffness(4,2)*1i*Consz.*V+Stiffness(4,4)*Dro1*1i*Vk+Stiffness(4,6)*Di1*V+Stiffness(4,1)*Dro1*W+Stiffness(4,3)*Di1*W+Stiffness(4,5)*Dro1*1i*Wk+Stiffness(4,6)*1i*Consz*W;

%% Dro1 is scalar 123 654

% Dro1=Rr_Current.^-1;
% Force_xx=Stiffness(1,1)*Dro1*1i.*Uk+Stiffness(1,4)*1i*Consz.*U+Stiffness(1,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(1,2)*1i*Consz.*V+Stiffness(1,4)*Dro1*1i.*Vk+Stiffness(1,6)*Di1*V+Stiffness(1,1)*Dro1.*W+Stiffness(1,3)*Di1*W+Stiffness(1,5)*Dro1*1i.*Wk+Stiffness(1,6)*1i*Consz.*W;
% Force_yy=Stiffness(2,1)*Dro1*1i.*Uk+Stiffness(2,4)*1i*Consz.*U+Stiffness(2,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(2,2)*1i*Consz.*V+Stiffness(2,4)*Dro1*1i.*Vk+Stiffness(2,6)*Di1*V+Stiffness(2,1)*Dro1.*W+Stiffness(2,3)*Di1*W+Stiffness(2,5)*Dro1*1i.*Wk+Stiffness(2,6)*1i*Consz.*W;
% Force_zz=Stiffness(3,1)*Dro1*1i.*Uk+Stiffness(3,4)*1i*Consz.*U+Stiffness(3,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(3,2)*1i*Consz.*V+Stiffness(3,4)*Dro1*1i.*Vk+Stiffness(3,6)*Di1*V+Stiffness(3,1)*Dro1.*W+Stiffness(3,3)*Di1*W+Stiffness(3,5)*Dro1*1i.*Wk+Stiffness(3,6)*1i*Consz.*W;
% 
% Force_yz=Stiffness(6,1)*Dro1*1i.*Uk+Stiffness(6,4)*1i*Consz.*U+Stiffness(6,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(6,2)*1i*Consz.*V+Stiffness(6,4)*Dro1*1i.*Vk+Stiffness(6,6)*Di1*V+Stiffness(6,1)*Dro1.*W+Stiffness(6,3)*Di1*W+Stiffness(6,5)*Dro1*1i.*Wk+Stiffness(6,6)*1i*Consz.*W;
% Force_xz=Stiffness(5,1)*Dro1*1i.*Uk+Stiffness(5,4)*1i*Consz.*U+Stiffness(5,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(5,2)*1i*Consz.*V+Stiffness(5,4)*Dro1*1i.*Vk+Stiffness(5,6)*Di1*V+Stiffness(5,1)*Dro1.*W+Stiffness(5,3)*Di1*W+Stiffness(5,5)*Dro1*1i.*Wk+Stiffness(5,6)*1i*Consz.*W;
% Force_xy=Stiffness(4,1)*Dro1*1i.*Uk+Stiffness(4,4)*1i*Consz.*U+Stiffness(4,5)*Di1*U-Stiffness(3,5)*Dro1.*U+Stiffness(4,2)*1i*Consz.*V+Stiffness(4,4)*Dro1*1i.*Vk+Stiffness(4,6)*Di1*V+Stiffness(4,1)*Dro1.*W+Stiffness(4,3)*Di1*W+Stiffness(4,5)*Dro1*1i.*Wk+Stiffness(4,6)*1i*Consz.*W;
