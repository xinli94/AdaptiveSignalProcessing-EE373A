clc
clear
close all
N = 5; mu = 0.3;
R = [1,cos(2*pi/N);cos(2*pi/N),1];
P = [0; -sin(2*pi/N)];
[V,D] = eig(R);
W_star = R^(-1)*P;
xi_min = 2-P'*W_star;
itr = 15;
xi = zeros(itr,1);
W = zeros(2,1);
for i = 0:itr-1
    V_prime = D^(-1)*(W-W_star);
    xi(i+1) = xi_min + V_prime'*(eye(2)-2*mu*D)^(2*i)*D*V_prime;
end
plot(0:itr-1,xi,'o-');
