%hw4_14

clear all;
clc;

log10Lambda=[2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10];
nLambda=length(log10Lambda);
lambda=10.^log10Lambda;
Ftrain = load ('hw4_train.dat');
[nFtrain,mFtrain]=size(Ftrain);
Xtrain=Ftrain(:,1:mFtrain-1);
Ytrain=Ftrain(:,mFtrain);

Ztrain=[ones(nFtrain,1),Xtrain];
%w=zeros(mFtrain,1);
I=eye(mFtrain);

Ein=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Ztrain')*Ztrain +lambda(i)*I ) \(Ztrain') *Ytrain;
    hZ=sign(Ztrain*wREG);
    %[nErrSum,mErrSum]=size( find( hZ-Ytrain ) );
    nErrSum=length( find( hZ-Ytrain ) );
    Ein(i)=nErrSum/nFtrain;
end
[EinMin,ind] = min(Ein);
fprintf('Ein = %d\n',Ein(ind));

Ftest = load ('hw4_test.dat');
[nFtest,mFtest]=size(Ftest);
Xtest=Ftest(:,1:mFtest-1);
Ytest=Ftest(:,mFtest);

Ztest=[ones(nFtest,1),Xtest];

Eout=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Ztrain')*Ztrain +lambda(i)*I ) \(Ztrain') *Ytrain;
    hZ=sign(Ztest*wREG);
    nErrSum=length( find( hZ-Ytest ) );
    Eout(i)=nErrSum/nFtest;
end

fprintf('Eout = %d\n',Eout(ind));



