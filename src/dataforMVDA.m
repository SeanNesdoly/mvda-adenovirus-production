load('Lucullus.mat');
load('MWF.mat');
%%
for r=1:4
data.(BatchName{r}).FLA_SamplePoint=MWF.(BatchName{r}).P_SamplePoint';
data.(BatchName{r}).FLA_30mInterval=MWF.(BatchName{r}).P_30mInterval';
end

for r=1:4
data.(BatchName{r}).FLP_SamplePoint=MWF.(BatchName{r}).WP_SamplePoint';
data.(BatchName{r}).FLP_30mInterval=MWF.(BatchName{r}).WP_30mInterval';
end
for r=1:4
data.(BatchName{r}).DE_SamplePoint=[Lucullus.(BatchName{r}).cap_SamplePoint' Lucullus.(BatchName{r}).con_SamplePoint'];
data.(BatchName{r}).DE_30mInterval=[Lucullus.(BatchName{r}).cap_30mInterval' Lucullus.(BatchName{r}).con_30mInterval'];

%rezero Con
data.(BatchName{r}).DE_SamplePoint(:,2)=data.(BatchName{r}).DE_SamplePoint(:,2)-data.(BatchName{r}).DE_SamplePoint(1,2);
data.(BatchName{r}).DE_30mInterval(:,2)=data.(BatchName{r}).DE_30mInterval(:,2)-data.(BatchName{r}).DE_30mInterval(1,2);
end
for r=1:4
data.(BatchName{r}).PV_SamplePoint=[Lucullus.(BatchName{r}).OURdo_SamplePoint' Lucullus.(BatchName{r}).OURvol_SamplePoint'...
    Lucullus.(BatchName{r}).dm_co2_SamplePoint' Lucullus.(BatchName{r}).dm_base_SamplePoint' Lucullus.(BatchName{r}).ph_SamplePoint'];
data.(BatchName{r}).PV_30mInterval=[Lucullus.(BatchName{r}).OURdo_30mInterval' Lucullus.(BatchName{r}).OURvol_30mInterval'...
    Lucullus.(BatchName{r}).dm_co2_30mInterval' Lucullus.(BatchName{r}).dm_base_30mInterval' Lucullus.(BatchName{r}).ph_30mInterval'];
%The OUR measurement start from ~2h post innoculation because it takes time
%for DO decreasing from 100% to 40% and OUR vol become stable at around 4h,
%so for OUR measurement there is NAN in 30mInterval data, all 30minterval data before 4h were assumed as same as 4h; 
for i=1:8
data.(BatchName{r}).PV_30mInterval(i,1:2)=data.(BatchName{r}).PV_30mInterval(9,1:2);
end
end
%
% Adjust samplepoint data before 4h
data.CG.PV_SamplePoint(1,2)=data.CG.PV_30mInterval(9,2);
%Rezero Base, CO2, and delta pH
data.(BatchName{r}).PV_30mInterval(:,3:5)=data.(BatchName{r}).PV_30mInterval(:,3:5)-data.(BatchName{r}).PV_30mInterval(1,3:5);
data.(BatchName{r}).PV_SamplePoint(:,3:5)=data.(BatchName{r}).PV_SamplePoint(:,3:5)-data.(BatchName{r}).PV_SamplePoint(1,3:5);
% For AdV03, Since pH were recalibrated to 7.4 at around 1h and back to
% 7.2 at 3h, so the pH and cumulative base and CO2 before 3h was assumed as
% same as the value at 3h
for i=1:6
data.AdV03.PV_30mInterval(i,3:5)=data.AdV03.PV_30mInterval(7,3:5);
end
data.AdV03.PV_SamplePoint(1,3:5)=data.AdV03.PV_30mInterval(7,3:5);
% to remove effect of pH due pH change due to innoculation, set first
% timepoint that pH is within the control range as reference
for i=1:3
data.AdV01.PV_30mInterval(i,3:5)=data.AdV01.PV_30mInterval(4,3:5);
end
data.AdV01.PV_SamplePoint(1,3:5)=data.AdV01.PV_30mInterval(4,3:5);
for i=1:2
data.CG.PV_30mInterval(i,3:5)=data.CG.PV_30mInterval(3,3:5);
end
data.CG.PV_SamplePoint(1,3:5)=data.CG.PV_30mInterval(3,3:5);
%Rezero Base, CO2, and delta pH
for r=1:4
data.(BatchName{r}).PV_30mInterval(:,3:5)=data.(BatchName{r}).PV_30mInterval(:,3:5)-data.(BatchName{r}).PV_30mInterval(1,3:5);
data.(BatchName{r}).PV_SamplePoint(:,3:5)=data.(BatchName{r}).PV_SamplePoint(:,3:5)-data.(BatchName{r}).PV_SamplePoint(1,3:5);
end
for r=1:4
data.(BatchName{r}).FD_SamplePoint=[Lucullus.(BatchName{r}).GLUCFD Lucullus.(BatchName{r}).GLUNFD]
data.(BatchName{r}).FD_30mInterval=[Lucullus.(BatchName{r}).GLUCFD_30mInterval Lucullus.(BatchName{r}).GLUNFD_30mInterval]
end
for r=1:4
data.(BatchName{r}).MSA_SamplePoint=[data.(BatchName{r}).FLA_SamplePoint data.(BatchName{r}).DE_SamplePoint data.(BatchName{r}).PV_SamplePoint];
data.(BatchName{r}).MSA_30mInterval=[data.(BatchName{r}).FLA_30mInterval data.(BatchName{r}).DE_30mInterval data.(BatchName{r}).PV_30mInterval];

data.(BatchName{r}).MSP_SamplePoint=[data.(BatchName{r}).FLP_SamplePoint data.(BatchName{r}).DE_SamplePoint data.(BatchName{r}).PV_SamplePoint];
data.(BatchName{r}).MSP_30mInterval=[data.(BatchName{r}).FLP_30mInterval data.(BatchName{r}).DE_30mInterval data.(BatchName{r}).PV_30mInterval];



data.(BatchName{r}).time_SamplePoint=Lucullus.(BatchName{r}).time_SamplePoint;
data.(BatchName{r}).time_30mInterval=Lucullus.(BatchName{r}).time_30mInterval;
data.(BatchName{r}).target=[Lucullus.(BatchName{r}).VCDM(:,2) Lucullus.(BatchName{r}).VCDM(:,2)./Lucullus.(BatchName{r}).VIAM(:,2).*100 Lucullus.(BatchName{r}).VIAM(:,2)...
    Lucullus.(BatchName{r}).GLUC(:,2) Lucullus.(BatchName{r}).GLUT(:,2) Lucullus.(BatchName{r}).GLUN(:,2) Lucullus.(BatchName{r}).AMM(:,2) Lucullus.(BatchName{r}).LAC(:,2)]
end
save('data.mat','data')
%%

    figure
    for i= 1:12
        subplot(3,4,i)
        hold on
        for r=1:4
            
            plot(data.(BatchName{r}).time_SamplePoint,data.(BatchName{r}).MSA_SamplePoint(:,i))
        end
        hold off
        legend(BatchName)
    end