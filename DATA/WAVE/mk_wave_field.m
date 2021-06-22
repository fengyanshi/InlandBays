clear all
wave=load('wave_sandy.txt');
% time
nhour=length(wave); % 12 days
%wave=zeros(nhour,5);
%wave(:,1)=[0:nhour-1];
tmp_time=[0:nhour-1];
wave_time=datenum('October 23, 2012 00:00:00.000 AM')+tmp_time/24.;
wave_date=datevec(wave_time);
for k=1:length(wave_date)
   nyear=int2str(wave_date(k,1));
     if wave_date(k,2)<10
    nmonth=['0' int2str(wave_date(k,2))];
   else
    nmonth=int2str(wave_date(k,2));      
     end
      if wave_date(k,3)<10
    ndate=['0' int2str(wave_date(k,3))];
   else
    ndate=int2str(wave_date(k,3))      ;
      end
     if wave_date(k,4)<10
    nhour=['0' int2str(wave_date(k,4))];
   else
    nhour=int2str(wave_date(k,4))      ;
     end
     if wave_date(k,5)<10
    nminute=['0' int2str(wave_date(k,5))];
   else
    nminute=int2str(wave_date(k,5))      ;
     end
     yeartime(k,:)=[nyear nmonth ndate '.' nhour nminute '00'];
end


%plot(wind_date,wind(:,2));
wave_height=wave(:,10);
wave_period=wave(:,12);
wave_angle=270.0-wave(:,16);
wave_spread=wave(:,17);

for k=1:length(wave)
   yt=yeartime(k,1:15);
   hh=num2str(wave_height(k),'%3.1f');
    if wave_period(k)<10
        wp=num2str(wave_period(k),'%3.2f');
    else
   wp=num2str(wave_period(k),'%3.1f');
    end
   wa=num2str(wave_angle(k),'%3.1f');
   if wave_spread(k) < 10
       ws=num2str(wave_spread(k),'%3.2f');
   else
   ws=num2str(wave_spread(k),'%3.1f');
   end
   tot=[yt ' ' hh ' ' wp ' ' wa ' ' ws];
   wavenew(k,1:length(tot))=tot;
end

fid=fopen('wave_field.txt','w','n');
fprintf(fid,'%s\n','TPAR')
for k=1:length(wavenew)
fprintf(fid, '%s\n', strtrim(wavenew(k,:)));
%fprintf(fid, '%s\n', wavenew(k,:));
end
fclose(fid);


figure(1)
set(gcf,'units','inches','paperunits','inches','papersize', [10 5],'position',[1 1 10 5]);
start_time='2012,10,23';
end_time='2012,11,03';
subplot(311)
plot(wave_time,wave_height)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) 0 6.5])
grid
ylabel('Hmo (m)')


subplot(312)
plot(wave_time,wave_period)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) 0 20])
grid
ylabel('Peak Period (s)')

subplot(313)
plot(wave_time,wave_angle)
datetick('x',6)
axis([datenum(start_time) datenum(end_time) 100 220])
grid
ylabel('wave angle (deg)')
xlabel('mm/dd/2012')

break

%z_model=load('outputz.out');

%   model.z=z_model(:,2:19);
 %  model.time=datenum('June 19, 2005  0:00:00.000 AM')+z_model(:,1)/3600./24.;
%save('model_z_n.mat','model');
