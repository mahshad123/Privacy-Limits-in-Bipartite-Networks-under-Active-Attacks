function [av_c,av_I] = main (m,r, ITER_IN_GRAPH, alpha, mu,sigma,Ps01,Ps10,Pq01,Pq10)
    [G,T]=degrees(m,r,alpha, mu,sigma) ;
    Gs=Error(G,Ps10,Ps01) ;
    Gq=Error(G,Pq10,Pq01) ;
    PZ=[1-(T/m)/r, (T/m)/r] ;
    e=0.01;
    I0= -log2(m)-log2(1/e);
    PYgivenZ = [1-Ps01 Ps01;Ps10 1-Ps10];
    PUgivenZ = [1-Pq01 Pq01;Pq10 1-Pq10];
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
    for(l=1:ITER_IN_GRAPH)
        Index_Victim= randi(m,1);
            I=zeros(m,r); 
    S=ones(m,1)*I0;
    i=0;
    Info=I0;
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
    label=find(S>0);
    correctLabel(l)=(label(1)==Index_Victim);
    Iter(l)=i
    end
    d=100;
    av_c=sum(correctLabel)/ ITER_IN_GRAPH;
    av_I= sum(Iter)/ ITER_IN_GRAPH- (m/(d *log2(m/d)))*log2(1/e);
    %av_I= sum(Iter)/ ITER_IN_GRAPH
    