clear all
clf
xycoast1=load('xy_coast.txt');
R=6371000.0;
dx=R*pi/180.0/3600.0/3.0*cos(38.53/180.0*pi);
dy=R*pi/180.0/3600.0/3.0;
xycoast(:,1)=xycoast1(:,1)*dx;
xycoast(:,2)=xycoast1(:,2)*dy;

x=load('../../DATA/GRID/x_lg.txt');
y=load('../../DATA/GRID/y_lg.txt');

[n,m]=size(x);

dep=load('../../DATA/GRID/depth_lg.txt');

dep(dep<-1)=NaN;

%x(dep<-1)=NaN;
%y(isnan(x))=NaN;


pcolor(x,y,-dep),shading flat
hold on
caxis([-25 10])
plot(xycoast(:,1),xycoast(:,2),'c')
%line(x,y,'color','k')
%line(x',y','color','k')
for i=1:n-1
    for j=1:m-1
        if dep(i,j)>0.0
        plot([x(i,j) x(i+1,j) x(i+1,j+1) x(i,j+1) x(i,j)],...
             [y(i,j) y(i+1,j) y(i+1,j+1) y(i,j+1) y(i,j)],'k')
        end
    end
end
xlabel('x(m)')
ylabel('y(m)')
colorbar


