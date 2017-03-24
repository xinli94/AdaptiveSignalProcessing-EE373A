clc
clear
close all
%% exercise 9.10
itr = 200;
runs = 100;
mu_max = 6;
mu = 0.2*mu_max;
R = diag(ones(1,2)/12);
P = [2; -3.6]/12;
w_star = R^(-1)*P;
hold on;
Xi = zeros(1,itr);
xi_t = [];
t1 = 0; t2 = 0; t3 = 0; % to calculate R_hat
for cnt = 1:runs
    x = rand(1,itr)-0.5;
    w = zeros(2,1);
    xi = [];
    for i = 1:itr
        if i==1
            tmp1 = 0; tmp2 = 0;
        end
        if i==2
            tmp1 = x(i-1); tmp2 = 0;
        end
        if i>2
            tmp1 = x(i-1); tmp2 = x(i-2);
        end
        eps = (2-w(1))*x(i)+(-3.6-w(2))*tmp1+2.6*tmp2;
        xi = [xi, eps^2];
        w = w + 2*mu*eps*[x(i);tmp1];
        if cnt==1
            t1 = t1 + x(i)^2;
            t2 = t2 + x(i)*tmp1;
            t3 = t3 + tmp1*tmp2;
        end
    end
    Xi = Xi+xi;
end
t1 = t1/itr; t2 = t2/(itr-1); t3 = t3/(itr-2);
R_hat = [t1, t2; t2, t1];
P_hat = [2*t1; -3.6*t1];
eps_min = [2, -3.6, 2.6].^2*[t1; t1; t1] - P_hat'*R_hat^(-1)*P_hat;
excess_MSE = mu*eps_min*trace(R_hat)
T_mse = 1./(4*mu*eig(R_hat))
Xi = Xi/runs;
plot(0:itr-1, Xi,'LineWidth',1.5);
xlabel('iteration'); ylabel('MSE');
    