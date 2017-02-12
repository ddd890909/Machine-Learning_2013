%hw3_15

clear all;
clc;

T=1000;
EinSum=0;
noise=0.1;
N=1000;

s=RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);
Xr=rand(N,2)*2-1;
noisePro=rand(N,1);
Y=sign(noisePro-noise).*sign(Xr(:,1).^2+Xr(:,2).^2-0.6);
Train=[Xr Y];
save hw3_15_train.dat Train;

%X=[ones(N,1),Xr];
Z=[ones(N,1),Xr(:,1),Xr(:,2),Xr(:,1).*Xr(:,2),Xr(:,1).^2,Xr(:,2).^2];
wLin=pinv(Z)*Y;
hZ=sign(Z*wLin);
[nEin,mEin]=size( find( hZ-Y ) );
Ein=nEin/N;

EoutSum=0;
for t=1:T
    Xtest=rand(N,2)*2-1;
    noisePro=rand(N,1);
    Ytest=sign(noisePro-noise).*sign(Xtest(:,1).^2+Xtest(:,2).^2-0.6);
    Test=[Xtest Y];
    save hw3_15_test.dat Test;

    Ztest=[ones(N,1),Xtest(:,1),Xtest(:,2),Xtest(:,1).*Xtest(:,2),Xtest(:,1).^2,Xtest(:,2).^2];
    hZtest=sign(Ztest*wLin);
    [nEout,mEout]=size( find( hZtest-Ytest ) );
    Eout=nEout/N;
    EoutSum=EoutSum+Eout;
end

EoutAve=EoutSum/T;

fprintf('Average Eout = %d\n',EoutAve);


