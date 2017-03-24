clc
clear
close all
%% LMS/Newton's Method
N = 16; phi = 0.01; mu = 0.05;
R = 0.5*[1+2*phi, cos(2*pi/N); cos(2*pi/N), 1+2*phi];
P = [0; -sin(2*pi/N)];
lambda_av = mean(eig(R));
itr = 500;
w = zeros(2,itr+1);
w(:,1) = [6;-8];
w2 = w;
xi = zeros(itr,1);
xi2 = xi;
k = (1:itr)';
x = [0;sin(2*pi*k/N)];
d = 2*cos(2*pi*k/N);
for i = 1:itr
    eps = d(i)-[x(i+1);x(i)]'*w(:,i);
    w(:,i+1) = w(:,i) + 2*mu*lambda_av*R^(-1)*eps*[x(i+1);x(i)];
    eps2 = d(i)-[x(i+1);x(i)]'*w2(:,i);
    w2(:,i+1) = w2(:,i) + 2*mu*eps2*[x(i+1);x(i)];
    xi(i) = 2+w(:,i)'*R*w(:,i)-2*P'*w(:,i);
    xi2(i) = 2+w2(:,i)'*R*w2(:,i)-2*P'*w2(:,i);
end
xi_min = 2-P'*R^(-1)*P
excess_mse = 2*mu*xi_min*lambda_av/(1-mu*lambda_av)
excess_mse2 = mu*xi_min*trace(R)
plot(k,xi,k,xi2);
legend('LMS/Newton','LMS');
figure;
plot(w(1,1:end),w(2,1:end),w2(1,1:end),w2(2,1:end));
legend('LMS/Newton','LMS');
   