%hw4_13

clear all;
clc;

lambda=10;
Ftrain = load ('hw4_train.dat');
[nFtrain,mFtrain]=size(Ftrain);
Xtrain=Ftrain(:,1:mFtrain-1);
Ytrain=Ftrain(:,mFtrain);

Ztrain=[ones(nFtrain,1),Xtrain];
%w=zeros(mFtrain,1);
I=eye(mFtrain);

wREG= ( (Ztrain')*Ztrain +lambda*I ) \(Ztrain') *Ytrain;

hZ=sign(Ztrain*wREG);
%[nErrSum,mErrSum]=size( find( hZ-Ytrain ) );
nErrSum=length( find( hZ-Ytrain ) );
Ein=nErrSum/nFtrain;

fprintf('Ein = %d\n',Ein);

Ftest = load ('hw4_test.dat');
[nFtest,mFtest]=size(Ftest);
Xtest=Ftest(:,1:mFtest-1);
Ytest=Ftest(:,mFtest);

Ztest=[ones(nFtest,1),Xtest];

hZ=sign(Ztest*wREG);
%[nErrSum,mErrSum]=size( find( hZ-Ytest ) );
nErrSum=length( find( hZ-Ytest ) );
Eout=nErrSum/nFtest;

fprintf('Eout = %d\n',Eout);

