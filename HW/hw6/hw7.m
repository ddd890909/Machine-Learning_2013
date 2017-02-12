fid=fopen('hw6_train.dat','r');
m = fscanf(fid, '%f');
fclose(fid);
i=1; 
for r=1:5:length(m)
	for k=1:5
		A(i,k) = m(r);		
		r=r+1;
	end
	i=i+1;
end
[row_A col_A]=size(A);

fid=fopen('hw6_test.dat','r');
m = fscanf(fid, '%f');
fclose(fid);
i=1; 
for r=1:5:length(m)
	for k=1:5
		D(i,k) = m(r);		
		r=r+1;
	end
	i=i+1;
end
[row_D col_D]=size(D);

u=ones(1,row_A)./row_A;

min_d=0;
min_e=100;
best_thetas=[];
alphas=[];
U=[];
flags=[];
Ein=[];
Eout=[];
ein=0;
eout=0;
h=0;
h_test=0;

for T=1:500
    T
    min_e=100;
    min_d=0;
    ein=0;
	eout=0;
	
	for d=1:4
		
		s=sort(A(1:row_A,d)');
		for i=1:row_A-1
			s(i)=(s(i)+s(i+1))/2;
		end
		theta = [s(1)-0.1 s(1:row_A-1) s(row_A)+0.1];
		
		for i=1:length(theta)
			
			e_pos=abs((sign(A(1:row_A,d)'-theta(i)).*A(1:row_A,5)'-1)/2)*u';
			 if e_pos < min_e			
				min_e = e_pos;
				best_theta=theta(i);
				min_d=d;
				flag=1;
			end
			
			e_neg=abs((-sign(A(1:row_A,d)'-theta(i)).*(A(1:row_A,5)')-1)/2)*u';

			
			if e_neg < min_e			
				min_e = e_neg;
				best_theta=theta(i);
				min_d=d;
				flag=-1;
			end
		   
		end
	end

	tmp_e = [tmp_e min_e];
    epsion = min_e / (u*ones(row_A,1)) ;
    alpha = log((1-epsion)/epsion)/2;
	flags = [flags flag];
    best_thetas = [best_thetas best_theta];
    alphas = [alphas alpha];
    U = [U u*ones(row_A,1)];
    u = u.*exp( -alpha *A(1:row_A,5)'.*(flag*sign(A(1:row_A,min_d)-best_theta))');
	
	h = h + alpha * (flag*sign(A(1:row_A,min_d)-best_theta))' ; 
	for i=1:row_A
		if sign(h(i))~=A(i,5)
			ein=ein+1;
		end
	end
	Ein = [Ein ein/row_A]; 
	
	h_test = h_test + alpha * (flag*sign(D(1:row_D,min_d)-best_theta))' ; 
	for j=1:row_D
		if sign(h_test(j))~=D(j,5)
			eout=eout+1;
		end
	end
	Eout = [Eout eout/row_D]; 
	
	
end

plot(Ein);
hold on;
plot(Eout);
hold on;
plot(U,'r');






