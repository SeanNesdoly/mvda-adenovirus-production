function fit=MVDAfit(train_nor, target_nor, train_pca,cv,NumBatch)
for i=1:2 %w/0 inital subsctraction
    i
    for r=1:NumBatch % leave out batch
        r
        for s=1:6 %sensors
            s
           
%                 
% %normalized data
                fit{i,r}{s}.pls_nor_n=size(train_nor{i,r}{s},2);
                if fit{i,r}{s}.pls_nor_n>20
                    fit{i,r}{s}.pls_nor_n=20;
                end

                [fit{i,r}{s}.pls_nor.XL,fit{i,r}{s}.pls_nor.YL,fit{i,r}{s}.pls_nor.XS,fit{i,r}{s}.pls_nor.YS,fit{i,r}{s}.pls_nor.BETA,fit{i,r}{s}.pls_nor.PCTVAR,fit{i,r}{s}.pls_nor.MSE,fit{i,r}{s}.pls_nor.stats] = plsregress(train_nor{i,r}{s},target_nor{i,r},fit{i,r}{s}.pls_nor_n,'cv',cv{i,r});
                fit{i,r}{s}.pls_nor_n=find(fit{i,r}{s}.pls_nor.MSE(2,:)==min(fit{i,r}{s}.pls_nor.MSE(2,:)))-1;
                fit{i,r}{s}.pls_nor_n=fit{i,r}{s}.pls_nor_n(1)
                if fit{i,r}{s}.pls_nor_n<2
                    fit{i,r}{s}.pls_nor_n=2;
                end
                [fit{i,r}{s}.pls_nor.XL,fit{i,r}{s}.pls_nor.YL,fit{i,r}{s}.pls_nor.XS,fit{i,r}{s}.pls_nor.YS,fit{i,r}{s}.pls_nor.BETA,fit{i,r}{s}.pls_nor.PCTVAR,fit{i,r}{s}.pls_nor.MSE,fit{i,r}{s}.pls_nor.stats] = plsregress(train_nor{i,r}{s},target_nor{i,r},fit{i,r}{s}.pls_nor_n,'cv',cv{i,r});      
                %cv
                                
                
                %linear regression
                [fit{i,r}{s}.lr_nor,fit{i,r}{s}.lr_norinfo,fit{i,r}{s}.lr_norHPR]=fitrlinear(train_nor{i,r}{s},target_nor{i,r},'OptimizeHyperparameters','all','HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',100,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvlr_nor=fitrlinear(train_nor{i,r}{s},target_nor{i,r},'CVPartition',cv{i,r},'Lambda',fit{i,r}{s}.lr_norHPR.bestPoint.Lambda,'Learner',string(fit{i,r}{s}.lr_norHPR.bestPoint.Learner),'Regularization',string(fit{i,r}{s}.lr_norHPR.bestPoint.Regularization));
                               
                

                %gaussian procession 
                fit{i,r}{s}.gp_nor_params=hyperparameters("fitrgp",train_nor{i,r}{s},target_nor{i,r});
                fit{i,r}{s}.gp_nor_params(1).Optimize=false;
                fit{i,r}{s}.gp_nor_params(2).Optimize=true;
                fit{i,r}{s}.gp_nor_params(3).Optimize=true;
                fit{i,r}{s}.gp_nor_params(4).Optimize=true;
                fit{i,r}{s}.gp_nor_params(5).Optimize=false;
                fit{i,r}{s}.gp_nor=fitrgp(train_nor{i,r}{s},target_nor{i,r},'OptimizeHyperparameters',fit{i,r}{s}.gp_nor_params,'HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',100,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvgp_nor=crossval(fit{i,r}{s}.gp_nor,'CVPartition',cv{i,r});
                               
                

                %ANN
                fit{i,r}{s}.ann_nor_params=hyperparameters("fitrnet",train_nor{i,r}{s},target_nor{i,r});
                fit{i,r}{s}.ann_nor_params(1).Range=[1 2];
                fit{i,r}{s}.ann_nor_params(3).Optimize=false;
                fit{i,r}{s}.ann_nor_params(7).Range=[1 20];               
                fit{i,r}{s}.ann_nor_params(7).Transform='none';
                fit{i,r}{s}.ann_nor_params(8).Range=[1 20];
                fit{i,r}{s}.ann_nor_params(8).Transform='none';                
                fit{i,r}{s}.ann_nor_params(9).Optimize=false;

                fit{i,r}{s}.ann_nor=fitrnet(train_nor{i,r}{s},target_nor{i,r},'OptimizeHyperparameters',fit{i,r}{s}.ann_nor_params,'HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',300,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvann_nor=crossval(fit{i,r}{s}.ann_nor,'CVPartition',cv{i,r});
                
%PCA
                %Ir
                [fit{i,r}{s}.lr_pca,fit{i,r}{s}.lr_pcainfo,fit{i,r}{s}.lr_pcaHPR]=fitrlinear(train_pca{i,r}{s},target_nor{i,r},'OptimizeHyperparameters','all','HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',100,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvlr_pca=fitrlinear(train_pca{i,r}{s},target_nor{i,r},'CVPartition',cv{i,r},'Lambda',fit{i,r}{s}.lr_pcaHPR.bestPoint.Lambda,'Learner',string(fit{i,r}{s}.lr_pcaHPR.bestPoint.Learner),'Regularization',string(fit{i,r}{s}.lr_pcaHPR.bestPoint.Regularization));
                                
% 
%                 % gaussian procession
                fit{i,r}{s}.gp_pca_params=hyperparameters("fitrgp",train_pca{i,r}{s},target_nor{i,r}); 
                fit{i,r}{s}.gp_pca_params(1).Optimize=false;
                fit{i,r}{s}.gp_pca_params(2).Optimize=true;
                fit{i,r}{s}.gp_pca_params(3).Optimize=true;
                fit{i,r}{s}.gp_pca_params(4).Optimize=true;
                fit{i,r}{s}.gp_pca_params(5).Optimize=false;
                fit{i,r}{s}.gp_pca=fitrgp(train_pca{i,r}{s},target_nor{i,r},'OptimizeHyperparameters',fit{i,r}{s}.gp_pca_params,'HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',100,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvgp_pca=crossval(fit{i,r}{s}.gp_pca,'CVPartition',cv{i,r});
                                
% 
%                 %ANN
                fit{i,r}{s}.ann_pca_params=hyperparameters("fitrnet",train_pca{i,r}{s},target_nor{i,r});
                fit{i,r}{s}.ann_pca_params(1).Range=[1 2];
                fit{i,r}{s}.ann_pca_params(7).Range=[1 20];               
                fit{i,r}{s}.ann_pca_params(7).Transform='none';
                fit{i,r}{s}.ann_pca_params(8).Range=[1 20];
                fit{i,r}{s}.ann_pca_params(8).Transform='none';                
                fit{i,r}{s}.ann_pca_params(9).Optimize=false;

                fit{i,r}{s}.ann_pca=fitrnet(train_pca{i,r}{s},target_nor{i,r},'OptimizeHyperparameters',fit{i,r}{s}.ann_pca_params,'HyperparameterOptimizationOptions',struct('CVPartition',cv{i,r},'AcquisitionFunctionName','expected-improvement-plus','MaxObjectiveEvaluations',300,'Verbose',0,'ShowPlots',0,'UseParallel',true));
                
                %fit{i,r}{s}.cvann_pca=crossval(fit{i,r}{s}.ann_pca,'CVPartition',cv{i,r});
                
                                
           end 
           
        end              
        
    end
end