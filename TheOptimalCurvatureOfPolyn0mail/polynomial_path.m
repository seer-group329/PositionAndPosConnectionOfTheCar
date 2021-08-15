clear all;
clc;
close all;
p0=[0,0,0];
p5=[8,5,pi/3];
p5 = p5 - p0;
% angle = p0(3);
% R = [cos(angle) sin(angle) 0; -sin(angle) cos(angle) 0; 0 0 1];
% % p5 = R*p5' - p0';
% p5 = R*p5';
% p0 = [0 0 0];
% p5 = p5';
x0 = p0(1);
x1 = p5(1);
Y = [p0(2),tan(p0(3)),0,p5(2),tan(p5(3)),0];
X = [ x0^5      x0^4      x0^3     x0^2    x0   1;
      5*x0^4    4*x0^3    3*x0^2   2*x0    1    0;
      20*x0^3   12*x0^2   6*x0     2       0    0;
      x1^5      x1^4      x1^3     x1^2    x1   1;
      5*x1^4    4*x1^3    3*x1^2   2*x1    1    0;
      20*x1^3   12*x1^2   6*x1     2       0    0];
  
  
X = inv(X);
A = X*Y';

x = x0:0.01:x1;
y = A(1)*x.^5  + A(2)*x.^4 + A(3)*x.^3 + A(4)*x.^2 + A(5)*x + A(6);
hold on
figure(1)
subplot(2,2,1)
plot(x, y , 'Color', [1.0 0 0], 'LineWidth', 1);
title('显示方程曲线')
xlim([0,10]);

subplot(2,2,2)
dy = diff(y)./diff(x);
dy(end+1) = tan(p5(3));
plot(x, dy, 'Color', [1.0 0 0], 'LineWidth', 1);
% text(x(1),dy(1),['(',num2str(dy(1)),',',num2str(dy(1)),')'],'color','b')
% text(x(end),dy(end),['(',num2str(dy(end)),',',num2str(dy(end)),')'],'color','b')
xlim([0,10]);
title('一阶')


subplot(2,2,3)
ddy = diff(dy)./diff(x);
ddy(end+1) = 0;
plot(x,ddy,'*','markersize',0.8)
title('二阶')
xlim([0,10]);
  
subplot(2,2,4)
k = ddy./(1+dy.^2).^(3/2);
plot(x,k)
text(x(1),k(1),['(',num2str(x(1)),',',num2str(k(1)),')'],'color','b')
text(x(end),k(end),['(',num2str(x(end)),',',num2str(k(end)),')'],'color','b')
title('曲率')
xlim([0,10]);