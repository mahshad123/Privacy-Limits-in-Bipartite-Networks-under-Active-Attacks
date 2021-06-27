function [PY,PYgivenU]=alpha_prob(PYgivenZ,PUgivenZ,PZ)
PU= PZ*PUgivenZ;
    PY=PZ*PYgivenZ;
    for(i=1:2)
        for(j=1:2)
    PZgivenU(i,j)= PZ(i)*PUgivenZ(j,i)/PU(j);
        end
    end
    PYgivenU= zeros(2,2);
    for(i=1:2)
      for(j=1:2)
          PYgivenU(i,j)=  PZgivenU(1,j)*PYgivenZ(i,1)+ PZgivenU(2,j)*PYgivenZ(i,2);
      end
    end
end