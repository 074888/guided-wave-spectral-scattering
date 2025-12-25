function [ZAll]=Get_ChebLine(N,MaxLayers,H,Line)
% Mode_Dis=mod((length(DisCol_Pro)),Mode_Dis);
[Zz,~]=chebdif(N,1);
Zz=Zz+1;
Zz=Zz./2;             %Zoom to 0-1
SumH=sum(H);

ZzAll={MaxLayers};
for Lo=1:Line
    ZLocalVar=Zz;
    UpHLocalVar=0;
    for LOo=1:Lo
        UpHLocalVar=UpHLocalVar+H(LOo);
    end

    HLocaVar=SumH-UpHLocalVar;
    ZzAll{Lo}=ZLocalVar*H(Lo)+HLocaVar;
end

[~,Why]=size(ZzAll);

ZAll=[];
for Lo=1:Why
    LocalZ=ZzAll{Lo};
    ZAll=[ZAll;LocalZ];
end