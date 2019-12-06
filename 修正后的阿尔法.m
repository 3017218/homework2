%%%%%%------------------图像复原之空间滤波---------------------------------
clc;
clear;
%读入图像，并转换为double型
I=imread('C:/Users/asus.000/Desktop/timg.jfif');
I_D=im2double(I);
[MM,NN]=size(I_D);
 
%%%%%----------------------2、顺序统计滤波器-------------------------------
%%======================= 2.3 修正后的阿尔法均值滤波器=====================
%定义子窗口的尺寸
m=5;
n=5;
%确定要扩展的行列数
len_m=floor(m/2);
len_n=floor(n/2);
%将原始图像进行扩展，这里采用了镜像扩展，以进行图像边缘计算
I_D_pad=padarray(I_D,[len_m,len_n],'symmetric');
%获得扩展后的图像尺寸
[M,N]=size(I_D_pad);
d=5;
J_Alpha=zeros(MM,NN);
%逐点计算子窗口的谐波平均
for i=1+len_m:M-len_m
    for j=1+len_n:N-len_n
        %从扩展图像中取出子图像
        Block=I_D_pad(i-len_m:i+len_m,j-len_n:j+len_n);
        %计算矩阵的阿尔法均值        
        J_Alpha(i-len_m,j-len_n)=sum(sum(Block))/(m*n-d);
    end
end
imshow(J_Alpha);
title('修正后的阿尔法均值滤波器');