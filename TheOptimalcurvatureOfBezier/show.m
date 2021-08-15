function  show(p0,p1,p2,p3,p4,p5,p51_x,p51_y,i)
subplot(2,2,1)
hold on
subplot(2,2,1)
l_x = linspace(p0(1)-5*cos(p0(3)),p0(1),1000);
l_y = linspace(p0(2)-5*sin(p0(3)),p0(2),1000);
plot(l_x,l_y,'k-')

% plot([p0(1),p0(1)-30*cos(p0(3))],[p0(2),p0(2)-30*sin(p0(3))],'-k')
plot([p0(1),p1(1),p2(1)],[p0(2),p1(2),p2(2)],'--k*')
plot(p51_x,p51_y,'k')
plot([p3(1),p4(1),p5(1)],[p3(2),p4(2),p5(2)],'--k*')
plot([p5(1),p5(1)+5*cos(p5(3))],[p5(2),p5(2)+ 5*sin(p5(3))],'-k')
%title('直线-5阶-直线')
p51_x = [l_x p51_x];
p51_y = [l_y p51_y];
% xlim([-15,95])

subplot(2,2,2)
dy = diff(p51_y)./diff(p51_x);
a = dy(end);
dy(end+1) = a;
plot(p51_x,dy)
title('一阶')
% xlim([-15,65])

subplot(2,2,3)
ddy = diff(dy)./diff(p51_x);
ddy(end+1) = 0;
plot(p51_x,ddy,'*','markersize',0.8)
title('二阶')
% xlim([-15,65])

subplot(2,2,4)
k = ddy./(1+dy.^2).^(3/2);
plot(p51_x,k)
title('曲率')
% xlim([-15,65])
hold on
figure(i+1)
end