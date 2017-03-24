clc
clear
close all
%% exercise 5.2
% xi versus w
w = -2:0.01:6;
xi = 5*w.^2-20.*w+23;
plot(w,xi,'k');
grid on; hold on;
% w* and xi min
index_min = find(min(xi) == xi);
w_min = w(index_min);
xi_min = xi(index_min);
plot(w_min, xi_min, 'ro','LineWidth',1.5);
hold on;
strmin = ['w*=', num2str(w_min), ...
    ',  \xi_{min}=', num2str(xi_min)];
text(w_min,xi_min,strmin,'VerticalAlignment','top','FontSize',12,'color','r');
% lambda
index_v = find(2.5 == w);
xi_v = xi(index_v);
left_index = find(1.5 == w);
xi_v_left = xi(left_index);
right_index = find(3.5 == w);
xi_v_right = xi(right_index);
plot([1.5,2.5,3.5],[xi_v_left,xi_v,xi_v_right], 'b*', 'LineWidth', 1.5);
plot([1.5,3.5],[xi_v_left,xi_v_right], 'b', 'LineWidth', 1.5);
strlambda = ['slope:  \lambda=', num2str(5)];
text(3.5,xi_v_right,strlambda,'VerticalAlignment','top','FontSize',12,'color','b');
% gamma
tmp = 0.5*(xi_v_left+xi_v_right);
plot([2.5,2.5],[xi_v,tmp],'k*-','LineWidth',1.5);
strgamma = ['length:  \gamma=', num2str(5),'  '];
text(2.5,tmp,strgamma,'HorizontalAlignment','right','FontSize',12,'color','k');

title('\xi versus w');
xlabel('w'); ylabel('\xi');
axis([-2,6,-10,90]);