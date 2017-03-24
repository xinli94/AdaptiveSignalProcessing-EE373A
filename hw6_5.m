clc
clear
close all
%% exercise 9.23
mu = 0.0005;
fl = 0:15;
fl = fl/32;
w = 2*pi*fl;
theta = [];
for i=1:16
    if w(i)<=pi/3
        theta = [theta, 0];
    end
    if w(i)>=2*pi/3
        theta = [theta, -pi];
    end
    if w(i)>pi/3 && w(i)<2*pi/3
        theta = [theta, -3*w(i)+pi];
    end
end
dk = []; 
xk = zeros(11,1);
T = 1:200;
for t = T
    xk = [xk;sum(sin(w*t))];
    dk = [dk;sum(sin(w*t+theta))];
end
% plot(K,xk(12:end));
% figure;
subplot(2,1,1);
plot(T,dk, 'LineWidth', 1.5);
xlabel('t'); ylabel('d_t');
hold on;
itr = 200;
wk = zeros(12,1);
Xi = [];
yk = [];
for t = T
    yk = [yk; wk' * xk(11+t:-1:t)];
    eps = dk(t) - yk(end);
    Xi = [Xi, eps^2];
    wk = wk + 2*mu*eps * xk(11+t:-1:t);
end
subplot(2,1,2);
plot(T, yk,'r', 'LineWidth', 1.5);
xlabel('t'); ylabel('y_t');
figure;
plot(T, Xi, 'LineWidth', 1.5);
xlabel('iteration: k'); ylabel('\xi');
% figure;
% opts = bodeoptions;
% opts.FreqScale = 'linear';
% opts.grid = 'on';
% opts.Xlim = [0,pi];
% h = bodeplot( tf(wk',[1,zeros(1,11)]) ,opts);

figure;
freqz(wk',[1,zeros(1,11)]);
% figure;
% plot(w/pi,20*log10(abs(h)));



    