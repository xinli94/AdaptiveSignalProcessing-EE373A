clc
clear
close all
%% exercise 4.5
k = 0:1:10;
xi = 1+10.*((-0.2).^(2.*k));
plot(k,xi,'-*');
grid on;
axis([0,10,0,12]);
xlabel('k');
ylabel('\xi');
title('Learning Curve');