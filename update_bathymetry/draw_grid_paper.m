clear all
clf

xycoast1=load('xy_coast.txt');
R=6371000.0;
dx=R*pi/180.0/3600.0/3.0*cos(38.53/180.0*pi);
dy=R*pi/180.0/3600.0/3.0;
xycoast(:,1)=xycoast1(:,1)*dx;
xycoast(:,2)=xycoast1(:,2)*dy;

x=load('x_nearcom.txt');
y=load('y_nearcom.txt');

[n,m]=size(x);

dep=load('dep_196x140.txt');

%dep(dep<-1)=NaN;

set(gcf,'units','inches','paperunits','inches','papersize', [9 8],'position',[1 1 9 8],'color','white');
%pcolor(x,y,-dep),shading flat
contourf(x,y,-dep,80,'edgecolor','none')
hold on
caxis([-20 8])
plot(xycoast(:,1),xycoast(:,2),'color','k','LineWidth',1.5)
line(x,y,'color','k')
line(x',y','color','k')
dd=-2.5;

axis([9000 35560 0 23340])
%set(gca,'xlim',[0.8 3.2]*1E4)
%set(gca,'ylim',[0 2.22]*1E4)
xlabel('x(m)')
ylabel('y(m)')
h=colorbar;
ylabel(h,'Elevation (m)')
set(get(gcf,'CurrentAxes'),'FontSize',16)

station=load('station_info.txt');

x1=station(1,1);
x2=station(2,1);
x3=station(3,1);

y1=station(1,2);
y2=station(2,2);
y3=station(3,2);

plot([x1 x2 x3],[y1 y2 y3],'r^','linewidth',2,'markersize',10)

text(x1,y1+0.1E4,'R','fontsize',16,'color','w')
text(x2-0.06E4,y2+0.05E4,'I','fontsize',16,'color','w')
text(x3,y3+0.1E4,'D','fontsize',16,'color','w')
