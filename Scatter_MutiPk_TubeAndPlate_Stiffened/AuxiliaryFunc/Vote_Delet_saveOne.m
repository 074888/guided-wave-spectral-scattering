function[Ki_out,V3_out]= Vote_Delet_saveOne(Er,Tolerance,VoteTolerance,Kall,V3)    
%% Vote
%     Er=1e-2;
%     Tolerance=5e1;    interval
%     VoteTolerance=4;  number of items to deleted
    %% ------------
    [Row,~]=find((abs(imag(Kall))<Er));
    Kall_Judge=Kall(Row);
    DeletIndex=[];
    for Lo=1:length(Row)

        Result=abs((abs(real(Kall(Row(Lo)))))-abs(real(Kall_Judge)));
        [VoteResult,~]=find(Result<Tolerance);
        VoteNum=length(VoteResult);
        if VoteNum>VoteTolerance

            DeletIndex=[DeletIndex Row(Lo)];

        end

    end
%% DeletIndex
% [save_index_index,~]=find(real(Kall(DeletIndex))>0); %Do you need keep one of many removed roots?
% DeletIndex(save_index_index(1))=[];

Kall(DeletIndex)=[];
V3(:,DeletIndex)=[];

Ki_out=Kall;
V3_out=V3;
