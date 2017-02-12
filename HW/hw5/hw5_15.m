%hw5_15

clear all;
clc;

Ftrain = load ('hw5_14_train.dat');
[nFtrain,mFtrain]=size(Ftrain);

Xtrain=Ftrain(1:nFtrain,1:mFtrain-1);
[nXtrain,mXtrain]=size(Xtrain);
Ytrain=Ftrain(1:nFtrain,mFtrain);

%cross
Xtrain1=Xtrain(1:100,:);
Ytrain1=Ytrain(1:100,:);
Xtrain0=Xtrain(101:500,:);
Ytrain0=Ytrain(101:500,:);
model=svmtrain(Ytrain0,Xtrain0,'-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain1,Xtrain1,model);
nErrSum=0;
nErrSum=nErrSum+length( find( sign(Lab)-Ytrain1 ) );

Xtrain2=Xtrain(101:200,:);
Ytrain2=Ytrain(101:200,:);
Xtrain0=[Xtrain(1:100,:);Xtrain(201:500,:)];
Ytrain0=[Ytrain(1:100,:);Ytrain(201:500,:)];
model=svmtrain(Ytrain0,Xtrain0,'-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain2,Xtrain2,model);
nErrSum=nErrSum+length( find( sign(Lab)-Ytrain2 ) );

Xtrain3=Xtrain(201:300,:);
Ytrain3=Ytrain(201:300,:);
Xtrain0=[Xtrain(1:200,:);Xtrain(301:500,:)];
Ytrain0=[Ytrain(1:200,:);Ytrain(301:500,:)];
model=svmtrain(Ytrain0,Xtrain0,'-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain3,Xtrain3,model);
nErrSum=nErrSum+length( find( sign(Lab)-Ytrain3 ) );

Xtrain4=Xtrain(301:400,:);
Ytrain4=Ytrain(301:400,:);
Xtrain0=[Xtrain(1:300,:);Xtrain(401:500,:)];
Ytrain0=[Ytrain(1:300,:);Ytrain(401:500,:)];
model=svmtrain(Ytrain0,Xtrain0,'-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain4,Xtrain4,model);
nErrSum=nErrSum+length( find( sign(Lab)-Ytrain4 ) );

Xtrain5=Xtrain(401:500,:);
Ytrain5=Ytrain(401:500,:);
Xtrain0=Xtrain(1:400,:);
Ytrain0=Ytrain(1:400,:);
model=svmtrain(Ytrain0,Xtrain0,'-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain5,Xtrain5,model);
nErrSum=nErrSum+length( find( sign(Lab)-Ytrain5 ) );

Ecv=(nErrSum/100)/5;

%predict
model = svmtrain(Ytrain, Xtrain, '-s 3 -g 32 -c 0.001');
Lab=svmpredict(Ytrain,Xtrain,model);
nErrSum=length( find( sign(Lab)-Ytrain ) );
Ein=nErrSum/nXtrain;

% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 0.001 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 0.001');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 0.001 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 0.001');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 32 -c 1 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 32 -c 1');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 1 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 1');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 1 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 1');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 32 -c 1000 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 32 -c 1000');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 1000 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 2 -c 1000');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);
% 
% AccCrossVal=svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 1000 -v 5');
% model = svmtrain(Ytrain, Xtrain, '-s 3 -g 0.125 -c 1000');
% [Lab,Acc,Dec]=svmpredict(Ytrain,Xtrain,model);




