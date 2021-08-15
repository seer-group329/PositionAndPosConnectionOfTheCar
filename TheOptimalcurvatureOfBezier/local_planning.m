%五阶贝塞尔曲线
%为满足使连接点曲率连续和切线连续,增加了两对控制点

clc
clear
close all
p0=[1,1,0];
p5=[15,15,0.7];
dis = norm(p0-p5);
L = dis/2;
Rmin = 0.5;
kamin = 10.^10; %曲率累加的最小值
lmin1 = 0;
lmin2 = 0;
kamax = 0; %曲率累加的最大值
lmax1 = 0;
lmax2 = 0;
for i = dis/10:0.1:L
    p1 = p0 + [i*cos(p0(3)),i*sin(p0(3)),0];
    p2 = p1;
    for j = dis/10:0.01:dis
        p4 = p5 - [j*cos(p5(3)),j*sin(p5(3)),0];
        p3 = p4;
        
        [p51_x, p51_y] = B5_C(p0,p1,p2,p3,p4,p5);
        
        %     l_x = linspace(-10,0,10000);
        %     l_y = l_x;
        %     p51_x = [l_x p51_x];
        %     p51_y = [l_y p51_y];
        
        dy = diff(p51_y)./diff(p51_x);
        a = dy(end);
        dy(end+1) = a;
        
        ddy = diff(dy)./diff(p51_x);
        ddy(end+1) = 0;
        k = (ddy./(1+dy.^2).^(3/2));
        klimit = (1/Rmin);
        if(max(abs(k))>=klimit)
            continue
        end
        ka = sum(abs(k));
        if ka>kamax
            kamax = ka;
            lmax1 = i;
            lmax2 = j;
        end
        if ka < kamin
            kamin = ka;
            lmin1 = i;
            lmin2 = j;
        end
    end
end
figure(1)
planning_plot(p0,p5,1,lmin1,lmin2);
% planning_plot(p0,p5,2,lmax);
% planning_plot(p0,p5,3,L);