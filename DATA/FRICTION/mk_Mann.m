Mann = zeros([90,160]) +0.016;
% make higher value in (20-80,30-35)
for i=1:40
for j=1:85
    if(isnan(dep(i,j)))
    else
        Mann(i,j)=0.018;
    end
end
end

for i=41:90
for j=1:85
    if(isnan(dep(i,j)))
    else
        Mann(i,j)=0.03;
    end
end
end

figure
pcolor(Mann),shading flat
colorbar


%save -ASCII Manning4.txt Mann % Manning4 -- Indian River Bay n=0.023; Rehoboth bay n=0.004; open water n=0.02
%save -ascii Manning5.txt Mann % Manning5 -- Indian River Bay n=0.02; Rehoboth bay n=0.01; open water n=0.018
%save -ascii Manning6.txt Mann % Manning6 -- Indian River Bay n=0.018; Rehoboth bay n=0.01; open water n=0.016
%save -ascii Manning7.txt Mann % Manning7 -- Indian River Bay n=0.018; Rehoboth bay n=0.008; open water n=0.016
%save -ascii Manning10.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.018; Rehoboth bay n=0.005; open water n=0.016
%save -ascii Manning11.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.018; Rehoboth bay n=0.01; open water n=0.016
%save -ascii Manning12.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.018; Rehoboth bay n=0.0025; open water n=0.016
%save -ascii Manning13.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.02; Rehoboth bay n=0.01; open water n=0.02
%save -ascii Manning14.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.02; Rehoboth bay n=0.01; open water n=0.04
%save -ascii Manning15.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.02; Rehoboth bay n=0.01; open water n=0.03
%save -ascii Manning16.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.02; Rehoboth bay n=0.015; open water n=0.028
%save -ascii Manning17.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.014; Rehoboth bay n=0.015; open water n=0.016
%save -ascii Manning18.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.018; Rehoboth bay n=0.02; open water n=0.016
%save -ascii Manning19.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.014; Rehoboth bay n=0.02; open water n=0.016
save -ascii Manning22.txt Mann % May, 2017. Manning10 -- Indian River Bay n=0.018; Rehoboth bay n=0.02; open water n=0.016