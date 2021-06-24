function Gs=Error(G,P10,P01)

    P11=1-P10;
    P00=1-P01;
    for i=1 : size(G,1)
        for j=1 : size(G,2)
            if G(i,j)==1
                if rand(1)<P10
                    G(i,j)=0;
                end 
            else
               if rand(1)<P01
                   G(i,j)=1;
               end
            end
            
        end
    end
    Gs=G;




