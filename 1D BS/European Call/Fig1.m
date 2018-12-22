global K;
s_res=linspace(1,300,1000)';
x_res=log((1/K)*s_res);
y_res=interp1(x,Nodes_v(:,length(tau_v)),x_res,'pchip');
y_res_terminal=interp1(x,Nodes_v(:,1),x_res,'linear');
figure;
plot(s_res,y_res,'r','linewidth',1);
xlabel('Stock Price');ylabel('Option Price');title('European Call');
hold on
plot(s_res,y_res_terminal,'b');
legend('Initial','Terminal');