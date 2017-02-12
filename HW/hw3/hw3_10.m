%hw3_10

clear all;
clc;

T=5;
u=zeros(T+1,1);
v=zeros(T+1,1);
DEuv=zeros(2,1);
HEuv=zeros(2,2);
upDate=zeros(2,1);
Euv=zeros(T,1);

u(1)=0;
v(1)=0;
for i=1:T
    DEuv(1,1)=exp(u(i)) +v(i)*exp(u(i)*v(i)) +2*u(i) -2*v(i) -3;
    DEuv(2,1)=2*exp(2*v(i)) +u(i)*exp(u(i)*v(i)) -2*u(i) +4*v(i) -2;
    HEuv(1,1)=exp(u(i)) +(v(i)^2)*exp(u(i)*v(i)) +2;
    HEuv(1,2)=exp(u(i)*v(i)) +u(i)*v(i)*exp(u(i)*v(i)) -2;
    HEuv(2,1)=exp(u(i)*v(i)) +u(i)*v(i)*exp(u(i)*v(i)) -2;
    HEuv(2,2)=4*exp(2*v(i)) +(u(i)^2)*exp(u(i)*v(i)) +4;
    upDate=HEuv\DEuv;
    u(i+1)=u(i) -upDate(1,1);
    v(i+1)=v(i) -upDate(2,1);
    Euv(i)=exp(u(i+1)) +exp(2*v(i+1)) +exp(u(i+1)*v(i+1)) +u(i+1)^2 -2*u(i+1)*v(i+1) +2*(v(i+1)^2) -3*u(i+1) -2*v(i+1);
end


