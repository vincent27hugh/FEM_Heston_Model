global K r T sigma;
s_res=linspace(1,300,1000)';
s_res_exact=linspace(1,300,20)';
x_res=log((1/K)*s_res);
y_res=interp1(x,Nodes_v(:,length(tau_v)),x_res,'pchip');
[y_exact,~]=blsprice(s_res_exact,K,r,T,sigma);
figure;
plot(s_res,y_res,'r');
hold on
plot(s_res_exact,y_exact,'x');
xlabel('Stock Price');ylabel('Option Price');
legend('FEM Solution','Exact Solution');
title('European Call');