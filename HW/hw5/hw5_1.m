%hw5_1

clear all;
clc;

X=[1,0;0,1;0,-1;-1,0;0,2;0,-2;-2,0];
[nX,mX]=size(X);
Y=[-1;-1;-1;1;1;1;1];
Z=zeros(nX,2);
Z(:,1)=X(:,2).^2-2*X(:,1)-2;
Z(:,2)=X(:,1).^2-2*X(:,2)+3;
[nZ,mZ]=size(Z);

A=[0,zeros(1,mZ);zeros(mZ,1),eye(mZ)];
c=zeros(mZ+1,1);
P=zeros(nZ,mZ+1);
for i=1:nZ
    P(i,:)=Y(i)*[1,Z(i,:)];
end
r=ones(nZ,1);

a=quadprog(A,c,-P,-r);
b=a(1);
w=a(2:mZ+1);

figure;
for i=1:nZ
    if Y(i)>=0
        plot(Z(i,1),Z(i,2),'bo');
        hold on;
    else
        plot(Z(i,1),Z(i,2),'bx');
        hold on;
    end   
end
xLine=-0.5;
yLine=-2:0.001:8;
plot(xLine,yLine,'k');
axis([-5 3 -2 8]);
hold on;



