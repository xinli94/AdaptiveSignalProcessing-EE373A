clc
clear
close all
%% exercise 6.9
N = 150; %150 iterations
k = 0:N;
x = sin(k*pi/5);
wk = [0;0];
Epsilon = [];
for i = 0:N
    if i==0
        tmp1 = 0; tmp2 = 0;
    end
    if i==1
        tmp1 = x(1); tmp2 = 0;
    end
    if i>=2
        tmp1 = x(i); tmp2 = x(i-1);
    end
    epsilon = x(i+1)-[tmp1,tmp2]*wk;
    Epsilon = [Epsilon, epsilon];
    if i<20
        display(['epsilon ',num2str(i),' = ',num2str(epsilon)]);
    end
    wk = wk+0.4*epsilon*[tmp1;tmp2];
end
plot(k,Epsilon,'b.-');
xlabel('iteration: k'); ylabel('\epsilon_k');
    