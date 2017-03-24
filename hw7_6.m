clc
clear
close all
%% exercise 13.4
w0 = pi/16;
L = 1;
C = 2;
mu = 0.002;
itr = 600;
runs = 500;
Xi = zeros(itr,1);
Wk = zeros(2,itr);
for run = 1:runs
    k = (1:itr)';
    n = sqrt(12)*(rand(itr,3)-0.5);
    dk = C*sin(k*w0)+n(:,1);
    xk1 = C*sin(k*w0)+n(:,2);
    xk2 = C*cos(k*w0)+n(:,3);
    wk = zeros(L+1,1);
    xi = [];
    W = [];
    for i = 1:itr
        eps = dk(i)-wk'*[xk1(i);xk2(i)];
        wk = wk + 2*mu*eps*[xk1(i);xk2(i)];
        xi = [xi;eps^2];
        W = [W,wk];
    end
    Xi = Xi+xi;
    Wk = Wk+W;
end
Xi = Xi/runs;
Wk = Wk/runs;
plot(0:itr-1,Xi); grid on;
title('Learning Curve'); 
xlabel('iteration'); ylabel('\xi');
figure;
plot(0:itr-1,Wk(1,:),0:itr-1,Wk(2,:),'g','Linewidth',1.5); hold on;
plot(0:itr-1,W(1,:),'k',0:itr-1,W(2,:),'c'); hold on;
plot([0;itr-1],[2/3,2/3],'b-.',[0;itr-1],[0,0],'g-.','Linewidth',1.5);
legend('w_1(average over 500 runs)','w_2(average over 500 runs)',...
    'w_1(one run)', 'w_2(one run)','w_1^*','w_2^*','Location','east');
grid on; xlabel('iteration'); 
