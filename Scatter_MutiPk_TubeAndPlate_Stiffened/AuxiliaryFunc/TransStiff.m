function[Cc,c] = TransStiff(Elastic,O)  

%%

        C=cosd(O); %Cos(O)
        S=sind(O); %Sin(O)
        
        R1=[1, 0, 0, 0, 0, 0 ;...
            0, C.^2, S.^2,-2*C*S ,0 ,0; ...
            0, S.^2, C.^2,2*C*S ,0 ,0; ...
            0, C*S, -C*S, C.^2-S.^2, 0, 0; ...
            0, 0, 0, 0, C, S;...
            0, 0, 0, 0, -S, C];
        
        R2=[1, 0, 0, 0, 0, 0;
            0, C.^2, S.^2, -C*S, 0, 0;
            0, S.^2, C.^2, C*S,0, 0;
            0, 2*C*S, -2*C*S, C.^2-S.^2, 0, 0;
            0, 0, 0, 0, C, S;
            0, 0, 0, 0, -S, C];

%       Cc=R1*Elastic*inv(R2);  
        Cc=R1*Elastic/(R2);  

%%

        s = sind(O);
        g = cosd(O);
        c(1,1) = Elastic(1,1)*g^4+Elastic(2,2)*s^4+2*(Elastic(1,2)+2*Elastic(6,6))*s^2*g^2;
        c(1,2) = (Elastic(1,1)+Elastic(2,2)-2*Elastic(1,2)-4*Elastic(6,6))*s^2*g^2+Elastic(1,2);
        c(1,3) = Elastic(1,3)*g^2+Elastic(2,3)*s^2;
        c(1,6) = (Elastic(1,2)+2*Elastic(6,6)-Elastic(1,1))*s*g^3+(Elastic(2,2)-Elastic(1,2)-2*Elastic(6,6))*g*s^3;
        c(2,2) = Elastic(1,1)*s^4+Elastic(2,2)*g^4+2*(Elastic(1,2)+2*Elastic(6,6))*s^2*g^2;
        c(2,3) = Elastic(2,3)*g^2+Elastic(1,3)*s^2;  
        c(2,6) = (Elastic(1,2)+2*Elastic(6,6)-Elastic(1,1))*g*s^3+(Elastic(2,2)-Elastic(1,2)-2*Elastic(6,6))*s*g^3;
        c(3,3) = Elastic(3,3);
        c(3,6) = (Elastic(2,3)-Elastic(1,3))*s*g;
        c(4,4) = Elastic(4,4)*g^2+Elastic(5,5)*s^2;
        c(4,5) = (Elastic(4,4)-Elastic(5,5))*s*g;
        c(5,5) = Elastic(5,5)*g^2+Elastic(4,4)*s^2;
        c(6,6) = Elastic(6,6)+(Elastic(1,1)+Elastic(2,2)-2*Elastic(1,2)-4*Elastic(6,6))*s^2*g^2;
        
        c(2,1) = c(1,2);
        c(3,1) = c(1,3);
        c(3,2) = c(2,3);
        c(5,4) = c(4,5);
        c(6,1) = c(1,6);
        c(6,2) = c(2,6);
        c(6,3) = c(3,6);

%%

        