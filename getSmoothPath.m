function [smoothPath] = getSmoothPath(path, k, alpha)
%smoothPath��ƽ��֮��Ŀ��Ƶ�
%path��ԭʼ·����
%k���������
%alpha����С�н�

% Lmin = 112;
% assignAngle = pi/2;
% assignAngle = alpha;
% Lmin = (sin(alpha) / (0.125 * (1 - cos(alpha)))^(1.5)) / (6*k);
[Lmin, assignAngle] = getLAngel(path); %�õ����Ƶ�֮�����С�ĳ�������Ƶ�֮���ƽ���Ƕ�
% assignAngle = pi/2;
%���н�
m = size(path,1);
newPath = [path(1,:)];% �洢������С�нǵĵ㣬�������º�����нǵĵ�
waitCheckPoint = path; %�����ĵ�
id = 2; %waitCheckPoint�еĵڼ�����
% deg =[]; 

% �趨ѭ������
maxNum = 2*m;
num = 0;
while (id < size(waitCheckPoint,1))
    %����������cos
    A = waitCheckPoint(id,:);
    B = waitCheckPoint(id-1,:);
    C = waitCheckPoint(id+1,:);
    AB = B - A;
    AC = C - A;
    % ������
    cosTheta = AB * AC' / (norm(AB) * norm(AC));
    theta = acos(cosTheta);
    angle = rad2deg(theta);
    %���õ㲻������С�нǣ���ôwaitCheckPoint�����
    %id����Ϊ1��ͬʱ���õ����µõ��ĵ�ѹ��newPath
    if (theta - alpha < -0.01) %һ����Χ����Ϊtheta��alpha��𲻴�
        % ���ò���͵�����µĿ��Ƶ�D
        H = [AB(1,1) AB(1,2); -1*AB(1,2) AB(1,1)];
        % \�������a\b��ʾ����a�������b
%         ADT = H\[norm(AB)*Lmin*cos(alpha);norm(AB)*Lmin*sin(alpha)];
        %��AB��AC�Ĳ��
        crossABAC = cross([AB 0], [AC 0]);
        if (crossABAC(1,3) < 0)
            ADT = H\[norm(AB)*Lmin*cos(assignAngle);norm(AB)*Lmin*sin(-1*assignAngle)];
        else
            ADT = H\[norm(AB)*Lmin*cos(assignAngle);norm(AB)*Lmin*sin(assignAngle)];
        end
        DT = ADT + A';
        D = DT';
        %����newPath
        newPath = [newPath; A];
        %����waitCheckPoint��id
        waitCheckPoint = [A;D;waitCheckPoint(id+1:end,:)];
        id = 2;
    %���õ�������С�нǣ���ôwaitCheckPoint�������
    %����Ҫ��id��newPath����
    else
        newPath = [newPath;A];
        id = id+1;
    end
    num = num + 1;
    if(num > maxNum)
        break;
    end
end

newPath = [newPath;path(end,:)];

%�м���ֵ insertPoint
midPath = [newPath(1,:)];

for i=2:size(newPath,1)
    A = newPath(i,:);
    B = newPath(i-1,:);
    D = (A+B)./2;
    midPath = [midPath;D;A];
end
smoothPath = midPath;
end