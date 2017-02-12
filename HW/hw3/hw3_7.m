%hw3_7

clear all;
clc;

T=5;
u=zeros(T+1,1);
v=zeros(T+1,1);
Eu=zeros(T+1,1);
Ev=zeros(T+1,1);
Eta=0.01;
Euv=zeros(T,1);

u(1)=0;
v(1)=0;
for i=1:T
    Eu(i)=exp(u(i)) +v(i)*exp(u(i)*v(i)) +2*u(i) -2*v(i) -3;
    Ev(i)=2*exp(2*v(i)) +u(i)*exp(u(i)*v(i)) -2*u(i) +4*v(i) -2;
    u(i+1)=u(i) -Eta*Eu(i);
    v(i+1)=v(i) -Eta*Ev(i);
    Euv(i)=exp(u(i+1)) +exp(2*v(i+1)) +exp(u(i+1)*v(i+1)) +u(i+1)^2 -2*u(i+1)*v(i+1) +2*(v(i+1)^2) -3*u(i+1) -2*v(i+1);
end



