close all 
clear all

f=imread('C:/Users/asus.000/Desktop/timg.jfif');

[w,h]=size(f);
image= f(:,:);
Q1 = 1;
fsize1=3;
fsize2=5;
fsize3=9;

fssize1=(fsize1-1)/2;
fssize2=(fsize2-1)/2;
fssize3=(fsize3-1)/2;

figure();
subplot(2,2,1);
imshow(f);
xlabel('原图像');

%3*3逆谐波均值
resultImage = image;
for x=1+fssize1:1:w-fssize1
    for y=1+fssize1:1:w-fssize1
        is=f(x-fssize1:1:x+fssize1,y-fssize1:1:y+fssize1);
        resultImage(x,y) = sum(is(:).^(Q1+1))/sum(is(:).^(Q1));
    end
end

subplot(2,2,2);
imshow(resultImage);
xlabel('3*3逆谐波均值');

%5*5逆谐波均值
resultImage= f(:,:);
for x=1+fssize2:1:w-fssize2
    for y=1+fssize2:1:w-fssize2
        %遍历每个点的四周
        is=f(x-fssize2:1:x+fssize2,y-fssize2:1:y+fssize2);
        resultImage(x,y) = sum(is(:).^(Q1+1))/sum(is(:).^(Q1));

    end
end

subplot(2,2,3);
imshow(resultImage);
xlabel('5*5逆谐波均值');

%9*9逆谐波均值
resultImage= f(:,:);
for x=1+fssize3:1:w-fssize3
    for y=1+fssize3:1:w-fssize3
        %遍历每个点的四周
        is=f(x-fssize3:1:x+fssize3,y-fssize3:1:y+fssize3);
        resultImage(x,y) = sum(is(:).^(Q1+1))/sum(is(:).^(Q1));
    end
end

subplot(2,2,4);
imshow(resultImage);
xlabel('9*9逆谐波均值');