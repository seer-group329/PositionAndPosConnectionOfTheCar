function [X,Y,s] = BSpline(order, controlPoint, knotVector)
m = length(knotVector) - 1;
n = size(controlPoint,1) - 1;
if(m ~= n + 1 + order)
    disp('����ĵ�����ڵ���������ƥ��');
end
[s, Basis] = CoxdeBoor(order,knotVector,order+1,m-order+1);
X = controlPoint(:,1)' * Basis;
Y = controlPoint(:,2)' * Basis;
end