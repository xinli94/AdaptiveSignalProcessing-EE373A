function output = nonlinear_plant(input)
%% Nonlinear plant
h1_num = [-0.0078    0.0645    0.4433    0.4433    0.0645   -0.0078];
h1_den = 1; 
h2_num = [-0.0078    0.0645    0.4433    0.4433    0.0645   -0.0078];
h2_den = 1;
g = @(u) exp(u/2) - 1;

input = filter(h1_num, h1_den, input);
output = g(input);
output = filter(h2_num, h2_den, output);