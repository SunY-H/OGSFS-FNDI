clc;
clear;

% load('COLON.mat', 'Data_Colon');
% data = Data_Colon;

% load('leukemia.mat', 'leukemia');
% data = leukemia;

% load('DLBCL.mat', 'DLBCL');
% data = DLBCL;

% load('SRBCT.mat', 'mdata');
% data = mdata;

% load('Lymphoma.mat', 'mdata');
% data = mdata;
% data(isnan(data))=0;

% load('Lung.mat', 'mdata');
% data = mdata;

% load('Ovarian.mat', 'mdata');
% data = mdata;

% load arcene;
% data = [X_train,Y_train];

% load madelon;
% data = [X_train,Y_train];

load Data_Heart;
data = Data_Heart;

% load Data_Breast;
% data = Data_Breast;

% load Data_MLL;
% data = Data_MLL;

% data = xlsread('lonosphere.xlsx');
% data = xlsread('Sonar.xlsx');
% data = xlsread('wpbc.xlsx');
% data = xlsread('wdbc.xlsx');

ACC1= zeros(5,10) ;
ACC2= zeros(5,10) ;
Number = zeros(5,10);
Time = zeros(5,10);
G = [50,100,200,400,800];
alpha = 0.1:0.1:1;

[x,y] = meshgrid(G,alpha);
for m=1:1:5
    for n=1:1:10
        [Aver_Accuracy1,Aver_Accuracy2,Aver_Number,Aver_time] = main(data,G(m),alpha(n));

        Time(m,n) = Aver_time;
        Number(m,n) = Aver_Number;
        ACC1(m,n)=Aver_Accuracy1;
        ACC2(m,n)=Aver_Accuracy2;
    end
end
C = ACC1;
surfc(x,y,ACC1',C');
colorbar;
x1 = xlabel('Group Size');
x2 = ylabel('Delta');
x3 = zlabel('Accuracy(%)');
set(x1,'Rotation',30);
set(x2,'Rotation',-30);

% function [Aver_Accuracy1,Aver_Accuracy2,Aver_Accuracy3,Aver_Accuracy4,Aver_Number,Feature_select]=main2(Data,debt,delta,lambd)
% %k折交叉验证
% [~,b] = size(Data);
% xtrain = Data(:,1:b-1);
% ytrain = Data(:,b);
% 
% data=double(xtrain);
% label=double(ytrain);  %要求数据集每一行代表一个样本 ;label每行为标签
% 
% [M,N]=size(data); % M:总样本量； N:一个样本的元素总数  条件属性数据
% rng(0);
% indices=crossvalind('Kfold',data(1:M,N),5);  %进行随机分包
% %indices是一个N维列向量，每个元素对应的值为该单元所属的包的编号（即该列向量中元素是1~k的整随机数），利用这个向量即可通过循环控制来对数据集进行划分。
% %test 和 train 为 N维布尔列向量，用于抽取数据。 
% %分为1-5  随机五组数据
% %Aver_Time = 0;
% Aver_Number = 0;
% Aver_Accuracy1 = 0;
% Aver_Accuracy2 = 0;
% Aver_Accuracy3 = 0;
% Aver_Accuracy4 = 0;
% for k=1:5  %交叉验证k=10，10个包轮流作为测试集
%     test = (indices == k);   %获得test集元素在数据集中对应的单元编号
%     train = ~test;  %train集元素的编号为非test元素的编号
%     train_data=data(train,:);%从数据集中划分出train样本的数据
%     train_label=label(train,:);
%     
%     %Input_data = normlize_data(train_data);
%     %Input_train = normlize_data(train_label);
%     data1=[train_data,train_label];
%     [feature_select,time]= FNR2(data1,debt,delta,alpha,lambd);
%     %[selectedFeatures,time] = OSGFS_FNR_inter(Input_data,train_label,G,alpha);
%     C{k}=feature_select;
%     %Aver_Time = Aver_Time + time;
% %     Aver_Number = Aver_Number + length(selectedFeatures);
% %     Selected = Input_data(:,selectedFeatures);
%     Aver_Number = Aver_Number + length(feature_select);
%     Selected = train_data(:,feature_select);
%     test_data=data(test,feature_select);
%    % test_data=normlize_data(test_data);
%     test_label=label(test,:);
%     %test_label= normlize_data(test_label);
% 
%     if ~isempty(Selected)
%         %KNN
%         %Train the classifier
%         nb = fitcknn(Selected,train_label,'NumNeighbors',3);
%         %Test the classifier
%         predicted_label = predict(nb,test_data);
%         Acc1 = length(find(predicted_label==test_label))/length(test_label)*100;
%         %SVM
%         model_linear = svmtrain(train_label, Selected, '-t 0');
%         [~, accuracy_L, ~] = svmpredict(test_label, test_data, model_linear);
%         Acc2 = accuracy_L(1,1);
%         %NB
%         nb2 = fitcnb(Selected,train_label);
%         %Test the classifier
%         predicted_label2 = predict(nb2,test_data);
%         Acc3 = length(find(predicted_label2==test_label))/length(test_label)*100;
%         %CART
%          %Train the classifier
%         tree=fitctree(Selected,train_label);
%         %view(tree,'Mode','graph');%生成树图
%         %rules_num=(tree.IsBranchNode==0);
%         %rules_num=sum(rules_num);%求取规则数量
%         Cart_result=predict(tree,test_data);%使用测试样本进行验证
%         Cart_result=(Cart_result==test_label);
%         Cart_length=size(Cart_result,1);%统计准确率
%         Cart_rate=(sum(Cart_result))/Cart_length*100;
%         %disp(['规则数：' num2str(rules_num)]);
%         %disp(['测试样本识别准确率：' num2str(Cart_rate)]);       
%         Acc4 = Cart_rate;
%     else
%         Acc1=0;
%         Acc2=0;
%         Acc3=0;
%         Acc4=0;
%     end
%     Aver_Accuracy1 = Aver_Accuracy1 + Acc1; 
%     Aver_Accuracy2 = Aver_Accuracy2 + Acc2; 
%     Aver_Accuracy3 = Aver_Accuracy3 + Acc3; 
%     Aver_Accuracy4 = Aver_Accuracy4 + Acc4; 
% end
% Feature_select=C;
% %Aver_Time = Aver_Time / 5;
% Aver_Number = Aver_Number / 5;
% Aver_Accuracy1 = Aver_Accuracy1 / 5;
% Aver_Accuracy2 = Aver_Accuracy2 / 5;
% Aver_Accuracy3 = Aver_Accuracy3 / 5;
% Aver_Accuracy4 = Aver_Accuracy4 / 5;

