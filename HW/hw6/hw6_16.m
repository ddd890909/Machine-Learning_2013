%hw6_15

clear all;
clc;

F=load('hw6_train.dat');
[m,n]=size(F);
Xtrain=F(:,1:n-1);
Ytrain=F(:,n);
trainSize=m;

F=load('hw6_test.dat');
[m,n]=size(F);
Xtest=F(:,1:n-1);
Ytest=F(:,n);
testSize=m;

D=classregtree(Xtrain,Ytrain,'method','classification','prune','off')

yfitTrain=eval(D,Xtrain);
Yin=zeros(100,1);
for i=1:100
    Yin(i,1)=str2num(yfitTrain{i,1});
end
Ein = size(find(Yin-Ytrain))/trainSize


yfitTest=eval(D,Xtest);
Yout=zeros(1000,1);
for i=1:1000
    Yout(i,1)=str2num(yfitTest{i,1});
end
Eout = size(find(Yout-Ytest))/testSize

