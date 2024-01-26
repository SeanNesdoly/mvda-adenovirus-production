function [predcv,rmsecv,nrmsecv,rsqcv,Result_nCV]=ResultnCV(fit,target_array,test_nor, test_pca,target_nor_C,NumBatch)

for i=1:2
    i
    for s=1:6
        s
        for r=1:NumBatch
            r
            
                if i == 1
%                     
                     if s==1|3|4|5   % Result_nCV{1-4} means different regression method
                        Result_nCV{1,1}.pred{i,s}{r,1}=[ones(size(test_nor{i,r}{s},1),1) test_nor{i,r}{s}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r};
                        Result_nCV{2,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.ann_nor,test_nor{i,r}{s})+target_nor_C{i,r};
                        Result_nCV{3,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.gp_nor,test_nor{i,r}{s})+target_nor_C{i,r};                    
                        Result_nCV{4,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.lr_nor,test_nor{i,r}{s})+target_nor_C{i,r};
                     else   % c= 2 or 6 PCA
                        Result_nCV{1,1}.pred{i,s}{r,1}=[ones(size(test_nor{i,r}{s},1),1) test_nor{i,r}{s}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r};
                        Result_nCV{2,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.ann_pca,test_pca{i,r}{s})+target_nor_C{i,r};
                        Result_nCV{3,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.gp_pca,test_pca{i,r}{s})+target_nor_C{i,r};
                        Result_nCV{4,1}.pred{i,s}{r,1}=predict(fit{i,r}{s}.lr_pca,test_pca{i,r}{s})+target_nor_C{i,r};
                     end
                else 
                    if s==1|3|4|5        
                        Result_nCV{1,1}.pred{i,s}{r,1}=[0;[ones(size(test_nor{i,r}{s},1),1) test_nor{i,r}{s}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_nCV{2,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.ann_nor,test_nor{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_nCV{3,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.gp_nor,test_nor{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);                    
                        Result_nCV{4,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.lr_nor,test_nor{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                    else
                        Result_nCV{1,1}.pred{i,s}{r,1}=[0;[ones(size(test_nor{i,r}{s},1),1) test_nor{i,r}{s}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_nCV{2,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.ann_pca,test_pca{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_nCV{3,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.gp_pca,test_pca{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_nCV{4,1}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.lr_pca,test_pca{i,r}{s})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                    end        
                end
                
            end
        end
    end


for n=1:4 % regression method    
        for i=1:2
            for s=1:6
                
             Result_nCV{n}.predcv{i,s}=cell2mat(Result_nCV{n}.pred{i,s});
             Result_nCV{n}.rmsecv{i,s}=sqrt(sum((Result_nCV{n}.predcv{i,s}-cell2mat(target_array{1,1})).^2)./height(cell2mat(target_array{i,1})));
             Result_nCV{n}.nrmsecv{i,s}=Result_nCV{n}.rmsecv{i,s}./range(cell2mat(target_array{1,1}),1);
             Result_nCV{n}.rsqcv{i,s}=1-sum((Result_nCV{n}.predcv{i,s}-cell2mat(target_array{1,1})).^2)./sum((cell2mat(target_array{1,1})-mean(cell2mat(target_array{1,1}))).^2);
                 
             end         
        end
    
end

    for n=1:4
             
                    for i=1:2
                            for s=1:6
                                predcv{n,1}{i,s}=Result_nCV{n}.predcv{i,s};
                                rmsecv{n,1}(i,s)=Result_nCV{n}.rmsecv{i,s};
                                nrmsecv{n,1}(i,s)=Result_nCV{n}.nrmsecv{i,s}*100;
                                rsqcv{n,1}(i,s)=Result_nCV{n}.rsqcv{i,s};
                            end
                    end
            
     end


end