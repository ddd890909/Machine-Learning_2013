%hw5_14

clear all;
clc;

Ftrain = load ('hw5_14_train.dat');
[nFtrain,mFtrain]=size(Ftrain);

Xtrain=Ftrain(1:nFtrain,1:mFtrain-1);
[nXtrain,mXtrain]=size(Xtrain);
Ytrain=Ftrain(1:nFtrain,mFtrain);

%cross
AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 32 -c 0.001 -v 5');
%predict
model = svmtrain(Ytrain, Xtrain, '-g 32 -c 0.001');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 2 -c 0.001 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 2 -c 0.001');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 0.125 -c 0.001 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 0.125 -c 0.001');
Acc=svmpredict(Ytrain,Xtrain,model);


AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 32 -c 1 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 32 -c 1');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 2 -c 1 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 2 -c 1');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 0.125 -c 1 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 0.125 -c 1');
Acc=svmpredict(Ytrain,Xtrain,model);


AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 32 -c 1000 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 32 -c 1000');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 2 -c 1000 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 2 -c 1000');
Acc=svmpredict(Ytrain,Xtrain,model);

AccCrossVal=svmtrain(Ytrain, Xtrain, '-g 0.125 -c 1000 -v 5');
model = svmtrain(Ytrain, Xtrain, '-g 0.125 -c 1000');
Acc=svmpredict(Ytrain,Xtrain,model);






