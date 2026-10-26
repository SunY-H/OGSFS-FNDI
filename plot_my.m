% I = imread('Wpbc.jpg'); %%%读取test图片（为三通道彩色图片）
% imfinfo('Wpbc.jpg') %%%显示图片详细信息，不想看也ok的
% I1 = rgb2gray(I); %%%将RGB图片转换为灰度图片
% imshow(I1); %%%可以看一看转换后的图片哈，当然，不想看也可以不看哈
% imwrite(I1,'Wpbcsave.jpg') %%%将转换后的I1图片保存为testsave.jpg。




% ACC1= zeros(5,10) ;
% G = [50,100,200,400,800];
% alpha = 0.1:0.1:1;
% [x,y] = meshgrid(G,alpha);
% C = ACC1;
% surfc(x,y,ACC1',C');
% colorbar('FontWeight','bold','FontSize',25);
% x1 = xlabel('组规模','FontWeight','bold');
% x2 = ylabel('模糊邻域半径','FontWeight','bold');
% x3 = zlabel('分类准确率/%','FontWeight','bold');
% set(x1,'Rotation',25);
% set(x2,'Rotation',-30);



x = zeros(16,7) ;
rng default;
figure;
boxplot(x,'Labels',{'OGSFS-FNGBRS','OGSFS-FI','Group-SAOLA','OFS-A3M','α-investing','FNRS','FNPME-FS'},'colors','k','outliersize',8,'symbol','k+');
x22 = ylabel('分类准确率/%','FontWeight','bold');
% b.BoxFaceColor = [0 0 0];%BoxFaceColor - 框颜色
% b.WhiskerLineColor = [0 0 0];%WhiskerLineColor - 须线颜色