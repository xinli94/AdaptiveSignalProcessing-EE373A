clc
clear
close all
%% System modeling exercise
%% Ask user for the inputs
% itn=input('\n No. of iterations?      ');
itn = 2000;
% sigman2=input('\n Variance of the plant noise?      ');
sigman2 = 0.001;
sigman=sqrt(sigman2);
% wo=input('\n Plant impulse response (vector, w_o)?      ');
wo = [ones(1,8),-ones(1,7)];
a=size(wo);
if a(1)<a(2)
   wo=wo';
end
% N=input('\n Length of the model (N)?      ');
N = 15;
% h=input('\n Coloring filter impulse response (vector, h)?     ');
h = [0.35, 1, 0.35];
a=size(h);
if a(1)<a(2)
   h=h';
end
% Misad=input('\n Misadjustment (e.g., 0.1 for 10%) ?     ');
Misad = [0.1,0.2,0.3];
Mu=Misad/(N*(h'*h));
% runs=input('\n \n No. of runs (for ensemble averaging)? ');
runs = 100;
xi=zeros(itn,1);
%% Run LMS algorithm
color = ['b','r','g'];
for i=1:3
    mu = Mu(i);
    for k=1:runs
        x=filter(h,1,randn(itn,1));
        d=filter(wo,1,x)+sigman*randn(itn,1);
        w=zeros(N,1);
        for n=N:itn
            xtdl=x(n:-1:n-N+1);
            e=d(n)-w'*xtdl;
            w=w+2*mu*e*xtdl;
            xi(n)=xi(n)+e^2;
        end
    end
    xi=xi/runs;
    semilogy(xi,'color',color(i));
    hold on;
end
xlabel('NO. OF ITERATIONS');
ylabel('MSE');
legend('misadjustment = 10%','misadjustment = 20%','misadjustment = 30%');

