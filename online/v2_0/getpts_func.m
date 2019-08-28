clc
clear all
close all


number = 25;

x1 = rand(number,1);
x2 = rand(number,1);

figure
plot(x1,x2,'*')

xlim([0 max(x1)])
ylim([0 max(x2)])

[x,y] = getpts;

a = (y(2)-y(1))/(x(2)-x(1));
b = y(1)-a*x(1);

w = [a,-1];

yPtr = y(2)-y(1);
xPtr = x(2)-x(1);

f_x2_min = a*min(x1)+b;
f_x2_max = a*max(x1)+b;


%% a*x1-x2+b = 0 equation for the plane  


hold on
plot([0,xPtr], [b,yPtr+b],'or')
plot([min(x1) max(x1)],[f_x2_min f_x2_max],'-g')

valueSign = sign(w(1)*x1+w(2)*x2+b);

sum(valueSign(:) == -1)
sum(valueSign(:) == 1)

x1L_m = []; x2L_m = [];x1L_p = [];x2L_p = [];
for i = 1:length(valueSign)
    if valueSign(i) == -1
        x1L_m = [x1L_m x1(i)];
        x2L_m = [x2L_m x2(i)];
    else
        x1L_p = [x1L_p x1(i)];
        x2L_p = [x2L_p x2(i)];
    end
end

figure
plot(x1L_m,x2L_m,'*r')
hold on
plot(x1L_p,x2L_p,'*b')
plot([min(x1) max(x1)],[f_x2_min f_x2_max],'-b')


for i = 1:30
    x1_e = rand(1);
    x2_e = rand(1);
    valueSign_e = sign(w(1)*x1_e+w(2)*x2_e+b);
    if valueSign_e > 0
        plot(x1_e,x2_e,'.b','MarkerSize',20)
    else
        plot(x1_e,x2_e,'.r','MarkerSize',20)
    end
pause(1)    
end



