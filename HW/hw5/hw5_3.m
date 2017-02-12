%hw5_3

clear all;
clc;

X=[1,0;0,1;0,-1;-1,0;0,2;0,-2;-2,0];
[nX,mX]=size(X);
Y=[-1;-1;-1;1;1;1;1];
% Z=zeros(nX,2);
% Z(:,1)=X(:,2).^2-2*X(:,1)-2;
% Z(:,2)=X(:,1).^2-2*X(:,2)+3;
% [nZ,mZ]=size(Z);

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

[a,fval,exitflag,output]=quadprog(Q,c,[],[],Aeq,beq,lb,[])

% w=zeros(mZ,1);
% for i=1:nZ
%     w=w+a(i)*Y(i)*( Z(i,:)' );
% end

% figure;
% for i=1:nX
%     if Y(i)>=0
%         plot(X(i,1),X(i,2),'bo');
%         hold on;
%     else
%         plot(X(i,1),X(i,2),'bx');
%         hold on;
%     end   
% end
% yLine=-3:0.001:3;
% xLine=0.5*(yLine.^2-2+0.5);
% plot(xLine,yLine,'k');
% axis([-3,2,-3,3]);
% hold on;

