%hw6_10

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

T=300;
Ein=zeros(T,1);
EinMin=1;
Eout=zeros(T,1);
U=zeros(T,1);

u=ones(trainSize,1);
u=u/trainSize;
g=zeros(T,4);

for t=1:T
    ErrGt=1;
    for thr=-1:0.0001:1
        for dimX=1:n-1  
            
            s=1;
            ErrSum=0;           
            for i=1:trainSize
                hi=u(i)*s*sign(Xtrain(i,dimX)-thr);
                if(hi*Ytrain(i)<0)
                    ErrSum = ErrSum + u(i);
                end
            end
            if(ErrSum < ErrGt)
                ErrGt = ErrSum;
                g(t, 1) = dimX; g(t, 2) = s; g(t, 3) = thr;
            end

            s=-1;
            ErrSum=0;           
            for i=1:trainSize
                hi=u(i)*s*sign(Xtrain(i,dimX)-thr);
                if(hi*Ytrain(i)<0)
                    ErrSum = ErrSum + u(i);
                end
            end
            if(ErrSum < ErrGt)
                ErrGt = ErrSum;
                g(t, 1) = dimX; g(t, 2) = s; g(t, 3) = thr;
            end
            
        end          
    end 
    
    right=0;
    wrong=0;
    for i=1:trainSize
        gi=u(i)*g(t,2)*sign(Xtrain(i, g(t,1))-g(t,3));
        if(gi*Ytrain(i)<0)
            wrong=wrong+u(i);
        else
            right=right+u(i);
        end
    end

    e=wrong/(wrong+right);
    a=log(sqrt((1-e)/e));
    g(t,4)=a;

    for i=1:trainSize
        u(i) = u(i)*exp((-1)*Ytrain(i)*a*g(t,2)*sign(Xtrain(i,g(t,1))-g(t,3)));
    end

    uSum= 0;
    for i=1:trainSize
        uSum = uSum + u(i);
    end
    U(t) = uSum;

    ErrSum=0;
    for i=1:trainSize
        agSum = 0;
        for k=1:t
            agSum = agSum + g(k,4)*g(k,2)*sign(Xtrain(i,g(k,1))-g(k,3));
        end
        if(sign(agSum)*Ytrain(i) < 0)
            ErrSum = ErrSum + 1;
        end
    end
	Ein(t) = ErrSum/trainSize;
    
    ErrSum=0;
    for i=1:testSize
		agSum = 0;
		for k=1:t
			agSum = agSum + g(k,4)*g(k,2)*sign(Xtest(i,g(k,1))-g(k,3));
		end
		if(sign(agSum)*Ytest(i) < 0)
			ErrSum = ErrSum + 1;
		end
    end
	Eout(t) = ErrSum/testSize;
end

figure(10);

for t=1:T   
	plot(t, Ein(t), 'm*-');
    plot(t, Eout(t), 'c^-');
    plot(t, U(t), 'ro-');
	hold on;
end

figure(14);
for i=1:trainSize
	if(Ytrain(i)>0)
		plot(Xtrain(i, 1), Xtrain(i, 2), 'o', 'MarkerSize', 9);
	else
		plot(Xtrain(i, 1), Xtrain(i, 2), '*', 'MarkerSize', 9);
    end    
	hold on;
end
[B,Ind]=sort(u,'descend');
for i=1:10
    plot(Xtrain(Ind(i), 1), Xtrain(Ind(i), 2), 'o', 'MarkerSize', 15);
    hold on;
end



