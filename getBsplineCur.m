function [s, cur]=getBsplineCur(degree, contrlPoint, kv)
% ��ȡ����B-spline��clamped B-spline������
% degree B-spline ����
% contrlPoint���Ƶ�
% kv �ڵ����� 
m = length(kv) - 1;
n = size(contrlPoint,1) - 1;
if(m ~= n + 1 + degree)
    disp('����ĵ�����ڵ���������ƥ��');
end

deltaKV = kv(degree+2) - kv(degree+1);
%һ�׵����Ƶ�
contrlPoint1 = [];
kv1 = kv(:,2:end-1);
%���׵����Ƶ�
contrlPoint2 = [];
kv2 = kv1(:,2:end-1);
%��һ�׵�
for i=1:size(contrlPoint)-1
    point_ = degree .* (contrlPoint(i+1,:) - contrlPoint(i,:)) ./ deltaKV;
    contrlPoint1 = [contrlPoint1; point_];
end
[dif1X, dif1Y, s] = BSpline(degree-1,contrlPoint1, kv1);
%����׵�

for i=1:size(contrlPoint1)-1
    point_ = (degree-1) .* (contrlPoint1(i+1,:) - contrlPoint1(i,:)) ./ deltaKV;
    contrlPoint2 = [contrlPoint2; point_];
end
[dif2X, dif2Y, ~] = BSpline(degree-2,contrlPoint2, kv2);

%��������
cur = (dif1X.*dif2Y - dif2X.*dif1Y)./((dif1X.^2 + dif1Y.^2).^1.5);

end