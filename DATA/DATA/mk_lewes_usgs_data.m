clear all
clf

fid = fopen('inlet_nohead.txt','r');
%b = fscanf(fid,'%*s %*s %*s %*s %*s %g %*s');
%b = fscanf(fid,'%*s %*s %{yyyy-mm-dd}D %*s %*s %g %*s');
C=textscan(fid,'%s %s %s %s %s %f %s');
fclose(fid)

format long
for k=1:length(C{1})
year=str2num(C{3}{k}(1:4));
month(k)=str2num(C{3}{k}(6:7));
day(k)=str2num(C{3}{k}(9:10));
hour(k)=str2num(C{4}{k}(1:2));
min(k)=str2num(C{4}{k}(4:5));
time(k)=(month(k)-10.)*31.+day(k)+hour(k)/24.+min(k)/60./24.;
time(k)=time(k)-23.;
end
ele=C{6};
time=time';

data(:,1)=time+5./24.;
data(:,2)=(ele-0.78)*0.3048;
save -ASCII inlet.txt data
plot(time,ele)


clear all

fid = fopen('rosedale_nohead.txt','r');
C=textscan(fid,'%s %s %s %s %s %f %s');
fclose(fid)
for k=1:length(C{1})
year=str2num(C{3}{k}(1:4));
month(k)=str2num(C{3}{k}(6:7));
day(k)=str2num(C{3}{k}(9:10));
hour(k)=str2num(C{4}{k}(1:2));
min(k)=str2num(C{4}{k}(4:5));
time(k)=(month(k)-10.)*31.+day(k)+hour(k)/24.+min(k)/60./24.;
time(k)=time(k)-23.;
end
ele=C{6};
time=time';
plot(time,ele)
data(:,1)=time+5./24.;
data(:,2)=(ele-0.78)*0.3048;
save -ASCII rosedale.txt data

clear all

fid = fopen('dewey_nohead.txt','r');
C=textscan(fid,'%s %s %s %s %s %f %s');
fclose(fid)
for k=1:length(C{1})
year=str2num(C{3}{k}(1:4));
month(k)=str2num(C{3}{k}(6:7));
day(k)=str2num(C{3}{k}(9:10));
hour(k)=str2num(C{4}{k}(1:2));
min(k)=str2num(C{4}{k}(4:5));
time(k)=(month(k)-10.)*31.+day(k)+hour(k)/24.+min(k)/60./24.;
time(k)=time(k)-23.;
end
ele=C{6};
time=time';
plot(time,ele)
data(:,1)=time+5./24.;
data(:,2)=(ele-0.78)*0.3048;
save -ASCII dewey.txt data

clear all
fid = fopen('lewes_oct_23_nov_3.txt','r');
%b = fscanf(fid,'%*s %*s %g %*s %*s %*s %*s %*s %*s');
C=textscan(fid,'%s %s %f %s %f');
fclose(fid)
for k=1:length(C{1})
year=str2num(C{1}{k}(1:4));
month(k)=str2num(C{1}{k}(6:7));
day(k)=str2num(C{1}{k}(9:10));
hour(k)=str2num(C{2}{k}(1:2));
min(k)=str2num(C{2}{k}(4:5));
time(k)=(month(k)-10.)*31.+day(k)+hour(k)/24.+min(k)/60./24.;
time(k)=time(k)-23.;
end
ele=C{5};
time=time';
plot(time,ele)
data(:,1)=time;
data(:,2)=ele;
save -ASCII lewes.txt data

