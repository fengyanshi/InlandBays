clear all
clf
xycoast1=load('xy_coast.txt');
R=6371000.0;
dx=R*pi/180.0/3600.0/3.0*cos(38.53/180.0*pi);
dy=R*pi/180.0/3600.0/3.0;
xycoast(:,1)=xycoast1(:,1)*dx;
xycoast(:,2)=xycoast1(:,2)*dy;
m=198;
n=141;
x1=load('x_add_bethany.txt');
y1=load('y_add_bethany.txt');

x1=x1';
y1=y1';

dep=load('dep_196x140.txt');
[n m]=size(dep);

x=x1(1:n,1:m)*dx;
y=y1(1:n,1:m)*dy;

pcolor(x,y,-dep),shading flat
hold on
plot(xycoast(:,1),xycoast(:,2),'r')
line(x,y,'color','k')
line(x',y','color','k')
xlabel('x(m)')
ylabel('y(m)')

xy(1:n,1:m)=x;
xy(n+1:2*n,1:m)=y;

% nearcom grid

save -ASCII x_nearcom.txt x
save -ASCII y_nearcom.txt y


