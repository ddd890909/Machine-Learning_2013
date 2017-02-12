%hw1_15

clear all;
clc;

F = load ('hw1_15_train.dat');
x=F(:,1:4);
y=F(:,5);
[n,m]=size(x);
x=[ones(n,1),x];

w=[0 0 0 0 0];
corNum=0;
badPoint=1;
while badPoint~=0
    badPoint=0;
    for i=1:n
       WtXn=dot(w,x(i,:));
       if  y(i)*WtXn<=0
          w=w+y(i)*x(i,:);
          corNum=corNum+1;
          badPoint=badPoint+1;
       end
    end
end

fprintf('Update Number = %d\n',corNum);