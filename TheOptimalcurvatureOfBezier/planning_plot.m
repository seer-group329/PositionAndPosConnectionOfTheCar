function  planning_plot(p0,p5,i,lmin1,lmin2)
p1 = p0 + [lmin1*cos(p0(3)),lmin1*sin(p0(3)),0];
p2 = p1;
p4 = p5 - [lmin2*cos(p5(3)),lmin2*sin(p5(3)),0];
p3 = p4;
[p51_x, p51_y] = B5_C(p0,p1,p2,p3,p4,p5);
show(p0,p1,p2,p3,p4,p5,p51_x,p51_y,i);
end