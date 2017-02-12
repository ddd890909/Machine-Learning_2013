%hw1_16

clear all;
clc;

F = load ('hw1_15_train.dat');
x=F(:,1:4);
y=F(:,5);
[n,m]=size(x);
x=[ones(n,1),x];

repNum=2000;
corNumSum=0;

for j=1:repNum
    s=RandStream('mt19937ar','seed',sum(100*clock));
    RandStream.setDefaultStream(s);
    R=randperm(n);

    w=[0 0 0 0 0];
    corNum=0;
    badPoint=1;
    while badPoint~=0
        badPoint=0;
        for i=1:n
           WtXn=dot(w,x(R(i),:));
           if  y(R(i))*WtXn<=0
              w=w+y(R(i))*x(R(i),:);
              corNum=corNum+1;
              badPoint=badPoint+1;
           end
        end
    end
    corNumSum=corNumSum+corNum;
    
end

aveNumSum=corNumSum/repNum;
fprintf('Average Update Number = %d\n',aveNumSum);
