%%    Effect of Alpha on the number of queries

% Effect of Alpha on the number of queries
%Output:
% 1. figure of the average number of queries based on the number of users 
% 2. figure of the accurate matching based on the number of users 
% in this file number of users are 1000 , 2000, 5000 and 10000

%%     inputs:

 


matrixgen=5; %number of matrix generating
ITER=100;    % number of iteration for each matrix
Ps01=0.01;   % Scan matrix error for 0 --> 1
Ps10=0.01;   % Scan matrix error for 1 --> 0
Pq01=0.01;   % Query matrix error for 0 --> 1
Pq10=0.01;   % Query matrix error for 1 --> 0


%%    Main Code


A=zeros(4,5,5);
B=A;
for (alpha=[1 0.8 0.2 0.01])
    n=1;
for(t=1:matrixgen)
    tt=0;
    for(m= [1000 2000 5000 10000])
        tt=tt+1;
        r=0.4*m;
        mu=100*r;
        [av_c av_I]=main(m,r,ITER,alpha,mu,0,Ps01,Ps10,Pq01,Pq10);
        A(n,t,tt)=av_c;
        B(n,t,tt)=av_I;
        n=n+1;
    end
end
end

x=[1000 2000 5000 10000];
y=zeros(4,4);
Q=zeros(4,4);
for i= 1 : 4
    y(i,:)=[mean(A(i,:,1))  mean(A(i,:,2))   mean(A(i,:,3))   mean(A(i,:,4)) ];
    Q(i,:)=[mean(B(i,:,1))  mean(B(i,:,2))   mean(B(i,:,3))   mean(B(i,:,4)) ];
    
end


%%  Figures


plot(x,y(1,:),x,y(2,:),x,y(3,:),x,y(4,:),x,y(5,:))
legend({'alpha=1','alpha=0.8','alpha=0.2','alpha=0.01'},'Location','southeast')
xlabel('Users') 
ylabel('1-Pe') 
figure

plot(x,Q(1,:),x,Q(2,:),x,Q(3,:),x,Q(4,:),x,Q(5,:))
legend({'alpha=1','alpha=0.8','alpha=0.2','alpha=0.01'},'Location','southeast')
xlabel('Users') 
ylabel('Queries') 