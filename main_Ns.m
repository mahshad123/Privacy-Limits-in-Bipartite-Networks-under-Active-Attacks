function [correctLabel,Iter,av_c,av_I] = Ns (m,r, ITER_IN_GRAPH, alpha, mu,sigma,Pq01,Pq10,P1,P2,k)
    [G,T]=degrees(m,r,alpha, mu,sigma) ;
    Gq=Error(G,Pq10,Pq01) ;
    Gs=zeros(m,r);
    
    for w=1 : 2^k
                Ps10=((w-1)/(2^k-1))*P1+(1-(w-1)/(2^k-1))*P2;
                Ps01=Ps10;
                Gs(round(((w-1)/(2^k))*m+1) :round(w/(2^k)*m),:)=Error(G(round(((w-1)/(2^k))*m+1) :round(w/(2^k)*m),:),Ps10,Ps01) ;
    end
    PZ=[1-(T/m)/r, (T/m)/r] ;
    PYgivenZ = [1-Pq01 Pq01;Pq10 1-Pq10];
    PY=PZ*PYgivenZ;
    PYgivenU= zeros(2^k-1,2,2);
    for jj=1 : 2^k
    Ps10=((jj-1)/(2^k-1))*P1+(1-(jj-1)/(2^k-1))*P2;
    Ps01=Ps10;
    PUgivenZ = [1-Ps01 Ps01;Ps10 1-Ps10];
    PU= PZ*PUgivenZ;
    
                for(iii=1:2)
                for(jjj=1:2)
                PZgivenU(jj,iii,jjj)= PZ(iii)*PUgivenZ(jjj,iii)/PU(jjj);
                end
                end
                for(iii=1:2)
                for(jjj=1:2)
                PYgivenU(jj,iii,jjj)=  PZgivenU(jj,1,jjj)*PYgivenZ(iii,1)+ PZgivenU(jj,2,jjj)*PYgivenZ(iii,2);
                end
                end
    end
    
    e=0.1;
    I0= -log2(m)-log2(1/e);
    
    I=zeros(m,r); 
    S=ones(m,1)*I0;
    i=0;
    Info=I0;
    
    for(l=1:ITER_IN_GRAPH)
    Index_Victim= randi(m,1);
    M=zeros(2^k-1,1);
    I=zeros(m,r); 
    Info=I0;
    S=ones(m,1)*I0;
    i=0;
    while Info<0 & i<r
    i=i+1;
        for j =1 : m 
            Y=Gq(Index_Victim,i);
            U=Gs(j,i);
            for jj=1 : 2^k
                A(1,1)=PYgivenU(jj,1,1);
                A(1,2)=PYgivenU(jj,1,2);
                A(2,1)=PYgivenU(jj,2,1);
                A(2,2)=PYgivenU(jj,2,2);
                M(jj,1)=S(j,1)+Information(Y,U,A,PY);
            end
            S(j,1)=max(M(:,1));
            I(j,i)=S(j,1);        
        end
        Info=I(:,i);
    end
    label=find(S>0);
    if(sum(label)>0)
    correctLabel(l)=(label(1)==Index_Victim);
    end
    Iter(l)=i
    end
    d=100;
    av_c=sum(correctLabel)/ ITER_IN_GRAPH;
    av_I= sum(Iter)/ ITER_IN_GRAPH - (m/(d *log2(m/d)))*log2(1/e);
    
    