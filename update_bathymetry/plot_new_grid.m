clear all
dep=load('dep_196x140.txt');
x=load('x_add_bethany.txt');
x=x(1:end-2,1:end-1)';
y=load('y_add_bethany.txt');
y=y(1:end-2,1:end-1)';

pcolor(x,y,-dep),shading flat
hold on


