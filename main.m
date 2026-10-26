function [Aver_Accuracy1,Aver_Accuracy2,Aver_Number,Aver_Time]=main(Data,G,alpha)
%k折交叉验证

[~,b] = size(Data);
xtrain = Data(:,1:b-1);
ytrain = Data(:,b);

data=double(xtrain);
label=double(ytrain);  %要求数据集每一行代表一个样本 ;label每行为标签

[M,N]=size(data); % M:总样本量； N:一个样本的元素总数
indices=crossvalind('Kfold',data(1:M,N),5);  %进行随机分包
%indices是一个N维列向量，每个元素对应的值为该单元所属的包的编号（即该列向量中元素是1~k的整随机数），利用这个向量即可通过循环控制来对数据集进行划分。
%test 和 train 为 N维布尔列向量，用于抽取数据。
Aver_Time = 0;
Aver_Number = 0;
Aver_Accuracy1 = 0;
Aver_Accuracy2 = 0;
for k=1:5  %交叉验证k=10，10个包轮流作为测试集
    test = (indices == k);   %获得test集元素在数据集中对应的单元编号
    train = ~test;  %train集元素的编号为非test元素的编号
    train_data=data(train,:);%从数据集中划分出train样本的数据
    train_label=label(train,:);

    Input_data = normlize_data(train_data);

    [ selectedFeatures,time] = OSGFS_FNDI(Input_data,train_label,G,alpha);

    Aver_Time = Aver_Time + time;
    Aver_Number = Aver_Number + length(selectedFeatures);
    Selected = Input_data(:,selectedFeatures);

    test_data=data(test,selectedFeatures);
    test_data=normlize_data(test_data);
    test_label=label(test,:);

    if ~isempty(Selected)
        %Train the classifier
        nb = fitcknn(Selected,train_label,'NumNeighbors',3);
        %Test the classifier
        predicted_label = predict(nb,test_data);
        Acc1 = length(find(predicted_label==test_label))/length(test_label)*100;
        
        tree=fitctree(Selected,train_label);
        %view(tree,'Mode','graph');%生成树图
        %rules_num=(tree.IsBranchNode==0);
        %rules_num=sum(rules_num);%求取规则数量
        Cart_result=predict(tree,test_data);%使用测试样本进行验证
        Cart_result=(Cart_result==test_label);
        Cart_length=size(Cart_result,1);%统计准确率
        Cart_rate=(sum(Cart_result))/Cart_length*100;
        %disp(['规则数：' num2str(rules_num)]);
        %disp(['测试样本识别准确率：' num2str(Cart_rate)]);
        
        Acc2 = Cart_rate;

    else
        Acc1=0;
        Acc2=0;
    end

%     if ~isempty(Selected)
%         %Train the classifier
%         nb = fitcnb(Selected,train_label);
%         %Test the classifier
%         predicted_label = predict(nb,test_data);
%         Acc = length(find(predicted_label==test_label))/length(test_label)*100;
%     else
%         Acc=0;
%     end

%     if ~isempty(Selected)
%         model_linear = svmtrain(train_label, Selected, '-t 0');
%         [~, accuracy_L, ~] = svmpredict(test_label, test_data, model_linear);
%         Acc = accuracy_L(1,1);
%     else
%         Acc=0;
%     end

%     if ~isempty(Selected)
%         
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
%         
%         Acc = Cart_rate;
%     else
%         Acc=0;
%     end
 
    Aver_Accuracy1 = Aver_Accuracy1 + Acc1;
    Aver_Accuracy2 = Aver_Accuracy2 + Acc2;
    
end
Aver_Time = Aver_Time / 5;
Aver_Number = Aver_Number / 5;
Aver_Accuracy1 = Aver_Accuracy1 / 5;
Aver_Accuracy2 = Aver_Accuracy2 / 5;

% for m=1:1:8
%     for n=1:1:8
%         %[feature_select,Accu]= FNR2(data,debt,delta,xa(n),ya(m));  
%         [Aver_Accuracy1,Aver_Accuracy2,Aver_Accuracy3,Aver_Accuracy4,Aver_Number,Feature_select]= main2(data,debt,delta,xa(m),ya(n));  
%         %第m行第n列的元胞
%         % A{m,n}=feature_select;
%         C{m,n}=Feature_select;
%         A(m,n)=Aver_Number;
%         %B(m,n)=Accu;
%         BKnn(m,n)= Aver_Accuracy1;
%         BSvm(m,n)= Aver_Accuracy2; 
%         BNB(m,n)=  Aver_Accuracy3;
%         BCart(m,n)=Aver_Accuracy4;   
%     end
% end
%  %a1(B);