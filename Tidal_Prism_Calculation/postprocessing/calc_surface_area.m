clear all
close all
fdir_model='/Users/fengyanshi15/work/NewInlandbayModel/INLANDBAYS_MODEL/LuYang/DATA/GRID/';

setupname='25_35_25';
time_start_number = 2420;% 1320;
time_end_number=time_start_number+3100;  % 12.42*3600*15/360=1863;

%time_start_number = 1;% 1320;
%time_end_number=time_start_number+5600;

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

setupcase={'25_35_25'};


kcase=1;
fdir_result=['/Volumes/DISK_2020_5/Inlandbays/' 'setup_' setupcase{kcase} '/'];


fname=[fdir_model 'depth_' setupcase{kcase} '.txt'];
dep=load(fname);

Area=0.0;
[n m]=size(dep);
n_indian_1=1;
n_indian_2=42;
m_indian_1=1;
m_indian_2=97;

n_reho_1=43;
n_reho_2=75;
m_reho_1=1;
m_reho_2=85;

A=0;
Area=0;
icount1=0;
icount2=0;
for i=m_indian_1:m_indian_2
for j=n_indian_1:n_indian_2
icount1=icount1+1;
if (dep(j,i)>0.0)
icount2=icount2+1;
x1=x(j,i);
y1=y(j,i);
x2=x(j,i+1);
y2=y(j,i+1);
x3=x(j+1,i+1);
y3=y(j+1,i+1);
x4=x(j+1,i);
y4=y(j+1,i);
A=abs(0.5*((x1*y2+x2*y3+x3*y4+x4*y1)-(x2*y1+x3*y2+x4*y3+x1*y4)));
%A=sqrt((x2-x1)^2+(y2-y1)^2)*sqrt((x4-x1)^2+(y4-y1)^2);
Area=Area+A;
end
end
end
Area_indian=Area

A=0;
Area=0;
for i=m_reho_1:m_reho_2
for j=n_reho_1:n_reho_2
if (dep(j,i)>0.0)
x1=x(j,i);
y1=y(j,i);
x2=x(j,i+1);
y2=y(j,i+1);
x3=x(j+1,i+1);
y3=y(j+1,i+1);
x4=x(j+1,i);
y4=y(j+1,i);
A=abs(0.5*((x1*y2+x2*y3+x3*y4+x4*y1)-(x2*y1+x3*y2+x4*y3+x1*y4)));
%A=sqrt((x2-x1)^2+(y2-y1)^2)*sqrt((x4-x1)^2+(y4-y1)^2);
Area=Area+A;
end
end
end
Area_reho=Area

Area_total=Area_reho+Area_indian

writeout(1,1)=Area_indian;
writeout(2,1)=Area_reho;
writeout(3,1)=Area_total;

writeout(1,2)=Area_indian*10.7639;
writeout(2,2)=Area_reho*10.7639;
writeout(3,2)=Area_total*10.7639;

save -ASCII areas_ft_cm.txt writeout




