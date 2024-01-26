%% Load MWF data
clc; clear all;
load('Lucullus.mat');
MWF.AdV01={};
MWF.AdV02={};
MWF.AdV03={};
MWF.CG={};
BatchName=["CG" "AdV01" "AdV02" "AdV03"]
for r=1:4
MWF.(BatchName{r}).time_SamplePoint=Lucullus.(BatchName{r}).time_SamplePoint;
MWF.(BatchName{r}).time_30mInterval=Lucullus.(BatchName{r}).time_30mInterval;
MWF.(BatchName{r}).toi=Lucullus.(BatchName{r}).toi;
end
% 'Location' is the path to Data file
Location="C:\Users\27010\OneDrive - McGill University\PhD-research\Publication\Monitoring the adenovirus production in HEK293 cells with multiple sensors"
MWF.AdV01.filename=ls(strcat(Location,'\Data\AdV01_MWF\*.dat'));
MWF.AdV02.filename=ls(strcat(Location,'\Data\AdV02_MWF\*.dat'));
MWF.AdV03.filename=ls(strcat(Location,'\Data\AdV03_MWF\*.dat'));
MWF.CG.filename=ls(strcat(Location,'\Data\CellGrowth_MWF\*.dat'));

delimiterIn=' ';
headerlinesIn=13;
%InnoTime is the number of first spectra after innoculation. This is by comparing the Timestamp with Lucullus data. Before InnoTime is spectra from medium. 
MWF.AdV01.InnoTime=15; 
MWF.AdV02.InnoTime=2;
MWF.AdV03.InnoTime=25;
MWF.CG.InnoTime=15;

% find intensity of pure medium.
%not all medium spetrum before innoculation were used as medium intensity
%due to signal fluctuation. 

 MWF.AdV01.medium=[1:3];
 MWF.AdV02.medium=1;
 MWF.AdV03.medium=[1:24];
 MWF.CG.medium=[10:13];

for i=1:length(MWF.AdV01.filename)
    MWF.AdV01.str=[strcat(Location,'\Data\AdV01_MWF\',MWF.AdV01.filename(i,:))];
    MWF.AdV01.data_cel{1,i}=importdata(MWF.AdV01.str,delimiterIn,headerlinesIn);    
end

for i=1:length(MWF.AdV02.filename)
    MWF.AdV02.str=[strcat(Location,'\Data\AdV02_MWF\',MWF.AdV02.filename(i,:))];
    MWF.AdV02.data_cel{1,i}=importdata(MWF.AdV02.str,delimiterIn,headerlinesIn);    
end

for i=1:length(MWF.AdV03.filename)
    MWF.AdV03.str=[strcat(Location,'\Data\AdV03_MWF\',MWF.AdV03.filename(i,:))];
    MWF.AdV03.data_cel{1,i}=importdata(MWF.AdV03.str,delimiterIn,headerlinesIn);    
end

for i=1:length(MWF.CG.filename)
    MWF.CG.str=[strcat(Location,'\Data\CellGrowth_MWF\',MWF.CG.filename(i,:))];
    MWF.CG.data_cel{1,i}=importdata(MWF.CG.str,delimiterIn,headerlinesIn);    
end

for r=1:4
MWF.(BatchName{r}).wl=MWF.(BatchName{r}).data_cel{1,1}.data(:,1); % wavelength
MWF.(BatchName{r}).sp365=MWF.(BatchName{r}).data_cel{1,1}.data(:,2);% spetra lamda_excitation=365nm
MWF.(BatchName{r}).sp410=MWF.(BatchName{r}).data_cel{1,1}.data(:,3);% spetra lamda_excitation=410nm

for j=2:length(MWF.(BatchName{r}).data_cel)
    MWF.(BatchName{r}).sp365=[MWF.(BatchName{r}).sp365 MWF.(BatchName{r}).data_cel{1,j}.data(:,2)];
    MWF.(BatchName{r}).sp410=[MWF.(BatchName{r}).sp410 MWF.(BatchName{r}).data_cel{1,j}.data(:,3)];
    
end
% Set time =0 at time of innoculation. 
MWF.(BatchName{r}).time=transpose([0:(length(MWF.(BatchName{r}).filename)-MWF.(BatchName{r}).InnoTime)]*5/60)-(MWF.(BatchName{r}).InnoTime-1)*5/60;
%The spectra were collected every  5mins but he lucullus data was recorded
%every 5s. More adujust can be done manuelly

clear MWF.(BatchName{1}).str MWF.(BatchName{1}).filename i headerlinesIn delimiterIn MWF.(BatchName{1}).data_cel
end
%%
for r=1:4
%baseline correction
MWF.(BatchName{r}).sp365Baseline=mean(MWF.(BatchName{r}).sp365(2900:3100));
MWF.(BatchName{r}).sp410Bbaseline=mean(MWF.(BatchName{r}).sp410(2900:3100));


MWF.(BatchName{r}).sp365=MWF.(BatchName{r}).sp365-MWF.(BatchName{r}).sp365Baseline;
MWF.(BatchName{r}).sp410=MWF.(BatchName{r}).sp410-MWF.(BatchName{r}).sp410Bbaseline;
% Due to high power setting, the P4 from 410nm was oversaturated (from 556-1733 in time series), the follwoing code recover the peak(#1020-1120 of wavelength ~ 410nm)
% based on the signal ratio at # of wavelength 1000 
if r==2
MWF.(BatchName{r}).sp410c=MWF.(BatchName{r}).sp410
MWF.(BatchName{r}).sp410_ratio_1000=MWF.(BatchName{r}).sp410(1020:1120,50:500)./MWF.(BatchName{r}).sp410(1000,50:500)
MWF.(BatchName{r}).sp410_ratio_1000rm=mean(transpose(filloutliers(MWF.(BatchName{r}).sp410_ratio_1000','linear','movmedian',[24 0],'ThresholdFactor',1)),2)
for i=556:1733
MWF.(BatchName{r}).sp410(1020:1120,i)=MWF.(BatchName{r}).sp410c(1000,i)*MWF.(BatchName{r}).sp410_ratio_1000rm
end
end


% apply s-g filter
[MWF.(BatchName{r}).b365,MWF.(BatchName{r}).g365]=sgolay(4,101);

[MWF.(BatchName{r}).b410,MWF.(BatchName{r}).g410]=sgolay(4,101);

MWF.(BatchName{r}).dwl=(MWF.(BatchName{r}).wl(end)-MWF.(BatchName{r}).wl(1))/(length(MWF.(BatchName{r}).wl)-1);

%
for i=1:length(MWF.(BatchName{r}).time)    
    MWF.(BatchName{r}).d365_0(:,i) = conv(MWF.(BatchName{r}).sp365(:,i), factorial(0)/(-MWF.(BatchName{r}).dwl)^0 * MWF.(BatchName{r}).g365(:,1), 'same');
    MWF.(BatchName{r}).d365_1(:,i) = conv(MWF.(BatchName{r}).sp365(:,i), factorial(1)/(-MWF.(BatchName{r}).dwl)^1 * MWF.(BatchName{r}).g365(:,2), 'same');
    MWF.(BatchName{r}).d365_2(:,i) = conv(MWF.(BatchName{r}).sp365(:,i), factorial(2)/(-MWF.(BatchName{r}).dwl)^2 * MWF.(BatchName{r}).g365(:,3), 'same');
    MWF.(BatchName{r}).d365_3(:,i) = conv(MWF.(BatchName{r}).sp365(:,i), factorial(3)/(-MWF.(BatchName{r}).dwl)^3 * MWF.(BatchName{r}).g365(:,4), 'same');
end


for i=1:length(MWF.(BatchName{r}).time)    
    MWF.(BatchName{r}).d410_0(:,i) = conv(MWF.(BatchName{r}).sp410(:,i), factorial(0)/(-MWF.(BatchName{r}).dwl)^0 * MWF.(BatchName{r}).g410(:,1), 'same');
    MWF.(BatchName{r}).d410_1(:,i) = conv(MWF.(BatchName{r}).sp410(:,i), factorial(1)/(-MWF.(BatchName{r}).dwl)^1 * MWF.(BatchName{r}).g410(:,2), 'same');
    MWF.(BatchName{r}).d410_2(:,i) = conv(MWF.(BatchName{r}).sp410(:,i), factorial(2)/(-MWF.(BatchName{r}).dwl)^2 * MWF.(BatchName{r}).g410(:,3), 'same');
    MWF.(BatchName{r}).d410_3(:,i) = conv(MWF.(BatchName{r}).sp410(:,i), factorial(3)/(-MWF.(BatchName{r}).dwl)^3 * MWF.(BatchName{r}).g410(:,4), 'same');
end






%Find Peak area intensity
MWF.(BatchName{r}).p1=[];
MWF.(BatchName{r}).p2=[];
MWF.(BatchName{r}).p3=[];
MWF.(BatchName{r}).p4=[];
MWF.(BatchName{r}).p5=[];



MWF.(BatchName{r}).p1=sum(MWF.(BatchName{r}).d365_0(find(MWF.(BatchName{r}).wl>355&MWF.(BatchName{r}).wl<410),:));
MWF.(BatchName{r}).p2=sum(MWF.(BatchName{r}).d365_0(find(MWF.(BatchName{r}).wl>425&MWF.(BatchName{r}).wl<465),:));
MWF.(BatchName{r}).p3=sum(MWF.(BatchName{r}).d365_0(find(MWF.(BatchName{r}).wl>475&MWF.(BatchName{r}).wl<650),:));
MWF.(BatchName{r}).p4=sum(MWF.(BatchName{r}).d410_0(find(MWF.(BatchName{r}).wl>370&MWF.(BatchName{r}).wl<450),:));
MWF.(BatchName{r}).p5=sum(MWF.(BatchName{r}).d410_0(find(MWF.(BatchName{r}).wl>485&MWF.(BatchName{r}).wl<650),:));
%remove outlier in time-series
MWF.(BatchName{r}).p1rm=MWF.(BatchName{r}).p1;
MWF.(BatchName{r}).p2rm=MWF.(BatchName{r}).p2;
MWF.(BatchName{r}).p3rm=MWF.(BatchName{r}).p3;
MWF.(BatchName{r}).p4rm=MWF.(BatchName{r}).p4;
MWF.(BatchName{r}).p5rm=MWF.(BatchName{r}).p5;

MWF.(BatchName{r}).p1rm(MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).p1(MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4);
MWF.(BatchName{r}).p2rm(MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).p2(MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4);
MWF.(BatchName{r}).p3rm(MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).p3(MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4);
MWF.(BatchName{r}).p4rm(MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).p4(MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4);
MWF.(BatchName{r}).p5rm(MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).p5(MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4);
% find intensity of pure medium.

MWF.(BatchName{r}).p1_m=mean(MWF.(BatchName{r}).p1(MWF.(BatchName{r}).medium)); 
MWF.(BatchName{r}).p2_m=mean(MWF.(BatchName{r}).p2(MWF.(BatchName{r}).medium));
MWF.(BatchName{r}).p3_m=mean(MWF.(BatchName{r}).p3(MWF.(BatchName{r}).medium));
MWF.(BatchName{r}).p4_m=mean(MWF.(BatchName{r}).p4(MWF.(BatchName{r}).medium));
MWF.(BatchName{r}).p5_m=mean(MWF.(BatchName{r}).p5(MWF.(BatchName{r}).medium));

% MWF calibrate to medium
% For P1 and P4, as back scattering, the medium background was removed.
MWF.(BatchName{r}).P=[MWF.(BatchName{r}).p1rm./MWF.(BatchName{r}).p3_m;MWF.(BatchName{r}).p2rm./MWF.(BatchName{r}).p3_m;MWF.(BatchName{r}).p3rm./MWF.(BatchName{r}).p3_m;MWF.(BatchName{r}).p4rm./MWF.(BatchName{r}).p5_m;MWF.(BatchName{r}).p5rm./MWF.(BatchName{r}).p5_m];
% MWF area itensity signal at sampling time
MWF.(BatchName{r}).P_SamplePoint=[]
for i=1:length(MWF.(BatchName{r}).time_SamplePoint)
    if MWF.(BatchName{r}).time_SamplePoint(i)<MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)
        MWF.(BatchName{r}).P_SamplePoint(:,i)=MWF.(BatchName{r}).P(:,MWF.(BatchName{r}).InnoTime)
    else if MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)<0.5% average range adjust  for infection and feed.
            MWF.(BatchName{r}).P_SamplePoint(:,i)=mean(MWF.(BatchName{r}).P(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime) & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2);
    else if MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).toi>0 && MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).toi<0.5
            MWF.(BatchName{r}).P_SamplePoint(:,i)=mean(MWF.(BatchName{r}).P(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).toi & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2);
    else if MWF.(BatchName{r}).time_SamplePoint(i)>MWF.(BatchName{r}).time(end)
            MWF.(BatchName{r}).P_SamplePoint(:,i)=mean(MWF.(BatchName{r}).P(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(end)-0.5))),2)
    else MWF.(BatchName{r}).P_SamplePoint(:,i)=mean(MWF.(BatchName{r}).P(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time_SamplePoint(i)-0.5 & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2);
    end
    end
    end
    end
end

%MWF area intensity signal at 30mins interval
MWF.(BatchName{r}).P_30mInterval=[]
MWF.(BatchName{r}).P_30mInterval(:,1)=mean(MWF.(BatchName{r}).P(:,find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)&MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_30mInterval(2))),2)
for i=2:length(MWF.(BatchName{r}).time_30mInterval)
    MWF.(BatchName{r}).P_30mInterval(:,i)=mean(MWF.(BatchName{r}).P(:,find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time_30mInterval(i-1)&MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_30mInterval(i))),2)
end


% MWF.(BatchName{r}).train=[MWF.(BatchName{r}).P_SamplePoint' MWF.(BatchName{r}).caP_SamplePoint' MWF.(BatchName{r}).con_off' MWF.(BatchName{r}).ddo_off' MWF.(BatchName{r}).ddm_o2_off' MWF.(BatchName{r}).dm_co2_off MWF.(BatchName{r}).dm_base_off MWF.(BatchName{r}).ph_off MWF.(BatchName{r}).stir_off MWF.(BatchName{r}).vol_off]
% MWF.(BatchName{r}).fit=[MWF.(BatchName{r}).P_30mInterval' MWF.(BatchName{r}).caP_30mInterval' MWF.(BatchName{r}).con_30minInterval' MWF.(BatchName{r}).ddo_30minInterval' MWF.(BatchName{r}).ddm_o2_30minInterval' MWF.(BatchName{r}).dm_co2_30minInterval' MWF.(BatchName{r}).dm_base_30minInterval' MWF.(BatchName{r}).ph_30minInterval' MWF.(BatchName{r}).stir_30minInterval MWF.(BatchName{r}).vol_30minInterval']
% calculate the peak intensity
MWF.(BatchName{r}).wp365=MWF.(BatchName{r}).sp365([788:25:2557],:)% 25 * wavelength interval =15nm
MWF.(BatchName{r}).wprm365=MWF.(BatchName{r}).wp365;

MWF.(BatchName{r}).wp410=MWF.(BatchName{r}).sp410([926:25:2557],:)
MWF.(BatchName{r}).wprm410=MWF.(BatchName{r}).wp410;
%remove outlier
for i=1:height(MWF.(BatchName{r}).wp365);
MWF.(BatchName{r}).wprm365(i,MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).wp365(i,MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4)
end

for i=1:height(MWF.(BatchName{r}).wp410);
MWF.(BatchName{r}).wprm410(i,MWF.(BatchName{r}).InnoTime:end)=filloutliers(MWF.(BatchName{r}).wp410(i,MWF.(BatchName{r}).InnoTime:end),'linear','movmedian',[24 0],'ThresholdFactor',4)
end
% calibrate to medium
MWF.(BatchName{r}).wprm365_m=mean(MWF.(BatchName{r}).wprm365(:,MWF.(BatchName{r}).medium),2);
MWF.(BatchName{r}).wprm365=MWF.(BatchName{r}).wprm365./MWF.(BatchName{r}).wprm365_m(35); % 35 is the number wavelength at 525nm


MWF.(BatchName{r}).wprm410_m=mean(MWF.(BatchName{r}).wprm410(:,MWF.(BatchName{r}).medium),2);
MWF.(BatchName{r}).wprm410=MWF.(BatchName{r}).wprm410./MWF.(BatchName{r}).wprm410_m(30); % 35 is the number wavelength at 525nm

MWF.(BatchName{r}).WP=[MWF.(BatchName{r}).wprm365;MWF.(BatchName{r}).wprm410]
% MWF peak itensity signal at sampling time
MWF.(BatchName{r}).WP_SamplePoint=[]
for i=1:length(MWF.(BatchName{r}).time_SamplePoint)
    if MWF.(BatchName{r}).time_SamplePoint(i)<MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)
        MWF.(BatchName{r}).WP_SamplePoint(:,i)=MWF.(BatchName{r}).WP(:,MWF.(BatchName{r}).InnoTime)
    else if MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)<0.5 % average range adjust  for infection and feed.
            MWF.(BatchName{r}).WP_SamplePoint(:,i)=mean(MWF.(BatchName{r}).WP(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime) & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2)
    else if MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).toi>0 && MWF.(BatchName{r}).time_SamplePoint(i)-MWF.(BatchName{r}).toi<0.5
            MWF.(BatchName{r}).WP_SamplePoint(:,i)=mean(MWF.(BatchName{r}).WP(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).toi & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2)
    else if MWF.(BatchName{r}).time_SamplePoint(i)>MWF.(BatchName{r}).time(end)
            MWF.(BatchName{r}).WP_SamplePoint(:,i)=mean(MWF.(BatchName{r}).WP(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(end)-0.5))),2)
    else MWF.(BatchName{r}).WP_SamplePoint(:,i)=mean(MWF.(BatchName{r}).WP(:,(find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time_SamplePoint(i)-0.5 & MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_SamplePoint(i)))),2)
    end   
    end
    end
    end
end
%MWF area intensity signal at 30mins interval
MWF.(BatchName{r}).WP_30mInterval=[]
MWF.(BatchName{r}).WP_30mInterval(:,1)=mean(MWF.(BatchName{r}).WP(:,find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time(MWF.(BatchName{r}).InnoTime)&MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_30mInterval(2))),2)
for i=2:length(MWF.(BatchName{r}).time_30mInterval)
    MWF.(BatchName{r}).WP_30mInterval(:,i)=mean(MWF.(BatchName{r}).WP(:,find(MWF.(BatchName{r}).time>MWF.(BatchName{r}).time_30mInterval(i-1)&MWF.(BatchName{r}).time<MWF.(BatchName{r}).time_30mInterval(i))),2)
end

end
save('MWF.mat', 'MWF','-v7.3')
%%
