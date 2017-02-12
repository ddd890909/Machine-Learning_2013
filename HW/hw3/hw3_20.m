%hw3_20

clear all;
clc;

T=2000;
Eta=0.001;
Ftrain = load ('hw3_train.dat');
[nF,mF]=size(Ftrain);
X=Ftrain(:,1:mF-1);
Y=Ftrain(:,mF);

X=[ones(nF,1),X];
w=zeros(mF,1);

for t=1:T
    i=mod((t-1),nF)+1;
    xn=X(i,:)';
    wT=w';
    wTxn=wT*xn;
    s=-Y(i)*wTxn;
    Theta=1/(1+exp(-s));
    DErr=-Theta*(Y(i)*xn);
    w=w-Eta*DErr;
    if DErr==0
        break;
    end
end

g=w;

Ftest = load ('hw3_test.dat');
[nFtest,mFtest]=size(Ftest);
Xtest=Ftest(:,1:mFtest-1);
Ytest=Ftest(:,mFtest);

Xtest=[ones(nFtest,1),Xtest];
wT=g';
hX=sign(wT*(Xtest'));
hXT=hX';
[nErrSum,mErrSum]=size( find( hXT-Ytest ) );
Eout=nErrSum/nFtest;

fprintf('Eout = %d\n',Eout);


