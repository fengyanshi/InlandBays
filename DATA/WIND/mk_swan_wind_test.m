clear all



ip_windu2d=ones(1,10)*20*sqrt(2)/2;
ip_windv2d=ones(1,10)*20*sqrt(2)/2;


fid=fopen('fwind_test.dat','w','n');
fmt={'%10.2f ';'\n'};

sk=1;

for i=1:sk:10
    for j=1:160
        fprintf(fid,[fmt{[ones(1,90) 2]}],ip_windu2d(i)*[ones(1,90)]);
    end
    for j=1:160
        fprintf(fid,[fmt{[ones(1,90) 2]}],ip_windv2d(i)*[ones(1,90)]);
    end
end
fclose('all')







