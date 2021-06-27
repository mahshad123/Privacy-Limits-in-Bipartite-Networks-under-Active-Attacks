function [PYgivenU,PY]=scan_prob(m,r,T,Pq01,Pq10,P1,P2,k)
    PZ=[1-(T/m)/r, (T/m)/r] ;
    PYgivenZ = [1-Pq01 Pq01;Pq10 1-Pq10];
    PY=PZ*PYgivenZ;
    PYgivenU= zeros(2^k-1,2,2);
    for jj=1 : 2^k
    Ps10=((jj-1)/(2^k-1))*P1+(1-(jj-1)/(2^k-1))*P2;
    Ps01=Ps10;
    PUgivenZ = [1-Ps01 Ps01;Ps10 1-Ps10];
    PU= PZ*PUgivenZ;
    
                for(iii=1:2)
                for(jjj=1:2)
                PZgivenU(jj,iii,jjj)= PZ(iii)*PUgivenZ(jjj,iii)/PU(jjj);
                end
                end
                for(iii=1:2)
                for(jjj=1:2)
                PYgivenU(jj,iii,jjj)=  PZgivenU(jj,1,jjj)*PYgivenZ(iii,1)+ PZgivenU(jj,2,jjj)*PYgivenZ(iii,2);
                end
                end
    end


end