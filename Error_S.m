function [Gs]=Error_S(G,P1,P2,m,r,k)
 Gs=zeros(m,r);
    for w=1 : 2^k
                Ps10=((w-1)/(2^k-1))*P1+(1-(w-1)/(2^k-1))*P2;
                Ps01=Ps10;
                Gs(round(((w-1)/(2^k))*m+1) :round(w/(2^k)*m),:)=Error(G(round(((w-1)/(2^k))*m+1) :round(w/(2^k)*m),:),Ps10,Ps01) ;
    end

end