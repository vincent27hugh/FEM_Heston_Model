%%%Plot_EOp
global x K tau_v sigma
stock = K*exp(x);
time = T-tau_v*2/sigma^2;
mesh(time',stock(200:590),Nodes_v(200:590,:));view(3);

title('European Call');
ylabel('Stock Price');xlabel('Time');zlabel('Option Price');
