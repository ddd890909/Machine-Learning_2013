%hw5_4

clear all;
clc;

X=[1,0;0,1;0,-1;-1,0;0,2;0,-2;-2,0];
[nX,mX]=size(X);
Y=[-1;-1;-1;1;1;1;1];

Q=zeros(nX,nX);
for i=1:nX
    for j=1:nX
        Q(i,j)=Y(i)*Y(j)*Kernel( X(i,:)', X(j,:)' );
    end
end
c=-ones(nX,1);
Aeq=Y';
beq=0;
lb=zeros(nX,1);

a=quadprog(Q,c,[],[],Aeq,beq,lb,[])
%[u,v,aSV]=find(a);

for i=2:6
    sum=0;
    for j=2:6
        sum=sum+a(j)*Y(j)*Kernel( X(j,:)', X(i,:)' );
    end
    b(i)=Y(i)-sum;
end

figure;
for i=1:nX
    if Y(i)>=0
        plot(X(i,1),X(i,2),'bo');
        hold on;
    else
        plot(X(i,1),X(i,2),'bx');
        hold on;
    end   
end

ezplot('0.5333*((xLine-2)^2)+0.6666*(yLine.^2)-3.8003=0')
%plot(xLine,yLine,'k');
axis([-3,5,-3,3]);
hold on;



