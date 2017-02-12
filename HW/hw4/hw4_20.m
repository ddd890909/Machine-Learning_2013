%hw4_20

clear all;
clc;

log10Lambda=[2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10];
nLambda=length(log10Lambda);
lambda=10.^log10Lambda;
F = load ('hw4_train.dat');
[nF,mF]=size(F);
X=F(1:nF,1:mF-1);
Y=F(1:nF,mF);
Z=[ones(nF,1),X];
I=eye(mF);

nFold=40;
Ecv=zeros(1,nLambda);
for i=1:nLambda;
    EvalSum=0;
    for j=1:(nF/nFold)
        if j==1
            Ztrain=Z(nFold+1:nF,:);
            Ytrain=Y(nFold+1:nF,:);
            Zval=Z( 1:nFold , : );
            Yval=Y( 1:nFold , : );
        else
            Ztrain=[ Z(1:nFold*(j-1),:) ; Z(nFold*j+1:nF,:) ];
            Ytrain=[ Y(1:nFold*(j-1),:) ; Y(nFold*j+1:nF,:) ];
            Zval=Z( nFold*(j-1)+1:nFold*j , : );
            Yval=Y( nFold*(j-1)+1:nFold*j , : );
        end
        wREG = ( (Ztrain')*Ztrain +lambda(i)*I ) \(Ztrain') *Ytrain;
        hZ=sign(Zval*wREG);
        nErrSum=length( find( hZ-Yval ) );
        Eval=nErrSum/nFold;
        EvalSum=EvalSum+Eval;
    end
    Ecv(i)=EvalSum/(nF/nFold);
end
[EcvMin,ind] = min(Ecv);
%fprintf('Ecv = %d\n',Ecv(ind));

Ein=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Z')*Z +lambda(i)*I ) \(Z') *Y;
    hZ=sign(Z*wREG);
    nErrSum=length( find( hZ-Y ) );
    Ein(i)=nErrSum/nF;
end

fprintf('Ein = %d\n',Ein(ind));

Ftest = load ('hw4_test.dat');
[nFtest,mFtest]=size(Ftest);
Xtest=Ftest(:,1:mFtest-1);
Ytest=Ftest(:,mFtest);
Ztest=[ones(nFtest,1),Xtest];

Eout=zeros(1,nLambda);
for i=1:nLambda;
    wREG = ( (Z')*Z +lambda(i)*I ) \(Z') *Y;
    hZ=sign(Ztest*wREG);
    nErrSum=length( find( hZ-Ytest ) );
    Eout(i)=nErrSum/nFtest;
end

fprintf('Eout = %d\n',Eout(ind));


