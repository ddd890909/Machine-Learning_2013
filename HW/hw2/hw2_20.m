%hw2_20

clear all;
clc;

s=RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);
Ftest=load('hw2_test.dat');
[m,n]=size(Ftest);
Xtest=Ftest(:,1:n-1);
Ytest=Ftest(:,n);

hX=zeros(m,n-1);
EinMinS=-1;
EinMinDim=4;
EinMinThr=1.6175;

hX(:,EinMinDim)=EinMinS*sign(Xtest(:,EinMinDim)-EinMinThr);
[ErrSum,nErrSum]=size( find( hX(:,EinMinDim)-Ytest ) );
Eout=ErrSum/m;

fprintf('Eout of the optimal decision stump = %d\n',Eout);


