%%%Plot_E Op
function PlotEOP(Nodes_v)
global x K tau_v sigma T
stock = K*exp(x);
time = T-tau_v*2/sigma^2;
figure;
mesh(time',stock(200:590),Nodes_v(200:590,:));
AZ =122;EL = 30;
view(AZ,EL);
title('European Put');
ylabel('Stock Price');xlabel('Time');zlabel('Option Price');
