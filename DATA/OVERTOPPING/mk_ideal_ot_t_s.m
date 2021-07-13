clear
t0=20.0;
T0=12.5;
q0=1.0;
eta0=1;


figure
subplot(211)
hold on
grid on
set(gca,'xlim',[t0-T0, t0+2*T0])
set(gca,'xtick',[t0-T0:T0/2:t0+2*T0])
set(gca,'xticklabel',{'','{t_0-0.5T_0}','t_0','t_0+0.5T_0','t_0+T_0','t_0+1.5T_0',''})
set(gca,'ylim',[0,2*q0])
set(gca,'ytick',[0:q0:2*q0])
set(gca,'yticklabel',{'0','q_0','2q_0'})
box on

t=[1:72];
f=0.5*q0*cos(2*pi*(t-t0)/T0)+0.5*q0;
f1=f;
f1(t>t0+T0/2)=0.0;
f1(t<t0-T0/2)=0.0;
f11=f1*2;

plot(t,f1,'r--','LineWidth',1.5)
plot(t,f11,'r--','LineWidth',1.5)

f2=f;
f2(t>t0+3*T0/2)=0.0;
f2(t<t0-T0/2)=0.0;
f21=f2*2;

plot(t,f2,'b','LineWidth',0.5)
plot(t,f21,'b','LineWidth',0.5)


text(t0,1.1*q0,'OV1')
text(t0,2.2*q0,'OV2')
text(t0+T0,1.1*q0,'OV3')
text(t0+T0,2.2*q0,'OV4')



subplot(212)
set(gca,'xlim',[t0-T0, t0+2*T0])
set(gca,'xtick',[t0-T0:T0/2:t0+2*T0])
set(gca,'xticklabel',{'','{t_0-0.5T_0}','t_0','t_0+0.5T_0','t_0+T_0','t_0+1.5T_0',''})
set(gca,'ylim',[-eta0 2*eta0])
set(gca,'ytick',[-eta0:eta0:2*eta0])
set(gca,'yticklabel',{'-\eta_0','0','\eta_0','2\eta_0'})
box on

hold on
grid on
eta1=eta0*cos(2*pi*(t-t0)/T0);
plot(t,eta1,'r')
eta2=eta0*cos(2*pi*(t-t0)/T0+pi);
plot(t,eta2,'b')

eta3=eta1+eta0;
plot(t,eta3,'r--','LineWidth',1.5)
eta4=eta1/2+3*eta0/2;
plot(t,eta4,'b--','LineWidth',1.5)

text(t0-1,1.1*eta0,'T1')
text(t0-1,-0.8*eta0,'T2')
text(t0-1,2.2*eta0,'TS1')
text(t0-1,1.5.*eta0,'TS2')