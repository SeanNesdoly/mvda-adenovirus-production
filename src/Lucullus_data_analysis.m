clc; clear all;
BatchName=["CG" "AdV01" "AdV02" "AdV03"]
Lucullus.AdV01={};
Lucullus.AdV02={};
Lucullus.AdV03={};
Lucullus.CG={};


% 'Location' is the path to Data file
Location="C:\Users\27010\OneDrive - McGill University\PhD-research\Publication\Monitoring the adenovirus production in HEK293 cells with multiple sensors"
Lucullus.AdV01.filename=strcat(Location,'\Data\AdV01_Lucullus&Dielectric.xlsx');
Lucullus.AdV02.filename=strcat(Location,'\Data\AdV02_Lucullus&Dielectric.xlsx');
Lucullus.AdV03.filename=strcat(Location,'\Data\AdV03_Lucullus&Dielectric.xlsx');
Lucullus.CG.filename=strcat(Location,'\Data\CellGrowth_Lucullus&Dielectric.xlsx');
%Initial datapoing after innoculation, the end time of Innoculation is defined by
%capacitance increase.
Lucullus.AdV01.LucIni=31;
Lucullus.AdV02.LucIni=26;
Lucullus.AdV03.LucIni=532;
Lucullus.CG.LucIni=19;

Lucullus.AdV01.CapIni=18;
Lucullus.AdV02.CapIni=3;
Lucullus.AdV03.CapIni=121;
Lucullus.CG.CapIni=152;

Lucullus.AdV01.Cap_m=[1:17];
Lucullus.AdV02.Cap_m=1;
Lucullus.AdV03.Cap_m=[1:116];
Lucullus.CG.Cap_m=[1:143];

for r=1:4
r
[num,var,raw]=xlsread(Lucullus.(BatchName{r}).filename,'Lucullus Data');
Lucullus.(BatchName{r}).LucRaw=array2table(num(1:end,:),'VariableNames',var(1,:));
clear num var raw;

[num,var,raw]=xlsread(Lucullus.(BatchName{r}).filename,'Capacitance');
Lucullus.(BatchName{r}).CapRaw=array2table(num(1:end,1:3),'VariableNames',var(1,[2:4]));
clear num var raw str;
end
%% load data
for r=2:4
%capcacitance time 1min to h interval
Lucullus.(BatchName{r}).time1m=[1:1:height(Lucullus.(BatchName{r}).CapRaw)]/60-Lucullus.(BatchName{r}).CapIni/60;
Lucullus.(BatchName{r}).raw_cap=Lucullus.(BatchName{r}).CapRaw.Capacitance;
Lucullus.(BatchName{r}).cap_m=mean(Lucullus.(BatchName{r}).raw_cap(1:(Lucullus.(BatchName{r}).Cap_m)));
Lucullus.(BatchName{r}).cap=Lucullus.(BatchName{r}).raw_cap-Lucullus.(BatchName{r}).cap_m;
Lucullus.(BatchName{r}).con=Lucullus.(BatchName{r}).CapRaw.Conductivity;

Lucullus.(BatchName{r}).toi=Lucullus.(BatchName{r}).LucRaw.Time(find(Lucullus.(BatchName{r}).LucRaw.A_Inf==1))-Lucullus.(BatchName{r}).LucRaw.Time(Lucullus.(BatchName{r}).LucIni);% time of infection
Lucullus.(BatchName{r}).time5s=Lucullus.(BatchName{r}).LucRaw.Time-Lucullus.(BatchName{r}).LucRaw.Time(Lucullus.(BatchName{r}).LucIni);% time in a 5s interval
Lucullus.(BatchName{r}).m_do=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.m_do];
Lucullus.(BatchName{r}).dm_o2=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.dm_o2];
Lucullus.(BatchName{r}).m_co2=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.m_co2];
Lucullus.(BatchName{r}).dm_co2=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.dm_co2];
Lucullus.(BatchName{r}).dm_base=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.dm_spump1];
Lucullus.(BatchName{r}).ph=[Lucullus.(BatchName{r}).time5s,Lucullus.(BatchName{r}).LucRaw.m_ph];

Lucullus.(BatchName{r}).time_SamplePoint=Lucullus.(BatchName{r}).time5s(find(Lucullus.(BatchName{r}).LucRaw.A_SAMPLE==1));

Lucullus.(BatchName{r}).VCD=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VDENS)),Lucullus.(BatchName{r}).LucRaw.M_VDENS(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VDENS))];
%VCDM is VCD result that has been corrected based on pictures from cell
%counter. This is need especially for samples after infection because of
%cell agragation 
Lucullus.(BatchName{r}).VCDM=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VDENS_MICROSCOPE)),Lucullus.(BatchName{r}).LucRaw.M_VDENS_MICROSCOPE(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VDENS_MICROSCOPE))];
Lucullus.(BatchName{r}).TCD=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_TDENS)),Lucullus.(BatchName{r}).LucRaw.M_TDENS(~isnan(Lucullus.(BatchName{r}).LucRaw.M_TDENS))];
Lucullus.(BatchName{r}).VIA=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VIAB)),Lucullus.(BatchName{r}).LucRaw.M_VIAB(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VIAB))];
Lucullus.(BatchName{r}).VIAM=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VIAB_MICROSCOPE)),Lucullus.(BatchName{r}).LucRaw.M_VIAB_MICROSCOPE(~isnan(Lucullus.(BatchName{r}).LucRaw.M_VIAB_MICROSCOPE))];
Lucullus.(BatchName{r}).AMM=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_AMM)),Lucullus.(BatchName{r}).LucRaw.M_AMM(~isnan(Lucullus.(BatchName{r}).LucRaw.M_AMM))];
Lucullus.(BatchName{r}).GLUT=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUT)),Lucullus.(BatchName{r}).LucRaw.M_GLUT(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUT))];
Lucullus.(BatchName{r}).GLUN=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUN)),Lucullus.(BatchName{r}).LucRaw.M_GLUN(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUN))];
Lucullus.(BatchName{r}).GLUC=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUC)),Lucullus.(BatchName{r}).LucRaw.M_GLUC(~isnan(Lucullus.(BatchName{r}).LucRaw.M_GLUC))];
Lucullus.(BatchName{r}).LAC=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.M_LAC)),Lucullus.(BatchName{r}).LucRaw.M_LAC(~isnan(Lucullus.(BatchName{r}).LucRaw.M_LAC))];

Lucullus.(BatchName{r}).titre=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.VT_TCID)),Lucullus.(BatchName{r}).LucRaw.VT_TCID(~isnan(Lucullus.(BatchName{r}).LucRaw.VT_TCID))];
Lucullus.(BatchName{r}).fed=[Lucullus.(BatchName{r}).time5s(~isnan(Lucullus.(BatchName{r}).LucRaw.A_FEED)),Lucullus.(BatchName{r}).LucRaw.A_FEED(~isnan(Lucullus.(BatchName{r}).LucRaw.A_FEED))];
Lucullus.(BatchName{r}).VolumeChange=sort([Lucullus.(BatchName{r}).fed(:,1);Lucullus.(BatchName{r}).toi])
Lucullus.(BatchName{r}).time_30mInterval=[0:0.5:floor(Lucullus.(BatchName{r}).time5s(end))];
end
% Some adjust; Feed calculated based on volume and feed concentration.
%the number is the cummulative feed added
Lucullus.AdV01.GLUNFD=[6;6;6;6;6;6;6;6;6;6;6;6;6;6;7.1;7.1;7.1];
Lucullus.AdV01.GLUCFD=[6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;7.1;7.1;7.1];
Lucullus.AdV01.GLUNFD_30mInterval=7.1*ones(length(Lucullus.AdV01.time_30mInterval),1);
Lucullus.AdV01.GLUCFD_30mInterval=7.1*ones(length(Lucullus.AdV01.time_30mInterval),1);
Lucullus.AdV01.GLUNFD_30mInterval(Lucullus.AdV01.time_30mInterval<Lucullus.AdV01.fed(1,1))=6;
Lucullus.AdV01.GLUCFD_30mInterval(Lucullus.AdV01.time_30mInterval<Lucullus.AdV01.fed(1,1))=6.8;

Lucullus.AdV01.time_SamplePoint(7)=[];% two sample was taken at (52h and 53h) to measure VCD but only the 52 h sample was measured for metabolites, so one time point removed.
% The second VCD point were not corrected with cell-counter picture, so
% VCDM and VIAM not availble.
% For the first two samplepoint VCD and VIA was closed enough to replace VCDM and VIAM at low cell density.
Lucullus.AdV01.VCDM=[Lucullus.AdV01.VCD(1:2,:);Lucullus.AdV01.VCDM(2:end,:)];
Lucullus.AdV01.VIAM=[Lucullus.AdV01.VIA(1:2,:);Lucullus.AdV01.VIAM(2:end,:)];
%average the duplicate measure (52h and 53h)
Lucullus.AdV01.VCDM(6,:)=mean(Lucullus.AdV01.VCDM(6:7,:));
Lucullus.AdV01.VIAM(6,:)=mean(Lucullus.AdV01.VIAM(6:7,:));

Lucullus.AdV01.VCDM(7,:)=[];
Lucullus.AdV01.VIAM(7,:)=[];

Lucullus.AdV02.GLUNFD=[6;6;6;6;6;7.1;7.1;7.1;8.2;8.2;8.2;9.3;9.3;9.3];
Lucullus.AdV02.GLUCFD=[6.8;6.8;6.8;6.8;6.8;7.1;7.1;7.1;7.4;7.4;7.4;7.7;7.7;7.7];
Lucullus.AdV02.GLUNFD_30mInterval=9.3*ones(length(Lucullus.AdV02.time_30mInterval),1);
Lucullus.AdV02.GLUCFD_30mInterval=7.7*ones(length(Lucullus.AdV02.time_30mInterval),1);
Lucullus.AdV02.GLUNFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(3,1))=8.2;
Lucullus.AdV02.GLUCFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(3,1))=7.4;
Lucullus.AdV02.GLUNFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(2,1))=7.1;
Lucullus.AdV02.GLUCFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(2,1))=7.1;
Lucullus.AdV02.GLUNFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(1,1))=6;
Lucullus.AdV02.GLUCFD_30mInterval(Lucullus.AdV02.time_30mInterval<Lucullus.AdV02.fed(1,1))=6.8;


Lucullus.AdV03.GLUNFD=[6;6;6;6;6;6;6;6;6];
Lucullus.AdV03.GLUCFD=[6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8];
Lucullus.AdV03.GLUNFD_30mInterval=6*ones(length(Lucullus.AdV03.time_30mInterval),1);
Lucullus.AdV03.GLUCFD_30mInterval=6.8*ones(length(Lucullus.AdV03.time_30mInterval),1);
% CG data format is slightly different, so the data was inported
% individually
% capaciatance was recorded every 30s 
Lucullus.CG.time1m=[1:1:20146]/120-Lucullus.CG.CapIni/120;
Lucullus.CG.raw_cap=Lucullus.CG.CapRaw.Capacitance;
Lucullus.CG.cap_m=mean(Lucullus.CG.raw_cap(1:50));
Lucullus.CG.cap=Lucullus.CG.raw_cap-Lucullus.CG.cap_m;
Lucullus.CG.con=Lucullus.CG.CapRaw.Conductivity;

Lucullus.CG.toi=0;
Lucullus.CG.time5s=Lucullus.CG.LucRaw.Time-Lucullus.CG.LucRaw.Time(Lucullus.CG.LucIni);
Lucullus.CG.m_do=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.m_do]
Lucullus.CG.dm_o2=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.dm_o2];
Lucullus.CG.m_co2=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.m_co2];
Lucullus.CG.dm_co2=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.dm_co2];
Lucullus.CG.dm_base=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.dm_spump1];
Lucullus.CG.ph=[Lucullus.CG.time5s,Lucullus.CG.LucRaw.m_ph];

Lucullus.CG.time_SamplePoint=Lucullus.CG.time5s(find(Lucullus.CG.LucRaw.A_SAMPLE==1));
Lucullus.CG.VCD=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_VDENS)),Lucullus.CG.LucRaw.M_VDENS(~isnan(Lucullus.CG.LucRaw.M_VDENS))];
Lucullus.CG.VCDM=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_VDENS_MICROSCOPE)),Lucullus.CG.LucRaw.M_VDENS_MICROSCOPE(~isnan(Lucullus.CG.LucRaw.M_VDENS_MICROSCOPE))];
Lucullus.CG.TCD=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_TDENS)),Lucullus.CG.LucRaw.M_TDENS(~isnan(Lucullus.CG.LucRaw.M_TDENS))];
Lucullus.CG.VIAM=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE)),Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE(~isnan(Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE))];
Lucullus.CG.TCDM=Lucullus.CG.VCDM(:,2)./Lucullus.CG.VIAM(:,2)*100;
Lucullus.CG.TCDM=[Lucullus.CG.VCDM(:,1) Lucullus.CG.TCDM];
Lucullus.CG.VIA=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_VIAB)),Lucullus.CG.LucRaw.M_VIAB(~isnan(Lucullus.CG.LucRaw.M_VIAB))];
Lucullus.CG.VIAM=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE)),Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE(~isnan(Lucullus.CG.LucRaw.M_VIAB_MICROSCOPE))];
Lucullus.CG.AMM=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_AMM)),Lucullus.CG.LucRaw.M_AMM(~isnan(Lucullus.CG.LucRaw.M_AMM))];
Lucullus.CG.GLUT=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_GLUT)),Lucullus.CG.LucRaw.M_GLUT(~isnan(Lucullus.CG.LucRaw.M_GLUT))];
Lucullus.CG.GLUN=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_GLUN)),Lucullus.CG.LucRaw.M_GLUN(~isnan(Lucullus.CG.LucRaw.M_GLUN))];
Lucullus.CG.GLUC=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_GLUC)),Lucullus.CG.LucRaw.M_GLUC(~isnan(Lucullus.CG.LucRaw.M_GLUC))];
Lucullus.CG.LAC=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.M_LAC)),Lucullus.CG.LucRaw.M_LAC(~isnan(Lucullus.CG.LucRaw.M_LAC))];


% Lucullus.CG.titre=[Lucullus.CG.time5s(~isnan(Lucullus.CG.LucRaw.VT_TCID)),Lucullus.CG.LucRaw.VT_TCID(~isnan(Lucullus.CG.LucRaw.VT_TCID))];
Lucullus.CG.titre=zeros(length(Lucullus.CG.time_SamplePoint),1);
Lucullus.CG.time_30mInterval=[0:0.5:floor(Lucullus.CG.time5s(end))];
Lucullus.CG.fed=121.6524;
Lucullus.CG.GLUNFD=[4;4;4;4;4;4;4;4;4;4;4.73;4.73;4.73;4.73;4.73];
Lucullus.CG.GLUCFD=[6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8;6.8];
Lucullus.CG.GLUNFD_30mInterval=4.73*ones(length(Lucullus.CG.time_30mInterval),1);
Lucullus.CG.GLUCFD_30mInterval=6.8*ones(length(Lucullus.CG.time_30mInterval),1);
Lucullus.CG.GLUNFD_30mInterval(Lucullus.CG.time_30mInterval<Lucullus.CG.fed(1,1))=4;


%% find the time oxygen valve open

for r=1:4
Lucullus.(BatchName{r}).dm_o2_change_index=(find(diff(isnan(Lucullus.(BatchName{r}).dm_o2(:,2)))==-1)+1);
for i=1:(length(Lucullus.(BatchName{r}).dm_o2_change_index)-1)
    if Lucullus.(BatchName{r}).dm_o2(Lucullus.(BatchName{r}).dm_o2_change_index(i),2)==Lucullus.(BatchName{r}).dm_o2(Lucullus.(BatchName{r}).dm_o2_change_index(i+1),2)
        Lucullus.(BatchName{r}).dm_o2_change_index(i)=0
    end
end
Lucullus.(BatchName{r}).dm_o2_change_index(find(Lucullus.(BatchName{r}).dm_o2_change_index==0))=[]
for i=1:(length(Lucullus.(BatchName{r}).dm_o2_change_index)-1)
    if Lucullus.(BatchName{r}).dm_o2(Lucullus.(BatchName{r}).dm_o2_change_index(i+1),2)-Lucullus.(BatchName{r}).dm_o2(Lucullus.(BatchName{r}).dm_o2_change_index(i),2)<1
        Lucullus.(BatchName{r}).dm_o2_change_index(i)=0
    end
end
Lucullus.(BatchName{r}).dm_o2_change_index(find(Lucullus.(BatchName{r}).dm_o2_change_index==0))=[]
Lucullus.(BatchName{r}).dm_o2_change_index(end)=[]


Lucullus.(BatchName{r}).dm_o2_change=Lucullus.(BatchName{r}).dm_o2(Lucullus.(BatchName{r}).dm_o2_change_index,:);

% figure
% plot(Lucullus.(BatchName{r}).dm_o2(:,1),Lucullus.(BatchName{r}).dm_o2(:,2))
% hold
% scatter(Lucullus.(BatchName{r}).dm_o2_change(:,1),Lucullus.(BatchName{r}).dm_o2_change(:,2));
% 
% hold off
end
%% define OURdo/dt range
% Find the lowest do before oxygen open
for r=1:4
Lucullus.(BatchName{r}).do_low_index=Lucullus.(BatchName{r}).dm_o2_change_index
Lucullus.(BatchName{r}).do_low=Lucullus.(BatchName{r}).m_do(Lucullus.(BatchName{r}).do_low_index,:)

Lucullus.(BatchName{r}).do_up_index=Lucullus.(BatchName{r}).do_low_index-1

Lucullus.(BatchName{r}).do_up=Lucullus.(BatchName{r}).m_do(Lucullus.(BatchName{r}).do_up_index,:)

%only 45%-40% range was used
for i=1:length(Lucullus.(BatchName{r}).do_up_index)
    
    while Lucullus.(BatchName{r}).do_up(i,2)<45 
        Lucullus.(BatchName{r}).do_up_index(i)=Lucullus.(BatchName{r}).do_up_index(i)-1;
        Lucullus.(BatchName{r}).do_up(i,:)=Lucullus.(BatchName{r}).m_do(Lucullus.(BatchName{r}).do_up_index(i),:);
    end
    
        
    if Lucullus.(BatchName{r}).do_up(i,2)>46 
        
        Lucullus.(BatchName{r}).do_up_index(i)=0;
        Lucullus.(BatchName{r}).do_low_index(i)=0;
    end
    
    if Lucullus.(BatchName{r}).do_low(i,2)>41
        Lucullus.(BatchName{r}).do_low(i,2)=0;
        Lucullus.(BatchName{r}).do_low_index(i)=0;
        Lucullus.(BatchName{r}).do_up_index(i)=0;
    end
    
end

for i=1:length(Lucullus.(BatchName{r}).do_up_index)-1
if Lucullus.(BatchName{r}).do_low(i,1)>=Lucullus.(BatchName{r}).do_up(i+1,1);
        Lucullus.(BatchName{r}).do_up_index(i+1)=0;
        Lucullus.(BatchName{r}).do_low_index(i+1)=0;
end
end


    
Lucullus.(BatchName{r}).do_low(find(Lucullus.(BatchName{r}).do_low_index==0),:)=[];
Lucullus.(BatchName{r}).do_up(find(Lucullus.(BatchName{r}).do_up_index==0),:)=[];
% figure
% plot(Lucullus.(BatchName{r}).m_do(:,1),Lucullus.(BatchName{r}).m_do(:,2));
% hold on; 
% scatter(Lucullus.(BatchName{r}).do_up(:,1),Lucullus.(BatchName{r}).do_up(:,2));
% scatter(Lucullus.(BatchName{r}).do_low(:,1),Lucullus.(BatchName{r}).do_low(:,2));
% hold off
% 
end

%% calculate d(do)/dt d(dm)/dt
for r=1:4
% OURdo
Lucullus.(BatchName{r}).OURdo=[(Lucullus.(BatchName{r}).do_up(:,1)+Lucullus.(BatchName{r}).do_low(:,1))./2,(Lucullus.(BatchName{r}).do_up(:,2)-Lucullus.(BatchName{r}).do_low(:,2))./(Lucullus.(BatchName{r}).do_low(:,1)-Lucullus.(BatchName{r}).do_up(:,1))]
%OUR vol
Lucullus.(BatchName{r}).OURvol=[Lucullus.(BatchName{r}).dm_o2_change(2:end,1),diff(Lucullus.(BatchName{r}).dm_o2_change(:,2))./diff(Lucullus.(BatchName{r}).dm_o2_change(:,1))] 

% After this step, check any outlier in OURdo and OURvol. The very visible
% outlier is due to miss detection of low and up time in laststep.

end
%%
for r=1:4
Lucullus.(BatchName{r}).OURdo_SamplePoint=[]
for i=1:length(Lucullus.(BatchName{r}).time_SamplePoint)
    if Lucullus.(BatchName{r}).time_SamplePoint(i)<Lucullus.(BatchName{r}).OURdo(1,1)
        Lucullus.(BatchName{r}).OURdo_SamplePoint(i)=min(Lucullus.(BatchName{r}).OURdo(:,2))
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi>0 && Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi<0.5
            Lucullus.(BatchName{r}).OURdo_SamplePoint(i)=mean(Lucullus.(BatchName{r}).OURdo((find(Lucullus.(BatchName{r}).OURdo(:,1)>Lucullus.(BatchName{r}).toi & Lucullus.(BatchName{r}).OURdo(:,1)<Lucullus.(BatchName{r}).time_SamplePoint(i))),2))
    else Lucullus.(BatchName{r}).OURdo_SamplePoint(i)=mean(Lucullus.(BatchName{r}).OURdo((find(Lucullus.(BatchName{r}).OURdo(:,1)>Lucullus.(BatchName{r}).time_SamplePoint(i)-0.5 & Lucullus.(BatchName{r}).OURdo(:,1)<Lucullus.(BatchName{r}).time_SamplePoint(i))),2))
    end
    end
end

Lucullus.(BatchName{r}).OURvol_SamplePoint=[]
for i=1:length(Lucullus.(BatchName{r}).time_SamplePoint)
    if Lucullus.(BatchName{r}).time_SamplePoint(i)<Lucullus.(BatchName{r}).OURvol(1,1)
        Lucullus.(BatchName{r}).OURvol_SamplePoint(i)=min(Lucullus.(BatchName{r}).OURvol(:,2))
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi>0 && Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi<0.5
            Lucullus.(BatchName{r}).OURvol_SamplePoint(i)=mean(Lucullus.(BatchName{r}).OURvol((find(Lucullus.(BatchName{r}).OURvol(:,1)>Lucullus.(BatchName{r}).toi & Lucullus.(BatchName{r}).OURvol(:,1)<Lucullus.(BatchName{r}).time_SamplePoint(i))),2))
    else Lucullus.(BatchName{r}).OURvol_SamplePoint(i)=mean(Lucullus.(BatchName{r}).OURvol((find(Lucullus.(BatchName{r}).OURvol(:,1)>Lucullus.(BatchName{r}).time_SamplePoint(i)-0.5 & Lucullus.(BatchName{r}).OURvol(:,1)<Lucullus.(BatchName{r}).time_SamplePoint(i))),2))
    end
    end
end

Lucullus.(BatchName{r}).OURvol_30mInterval=[]
Lucullus.(BatchName{r}).OURvol_30mInterval(1)=Lucullus.(BatchName{r}).OURvol(1,2)
for i=2:length(Lucullus.(BatchName{r}).time_30mInterval)
    Lucullus.(BatchName{r}).OURvol_30mInterval(i)=mean(Lucullus.(BatchName{r}).OURvol(find(Lucullus.(BatchName{r}).OURvol(:,1)>Lucullus.(BatchName{r}).time_30mInterval(i-1)&Lucullus.(BatchName{r}).OURvol(:,1)<Lucullus.(BatchName{r}).time_30mInterval(i)),2))
end

Lucullus.(BatchName{r}).OURdo_30mInterval=[]
Lucullus.(BatchName{r}).OURdo_30mInterval(1)=Lucullus.(BatchName{r}).OURdo(1,2);
for i=2:length(Lucullus.(BatchName{r}).time_30mInterval)
    Lucullus.(BatchName{r}).OURdo_30mInterval(i)=mean(Lucullus.(BatchName{r}).OURdo(find(Lucullus.(BatchName{r}).OURdo(:,1)>Lucullus.(BatchName{r}).time_30mInterval(i-1)&Lucullus.(BatchName{r}).OURdo(:,1)<Lucullus.(BatchName{r}).time_30mInterval(i)),2))
end


figure
subplot(2,1,1)
scatter(Lucullus.(BatchName{r}).OURdo(:,1),Lucullus.(BatchName{r}).OURdo(:,2));
hold
scatter(Lucullus.(BatchName{r}).time_SamplePoint,Lucullus.(BatchName{r}).OURdo_SamplePoint);
%scatter(Lucullus.(BatchName{r}).time_30mInterval,Lucullus.(BatchName{r}).OURdo_30mInterval);
hold off
subplot(2,1,2)
scatter(Lucullus.(BatchName{r}).OURvol(:,1),Lucullus.(BatchName{r}).OURvol(:,2))
hold
scatter(Lucullus.(BatchName{r}).time_SamplePoint,Lucullus.(BatchName{r}).OURvol_SamplePoint);
%scatter(Lucullus.(BatchName{r}).time_30mInterval,Lucullus.(BatchName{r}).OURvol_30mInterval);
ylim([0 100])
hold off
end

%% calculate pH,dm_co2 and dm_base
for r=1:4
Lucullus.(BatchName{r}).ph_fin=Lucullus.(BatchName{r}).ph(isfinite(Lucullus.(BatchName{r}).ph(:,2)),:);
Lucullus.(BatchName{r}).dm_co2_fin=Lucullus.(BatchName{r}).dm_co2(isfinite(Lucullus.(BatchName{r}).dm_co2(:,2)),:);
Lucullus.(BatchName{r}).dm_base_fin=Lucullus.(BatchName{r}).dm_base(isfinite(Lucullus.(BatchName{r}).dm_base(:,2)),:);
for i=1:length(Lucullus.(BatchName{r}).time_SamplePoint);
        [ph_sampletime(i),ph_sampletime_index(i)]=min(abs(Lucullus.(BatchName{r}).ph_fin(:,1)-Lucullus.(BatchName{r}).time_SamplePoint(i)));
        Lucullus.(BatchName{r}).ph_SamplePoint(i)=Lucullus.(BatchName{r}).ph_fin(ph_sampletime_index(i),2);
    
        [co2_sampletime(i),co2_sampletime_index(i)]=min(abs(Lucullus.(BatchName{r}).dm_co2_fin(:,1)-Lucullus.(BatchName{r}).time_SamplePoint(i)));
        Lucullus.(BatchName{r}).dm_co2_SamplePoint(i)=Lucullus.(BatchName{r}).dm_co2_fin(co2_sampletime_index(i),2);
    
        [base_sampletime(i),base_sampletime_index(i)]=min(abs(Lucullus.(BatchName{r}).dm_base_fin(:,1)-Lucullus.(BatchName{r}).time_SamplePoint(i)));
        Lucullus.(BatchName{r}).dm_base_SamplePoint(i)=Lucullus.(BatchName{r}).dm_base_fin(base_sampletime_index(i),2);
        
end
Lucullus.(BatchName{r}).ph_30mInterval=[];
Lucullus.(BatchName{r}).dm_co2_30mInterval=[];
Lucullus.(BatchName{r}).dm_base_30mInterval=[];
Lucullus.(BatchName{r}).ph_30mInterval(1)=Lucullus.(BatchName{r}).ph_fin(1,1);
Lucullus.(BatchName{r}).dm_co2_30mInterval(1)=Lucullus.(BatchName{r}).dm_co2_fin(1,1);
Lucullus.(BatchName{r}).dm_base_30mInterval(1)=Lucullus.(BatchName{r}).dm_base_fin(1,1);
for i=1:length(Lucullus.(BatchName{r}).time_30mInterval);
        [ph_30mInterval(i),ph_30mInterval_index(i)]=min(abs(Lucullus.(BatchName{r}).ph_fin(:,1)-Lucullus.(BatchName{r}).time_30mInterval(i)));
        Lucullus.(BatchName{r}).ph_30mInterval(i)=Lucullus.(BatchName{r}).ph_fin(ph_30mInterval_index(i),2);
    
        [co2_30mInterval(i),co2_30mInterval_index(i)]=min(abs(Lucullus.(BatchName{r}).dm_co2_fin(:,1)-Lucullus.(BatchName{r}).time_30mInterval(i)));
        Lucullus.(BatchName{r}).dm_co2_30mInterval(i)=Lucullus.(BatchName{r}).dm_co2_fin(co2_30mInterval_index(i),2);
    
        [base_sampletime(i),base_30mInterval_index(i)]=min(abs(Lucullus.(BatchName{r}).dm_base_fin(:,1)-Lucullus.(BatchName{r}).time_30mInterval(i)));
        Lucullus.(BatchName{r}).dm_base_30mInterval(i)=Lucullus.(BatchName{r}).dm_base_fin(base_30mInterval_index(i),2);
        
end



end


%% capacitance/conductivity  fit
%calculate capacitance and conductivity
for r=1:4
Lucullus.(BatchName{r}).cap_SamplePoint=[];
for i=1:length(Lucullus.(BatchName{r}).time_SamplePoint)
    if Lucullus.(BatchName{r}).time_SamplePoint(i)<Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni)
        Lucullus.(BatchName{r}).cap_SamplePoint(i)=Lucullus.(BatchName{r}).cap(Lucullus.(BatchName{r}).CapIni)
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni)<0.5
            Lucullus.(BatchName{r}).cap_SamplePoint(i)=mean(Lucullus.(BatchName{r}).cap((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni) & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi>0 && Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi<0.5
            Lucullus.(BatchName{r}).cap_SamplePoint(i)=mean(Lucullus.(BatchName{r}).cap((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).toi & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    else Lucullus.(BatchName{r}).cap_SamplePoint(i)=mean(Lucullus.(BatchName{r}).cap((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time_SamplePoint(i)-0.5 & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    end
    end
    end
end

Lucullus.(BatchName{r}).con_SamplePoint=[];
for i=1:length(Lucullus.(BatchName{r}).time_SamplePoint)
    if Lucullus.(BatchName{r}).time_SamplePoint(i)<Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni)
        Lucullus.(BatchName{r}).con_SamplePoint(i)=Lucullus.(BatchName{r}).con(Lucullus.(BatchName{r}).CapIni)
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni)<0.5
            Lucullus.(BatchName{r}).con_SamplePoint(i)=nanmean(Lucullus.(BatchName{r}).con((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time1m(Lucullus.(BatchName{r}).CapIni) & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    else if Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi>0 && Lucullus.(BatchName{r}).time_SamplePoint(i)-Lucullus.(BatchName{r}).toi<0.5
            Lucullus.(BatchName{r}).con_SamplePoint(i)=nanmean(Lucullus.(BatchName{r}).con((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).toi & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    else Lucullus.(BatchName{r}).con_SamplePoint(i)=nanmean(Lucullus.(BatchName{r}).con((find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time_SamplePoint(i)-0.5 & Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_SamplePoint(i)))))
    end
    end
    end
end


Lucullus.(BatchName{r}).cap_30mInterval=[];

for i=2:length(Lucullus.(BatchName{r}).time_30mInterval)
    Lucullus.(BatchName{r}).cap_30mInterval(i)=nanmean(Lucullus.(BatchName{r}).cap(find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time_30mInterval(i-1)&Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_30mInterval(i))));
end
Lucullus.(BatchName{r}).cap_30mInterval(1)=Lucullus.(BatchName{r}).cap_30mInterval(2);

Lucullus.(BatchName{r}).con_30mInterval=[];

for i=2:length(Lucullus.(BatchName{r}).time_30mInterval)
    Lucullus.(BatchName{r}).con_30mInterval(i)=nanmean(Lucullus.(BatchName{r}).con(find(Lucullus.(BatchName{r}).time1m>Lucullus.(BatchName{r}).time_30mInterval(i-1)&Lucullus.(BatchName{r}).time1m<Lucullus.(BatchName{r}).time_30mInterval(i))));
end
Lucullus.(BatchName{r}).con_30mInterval(1)=Lucullus.(BatchName{r}).con_30mInterval(2);
end
% The base was run-out at around ~97hour, after refill, the base tube was
% primed, which bringed a lot base, we would correct this effect
% going up, this could be confirm by comparing dm_base figure and
% conductivity figure. Hence, correction is need as follow
Lucullus.AdV02.dm_base_SamplePoint(9:end)=Lucullus.AdV02.dm_base_SamplePoint(9:end)-(281.87-249.24);
Lucullus.AdV02.dm_base_30mInterval(196)=Lucullus.AdV02.dm_base_30mInterval(195);
Lucullus.AdV02.dm_base_30mInterval(197:end)=Lucullus.AdV02.dm_base_30mInterval(197:end)-(Lucullus.AdV02.dm_base_30mInterval(197)-Lucullus.AdV02.dm_base_30mInterval(195));
save('Lucullus.mat','Lucullus');