%hw5_13

clear all;
clc;

s=RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);

Ftrain = load ('hw5_13_train.dat');
[nFtrain,mFtrain]=size(Ftrain);

Ftest = load('hw5_13_test.dat');
[nFtest,mFtest]=size(Ftest);
 Xtest=Ftest(1:nFtest,1:mFtest-1);
[nXtest,mXtest]=size(Xtest);
Ytest=Ftest(1:nFtest,mFtest);
    
nSample=nFtrain*0.8;
T=100;
margin=zeros(T,1);
Eout=zeros(T,1);
for t=1:T
    nFtrainSample=randperm(nFtrain);
    FtrainSample=Ftrain(nFtrainSample,:);
    Xtrain=FtrainSample(1:nSample,1:mFtrain-1);
    [nXtrain,mXtrain]=size(Xtrain);
    Ytrain=FtrainSample(1:nSample,mFtrain);

    A=[0,zeros(1,mXtrain);zeros(mXtrain,1),eye(mXtrain)];
    c=zeros(mXtrain+1,1);
    P=zeros(nXtrain,mXtrain+1);
    for i=1:nXtrain
        P(i,:)=Ytrain(i)*[1,Xtrain(i,:)];
    end
    r=ones(nXtrain,1);

    a=quadprog(A,c,-P,-r);
    b=a(1);
    w=a(2:mXtrain+1);
    margin(t)=1/sqrt(w'*w);
    
    g=sign( Xtest*w +b);
    nErrSum=length( find( g-Ytest ) );
    Eout(t)=nErrSum/nXtest;
end

figure;
plot(margin,Eout,'bx');
axis([0,0.15,0,0.05]);
hold on;



