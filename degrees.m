function [G,tot]=degrees(m,r,alpha, mu,sigma) 
%This function is for generating random bipartite graph, 
% "m" is the number of the users
% "r" is the number of the groups
% "alpha" is PA parameter
% "mu" is the average number of group size
% "sigma" is variance of the  group size
tot= normrnd(mu, sigma); 
pop=ones(1,r); 
G=false(m,r); 
for(i=1:tot)     
    temp=sum(pop);     
    probs=pop/temp;     
    group_index=randsample(r,1,true,probs);     
    pop(group_index)= (pop(group_index)^(1/alpha)+1)^alpha;     
    if(sum(G(:,group_index)==0) >0)
    user_index= randsample(find(G(:,group_index)==0), 1);
    end
    G(user_index,group_index)=1;
end
