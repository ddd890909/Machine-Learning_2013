%hw4_16

clear all;
clc;

log10Lambda=[2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10];
nLambda=length(log10Lambda);
lambda=10.^log10Lambda;
F = load ('hw4_train.dat');
[nF,mF]=size(F);
nFtrain=120;
Xtrain=F(1:nFtrain,1:mF-1);
Ytrain=F(1:nFtrain,mF);

Ztrain=[ones(nFtrain,1),Xtrain];
%w=zeros(mF,1);
I=eye(mF);

Etrain=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Ztrain')*Ztrain +lambda(i)*I ) \(Ztrain') *Ytrain;
    hZ=sign(Ztrain*wREG);
    %[nErrSum,mErrSum]=size( find( hZ-Ytrain ) );
    nErrSum=length( find( hZ-Ytrain ) );
    Etrain(i)=nErrSum/nFtrain;
end
[EtrainMin,ind] = min(Etrain);
%fprintf('Etrain = %d\n',Etrain(ind));

nFval=80;
Xval=F(nFtrain+1:nF,1:mF-1);
Yval=F(nFtrain+1:nF,mF);
Zval=[ones(nFval,1),Xval];

Eval=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Ztrain')*Ztrain +lambda(i)*I ) \(Ztrain') *Ytrain;
    hZ=sign(Zval*wREG);
    nErrSum=length( find( hZ-Yval ) );
    Eval(i)=nErrSum/nFval;
end
%fprintf('Eval = %d\n',Eval(ind));

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
%[EoutMin,ind] = min(Eout);

fprintf('Etrain = %d\n',Etrain(ind));
fprintf('Eval = %d\n',Eval(ind));
fprintf('Eout = %d\n',Eout(ind));

fprintf('Etrain = %d\n',Etrain(ind+1));
fprintf('Eval = %d\n',Eval(ind+1));
fprintf('Eout = %d\n',Eout(ind+1));
