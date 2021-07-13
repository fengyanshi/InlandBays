clear all



load WIND.mat

% get raw data
windspe=WIND(:,2);
%windspe=WIND(:,4);%gust
winddir=WIND(:,3);
windu2d=-windspe.*cos(90-winddir/180*pi);
windv2d=-windspe.*sin(90-winddir/180*pi);
%NOTE it's (-)(!!!!)windspe, because wind direction is defined as the
%direction from which the wind blows!! 05/21/2017


% convert zeros (missing values) to NaNs 
windu2d(abs(windu2d)<1E-2)=NaN;
windv2d(abs(windv2d)<1E-2)=NaN;


% add the inpaint_nan tool (interpolating nans)
% https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint-nans
addpath('C:\MATLAB\work\Tools\Inpaint_nans\Inpaint_nans\');

windu2d=inpaint_nans(windu2d);
windv2d=inpaint_nans(windv2d);


%figure
subplot(211)
hold on
plot(WIND(:,1),windu2d,'b')
datetick('x',6)
grid on
subplot(212)
hold on
plot(WIND(:,1),windv2d,'b')
datetick('x',6)
grid on

% do median filtering
% y = medfilt1(x,n) applies an nth-order one-dimensional median filter to?x.
windu2d=medfilt1(windu2d,10);
windv2d=medfilt1(windv2d,10);

subplot(211)
hold on
plot(WIND(:,1),windu2d,'r')
datetick('x',6)
grid on
ylabel('u_w (m/s)')
subplot(212)
hold on
plot(WIND(:,1),windv2d,'r')
datetick('x',6)
grid on
ylabel('v_w (m/s)')
xlabel('mm/dd/2012')
% 

load windu2d
load windv2d
load winddir


%ip means 'input';
ip_windu2d=windu2d;
%ip_windu2d=windu2d*0.8;
ip_windv2d=windv2d;
%ip_windv2d=windv2d%*0.8;
ip_windspe=sqrt(ip_windu2d.^2+ip_windv2d.^2);
ip_ndata=2880;
wind_time_model=[0:ip_ndata-1]*360;
subplot(211)
hold on
plot(WIND(:,1),windu2d,'r')
datetick('x',6)
grid on
ylabel('u_w (m/s)')
subplot(212)
hold on
plot(WIND(:,1),windv2d,'r')
datetick('x',6)
grid on
ylabel('v_w (m/s)')
xlabel('mm/dd/2012')


fid = fopen('wind_lewes_mag1dot0.txt','w','n');
fprintf(fid,'%s\n','WIND');
fprintf(fid,'%5d\n',ip_ndata);
for  i = 1:ip_ndata
    fprintf(fid,'%10.2f %10.2f %10.2f\n',wind_time_model(i),ip_windu2d(i),ip_windv2d(i));
end
fclose(fid)

fid = fopen('kwind_lewes_mag1dot0.txt','w','n');
for i=1:ip_ndata
    if(ip_windspe(i)>5.6)
        k_wind(i)=1.2E-6+2.25E-6*(1-5.6/ip_windspe(i))^2;
    else
        k_wind(i)=1.2E-6;
    end
    fprintf(fid,'%10.4E\n',k_wind(i));
end
fclose(fid)

% wwind means weight of wind usually set as 0 or 1
% because dims are 90*160
wwindg(1:90,1:160)=1;
%save -ascii wwindg_lewes.txt wwindg








