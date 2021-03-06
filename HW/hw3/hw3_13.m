%hw3_13

clear all;
clc;

T=1000;
EinSum=0;
noise=0.1;
N=1000;
for t=1:T
    s=RandStream('mt19937ar','seed',sum(100*clock));
    RandStream.setDefaultStream(s);
    Xr=rand(N,2)*2-1;
    noisePro=rand(N,1);
    Y=sign(noisePro-noise).*sign(Xr(:,1).^2+Xr(:,2).^2-0.6);
    Data=[Xr Y];
    save hw3_13_data.dat Data;
    
    %X=[ones(N,1),Xr];
    Z=[ones(N,1),Xr(:,1),Xr(:,2)];
    wLin=pinv(Z)*Y;
    hZ=sign(Z*wLin);
    [nEin,mEin]=size( find( hZ-Y ) );
    Ein=nEin/N;
    
    EinSum=EinSum+Ein;
end
EinAve=EinSum/T;

fprintf('Average Ein = %d\n',EinAve);


