clear all
close all
data1=load('prism_all_ft.txt');
% sort
[Asorted,I]=sort(data1(:,2));
[k1 k2]=size(data1);
data=data1;
for k=2:k2
da=data1(:,k);
data(:,k)=da(I);
end

n_end=20;
p_in_max=data(1:n_end,6);
p_out_max=data(1:n_end,7);
p_max=0.5*(abs(p_in_max)+abs(p_out_max));

p_in_min=data(1:n_end,8);
p_out_min=data(1:n_end,9);
p_min=0.5*(abs(p_in_min)+abs(p_out_min));

p_in_avg=data(1:n_end,3);
p_out_avg=data(1:n_end,4);
p_avg=0.5*(abs(p_in_avg)+abs(p_out_avg));

A=data(1:n_end,2)*10.7639;


h=figure(1);
clf
wid=6;
len=8.0;
set(h,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);
plot(A,p_in_max,'bo');
hold on
plot(A,p_in_min,'bx');
plot(A,p_out_max,'ro');
plot(A,p_out_min,'rx');
grid
xlabel('Inlet Sectional Area (ft^2)')
ylabel('Incoming/Outgoing Flows through Inlet (million ft^3)')
axis([5000 50000 -2300 2300])
legend('Maximum','Minimum','Average')
print -djpeg100 incoming_outgoing.jpg

h=figure(2);
clf
wid=6;
len=8.0;
set(h,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);
plot(A,p_max,'bo');
hold on
plot(A,p_min,'ro');
plot(A,p_avg,'ko');

poly_avg_fit=polyfit(A,p_avg,4);
poly_avg=polyval(poly_avg_fit,A);
%plot(A,poly_avg,'k-','LineWidth',2);

poly_max_fit=polyfit(A,p_max,4);
poly_max=polyval(poly_max_fit,A);
plot(A,poly_max,'b--','LineWidth',2);

poly_min_fit=polyfit(A,p_min,4);
poly_min=polyval(poly_min_fit,A);
plot(A,poly_min,'r--','LineWidth',2);

P = [800:200:1800]*10^6;
A_OBrien = 2.0*10^(-5)*P;
A_Nayak = 4.17*10^(-4)*P.^(0.85);
A_Stive = 2.0*10^(-4)*P.^(0.90);

plot(A_OBrien,P*10^(-6),'k>','MarkerSize',12)
plot(A_Nayak,P*10^(-6),'kd','MarkerSize',12)
plot(A_Stive,P*10^(-6),'ksq','MarkerSize',12)

plot([34445 34445], [0 10000],'k--')
text(34445,550,'present')

xlabel('Inlet Sectional Area (ft^2)')
ylabel('Prism (million ft^3)')
grid
legend('Model Maximum','Model Minimum','Model Average','Poly-fit Spring Tide','Poly-fit Neap Tide','O`Brien 1969','Nayak 1971','Johnson, 1972','Location','NorthWest' )

axis([5000 41500 500 2300])
print -djpeg100 prism_area_formula.jpg


