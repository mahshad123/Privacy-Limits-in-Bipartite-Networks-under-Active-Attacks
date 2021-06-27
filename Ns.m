function [av_c,av_I] = Ns (m,r, ITER_IN_GRAPH, alpha, mu,sigma,Pq01,Pq10,P1,P2,k)
% this funxtion includes the attack algoritm  
% "m" is the number of the users
% "r" is the number of the groups
% "alpha" is PA parameter
% "mu" is the average number of group size
% "sigma" is variance of the  group size
% "ITER_IN_GRAPH" number of iterations
% "P1" first probability of  error for scan matrix
% "P2" second probability of  error for scan matrix
% "Pq01" Query matrix error for 0 --> 1
% "Pq10" Query matrix error for 1 --> 0
% "k" number of privacy settings

%% Generating Random graph
    [G,T]=degrees(m,r,alpha, mu,sigma) ;
    
%% add Noise the the Ground truth graph
    Gq=Error(G,Pq10,Pq01) ;
    Gs=Error_S(G,P1,P2,m,r,k);
    
 %% feature of the network
 [PYgivenU,PY]=scan_prob(m,r,T,Pq01,Pq10,P1,P2,k);
    e=0.1;
    I0= -log2(m)-log2(1/e);
    %% the attack strategy
    Info=I0;
    for(l=1:ITER_IN_GRAPH)
        [correctLabel(l),i]=track_strategy_Scan(m,r,k,Info,Gq,Gs,PYgivenU,PY,I0)
        Iter(l)=i
    end
    d=100;
    
    %% number of queries and the correct matching ratio
    av_c=sum(correctLabel)/ ITER_IN_GRAPH;
    av_I= sum(Iter)/ ITER_IN_GRAPH - (m/(d *log2(m/d)))*log2(1/e);
    
    