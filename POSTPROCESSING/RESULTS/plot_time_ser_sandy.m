
%clear all
clf

fdir1='../../results_sandy_surge0/'; % 
fdir3='../../results_sandy_wave0/';
fdata='../../DATA/DATA/';

start_time='2012,10,23';
end_time='2012,11,03';

lag=1.0/24; % hr
vdatum=0.0;
vdatum_d=-0.1;


fdir={fdir1 fdir3};
colorr={'b' 'r'};

set(gcf,'units','inches','paperunits','inches','papersize', [10 5],'position',[1 1 10 5]);

for k=1:length(fdir)

sta1=load([fdir{k} 'sta_0001']);
sta2=load([fdir{k} 'sta_0002']);
sta3=load([fdir{k} 'sta_0003']);


subplot(311)


if k==1
data=load([fdata 'inlet.txt']);
time_data=data(:,1)+datenum(start_time);
plot(time_data,data(:,2),'k-','LineWidth',1)
datetick('x',6)
grid
hold on
end


hold on

time_model=sta2(:,1)/3600/24+datenum(start_time)-lag;
plot(time_model,sta2(:,2)+vdatum,colorr{k},'LineWidth',1)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) -2 2])
title('Inlet')
ylabel('elevation (m)')
if k==2
legend('data','surge','surge+wave')
end


subplot(312)

if k==1
data=load([fdata 'rosedale.txt']);
time_data=data(:,1)+datenum(start_time);
plot(time_data,data(:,2),'k-','LineWidth',1)
datetick('x',6)
hold on
grid
end

time_model=sta1(:,1)/3600/24+datenum(start_time)-lag;
plot(time_model,sta1(:,2)+vdatum,colorr{k},'LineWidth',1)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) -2 2])
title('Rosedale')
ylabel('elevation (m)')


subplot(313)

if k==1
data=load([fdata 'dewey.txt']);
time_data=data(:,1)+datenum(start_time);
plot(time_data,data(:,2),'k-','LineWidth',1)
datetick('x',6)
grid
hold on
end

time_model=sta3(:,1)/3600/24+datenum(start_time)-lag;
plot(time_model,sta3(:,2)+vdatum_d,colorr{k},'LineWidth',1)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) -2 2])
title('Dewey')
ylabel('elevation (m)')
xlabel('mm/dd/2016')
end




