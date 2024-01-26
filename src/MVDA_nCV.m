clc; clear all;
load('data.mat')
%% data no initial substarction
TargetName=["VCD","TCD","VIA","GLUC","GLUT","GLUN","AMM","LAC"]
BatchName=["CG" "AdV01" "AdV02" "AdV03"]
SensorName=["FLA","FLP","DE","PV","MSA","MSP"];
VarName={'P1','P2','P3','P4','P5','Cap','Con','ddo','ddm','co2','base','pH','GLUCfd','GLUNfd'}
NumBatch=4 % 3 batch(excluding CG) or 4 batch in nCV

for t=1:8 % changing t value for target variable
predcv={};
rmsecv={};
nrmsecv={};
rsqcv={};
Result_SamplePoint={}
Result_30mInterval={}
fit={};

 Var_nis.FLA={data.CG.FLA_SamplePoint;data.AdV01.FLA_SamplePoint;data.AdV02.FLA_SamplePoint;data.AdV03.FLA_SamplePoint};
 Var_nis.FLP={data.CG.FLP_SamplePoint;data.AdV01.FLP_SamplePoint;data.AdV02.FLP_SamplePoint;data.AdV03.FLP_SamplePoint};
 Var_nis.DE={data.CG.DE_SamplePoint;data.AdV01.DE_SamplePoint;data.AdV02.DE_SamplePoint;data.AdV03.DE_SamplePoint};
 Var_nis.PV={data.CG.PV_SamplePoint;data.AdV01.PV_SamplePoint;data.AdV02.PV_SamplePoint;data.AdV03.PV_SamplePoint};
 Var_nis.MSA={data.CG.MSA_SamplePoint;data.AdV01.MSA_SamplePoint;data.AdV02.MSA_SamplePoint;data.AdV03.MSA_SamplePoint};
 Var_nis.MSP={data.CG.MSP_SamplePoint;data.AdV01.MSP_SamplePoint;data.AdV02.MSP_SamplePoint;data.AdV03.MSP_SamplePoint};

 Interval30_nis.FLA={data.CG.FLA_30mInterval;data.AdV01.FLA_30mInterval;data.AdV02.FLA_30mInterval;data.AdV03.FLA_30mInterval};
 Interval30_nis.FLP={data.CG.FLP_30mInterval;data.AdV01.FLP_30mInterval;data.AdV02.FLP_30mInterval;data.AdV03.FLP_30mInterval};
 Interval30_nis.DE={data.CG.DE_30mInterval;data.AdV01.DE_30mInterval;data.AdV02.DE_30mInterval;data.AdV03.DE_30mInterval};
 Interval30_nis.PV={data.CG.PV_30mInterval;data.AdV01.PV_30mInterval;data.AdV02.PV_30mInterval;data.AdV03.PV_30mInterval};
 Interval30_nis.MSA={data.CG.MSA_30mInterval;data.AdV01.MSA_30mInterval;data.AdV02.MSA_30mInterval;data.AdV03.MSA_30mInterval};
 Interval30_nis.MSP={data.CG.MSP_30mInterval;data.AdV01.MSP_30mInterval;data.AdV02.MSP_30mInterval;data.AdV03.MSP_30mInterval};

 if strcmp('GLUC',TargetName(t)) %add fed to GLUC prediction group
        for r=1:NumBatch
        Var_nis.PV{r}=[Var_nis.PV{r} data.(BatchName{r}).FD_SamplePoint(:,1)];
        Var_nis.MSA{r}=[Var_nis.MSA{r} data.(BatchName{r}).FD_SamplePoint(:,1)];
        Var_nis.MSP{r}=[Var_nis.MSA{r} data.(BatchName{r}).FD_SamplePoint(:,1)];
 
        
        Interval30_nis.PV{r}=[Interval30_nis.PV{r} data.(BatchName{r}).FD_30mInterval(:,1)];
        Interval30_nis.MSA{r}=[Interval30_nis.MSA{r} data.(BatchName{r}).FD_30mInterval(:,1)];
        Interval30_nis.MSP{r}=[Interval30_nis.MSP{r} data.(BatchName{r}).FD_30mInterval(:,1)];;
        end
 end
if strcmp('GLUN',TargetName(t)) 
        for r=1:NumBatch
        Var_nis.PV{r}=[Var_nis.PV{r} data.(BatchName{r}).FD_SamplePoint(:,2)];
        Var_nis.MSA{r}=[Var_nis.MSA{r} data.(BatchName{r}).FD_SamplePoint(:,2)];
        Var_nis.MSP{r}=[Var_nis.MSP{r} data.(BatchName{r}).FD_SamplePoint(:,2)];
 
        
        Interval30_nis.PV{r}=[Interval30_nis.PV{r} data.(BatchName{r}).FD_30mInterval(:,2)];
        Interval30_nis.MSA{r}=[Interval30_nis.MSA{r} data.(BatchName{r}).FD_30mInterval(:,2)];
        Interval30_nis.MSP{r}=[Interval30_nis.MSP{r} data.(BatchName{r}).FD_30mInterval(:,2)];
        end
 end


% data WITH initial substarction
for r=1:NumBatch
Var_is.FLA{r,1}=Var_nis.FLA{r}(2:end,:)-Var_nis.FLA{r}(1,:);
Var_is.FLP{r,1}=Var_nis.FLP{r}(2:end,:)-Var_nis.FLP{r}(1,:);
Var_is.DE{r,1}=Var_nis.DE{r}(2:end,:)-Var_nis.DE{r}(1,:);
Var_is.PV{r,1}=Var_nis.PV{r}(2:end,:)-Var_nis.PV{r}(1,:);
Var_is.MSA{r,1}=Var_nis.MSA{r}(2:end,:)-Var_nis.MSA{r}(1,:);
Var_is.MSP{r,1}=Var_nis.MSP{r}(2:end,:)-Var_nis.MSP{r}(1,:);

Interval30_is.FLA{r,1}=Interval30_nis.FLA{r}(2:end,:)-Interval30_nis.FLA{r}(1,:);
Interval30_is.FLP{r,1}=Interval30_nis.FLP{r}(2:end,:)-Interval30_nis.FLP{r}(1,:);
Interval30_is.DE{r,1}=Interval30_nis.DE{r}(2:end,:)-Interval30_nis.DE{r}(1,:);
Interval30_is.PV{r,1}=Interval30_nis.PV{r}(2:end,:)-Interval30_nis.PV{r}(1,:);
Interval30_is.MSA{r,1}=Interval30_nis.MSA{r}(2:end,:)-Interval30_nis.MSA{r}(1,:);
Interval30_is.MSP{r,1}=Interval30_nis.MSP{r}(2:end,:)-Interval30_nis.MSP{r}(1,:);
end
%  NumBatch==3 for CG exclued from nCV
if NumBatch==3
    for s=1:6
        Var_nis.(SensorName{s})=Var_nis.(SensorName{s})(2:end,:);
        Interval30_nis.(SensorName{s})= Interval30_nis.(SensorName{s})(2:end,:);
        Var_is.(SensorName{s})=Var_is.(SensorName{s})(2:end,:);
        Interval30_is.(SensorName{s})= Interval30_is.(SensorName{s})(2:end,:);  
    end
end
%

target_array{1,1}={data.CG.target(:,t);data.AdV01.target(:,t);data.AdV02.target(:,t);data.AdV03.target(:,t)};
%2 with initial substaction
target_array{2,1}={data.CG.target(2:end,t)-data.CG.target(1,t);data.AdV01.target(2:end,t)-data.AdV01.target(1,t);data.AdV02.target(2:end,t)-data.AdV02.target(1,t);data.AdV03.target(2:end,t)-data.AdV03.target(1,t)};



train_array{1,1}=struct2cell(Var_nis);
train_array{2,1}=struct2cell(Var_is);

%%
% Leave one batch out partition, and apply the same normolization and PCA
% on traning and testing group.
for i=1:2 %w/o inital substraction
    
    for r=1:NumBatch %leave one batch out for targets
        target_cell=[];
        target_cell=target_array{i,1};
        target_cell(r)=[];
        target{i,r}=cell2mat(target_cell);         
        [target_nor{i,r},target_nor_C{i,r},target_nor_S{i,r}]=normalize(target{i,r},'center');  %apply the same center rescale to training and testing group    
        test_target{i,r}=target_array{i,1}{r};
        test_target_nor{i,r}=normalize(test_target{i,r},'center',target_nor_C{i,r},'scale',target_nor_S{i,r});        
       
         %cv partition
        

        for s=1:6  % for 6 sensors, leave one batch out cv and apply the same normalization and PCA to training and testing group
            train_cell{i,r}{s}=train_array{i,1}{s};
            train_cell{i,r}{s}(r)=[];       
            train{i,r}{s}=cell2mat(train_cell{i,r}{s});        
            test{i,r}{s}=cell2mat(train_array{i,1}{s,1}(r)); 
            [train_nor{i,r}{s},train_nor_C{i,r}{s},train_nor_S{i,r}{s}]=normalize(train{i,r}{s},'zscore');
            test_nor{i,r}{s}=normalize(test{i,r}{s},'center',train_nor_C{i,r}{s},'scale',train_nor_S{i,r}{s});
            
            [PCA.Coeff{i,r}{s}, PCA.Scores{i,r}{s}, ~, ~, PCA.explained{i,r}{s}, PCA.Centers{i,r}{s}] = pca(train_nor{i,r}{s})
            PCA.n{i,r}{s}=find(cumsum(PCA.explained{i,r}{s})/sum(PCA.explained{i,r}{s}) >=0.95)
            if   isempty(PCA.n{i,r}{s}) == true
                PCA.n{i,r}{s}=length(train_nor{i,r}{s})
            end
            train_pca{i,r}{s}=PCA.Scores{i,r}{s}(:,1:PCA.n{i,r}{s})
            test_pca{i,r}{s}=(test_nor{i,r}{s}-PCA.Centers{i,r}{s})*PCA.Coeff{i,r}{s}(:,1:PCA.n{i,r}{s})
            
        rng('default');        
        cv{i,r}=cvpartition(height(target{i,r}),'LeaveOut'); %leaveoneout partition for inner loop
        end
    end
end


%% Treat the 30mInterval date the same way
Interval30_raw{1,1}=struct2cell(Interval30_nis);
Interval30_raw{2,1}=struct2cell(Interval30_is);


%%
for i=1:2
    for s=1:6
        for r=1:NumBatch            
                Interval30_nor{i,1}{s,1}{r,1}=normalize(Interval30_raw{i,1}{s,1}{r,1},'center',train_nor_C{i,r}{s},'scale',train_nor_S{i,r}{s});            
            
        end
    end
end

for i=1:2
    for s=1:6
        for r=1:NumBatch            
                Interval30_pca{i,1}{s,1}{r,1}=(Interval30_nor{i,1}{s,1}{r,1}-PCA.Centers{i,r}{s})*PCA.Coeff{i,r}{s}(:,1:PCA.n{i,r}{s})         
            
        end
    end
end
%%
% fit the model
fit.(TargetName{t})=MVDAfit(train_nor, target_nor, train_pca,cv,NumBatch);

% Apply the partition models to testing gourp to calculate performance
[predcv.(TargetName{t}),rmsecv.(TargetName{t}),nrmsecv.(TargetName{t}),rsqcv.(TargetName{t}),Result_SamplePoint.(TargetName{t})]=ResultnCV(fit.(TargetName{t}),target_array,test_nor, test_pca,target_nor_C,NumBatch);
% Apply the partition models to 30minterval data of testing gourp
Result_30mInterval.(TargetName{t})=Result30m(fit.(TargetName{t}),Interval30_nor,Interval30_pca,target_nor_C,target_array,NumBatch);


save(['fit' (TargetName{t})],'fit','-v7.3');
save(['Result' (TargetName{t})],'Result_SamplePoint','Result_30mInterval','predcv','rsqcv','nrmsecv','rmsecv','-v7.3');
end