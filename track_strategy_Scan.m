function [correctLabel,i]=track_strategy_Scan(m,r,k,Info,Gq,Gs,PYgivenU,PY,I0)
    Index_Victim= randi(m,1);
    M=zeros(2^k-1,1);
    I=zeros(m,r); 
    Info=I0;
    S=ones(m,1)*I0;
    i=0;
    while Info<0 & i<r
    i=i+1;
        for j =1 : m 
            Y=Gq(Index_Victim,i);
            U=Gs(j,i);
            for jj=1 : 2^k
                A(1,1)=PYgivenU(jj,1,1);
                A(1,2)=PYgivenU(jj,1,2);
                A(2,1)=PYgivenU(jj,2,1);
                A(2,2)=PYgivenU(jj,2,2);
                M(jj,1)=S(j,1)+Information(Y,U,A,PY);
            end
            S(j,1)=max(M(:,1));
            I(j,i)=S(j,1);        
        end
        Info=I(:,i);
    end
    label=find(S>0);
    if(sum(label)>0)
        correctLabel=(label(1)==Index_Victim);
    end


end