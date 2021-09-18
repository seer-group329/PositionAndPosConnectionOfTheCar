%b����ʵ��
clc;clear;close all;
% path = ginput() * 100.0;
% ʵ��һ
% path =[8 5;7 15;2 10;11 10;11 14;45 30;45 12;25 45;12 45; 25 25];

% ʵ���
% path =[0 50;100 0;250 140;400 0;475 75];
% path =[0 50;100 0;250 140;475 75];
p0=[0,0,pi/6];
p3=[1.5,0.5,pi/3];
dis = norm(p0-p3);
L = dis/2;
%�������
kMax =5;
%��С�н�
alphaMin = deg2rad(15); %���ȱ�ʾ
% alphaMin = getMinAngel(kMax, Lmin);
%���
% Lmin =1/(6*kMax)*sin(alphaMin)*((1-cos(alphaMin))/8)^(-1.5);
kamin = 10.^10; %�����ۼӵ���Сֵ
lmin = 0;
kamax = 0; %�����ۼӵ����ֵ
lmax = 0;
for i = dis/12:0.05:dis
    p1 = p0 + [i*cos(p0(3)),i*sin(p0(3)),0];
    p2 = p3 - [i*cos(p3(3)),i*sin(p3(3)),0];
    
    path =[p0(1) p0(2);p1(1) p1(2);p2(1) p2(2);p3(1) p3(2)];
    
    boundPath = getSmoothPath(path, kMax,alphaMin);
    
    m = length(boundPath) + 3 + 1;
    kv = linspace(0,1,m-6);
    kv =[0 0 0 kv 1 1 1]; %׼����B�������ߵĽڵ�����
    %deboor
%     [X,Y] = BSpline(3,boundPath, kv);
    [s, cur] = getBsplineCur(3,boundPath,kv);
    
    if(max(abs(cur))>=kMax)
        continue
    end
    ka = sum(abs(cur).*abs(cur));
    if ka>kamax
        kamax = ka;
        lmax = i;
    end
    if ka < kamin
        kamin = ka;
        lmin = i;
    end
end

p1 = p0 + [lmin*cos(p0(3)),lmin*sin(p0(3)),0];
p2 = p3 - [lmin*cos(p3(3)),lmin*sin(p3(3)),0];
% p1 = p0 + [L*cos(p0(3)),L*sin(p0(3)),0];
% p2 = p3 - [L*cos(p3(3)),L*sin(p3(3)),0];
path =[p0(1) p0(2);p1(1) p1(2);p2(1) p2(2);p3(1) p3(2)];

controlPointX = path(:,1)';
controlPointY = path(:,2)';
subplot(2,2,1);
plot(controlPointX, controlPointY , 'Color', [1.0 0 0], 'LineWidth', 1);
hold on
plot(controlPointX, controlPointY , 'k.','MarkerSize', 20);
title('ԭʼ·����');

% [Lmin, ~] = getLAngel(path);
%˼����Դ��Continuous Path Smoothing for Car-Like Robots Using B-Spline Curves
%B����ƽ��������ԭʼ·����������ʡ����ߵ���С�нǣ����ƽ��B�����Ŀ��Ƶ�
%�������
kMax =0.5;
%��С�н�
alphaMin = deg2rad(15); %���ȱ�ʾ
% alphaMin = getMinAngel(kMax, Lmin);
%���
Lmin =1/(6*kMax)*sin(alphaMin)*((1-cos(alphaMin))/8)^(-1.5);
%��ȡƽ����Ŀ��Ƶ�
boundPath = getSmoothPath(path, kMax,alphaMin);
subplot(2,2,2);
plot(boundPath(:,1), boundPath(:,2) , 'Color', [0 0 1.0], 'LineWidth', 2);
hold on
plot(boundPath(:,1), boundPath(:,2), 'ko','MarkerSize', 5);
title('ƽ����·����');

m = length(boundPath) + 3 + 1;
kv = linspace(0,1,m-6);
kv =[0 0 0 kv 1 1 1]; %׼����B�������ߵĽڵ�����
%deboor
[X,Y] = BSpline(3,boundPath, kv);
subplot(2,2,3);
plot(X', Y' , 'Color', [1 0 0], 'LineWidth', 2);
hold on
plot(boundPath(1:end,1), boundPath(1:end,2) , 'Color', [0 0 1], 'LineWidth', 1);
plot(boundPath(1:end,1), boundPath(1:end,2) , 'ko','MarkerSize', 5);
title('��������Լ��');

subplot(2,2,4);
[s, cur] = getBsplineCur(3,boundPath,kv);
plot(s, cur, 'Color',[255 128 0]/255, 'LineWidth', 1);
title('����');

