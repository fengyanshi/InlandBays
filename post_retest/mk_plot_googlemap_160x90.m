clear all

fdir='../update_bathymetry/';

xycoast1=load('../update_bathymetry/xy_coast.txt');
R=6371000.0;
dx=R*pi/180.0/3600.0/3.0*cos(38.53/180.0*pi);
dy=R*pi/180.0/3600.0/3.0;

lon0=-75.33333;
lat0=38.53333+0.00075;

xcoast=lon0+xycoast1(:,1)/3.0/3600.;
ycoast=lat0+xycoast1(:,2)/3.0/3600.;

x1=load('../DATA/GRID/x_lg.txt');
y1=load('../DATA/GRID/y_lg.txt');

X=lon0+x1/(3*dx)/3600.0;
Y=lat0+y1/(3*dy)/3600.0;

lat=[Y(1,1) Y(end,end)];
lon=[X(1,1) X(end,end)];


dep=load('../DATA/GRID/depth_lg.txt');

dep(dep<-0.5)=NaN;


    
clf

plot(lon,lat,'.r','MarkerSize',1)
% plot_google_map here
xlabel('Longitude(^\circ)');
ylabel('Latitude(^\circ)')
hold on
sk=1;
pcolor(X(1:sk:end,1:sk:end),Y(1:sk:end,1:sk:end),-dep(1:sk:end,1:sk:end)),shading interp;
v=[0 0];
caxis([-10. 6])

