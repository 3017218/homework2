clear
close all
clc
a1=-1.6;   
a2=0.8; 
[x,fs1]=audioread('handel.wav');
[dn,fs2]=audioread('handel_echo.wav');
figure;
subplot(2,1,1);
plot(x);
title('spk参考信号');
subplot(2,1,2);
plot(dn);
title('MICin-期望信号');

n=max(size(x));  % 信号中的时间点个数   
P=5;   % LMS算法重复运算5次，用于评估五次运算产生的误差的平均水平
e=zeros(1,n);   % 用于存放误差
ep=zeros(1,n);  % 用于存放五次运算累积的误差
ee=zeros(1,n);  % 用于存放平方差
%算法
h=waitbar(0,'计算进度');
steps = P;
for p=1:P 
L=100;     % 滤波器阶数，考虑到两个信号之间没有延时，且这里只是用来分离出输入的x信号，而且误差不做要求，因此不需要设置太高的阶数 
u=0.0022;   % 增益常数 
wL=zeros(L,n);  % 产生一个权向量矩阵
for i=(L+1):n   % 计算权向量矩阵中第三组权向量到最后一组权向量相关的变量，根据x和e=x-y求下一个y,没有d（n）
    X=x(i-L:1:(i-1));   % 更新滤波器的参考矢量X（n）
    y(i)=X'*wL(:,i);    % 根据x计算i时刻输出信号 
    e(i)=dn(i)-y(i);     % 计算i时刻误差信号 
    wL(:,(i+1))=wL(:,i)+2*u*e(i)*X;     % 更新i时刻滤波器的权向量 
    ee(i)=e(i)^2;   % 更新平方差
end 
ep=ep+ee;  % 平方差累积
waitbar(p/steps);
end
close(h);
eq=ep/P;    % 五十次重复计算平方差求均值
a1L=-wL(2,1:n);   % a1在LMS算法下值的变化，wL矩阵中第一行的1到n个数，权向量矩阵第一行 
a2L=-wL(1,1:n);   % a2在LMS算法下值的变化 ，wL矩阵中第二行的1到n个数，权向量矩阵第二行 

%画图
figure;
subplot(3,2,1);
plot(x); 
title('需要采集的声音Voice');    % 根据w产生的随机信号x

subplot(3,2,2);
plot(dn);
title('被回声污染的了Voice，就是MICin');   % 五十次运算误差求均值

subplot(3,2,3);
plot(y); 
title('合成回声信号');    % 根据w产生的随机信号x

subplot(3,2,4);
plot(e);
title('误差');   % 五十次运算误差求均值


subplot(3,2,5); 
plot(a1L,'r-'); % 权向量矩阵第一行
hold on;
plot(a2L,'k-'); % 权向量矩阵第二行
title('权向量参数的学习过程');  
legend('a1L','a2L');