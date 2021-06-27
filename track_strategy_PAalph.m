function [S]=track_strategy_PAalph(Index_Victim,Info,PYgivenU,PY,i,Gq,Gs,S,I,r,m)
        while Info<0 & i<r
            i=i+1;
            for j =1 : m 
                Y=Gq(Index_Victim,i);
                U=Gs(j,i);
                S(j,1)=S(j,1)+Information(Y,U,PYgivenU,PY);
                I(j,i)=S(j,1);            
            end
            Info=I(:,i);
        end

end