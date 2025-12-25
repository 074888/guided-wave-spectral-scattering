function [Force_xx,Force_yy,Force_zz,Force_yz,Force_xz,Force_xy]=GetForce_ByDis(U,V,W,N,h,Cons,Stiffness,kx)

%%
[~,D]=chebdif(N,1);
Di1=(2/h)*D(:,:,1);

[~,Co]=size(U);

Uk=[];Vk=[];Wk=[];
for Lo=1:Co
    Uk(:,Lo)=U(:,Lo).*kx(Lo);
    Vk(:,Lo)=V(:,Lo).*kx(Lo);
    Wk(:,Lo)=W(:,Lo).*kx(Lo);

end

Force_xx=(Stiffness(1,1).*Uk.*1i)+(Stiffness(1,2).*V.*1i.*Cons)+(Stiffness(1,3).*Di1*W)+(Stiffness(1,4).*Di1*V+Stiffness(1,4).*W.*1i.*Cons)+(Stiffness(1,5).*Di1*U+Stiffness(1,5).*Wk.*1i)+(Stiffness(1,6).*U.*1i.*Cons+Stiffness(1,6).*Vk.*1i);
Force_yy=(Stiffness(2,1).*Uk.*1i)+(Stiffness(2,2).*V.*1i.*Cons)+(Stiffness(2,3).*Di1*W)+(Stiffness(2,4).*Di1*V+Stiffness(2,4).*W.*1i.*Cons)+(Stiffness(2,5).*Di1*U+Stiffness(2,5).*Wk.*1i)+(Stiffness(2,6).*U.*1i.*Cons+Stiffness(2,6).*Vk.*1i);
Force_zz=(Stiffness(3,1).*Uk.*1i)+(Stiffness(3,2).*V.*1i.*Cons)+(Stiffness(3,3).*Di1*W)+(Stiffness(3,4).*Di1*V+Stiffness(3,4).*W.*1i.*Cons)+(Stiffness(3,5).*Di1*U+Stiffness(3,5).*Wk.*1i)+(Stiffness(3,6).*U.*1i.*Cons+Stiffness(3,6).*Vk.*1i);

Force_yz=(Stiffness(4,1).*Uk.*1i)+(Stiffness(4,2).*V.*1i.*Cons)+(Stiffness(4,3).*Di1*W)+(Stiffness(4,4).*Di1*V+Stiffness(4,4).*W.*1i.*Cons)+(Stiffness(4,5).*Di1*U+Stiffness(4,5).*Wk.*1i)+(Stiffness(4,6).*U.*1i.*Cons+Stiffness(4,6).*Vk.*1i);
Force_xz=(Stiffness(5,1).*Uk.*1i)+(Stiffness(5,2).*V.*1i.*Cons)+(Stiffness(5,3).*Di1*W)+(Stiffness(5,4).*Di1*V+Stiffness(5,4).*W.*1i.*Cons)+(Stiffness(5,5).*Di1*U+Stiffness(5,5).*Wk.*1i)+(Stiffness(5,6).*U.*1i.*Cons+Stiffness(5,6).*Vk.*1i);
Force_xy=(Stiffness(6,1).*Uk.*1i)+(Stiffness(6,2).*V.*1i.*Cons)+(Stiffness(6,3).*Di1*W)+(Stiffness(6,4).*Di1*V+Stiffness(6,4).*W.*1i.*Cons)+(Stiffness(6,5).*Di1*U+Stiffness(6,5).*Wk.*1i)+(Stiffness(6,6).*U.*1i.*Cons+Stiffness(6,6).*Vk.*1i);

%%
% Force_xx=(Stiffness(1,1).*U.*1i.*kx)+(Stiffness(1,2).*V.*1i.*Cons)+(Stiffness(1,3).*Di1*W)+(Stiffness(1,4).*Di1*V+Stiffness(1,4).*W.*1i.*Cons)+(Stiffness(1,5).*Di1*U+Stiffness(1,5).*W.*1i.*kx)+(Stiffness(1,6).*U.*1i.*Cons+Stiffness(1,6).*V.*1i.*kx);
% Force_yy=(Stiffness(2,1).*U.*1i.*kx)+(Stiffness(2,2).*V.*1i.*Cons)+(Stiffness(2,3).*Di1*W)+(Stiffness(2,4).*Di1*V+Stiffness(2,4).*W.*1i.*Cons)+(Stiffness(2,5).*Di1*U+Stiffness(2,5).*W.*1i.*kx)+(Stiffness(2,6).*U.*1i.*Cons+Stiffness(2,6).*V.*1i.*kx);
% Force_zz=(Stiffness(3,1).*U.*1i.*kx)+(Stiffness(3,2).*V.*1i.*Cons)+(Stiffness(3,3).*Di1*W)+(Stiffness(3,4).*Di1*V+Stiffness(3,4).*W.*1i.*Cons)+(Stiffness(3,5).*Di1*U+Stiffness(3,5).*W.*1i.*kx)+(Stiffness(3,6).*U.*1i.*Cons+Stiffness(3,6).*V.*1i.*kx);
% 
% Force_yz=(Stiffness(4,1).*U.*1i.*kx)+(Stiffness(4,2).*V.*1i.*Cons)+(Stiffness(4,3).*Di1*W)+(Stiffness(4,4).*Di1*V+Stiffness(4,4).*W.*1i.*Cons)+(Stiffness(4,5).*Di1*U+Stiffness(4,5).*W.*1i.*kx)+(Stiffness(4,6).*U.*1i.*Cons+Stiffness(4,6).*V.*1i.*kx);
% Force_xz=(Stiffness(5,1).*U.*1i.*kx)+(Stiffness(5,2).*V.*1i.*Cons)+(Stiffness(5,3).*Di1*W)+(Stiffness(5,4).*Di1*V+Stiffness(5,4).*W.*1i.*Cons)+(Stiffness(5,5).*Di1*U+Stiffness(5,5).*W.*1i.*kx)+(Stiffness(5,6).*U.*1i.*Cons+Stiffness(5,6).*V.*1i.*kx);
% Force_xy=(Stiffness(6,1).*U.*1i.*kx)+(Stiffness(6,2).*V.*1i.*Cons)+(Stiffness(6,3).*Di1*W)+(Stiffness(6,4).*Di1*V+Stiffness(6,4).*W.*1i.*Cons)+(Stiffness(6,5).*Di1*U+Stiffness(6,5).*W.*1i.*kx)+(Stiffness(6,6).*U.*1i.*Cons+Stiffness(6,6).*V.*1i.*kx);
%%