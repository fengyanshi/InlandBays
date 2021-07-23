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
pc=[abs(p_in_max),abs(p_out_max)];
p_max=max(pc,[],2);

p_in_min=data(1:n_end,8);
p_out_min=data(1:n_end,9);
pc=[abs(p_in_min),abs(p_out_min)];
p_min=min(pc,[],2);

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
%plot(A,p_avg,'ko');

% poly
poly_avg_fit=polyfit(A,p_avg,4);
poly_avg=polyval(poly_avg_fit,A);
%plot(A,poly_avg,'k-','LineWidth',2);

poly_max_fit=polyfit(A,p_max,4);
poly_max=polyval(poly_max_fit,A);
poly_min_fit=polyfit(A,p_min,4);
poly_min=polyval(poly_min_fit,A);

plot(A,poly_max,'b--','LineWidth',2);
plot(A,poly_max+poly_max*0.1,'b-','LineWidth',2);
plot(A,poly_min,'r--','LineWidth',2);
%plot(A,poly_min+poly_min*0.1,'r-','LineWidth',2);

% data
%Year={'1974','1979','1984','1986','1994','1999','now'};
%Year={'1975','1976','1978','1979','1981','1985','1986','1988','2004'};
%A_year(1)=9000.0; % 1975 
%A_year(2)=11500.0; % 1976 interp
%A_year(3)=16900.0; % 1978, IRI_CTH  12500.0 (figure)
%A_year(4)=17410.0; % 1979 interp
%A_year(5)=18430.0; % 1981
%A_year(6)=20470; % 1985 interp
%A_year(7)=20980.0; % 1986 interp
%A_year(8)=22000.0; % 1988, IRI_CTH
%A_year(9)=30000.0; % 2004, guess
%A_year(10)=32500.0; % now 

Year={'1975','1976','1978','1979','1981','1985','1986','1988','2004'};
A_year(1)=14125; % 1975 IRI_CTH: 1*(16900-13200)/4+13200
A_year(2)=15050; % 1976 interp 2*(16900-13200)/4+13200
A_year(3)=16900.0; % 1978, IRI_CTH, but  12500.0 (figure)
A_year(4)=17410.0; % 1979 1*(22000-16900)/10+16900
A_year(5)=18430.0; % 1981 3*(22000-16900)/10+16900
A_year(6)=20470; % 1985 7*(22000-16900)/10+16900
A_year(7)=20980.0; % 1986 interp
A_year(8)=22000.0; % 1988, IRI_CTH
A_year(9)=27928; % 2004, 541  or 0.5*(200+541)*16+22000 
%A_year(10)=32500.0; % now 

P_year_f(1)=1100.0;
P_year_f(2)=1125.0;
P_year_f(3)=1250.0;
P_year_f(4)=1300.0;
P_year_f(5)=1550.0;
P_year_f(6)=1640.0;
P_year_f(7)=1800.0;
P_year_f(8)=1850.0;
P_year_f(9)=2293.0;
%P_year_f(10)=2500.0;

P_year_e(1)=-850.0;
P_year_e(2)=-860.0;
P_year_e(3)=-1000.0;
P_year_e(4)=-1010.0;
P_year_e(5)=-1250.0;
P_year_e(6)=-1355.0;
P_year_e(7)=-1500.0;
P_year_e(8)=-1510.0;
P_year_e(9)=-1682.0;
%P_year_e(10)=-2500.0;

P_year=0.5*(abs(P_year_f)+abs(P_year_e));

for k=1:length(A_year)
plot(A_year(k),P_year(k),'r>','MarkerSize',10)
plot([A_year(k) A_year(k)],[0 10000],'k--')
%if k==3 || k==6
%text(A_year(k)-500,P_year(k)+50,Year(k));
%else
text(A_year(k)+600,P_year(k),Year(k));
%end
end

plot([34445 34445], [0 10000],'k--')
text(34445,550,'present')

xlabel('Inlet Sectional Area (ft^2)')
ylabel('Prism (million ft^3)')
legend('Model Spring Tide','Model Neap Tide','Poly-fit Spring Tide', '10 % Exceedance Spring Tide','Poly-fit Ebb Tide','Location','NorthWest')
axis([5000 40000 500 2300])
print -djpeg100 prism_area_data.jpg


