function [av_c,av_I] = PAalpha (m,r, ITER_IN_GRAPH, alpha, mu,sigma,Ps01,Ps10,Pq01,Pq10)
% this function includes the attack algoritm  
% "m" is the number of the users
% "r" is the number of the groups
% "alpha" is PA parameter
% "mu" is the average number of group size
% "sigma" is variance of the  group size
% "ITER_IN_GRAPH" number of iterations
% "Ps01" Scan matrix error for 0 --> 1
% "Ps10" Scan matrix error for 1 --> 0
% "Pq01" Query matrix error for 0 --> 1
% "Pq10" Query matrix error for 1 --> 0

%% Generating Random Matrix
    [G,T]=degrees(m,r,alpha, mu,sigma) ;
%% add noise to the ground truth matrix
    Gs=Error(G,Ps10,Ps01) ;
    Gq=Error(G,Pq10,Pq01) ;
    
%% feature of the network
    PZ=[1-(T/m)/r, (T/m)/r] ;
    e=0.01;
    I0= -log2(m)-log2(1/e);
    PYgivenZ = [1-Ps01 Ps01;Ps10 1-Ps10];
    PUgivenZ = [1-Pq01 Pq01;Pq10 1-Pq10];
    [PY,PYgivenU]=alpha_prob(PYgivenZ,PUgivenZ,PZ);
 %% the attack strategy

    for(l=1:ITER_IN_GRAPH)
        Index_Victim= randi(m,1);
        I=zeros(m,r); 
        S=ones(m,1)*I0;
        i=0;
        Info=I0;
        [S]=track_strategy_PAalph(Index_Victim,Info,PYgivenU,PY,i,Gq,Gs,S,I,r,m);
        label=find(S>0);
        correctLabel(l)=(label(1)==Index_Victim);
        Iter(l)=i
    end
    d=100;
    %% number of queries and the correct matching ratio

    av_c=sum(correctLabel)/ ITER_IN_GRAPH;
    av_I= sum(Iter)/ ITER_IN_GRAPH- (m/(d *log2(m/d)))*log2(1/e);
    %av_I= sum(Iter)/ ITER_IN_GRAPH
    