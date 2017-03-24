clc
clear
close all
%% exercise 12.8 and 12.9
mu = 0.03;
L = 2;
N = 0.5;
beta = 0.1
runs = 100;
itr = 1200;
k = 1:itr;
sk = [zeros(L,1);sin(k*pi/8)'];
Xi = zeros(itr,1);
Wk = zeros(L+1,itr);
for run = 1:runs
    nk = [zeros(L,1);sqrt(12*N)*(rand(itr,1)-0.5)];
    yk = zeros(L+itr,1);
    xi = []; W = [];
    wk = zeros(L+1,1);
    for i = 1:itr
        y = nk(i+L)+0.2*yk(i+L-1);
        yk(i+L) = y;
        eps = sk(i+L)+nk(i+L)-wk'*(yk(i+L:-1:i)+beta*sk(i+L:-1:i));
        wk = wk+2*mu*eps*(yk(i+L:-1:i)+beta*sk(i+L:-1:i));
        W = [W, wk];
        xi = [xi;(eps)^2];
    end
    Wk = Wk+W;
    Xi = Xi+xi;
end
Xi = Xi/runs;
Wk = Wk/runs;
MSE = sum(Xi(end-99:end))/100
Ps = N*(1-Wk(1,end)*beta)^2
SNR = 10*log(Ps/(MSE-Ps)) % SNR(dB)
plot(0:itr-1, Xi); grid on;
title('Experimental Learning Curve');
xlabel('iteration'); ylabel('\xi');
figure;
plot(0:itr-1,Wk(1,:),0:itr-1, Wk(2,:),0:itr-1, Wk(3,:));
xlabel('iteration'); grid on;
legend('w_0','w_1','w_2','Location','east');