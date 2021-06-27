function [av_c,av_I] = Nq (m,r, mu, ITER_IN_GRAPH, alpha,P1,P2,k)
% this function includes the attack algoritm  
% "m" is the number of the users
% "r" is the number of the groups
% "alpha" is PA parameter
% "mu" is the average number of group size
% "sigma" is variance of the  group size
% "ITER_IN_GRAPH" number of iterations
% "P1" first probability of  error for query matrix
% "P2" second probability of  error for query matrix
% "k" the number of pricvacy setting

Pq01=0;
Pq10=0;
format long

%% Generating Random Matrix
[G,T]=degrees(m,r,alpha, mu,0.0000001) ;

%% add noise to the ground truth matrix
Gq=Error(G,0,0);
T=sum(sum(G));
Gs=Error_Q(G,P1,P2,k);

%% feature of the network
e=0.1;
I0= -log2(m)-log2(1/e);
PZ=[1-(T/m)/r, (T/m)/r];
PUgivenZ=zeros(2,2,2^k);
PYgivenZ = [1-Pq01 Pq10;Pq01 1-Pq10];
[PY,PYgivenU,PZgivenU]=Query_prob(PYgivenZ,PUgivenZ,PZ,k,P1,P2);

%% the attack strategy
for(lp=1:ITER_IN_GRAPH)
    [Info,correctLabel(lp),i]=track_startegy_Query (r,m,k,Gs,G,PZgivenU,PZ,I0);
    Iter(lp)=i;
end
%% number of queries and the correct matching ratio
av_c=sum(correctLabel)/ ITER_IN_GRAPH;
av_I= sum(Iter)/ ITER_IN_GRAPH;

