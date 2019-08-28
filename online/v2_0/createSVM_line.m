function [holderLabel] = createSVM_line(par,h)

holder = par.holder;


x1 = holder(:,1);
x2 = holder(:,2);

[x,y] = getpts(h);

a = (y(2)-y(1))/(x(2)-x(1));
b = y(1)-a*x(1);

w = [a,-1];

yPtr = y(2)-y(1);
xPtr = x(2)-x(1);

f_x2_min = a*min(x1)+b;
f_x2_max = a*max(x1)+b;

hold on
plot([0,xPtr], [b,yPtr+b],'or')
plot([min(x1) max(x1)],[f_x2_min f_x2_max],'-g')

valueSign = sign(w(1)*x1+w(2)*x2+b);

sum(valueSign(:) == -1)
sum(valueSign(:) == 1)

holderLabel = zeros(length(valueSign),1);
x1L_m = []; x2L_m = [];x1L_p = [];x2L_p = [];
for i = 1:length(valueSign)
    if valueSign(i) == -1
        x1L_m = [x1L_m x1(i)];
        x2L_m = [x2L_m x2(i)];
        holderLabel(i) = 0;
    else
        x1L_p = [x1L_p x1(i)];
        x2L_p = [x2L_p x2(i)];
        holderLabel(i) = 1;
    end
end

subplot(2,2,3)
plot(x1L_m,x2L_m,'*r')
hold on
plot(x1L_p,x2L_p,'*b')
plot([min(x1) max(x1)],[f_x2_min f_x2_max],'-b')
ylim([min(x1)-10 0])
ylim([min(x2)-10 0])

end

