function selectedFeatures = OSGFS_FNDI_inter(X_G,Y,alpha)

%FNMDI1 = FN_MDI_D(X_G,Y,alpha);
FNDI1 = FN_DI(X_G,Y,alpha);

[~,col] = size(X_G);
intra_Selected = zeros(1,col);
for i = 1:col
    data_delete_i = X_G;
    data_delete_i(:,i) = [];
    
    %FNMDI2 = FN_MDI_D(data_delete_i,Y,alpha);
    FNDI2 = FN_DI(data_delete_i,Y,alpha);
    
    %Sig = FNMDI1 - FNMDI2;
    Sig = FNDI1 - FNDI2;
    
    if Sig > 0
        intra_Selected(1,i) = 1;
    end
    
end
selectedFeatures = find(intra_Selected == 1);

end
