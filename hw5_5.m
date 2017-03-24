clc
clear
close all
%% exercise 6.10
runs = 500;
W = zeros(2,5000);
Xi = zeros(1,5000);
for cnt=1:500
    %% ----------------(a)------------------
    N = 5000;
    k = 0:N-1;
    r = rand(1,length(k));
    s1 = 0; s2 = 0; s3 = 0;
    xk = 0; Xk = xk; prev_xk = 0;
    for i=0:N-1
        p_prev_xk = prev_xk;
        prev_xk = xk;
        xk = 0.2*(r(i+1)-0.5)+0.8*xk;
        s1 = s1 + xk^2;
        s2 = s2 + xk*prev_xk;
        s3 = s3 + xk*p_prev_xk;
        Xk = [Xk, xk];
    end
    s1 = s1/N; s2 = s2/(N-1); s3 = s3/(N-2);
    R = [s1,s2;s2,s1];
    P = [s2;s3];
    %% ----------------(b)------------------
    lambda = eig(R);
    mu = 1/800*(1/lambda(1)+1/lambda(2));
    %% ----------------(c)------------------
    wk = [0;0];
    Wk = []; 
    Epsilon = [];
    xi = [];
    for i = 0:N-1
        if i==0
            tmp1 = 0; tmp2 = 0;
        end
        if i==1
            tmp1 = Xk(1); tmp2 = 0;
        end
        if i>=2
            tmp1 = Xk(i); tmp2 = Xk(i-1);
        end
        epsilon = Xk(i+1)-[tmp1,tmp2]*wk;
        Epsilon = [Epsilon, epsilon];
        wk = wk+2*mu*epsilon*[tmp1;tmp2];
        Wk = [Wk,wk];
        xi = [xi,epsilon^2];
    end
    W = W+Wk;
    Xi = Xi+xi;
end
%% -------------------(d)-----------------------
W = W/runs;
Xi = Xi/runs;
plot(1:1000,W(1,1:1000),1:1000,W(2,1:1000));
xlabel('iterations: k'); ylabel('w_k');
legend('w_{0k}','w_{1k}','Location','northwest');
figure
plot(1:1000,Xi(1,1:1000));
xlabel('iterations: k'); ylabel('\xi');
title('Learning Curve');
R
mu
