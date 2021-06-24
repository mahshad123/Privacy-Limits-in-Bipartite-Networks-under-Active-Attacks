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
PZ=[1-(T/m)/r, (T/m)/r];

%% feature of the network
e=0.1;
I0= -log2(m)-log2(1/e);
PYgivenZ = [1-Pq01 Pq10;Pq01 1-Pq10];
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


%% the attack strategy
for(lp=1:ITER_IN_GRAPH)
    S=zeros(m,2^k);
    lp
    Index_Victim= randi(m,1);
    i=0;
    flag=0;
    while flag==0 & i<r
        i=i+1;
        Y=G(Index_Victim,i);
        
        for j =1 : m
            U=Gs(j,i);
            for(l=1:2^k)
                S(j,l)=S(j,l)+log2(PZgivenU(Y+1,U+1,l)/PZ(Y+1));
            end
        end
        Info=zeros(m,1);
        for(j=1:m)
            Info(j)=max(S(j,:))+I0;
        end
        if(max(Info)>0)
            flag=1;
            1
        end
        label=find(Info>0);
        if(sum(label)>0)
            label=find(Info==max(Info));
            correctLabel(lp)=(label(1)==Index_Victim);
            correctLabel(lp)
        end
    end
    Iter(lp)=i;
end
%% number of queries and the correct matching ratio
av_c=sum(correctLabel)/ ITER_IN_GRAPH;
av_I= sum(Iter)/ ITER_IN_GRAPH;

