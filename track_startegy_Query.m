function [Info,correctLabel,i]=track_startegy_Query (r,m,k,Gs,G,PZgivenU,PZ,I0)
    correctLabel=0;
    S=zeros(m,2^k);
    Index_Victim= randi(m,1);
    i=0;
    flag=0;
        while flag==0 & i<r
        i=i+1;
        Y=G(Index_Victim,i);
        for j =1 : m
            U=Gs(j,i);
            for(l=1:2^k)
                S(j,l)=S(j,l)+log2(PZgivenU(Y+1,U+1,l)/PZ(Y+1));
            end
        end
        Info=zeros(m,1);
        for(j=1:m)
            Info(j)=max(S(j,:))+I0;
        end
        if(max(Info)>0)
            flag=1;
        end
        label=find(Info>0);
        if(sum(label)>0)
            label=find(Info==max(Info));
            correctLabel=(label(1)==Index_Victim);
            
        end
    end
end