clear all;
clc;
close all;
msx = 1;
msy = 1;
p0=[0,0,0];
p5=[8,5,pi/3];
p5 = p5 - p0;
angle = p0(3);
%R = [cos(angle) sin(angle) 0; -sin(angle) cos(angle) 0; 0 0 1];
% p5 = R*p5' - p0';
% p5 = R*p5';
% p0 = [0 0 0];
% p5 = p5';
% p5 = [msx*p5(1) msy*p5(2) p5(3)];
t0 = 0;
t1 = 1;
% a = 0.1:0.1:2;
% b = 0.1:0.1:2;
% X = [p0(1),a,0,p5(1),b,0];
% Y = [p0(2),a*tan(p0(3)),0,p5(2),b*tan(p5(3)),0];
Rmin = 0.1;
Kmin = 10^10;
Kmax = 0;
Amin = 0;
Bmin = 0;
Amax = 0;
Bmax = 0;

T = [ t0^5      t0^4      t0^3     t0^2    t0   1;
    5*t0^4    4*t0^3    3*t0^2   2*t0    1    0;
    20*t0^3   12*t0^2   6*t0     1       0    0;
    t1^5      t1^4      t1^3     t1^2    t1   1;
    5*t1^4    4*t1^3    3*t1^2   2*t1    1    0;
    20*t1^3   12*t1^2   6*t1     1       0    0];

for a = 0.1:0.1:10
    for b = 0.1:0.1:10
        
        X = [p0(1),a,0,p5(1),b,0];
        Y = [p0(2),a*tan(p0(3)),0,p5(2),b*tan(p5(3)),0];
        
        %         T = inv(T);
        %         A = T*X';
        %         B = T*Y';
        A = T \ X';
        B = T \ Y';
        t = t0:0.01:t1;
        
        x = (A(1)*t.^5  + A(2)*t.^4 + A(3)*t.^3 + A(4)*t.^2 + A(5)*t + A(6))/msx;
        
        y = (B(1)*t.^5  + B(2)*t.^4 + B(3)*t.^3 + B(4)*t.^2 + B(5)*t + B(6))/msy;
        
        dy = diff(y)./diff(x);%求一阶倒数
        dy(end+1) = tan(p5(3));%补全一阶导数
        
        ddy = diff(dy)./diff(x);%求二阶倒数
        ddy(end+1) = 0;%补全二阶导数
        
        k = ddy./(1+dy.^2).^(3/2);%曲率计算
        klimit = (1/Rmin);
        
        if(max(abs(k)) >= klimit)
            continue;
        end
        
        ka = sum(abs(k).*abs(k));
        
        if ka>Kmax
            Kmax = ka;
            Amax = a;
            Bmax = b;
        end
        
        if ka < Kmin
            Kmin = ka;
            Amin = a;
            Bmin = b;
        end
        
    end
    
end

a = Amin;
b = Bmin;
%  a = Amax;
%  b = Bmax;
X = [p0(1),a,0,p5(1),b,0];
Y = [p0(2),a*tan(p0(3)),0,p5(2),b*tan(p5(3)),0];
T = [ t0^5      t0^4      t0^3     t0^2    t0   1;
    5*t0^4    4*t0^3    3*t0^2   2*t0    1    0;
    20*t0^3   12*t0^2   6*t0     1       0    0;
    t1^5      t1^4      t1^3     t1^2    t1   1;
    5*t1^4    4*t1^3    3*t1^2   2*t1    1    0;
    20*t1^3   12*t1^2   6*t1     1       0    0];

T = inv(T);
A = T*X';
B = T*Y';
t = t0:0.01:t1;

x = (A(1)*t.^5  + A(2)*t.^4 + A(3)*t.^3 + A(4)*t.^2 + A(5)*t + A(6))/msx;

y = (B(1)*t.^5  + B(2)*t.^4 + B(3)*t.^3 + B(4)*t.^2 + B(5)*t + B(6))/msy;

subplot(2,2,1)
plot(x, y , 'Color', [1.0 0 0], 'LineWidth', 1);
title('参数方程曲线')
xlim([0,10]);

subplot(2,2,2)
dy = diff(y)./diff(x);
dy(end+1) = tan(p5(3));
plot(x, dy, 'Color', [1.0 0 0], 'LineWidth', 1);
title('一阶导数')
xlim([0,10]);

subplot(2,2,3)
ddy = diff(dy)./diff(x);
ddy(end+1) = 0;
plot(x,ddy,'*','markersize',0.8)
title('二阶导数')
xlim([0,10]);
  
subplot(2,2,4)
k = ddy./(1+dy.^2).^(3/2);
plot(x,k)
text(x(1),k(1),['(',num2str(x(1)),',',num2str(k(1)),')'],'color','b')
text(x(end),k(end),['(',num2str(x(end)),',',num2str(k(end)),')'],'color','b')
title('曲率')
xlim([0,10]);
        