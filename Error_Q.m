function Gs=Error_Q(G,P1,P2,k)
[a b]=size(G);
for i=1 : a
    Index_Error= randi(2^k,1)-1;
    P10=(Index_Error/(2^k-1))*P1+(1-(Index_Error)/(2^k-1))*P2;
    P01=P10;
    for j=1 : b
        if G(i,j)==1
            if rand(1)<P10
                G(i,j)=0;
            end
        elseif G(i,j)==0
            if rand(1)<P01 
                G(i,j)=1;
            end
        end
        
    end
end
Gs=G;




