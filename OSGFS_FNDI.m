function [ selectedFeatures,time ] = OSGFS_FNDI(X,Y,G,alpha)

start=tic;
[~,P] = size(X);
mode=zeros(1,P);
inter_Selected = find(mode == 1);
for i=1:G:P
    i_end=G+i-1;
    if i_end>P
        i_end=P;
    end
    indexArray = i:i_end;
    X_G=X(:,indexArray);
    %intra group FS
    RED_Selected=OSGFS_FNDI_inter(X_G,Y,alpha);
    G_N=length(RED_Selected);
    %inter group FS
    if isempty(inter_Selected)
        for j=1:G_N
            ind=RED_Selected(1,j);
            index=indexArray(ind);
            mode(1,index)=1;
        end
        inter_Selected = find(mode == 1);
    else
        X_middle = X(:,inter_Selected);
        [~,col_middle]=size(X_middle);
        
        %FNMDImid = FN_MDI_D(X_middle,Y,alpha);
        FNSUDImid = FN_MDI_D(X_middle,Y,alpha) / FN_DI(X_middle,Y,alpha);
        
        for j=1:G_N
            ind=RED_Selected(1,j);
            index=indexArray(ind);
            mode(1,index)=1;
            
            houxuan_Selected = mode == 1;
            X_houxuan = X(:,houxuan_Selected);

            %FNMDIhou = FN_MDI_D(X_houxuan,Y,alpha);
            FNSUDIhou = FN_MDI_D(X_houxuan,Y,alpha) / FN_DI(X_houxuan,Y,alpha);
            
            %FNMDIj = FN_MDI_D(X(:,index),Y,alpha);
            FNSUDIj = FN_MDI_D(X(:,index),Y,alpha) / FN_DI(X(:,index),Y,alpha);
            
            FNID = (FNSUDIhou - FNSUDImid - FNSUDIj) / (FNSUDImid+FNSUDIhou);
            %FNID = (FNMDIhou - FNMDImid - FNMDIj) / (FNMDImid+FNMDIhou);
            
            if FNID <= 0
                mode(1,index)=0;
            else
                for k = 1:col_middle
                    
                    %FNMDIk = FN_MDI_D(X_middle(:,k),Y,alpha);
                    FNSUDIk = FN_MDI_D(X_middle(:,k),Y,alpha)/FN_DI(X_middle(:,k),Y,alpha);
                    
                    %S = FNMDIj - FNMDIk;
                    S = FNSUDIj - FNSUDIk;
                    if S <= 0
                        mode(1,index) = 0;
                        break;
                    else
                        mode(1,inter_Selected(k)) = 0;
                    end
                end
            end
        end
        inter_Selected = find(mode == 1);
    end
end
intraSelectedFeatures = find(mode == 1);

if ~isempty(intraSelectedFeatures)
    X_Inter=X(:,intraSelectedFeatures);
    [B,FitInfo]=lasso(X_Inter,Y,'Alpha',1,'CV',5);
    minInd=FitInfo.IndexMinMSE;
    SF=B(:,minInd);
    selectedFeatures=intraSelectedFeatures(SF~=0);
else
    selectedFeatures=[];
end

% selectedFeatures = find(mode == 1);

time=toc(start);
end
