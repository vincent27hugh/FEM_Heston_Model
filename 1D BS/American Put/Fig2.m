global K r T sigma;
s_res=linspace(1,300,1000)';
s_res_exact=linspace(1,300,20)';
x_res=log((1/K)*s_res);
y_res=interp1(x,Nodes_v(:,length(tau_v)),x_res,'pchip');
[~,y_exact]=blsprice(s_res_exact,K,0.2,T,sigma);
figure;
plot(s_res,y_res,'r','linewidth',2);
hold on
plot(s_res_exact,y_exact,'--x');
xlabel('Stock');ylabel('Option Price');
legend('FEM Solution','Exact Solution of EP');
title('American Put');