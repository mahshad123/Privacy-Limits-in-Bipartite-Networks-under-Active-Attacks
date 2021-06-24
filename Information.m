function Info=Information(y,u,PYgivenU,PY)
PYgivenU=PYgivenU(y+1,u+1);
PY=PY(y+1);
    %PZgivenU = P_ZgivenU(U,PUgivenZ,Pz);
    Info = log2(PYgivenU/PY);
    
    