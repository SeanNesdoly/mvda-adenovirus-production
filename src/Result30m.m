function Result_30m=Result30m(fit,Interval30_nor,Interval30_pca,target_nor_C,target_array,NumBatch)
for i=1:2
    i
    for s=1:6
        s
        for r=1:NumBatch
            r
           
                if i == 1
                    if s==1|3|4|5   
                        Result_30m{1}.pred{i,s}{r,1}=[ones(size(Interval30_nor{i,1}{s,1}{r,1},1),1) Interval30_nor{i,1}{s,1}{r,1}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r};
                        Result_30m{2}.pred{i,s}{r,1}=predict(fit{i,r}{s}.ann_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r};
                        Result_30m{3}.pred{i,s}{r,1}=predict(fit{i,r}{s}.gp_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r};                    
                        Result_30m{4}.pred{i,s}{r,1}=predict(fit{i,r}{s}.lr_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r};
                    else   
                        Result_30m{1}.pred{i,s}{r,1}=[ones(size(Interval30_nor{i,1}{s,1}{r,1},1),1) Interval30_nor{i,1}{s,1}{r,1}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r};
                        Result_30m{2}.pred{i,s}{r,1}=predict(fit{i,r}{s}.ann_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r};
                        Result_30m{3}.pred{i,s}{r,1}=predict(fit{i,r}{s}.gp_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r};
                        Result_30m{4}.pred{i,s}{r,1}=predict(fit{i,r}{s}.lr_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r};
                    end
                else 
                    if s==1|3|4|5
                        Result_30m{1}.pred{i,s}{r,1}=[0;[ones(size(Interval30_nor{i,1}{s,1}{r,1},1),1) Interval30_nor{i,1}{s,1}{r,1}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{2}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.ann_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{3}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.gp_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{4}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.lr_nor,Interval30_nor{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                    else
                        Result_30m{1}.pred{i,s}{r,1}=[0;[ones(size(Interval30_nor{i,1}{s,1}{r,1},1),1) Interval30_nor{i,1}{s,1}{r,1}]*fit{i,r}{s}.pls_nor.BETA+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{2}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.ann_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{3}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.gp_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
                        Result_30m{4}.pred{i,s}{r,1}=[0;predict(fit{i,r}{s}.lr_pca,Interval30_pca{i,1}{s,1}{r,1})+target_nor_C{i,r}]+target_array{1,1}{r,1}(1);
            
                    end 
                
                
            end
        end
    end
end
end