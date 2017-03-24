clc
clear
close all
%% exercise 9.7
itr = 200;
runs = 500;
mu_max = 4;
mu = 0.2*mu_max;
R = diag(ones(1,3)/12);
w_opt = [2; -3.6; 2.6];
Xi = zeros(1,itr);
xi_t = [];
for cnt = 1:runs
    x = rand(1,itr)-0.5;
    w = zeros(3,1);
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
        eps = (2-w(1))*x(i)+(-3.6-w(2))*tmp1+(2.6-w(3))*tmp2;
        xi = [xi, eps^2];
        w = w + 2*mu*eps*[x(i);tmp1;tmp2];
        if cnt == 1
            tmp = w_opt'*(eye(3)-2*mu*R)^(2*i)*R*w_opt;
            xi_t = [xi_t, tmp];
        end
    end
    Xi = Xi+xi;
    if cnt==1
       subplot(1,2,1);
       plot(0:itr-1, xi, 0:itr-1, [w_opt'*R*w_opt,xi_t(1:itr-1)], 'r', 'LineWidth', 1.5); 
       legend('experimental plot','theoretical plot');
       xlabel('iteration'); ylabel('error');
       axis square;
    end
end
Xi = Xi/runs;
subplot(1,2,2);
plot(0:itr-1, Xi, 0:itr-1, [w_opt'*R*w_opt,xi_t(1:itr-1)], 'r', 'LineWidth', 1.5);
legend('experimental approximation','theoretical plot');
xlabel('iteration'); ylabel('MSE');
axis square;
    