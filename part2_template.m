clc;clear;close all;

%% Part 2: Modeling nonlinear plant with nonlinear adaptive filter
Niterations = 2000;             % Number of iterations
Nruns = 100;                    % Number of runs to average MSE
L = 9;                          % Memory length
var_r = 4;                      % variance of input signal
mu = 4e-4;                      % adaptation constant
xtest = 2*cos(pi/10*(0:50));    % sinusoidal test signal
ytest = nonlinear_plant(xtest); % nonlinear plant output for test signal
Nweights = 2*(L+1) + nchoosek(L+1, 2) + 1; % Number of weights

% For part 2.E
% var_r = 0.4;
% mu = 4e-3;

%% Your code goes here
% Matlab hints:
% - Hints for part 1 are also relevant here.
% - To calculate the output of the nonlinear filter, you need to calculate
% several cross-products of the input signal, as described in the exam. 
% You may want to use the Matlab function 'nchoosek' with a vector input to 
% obtain the indices of the elements you need to multiply. 
% For instance, idx = nchoosek(1:3, 2) results in 
% idx = 
%      1     2
%      1     3
%      2     3
% which corresponds to all possible combinations of the entries of the vector [1, 2, 3]
% taken 2 by 2. Each row of idx gives you the indices of the input that forms a
% cross-product, as you can verify from Fig. 2 in the exam. Hence, you can 
% obtain all cross-products of the elements of a vector X by using 
% > X(idx(:, 1)).*X(idx(:, 2))
% You're not required to use this particular implementation. Feel 
% free to use whatever method you like to compute the cross-products.

%% ----------------------(b)-------------------------
W = zeros(Nweights,1);
Xi = zeros(Niterations,1);
idx = nchoosek(1:L+1, 2);
for run = 1:Nruns
    r = sqrt(3*var_r)*(rand(Niterations+L,1)-0.5)*2;
%     display(var(r))  %show that var(r)==4
    d = nonlinear_plant(r);
    w = zeros(Nweights,1);
    xi = zeros(Niterations,1);
    for i = 1:Niterations
        tmp = r(i+L:-1:i);
        x = [1; tmp; tmp.^2; tmp(idx(:, 1)).*tmp(idx(:, 2))];
        eps = d(i+L) - w'*x;
        w = w + 2*mu*eps*x;
        xi(i) = eps^2;
    end
    W = W+w; Xi = Xi+xi;
end
Xi = Xi/Nruns;
W = W/Nruns;

plot(Xi(L+2:end));
title('(2.b) Learning curve (averaged over 100 runs)','FontSize',14);
xlabel('iteration','FontSize',14); ylabel('\xi','FontSize',14);
set(gca,'FontSize',14);
figure;
stem(0:length(w)-1, w);
axis([0,70,-0.05,0.3]);
title('(2.b) Weight vector (at the last iteration of the last run)','FontSize',14);
set(gca,'FontSize',14);

%% ----------------------(c)-------------------------
mmse = mean(Xi(end-199:end));
display(strcat('(2.c) mmse=',num2str(mmse)));

%% ----------------------(d)-------------------------
n_tmp = length(xtest);
x = [zeros(L,1);xtest'];
result = zeros(n_tmp,1);
for i = 1:length(xtest)
    tmp = x(i+L:-1:i);
    tmp = [1; tmp; tmp.^2; tmp(idx(:, 1)).*tmp(idx(:, 2))];
    result(i) = w'*tmp;
end
figure; 
plot(ytest); hold on; plot(result,'r');
legend('output of the plant','output of the ADF');
title('(2.d) compare the outputs','FontSize',14);
xlabel('t','FontSize',14); ylabel('output','FontSize',14);
set(gca,'FontSize',14);

%% ----------------------(e)-------------------------
mu = 4*10^(-3);
var_r = 0.4;
% % justify the reasoning
% xtest = 0.2*cos(pi/10*(0:50));    % sinusoidal test signal
% ytest = nonlinear_plant(xtest); % nonlinear plant output for test signal

W = zeros(Nweights,1);
Xi = zeros(Niterations,1);
idx = nchoosek(1:L+1, 2);
for run = 1:Nruns
    r = sqrt(3*var_r)*(rand(Niterations+L,1)-0.5)*2;
%     display(var(r))  %show that var(r)==0.4
    d = nonlinear_plant(r);
    w = zeros(Nweights,1);
    xi = zeros(Niterations,1);
    for i = 1:Niterations
        tmp = r(i+L:-1:i);
        x = [1; tmp; tmp.^2; tmp(idx(:, 1)).*tmp(idx(:, 2))];
        eps = d(i+L) - w'*x;
        w = w + 2*mu*eps*x;
        xi(i) = eps^2;
    end
    W = W+w; Xi = Xi+xi;
end
Xi = Xi/Nruns;
W = W/Nruns;

figure;
plot(Xi(L+2:end));
title('(2.e) Learning curve (averaged over 100 runs)','FontSize',14);
xlabel('iteration','FontSize',14); ylabel('\xi','FontSize',14);
set(gca,'FontSize',14);
figure;
stem(0:length(w)-1, w);
axis([0,70,-0.05,0.3]);
title('(2.e) Weight vector (at the last iteration of the last run)','FontSize',14);
set(gca,'FontSize',14);

mmse = mean(Xi(end-199:end));
display(strcat('(2.e) mmse=',num2str(mmse)));

n_tmp = length(xtest);
x = [zeros(L,1);xtest'];
result = zeros(n_tmp,1);
for i = 1:length(xtest)
    tmp = x(i+L:-1:i);
    tmp = [1; tmp; tmp.^2; tmp(idx(:, 1)).*tmp(idx(:, 2))];
    result(i) = w'*tmp;
end
figure; 
plot(ytest); hold on; plot(result,'r');
legend('output of the plant','output of the ADF');
title('(2.e) compare the outputs','FontSize',14);
xlabel('t','FontSize',14); ylabel('output','FontSize',14);
set(gca,'FontSize',14);
