%%main
  
clear
%%%%%%%%%%%%%%%%
SetOpPara;%%%%%%r=0.1; T=0.5; sigma=0.4; K=100;
SolveAP;
[Nodes_v,~]=GetNodes;
%%%%%%%%%%%%%%%%%%%%%
PlotEOP(Nodes_v);

