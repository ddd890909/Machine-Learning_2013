train_data = load('hw6_train.dat');
test_data = load('hw6_test.dat');

train_x = train_data(1:100, 1:2);
train_y = train_data(1:100, 3:3);
test_x = test_data(1:1000, 1:2);
test_y = test_data(1:1000, 3:3);
iter = 300;
data_size = 100;
test_size = 1000;
u = zeros(data_size, 1);
g = zeros(iter, 4);

Ein = zeros(iter, 1);
Eout = zeros(iter, 1);
Us = zeros(iter, 1);

for i=1:100
	u(i, 1) = 1/data_size;
end

for t=1:iter
	egt = 1;
	for i=-10000:10000
		err = 0;
		s = 1;
		d = 1;
		for n=1:data_size
			if(u(n)*s*sign(train_x(n, d) - i/10000)*train_y(n)<0)
				err = err + u(n);
			end
		end
		if(err < egt)
			egt = err;
			g(t, 1) = d;
			g(t, 2) = s;
			g(t, 3) = i/10000;
		end
		err = 0;
		s = -1;
		d = 1;
		for n=1:data_size
			if(u(n)*s*sign(train_x(n, d) - i/10000)*train_y(n)<0)
				err = err + u(n);
			end
		end
		if(err < egt)
			egt = err;
			g(t, 1) = d;
			g(t, 2) = s;
			g(t, 3) = i/10000;
		end
		err = 0;
		s = 1;
		d = 2;
		for n=1:data_size
			if(u(n)*s*sign(train_x(n, d) - i/10000)*train_y(n)<0)
				err = err + u(n);
			end
		end
		if(err < egt)
			egt = err;
			g(t, 1) = d;
			g(t, 2) = s;
			g(t, 3) = i/10000;
		end
		err = 0;
		s = -1;
		d = 2;
		for n=1:data_size
			if(u(n)*s*sign(train_x(n, d) - i/10000)*train_y(n)<0)
				err = err + u(n);
			end
		end
		if(err < egt)
			egt = err;
			g(t, 1) = d;
			g(t, 2) = s;
			g(t, 3) = i/10000;
		end
	end

	incor = 0;
	cor = 0;
	for n=1:data_size
		if(u(n)*g(t,2)*sign(train_x(n, g(t,1)) - g(t,3))*train_y(n) < 0)
			incor = incor + u(n);
		else
			cor = cor + u(n);
		end
	end
	
	et = incor/(incor + cor);
	alpha = log(sqrt((1-et)/et));
	g(t, 4) = alpha;

	for n=1:data_size
		u(n) = u(n)*exp((-1)*train_y(n)*alpha*g(t,2)*sign(train_x(n,g(t,1))-g(t,3)));
	end
	
	us = 0;
	for n=1:data_size
		us = us + u(n);
	end

	Us(t) = us;

	ein = 0;
	for n=1:data_size
		pre = 0;
		for k=1:t
			pre = pre + g(k,4)*g(k,2)*sign(train_x(n,g(k,1))-g(k,3));
		end
		if(sign(pre)*train_y(n) < 0)
			ein = ein + 1;
		end
	end

	ein = ein / data_size;
	Ein(t) = ein;

	eout = 0;
	for n=1:test_size
		pre = 0;
		for k=1:t
			pre = pre + g(k,4)*g(k,2)*sign(test_x(n,g(k,1))-g(k,3));
		end
		if(sign(pre)*test_y(n) < 0)
			eout = eout + 1;
		end
	end

	eout = eout / test_size;
	Eout(t) = eout;
end

g;

figure(10);
for t=1:iter
	plot(t, Ein(t), 'o');
	hold on;
end
print('-f10', '-djpeg', '-r480', 'p10');

figure(11);
for t=1:iter
	plot(t, Eout(t), 'o');
	hold on;
end
print('-f11', '-djpeg', '-r480', 'p11');

figure(12);
for t=1:iter
	plot(t, Us(t), 'o');
	hold on;
end
print('-f12', '-djpeg', '-r480', 'p12');

figure(14);
for n=1:data_size
	if(train_y(n)>0)
		plot(train_x(n, 1), train_x(n, 2), 'o', 'MarkerSize', 8);
	else
		plot(train_x(n, 1), train_x(n, 2), 'x', 'MarkerSize', 8);
	end
	hold on;
end
print('-f14', '-djpeg', '-r480', 'p14');
