global K x tau_v
s_res=linspace(1,300,1000)';
x_res=log((1/K)*s_res);
y_res=interp1(x,Nodes_v(:,length(tau_v)),x_res,'pchip');
y_res_terminal=interp1(x,Nodes_v(:,1),x_res,'linear');
figure;
plot(s_res,y_res,'r','linewidth',2);
xlabel('Stock');ylabel('Option Price');title('American Put');
hold on
plot(s_res,y_res_terminal,'--b');
legend('initial','terminal');