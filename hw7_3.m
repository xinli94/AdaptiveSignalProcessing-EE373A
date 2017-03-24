clc
clear
close all
%% exercise 8.20  % random serach algorithm
mu = 0.04/(32*(1+1+0.89^2));
L = 31;
N = 20;
sig = 10*mu*(L+1)/N;
runs = 50;
itr = 4000;
Xi = zeros(itr,1);
for run = 1:runs
    wk = zeros(L+1,1);
%     xk = zeros(L,1);  
    rk = [zeros(L,1);sqrt(12)*(rand(2*N*itr,1)-0.5)];
    xk = filter([1,-1,0.89],1,rk);
%     xk = [rk(1); rk(2)-rk(1); rk(3:end)-rk(2:end-1)+0.89*rk(1:end-2)];
    xi = zeros(itr,1);
    for i = 1:itr
        xi_1 = 0; xi_2 = 0;
        for k = 2*(i-1)*N+(1:N)
            eps = rk(k+L-5)-wk'*xk(k+L:-1:k);
            xi_1 = xi_1+eps^2;
        end
        uk = sqrt(12*sig)*(rand(L+1,1)-0.5);
        for k = 2*(i-1)*N+N+(1:N)
            epsu = rk(k+L-5)-(wk+uk)'*xk(k+L:-1:k);
            xi_2 = xi_2+epsu^2;
        end
        wk = wk + (mu/sig)*(xi_1/N-xi_2/N)*uk;
%         wk = wk + 2*mu*eps * xk(L+i:-1:i);  % LMS
        xi(i) = xi_1/N;
    end
    Xi = Xi+xi;
end
Xi = Xi/runs;
plot(0:itr-1, Xi); grid on;
xlabel('iteration'); ylabel('\xi');
title('Learning Curve');
mse = mean(Xi(end-49:end));
