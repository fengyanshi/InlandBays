clear all
close all
fdir_model='/Users/fengyanshi15/work/NewInlandbayModel/INLANDBAYS_MODEL/LuYang/DATA/GRID/';

setupname='all';
%time_end_number=3726; % 12.42*3600*30/3600;
time_start_number = [2440 2440 2440 2450 ...
2450 2450 2450 2450 ...
2450 2450 2450 2450 ...
2450 2450 2450 2450 ...
2450 2450 2450 2450 ...
2450 2520 2460 2520 ...
2460 ...
];% 1320;
time_end_number=time_start_number+3000;  % 12.42*3600*15/360=1863;

fname=[fdir_model 'x_lg.txt'];
x=load(fname);
fname=[fdir_model 'y_lg.txt'];
y=load(fname);


ix(1)=88;
iy(1)=36;
ix(2)=88;
iy(2)=37;
ix(3)=88;
iy(3)=38;
ix(4)=88;
iy(4)=39;

setupcase={'5_5_5','5_10_5','5_15_5','5_25_5',...
'7_10_7','7_15_7','7_20_7','7_25_7', '7_30_7',...
'10_10_10','10_15_10','10_20_10','10_25_10', '10_30_10',...
'15_20_15','15_25_15','15_30_15','15_35_15',...
'20_25_20','20_30_20','20_35_20',...
'22_30_22','22_35_22',...
'25_30_25','25_35_25'};


% ------------------------------
for kcase=1:length(setupcase)

fdir_result=['/Volumes/DISK_2020_5/Inlandbays/' 'setup_' setupcase{kcase} '/'];

fname=[fdir_model 'depth_' setupcase{kcase} '.txt'];
dep=load(fname);


% cross-section distance
for k=1:length(ix)-1

dis(k)=sqrt((x(iy(k+1),ix(k+1))-x(iy(k),ix(k))).^2+(y(iy(k+1),ix(k+1))-y(iy(k),ix(k))).^2);
depth(k)=dep(iy(k),ix(k));
end

% mk_depth_at the center

ina=0.0;
for k=1:length(ix)-1
ina=ina+dis(k)*depth(k);
end
inlet_area(kcase)=ina;

clear time data eta u flux FLUX 

% read data
for k=1:3
fnum=sprintf('%.4d',k+3);
data=load([fdir_result 'sta_' fnum]);
time(:,k)=data(time_start_number(kcase):time_end_number(kcase),1);
eta(:,k)=data(time_start_number(kcase):time_end_number(kcase),2);
u(:,k)=data(time_start_number(kcase):time_end_number(kcase),3);
end

% flux

for k=1:3
flux(:,k)=(depth(k)+eta(:,k)).*u(:,k).*dis(k);
end

FLUX=sum(flux,2);

figure(1)
clf
hold on
% plot
for k=1:3
plot(time(:,k),flux(:,k));
end
grid
plot(time(:,1),FLUX,'LineWidth',2)


total_time=max(time(:,1));
%total_time=time_end_number*360;
period=12.42*3600;
initial=min(time(:,1));
time_split=[initial:period:total_time];
yy1=time_split*0.0-3000.0;
yy2=time_split*0.0+3000.0;


for k=1:length(time_split)
plot([time_split(k) time_split(k)],[yy1(k) yy2(k)]);
end

printname=['flux_' setupcase{1} '_areaonly.jpg'];
print('-djpeg100', printname)

for k=1:length(time_split)
[minValue(k),closetIndex(k)]=min(abs(time(:,1)-time_split(k)));
end

% prisms
clear prism1 prism2
prism1=zeros(length(time_split)-1,3);
prism2=zeros(length(time_split)-1,3);
for k=1:3
for kk=1:length(time_split)-1
for kkk=closetIndex(kk):closetIndex(kk+1)-1
prism=flux(kkk,k)*(time(kkk+1,k)-time(kkk,k));
if(prism>0)
prism1(kk,k)=prism1(kk,k)+prism;
else
prism2(kk,k)=prism2(kk,k)+prism;
end
end
end
end

PRISM_in=sum(prism2,2);
PRISM_off=sum(prism1,2);

Avg_prism_in_cm(kcase)=mean(PRISM_in)/1000000;
Avg_prism_off_cm(kcase)=mean(PRISM_off)/1000000;
Avg_prism_in_cf(kcase)=Avg_prism_in_cm(kcase)*35.3147; % millin
Avg_prism_off_cf(kcase)=Avg_prism_off_cm(kcase)*35.3147;

Max_prism_in_cm(kcase)=-max(abs(PRISM_in))/1000000;
Max_prism_off_cm(kcase)=max(abs(PRISM_off))/1000000;
Min_prism_in_cm(kcase)=-min(abs(PRISM_in))/1000000;
Min_prism_off_cm(kcase)=min(abs(PRISM_off))/1000000;

Max_prism_in_cf(kcase)=Max_prism_in_cm(kcase)*35.3147;
Max_prism_off_cf(kcase)=Max_prism_off_cm(kcase)*35.3147;
Min_prism_in_cf(kcase)=Min_prism_in_cm(kcase)*35.3147;
Min_prism_off_cf(kcase)=Min_prism_off_cm(kcase)*35.3147;


figure(2)
plot(PRISM_off/1000000)
hold on
plot(PRISM_in/1000000)
grid
printname=['prism_' setupname '.jpg'];
print('-djpeg100', printname)

figure(3)
plot(PRISM_off/1000000*35.3147)
hold on
plot(PRISM_in/1000000*35.3147)
grid
printname=['prism_ft_' setupname '.jpg'];
print('-djpeg100', printname)

end % kcase

for kcase=1:length(Avg_prism_in_cm)
writeout(1,kcase)=kcase;
writeout(2,kcase)=inlet_area(kcase);
writeout(3,kcase)=Avg_prism_in_cm(kcase);
writeout(4,kcase)=Avg_prism_off_cm(kcase);
writeout(5,kcase)=0.5*(abs(Avg_prism_in_cm(kcase))+abs(Avg_prism_off_cm(kcase)));
writeout(6,kcase)=Max_prism_in_cm(kcase);
writeout(7,kcase)=Max_prism_off_cm(kcase);
writeout(8,kcase)=Min_prism_in_cm(kcase);
writeout(9,kcase)=Min_prism_off_cm(kcase);
end
fname=['prism_' setupname '_cm.txt'];
fid = fopen(fname, 'wt');
  fprintf(fid, ['%5d  %8.1f  %8.1f %8.1f %8.1f %8.1f %8.1f %8.1f %8.1f\n'], writeout);
fclose(fid);

for kcase=1:length(Avg_prism_in_cf)
writeout(1,kcase)=kcase;
writeout(2,kcase)=inlet_area(kcase);
writeout(3,kcase)=Avg_prism_in_cf(kcase);
writeout(4,kcase)=Avg_prism_off_cf(kcase);
writeout(5,kcase)=0.5*(abs(Avg_prism_in_cf(kcase))+abs(Avg_prism_off_cf(kcase)));
writeout(6,kcase)=Max_prism_in_cf(kcase);
writeout(7,kcase)=Max_prism_off_cf(kcase);
writeout(8,kcase)=Min_prism_in_cf(kcase);
writeout(9,kcase)=Min_prism_off_cf(kcase);
end
fname=['prism_' setupname '_ft.txt'];
fid = fopen(fname, 'wt');
  fprintf(fid, ['%5d  %8.1f  %8.1f %8.1f %8.1f %8.1f %8.1f %8.1f %8.1f\n'], writeout);
fclose(fid);





