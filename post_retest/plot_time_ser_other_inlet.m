
%clear all
clf
fdir1='/Volumes/DISK_2020_5/Inlandbays/setup_5_5_5/';
fdir2='/Volumes/DISK_2020_5/Inlandbays/setup_5_25_5/';
fdir3='/Volumes/DISK_2020_5/Inlandbays/setup_25_35_25/';
fdata='../DATA/DATA/';

start_time='2012,10,23';% GMT or UTM time
end_time='2012,11,04';

sttm_num=datenum(start_time)-4.0/24;% EST because of the summer time!!
edtm_num=datenum(end_time)-4.0/24;

tmp1=datenum('2012,10,23');
tmp2=datenum('2012,11,04');

lag=1.0/24; % hr lag between Lewis and inlet
vdatum=-0.1;


fdir={fdir1 fdir2 fdir3};
colorr={'b-' 'r','k-','m--'};

for k=1:length(fdir)

sta1=load([fdir{k} 'sta_0001']);
sta2=load([fdir{k} 'sta_0002']);
sta3=load([fdir{k} 'sta_0003']);

clear sta1k sta2k sta3k
sta1k(:,k)=sta1(:,2);
sta2k(:,k)=sta2(:,2);
sta3k(:,k)=sta3(:,2);

subplot(312)

hold on
if k==1
data=load([fdata 'inlet.txt']);
time_data=data(:,1)+sttm_num;
tmp=data(:,2);
tmp(tmp<-100)=NaN;
data(:,2)=tmp;
%plot(time_data,data(:,2),'k-','LineWidth',1)
end
time_model=sta2(:,1)/3600/24+sttm_num-lag;

    plot(time_model,sta2(:,2)+vdatum,colorr{k},'LineWidth',1)

title('station I')
ylabel('elevation (m)')
grid on

subplot(313)
hold on
if k==1
data=load([fdata 'rosedale.txt']);
time_data=data(:,1)+sttm_num;
%plot(time_data,data(:,2),'k-','LineWidth',1)
end
    plot(time_model,sta1(:,2)+vdatum,colorr{k},'LineWidth',1)

time_model=sta1(:,1)/3600/24+sttm_num-lag;

title('station R')
ylabel('elevation (m)')
xlabel('mm/dd/2012')
grid on


subplot(311)
hold on
if k==1
data=load([fdata 'dewey.txt']);
time_data=data(:,1)+sttm_num;
%plot(time_data,data(:,2),'k-','LineWidth',1)
end
time_model=sta3(:,1)/3600/24+sttm_num-lag;

title('station D')
ylabel('elevation (m)')
grid on

    plot(time_model,sta3(:,2)+vdatum_d,colorr{k},'LineWidth',1)

end

showsttm_num=datenum('2012,10,28');
showedtm_num=datenum('2012,10,31');

for i=1:3
    subplot(['31',num2str(i)])
%    set(gca,'xlim',[tmp1 tmp2])
    set(gca,'ylim',[-1 1])
    set(gca,'xtick',[tmp1:1:tmp2])
    datetick('x',6,'keepticks')
%    set(gca,'xlim',[showsttm_num,showedtm_num])
    box on
end
legend('inlet 5 5 5','inlet 5 25 5','inlet 25 35 35')
%print -djpeg100 wo_wind.jpg


