function [PY,PYgivenU,PZgivenU]=Query_prob(PYgivenZ,PUgivenZ,PZ,k,P1,P2)
PUgivenZ=zeros(2,2,2^k);
for(i=1:2^k)
    P10=((i-1)/(2^k-1))*P1+(1-(i-1)/(2^k-1))*P2;
    P01=P10;
    PUgivenZ(:,:,i) = [1-P10 P01;P10 1-P01];
end
PU=zeros(2,2^k);
for(i=1:2^k)
    for(j=1:2)
        PU(j,i)= PZ(1)*PUgivenZ(j,1,i)+ PZ(2)*PUgivenZ(j,2,i);
    end
end
PY=PZ;
PZgivenU=zeros(2,2,2^k);
for(l=1:2^k)
    for(j=1:2)
        for(i=1:2)
            PZgivenU(i,j,l)= PZ(i)*PUgivenZ(j,i,l)/PU(j,l);
        end
    end
end
PYgivenU= zeros(2,2,2^k);
for(l=1:2^k)
    for(i=1:2)
        for(j=1:2)
            PYgivenU(i,j,l)=  PZgivenU(1,j,l)*PYgivenZ(i,1)+ PZgivenU(2,j,l)*PYgivenZ(i,2);
        end
    end
end
