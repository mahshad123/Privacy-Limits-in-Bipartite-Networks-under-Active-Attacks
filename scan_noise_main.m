% Effect of scan noise on the number of queries
%Output:
% 1. figure of the average number of queries based on the number of users 
% 2. figure of the accurate matching based on the number of users 
% in this file number of users are 1000 , 2000, 5000 and 10000

%% Inputs
matrixgen=5; %number of matrix generating
ITER=100;    % number of iteration for each matrix
P1=0.1;   % First probability of error for Scan matrix
P2=0.01;   % Second probability of error for Scan matrix
Pq01=0;   % Query matrix error for 0 --> 1
Pq10=0;   % Query matrix error for 1 --> 0
alpha=1;   %chractristic for PA graph


%% main code
A=zeros(4,5,5);
B=A;
for(k=1:5)
for(t=1:5)
    tt=0;
    for(m= [1000 2000 5000 10000])
        tt=tt+1;
        r=0.4*m;
        mu=100*r;
        ITER=100;
        alpha=1;
        P1=0.01;
        P2=0.3;
        [av_c av_I]=main_Ns(m,r,mu,ITER,alpha,P1,P2,k)
        A(k,t,tt)=av_c;
        B(k,t,tt)=av_I;
    end
end
end
x=[1000 2000 5000 10000];
y=zeros(5,4);
Q=zeros(5,4);
for i= 1 : 5 
    y(i,:)=[mean(A(i,:,1))  mean(A(i,:,2))   mean(A(i,:,3))   mean(A(i,:,4)) ];
    Q(i,:)=[mean(B(i,:,1))  mean(B(i,:,2))   mean(B(i,:,3))   mean(B(i,:,4)) ];
    
end
plot(x,y(1,:),x,y(2,:),x,y(3,:),x,y(4,:),x,y(5,:))
legend({'k=1','k=2','k=3','k=4','k=5'},'Location','southeast')
xlabel('Users') 
ylabel('1-Pe') 
figure

plot(x,Q(1,:),x,Q(2,:),x,Q(3,:),x,Q(4,:),x,Q(5,:))
legend({'k=1','k=2','k=3','k=4','k=5'},'Location','southeast')
xlabel('Users') 
ylabel('Queries') 

        
        