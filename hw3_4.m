clc
clear
close all
%% exercise 4.15
k=0:60;
xi = 4+38*(0.9).^(2*k);
plot(k,xi,'-*');
grid on;
xlabel('k');
ylabel('\xi');
title('Learning Curve');