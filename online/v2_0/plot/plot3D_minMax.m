function [] = plot3D_minMax(par)

x = par.holder(:,1);   
y = par.holder(:,2);
z = par.holder(:,3);

figure
plot3(x,y,z,'.')
[value, index] = sort(x);
y = y(index);
z = z(index);

c = linspace(1,10,length(x));

figure
scatter3(value,y,z,[],c,'.')
xlabel('x')

%%
x = par.holder(:,1);   
y = par.holder(:,2);
z = par.holder(:,4);
xlabel('x')
ylabel('y')
figure
plot3(x,y,z,'.')

y = y(index);
z = z(index);

c = linspace(1,10,length(x));

figure
scatter3(value,y,z,[],c,'.')
xlabel('x')


%%
x = par.holder(:,2);   
y = par.holder(:,3);
z = par.holder(:,4);

figure
plot3(x,y,z,'.')

end

