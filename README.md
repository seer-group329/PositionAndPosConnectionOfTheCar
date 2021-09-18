# 简介
本仓前两部分分别是使用多项式和贝塞尔曲线进行位姿连接的实现。主要目的是为了实现自主叉车在行驶过程中，所行驶的轨迹在初始位置与目标位置都是直线，即两个位置的曲率为零。

其它是**Continuous Path Smoothing for Car-Like Robots Using B-Spline Curves**论文的复现，首先在每两个waypoint中添加一个点，使其与waypoint点构成B样条的控制点，然后通过一定的规则对生成新的控制点，具体的可以看**Continuous Path Smoothing for Car-Like Robots Using B-Spline Curves**，最后利用clamped B样条生成平滑后的路径。
# 效果：
![image](https://github.com/ouyiyun/BsplinOpt/blob/master/doc/Bspline.gif)
# 参考：
1、https://github.com/pjbarendrecht/BsplineLab

2、https://www.cs.montana.edu/paxton/classes/aui/dslectures/CoxdeBoor.pdf

3、Elbanhawi, M., et al. (2015). "Continuous Path Smoothing for Car-Like Robots Using B-Spline Curves." Journal of Intelligent & Robotic Systems 80(S1): 23-56.
# 鸣谢：
此程序为在仙工智能 SEER实习期间完成(7.12 - 8.16)，感谢黄强盛老师在期间的指导。
