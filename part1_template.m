clc;clear;close all;

%% Part 1: Modeling nonlinear plant with linear adaptive filter
Niterations = 2000;             % Number of iterations
Nruns = 100;                    % Number of runs to average MSE
L = 9;                          % FIR filter length - 1 (doesn't include bias weight)
var_r = 4;                      % variance of input signal
xtest = 2*cos(pi/10*(0:50));    % sinusoidal test signal
ytest = nonlinear_plant(xtest); % nonlinear plant output for test signal
Nweights = L + 2;               % number of weights: FIR taps + bias weight

%% Your code goes here
% Matlab hints:
% - To generate the random training signal, use the function rand().
% Note, however, that rand() generates an uniform signal in [0, 1].
% - At each run, don't forget to generate new realizations of the random 
% input signal and to reset the weight vector to its initial value.
% - To calculate the output of an FIR filter, you can use the function
% filter(h, 1, x), where h are the FIR filter coefficients and x is the input
% signal. You need to add the bias separately.
% - When plotting the learning curve, discard the learning curve first L+1 
% samples, since during that transient the filter is being initialized. 
% - To plot the weigtht vector W, use the function stem(0:length(W)-1, W)
% 
%% ----------------------(b)-------------------------
mu = 1/4100;
W = zeros(L+2,1);
Xi = zeros(Niterations,1);
for run = 1:Nruns
    r = sqrt(3*var_r)*(rand(Niterations+L,1)-0.5)*2;
%     display(var(r))  %show that var(r)==4
    d = nonlinear_plant(r);
    w = zeros(Nweights,1);
    xi = zeros(Niterations,1);
    for i = 1:Niterations
        x = [1;r(i+L:-1:i)];
        eps = d(i+L) - w'*x;
        w = w + 2*mu*eps*x;
        xi(i) = eps^2;
    end
    W = W+w; Xi = Xi+xi;
end
Xi = Xi/Nruns;
W = W/Nruns;

plot(Xi(L+2:end));
title('(1.b) Learning curve (averaged over 100 runs)','FontSize',14);
xlabel('iteration','FontSize',14); ylabel('\xi','FontSize',14);
set(gca,'FontSize',14, 'FontWeight','bold');
figure;
stem(0:length(w)-1, w);
title('(1.b) Weight vector (at the last iteration of the last run)','FontSize',14);
set(gca,'FontSize',14);

%% ----------------------(c)-------------------------
mmse = mean(Xi(end-199:end));
display(strcat('(1.c) mmse=',num2str(mmse)));

%% ----------------------(e)-------------------------
% n_tmp = length(xtest);
% x = [zeros(L,1);xtest'];
% result = zeros(n_tmp,1);
% for i = 1:length(xtest)
%     tmp = [1;x(i+L:-1:i)];
%     result(i) = w'*tmp;
% end
result = filter(w(2:end),1,xtest) + w(1);
figure; 
plot(ytest); hold on; plot(result,'r');
legend('output of the plant','output of the ADF');
title('(1.e) compare the outputs','FontSize',14);
xlabel('t','FontSize',14); ylabel('output','FontSize',14);
set(gca,'FontSize',14);

%% ----------------------(d)-------------------------
var_r = 10^(-2);
mu = 0.01;
W = zeros(L+2,1);
Xi = zeros(Niterations,1);
for run = 1:Nruns
    r = sqrt(3*var_r)*(rand(Niterations+L,1)-0.5)*2;
%     display(var(r))  %show that var(r)==4
    d = nonlinear_plant(r);
    w = zeros(L+2,1);
    xi = zeros(Niterations,1);
    for i = 1:Niterations
        x = [1;r(i+L:-1:i)];
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
title('Learning curve (averaged over 100 runs)','FontSize',14);
xlabel('iteration','FontSize',14); ylabel('\xi','FontSize',14);
set(gca,'FontSize',14);

mmse = mean(Xi(end-199:end));
display(strcat('mmse=',num2str(mmse)));

