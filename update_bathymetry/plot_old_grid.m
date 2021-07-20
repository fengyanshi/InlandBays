clear all
dep=load('dep_162x90.txt');
x=load('x_164x92.txt');
x=x(1:end-2,1:end-2)';
y=load('y_164x92.txt');
y=y(1:end-2,1:end-2)';

pcolor(x,y,-dep),shading flat
hold on


