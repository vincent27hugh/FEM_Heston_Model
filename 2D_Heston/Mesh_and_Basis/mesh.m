function mesh
clear all
%Spatial Resolution
N=5;M=6;

vmin=0.0;vmax=3;
ymin=-2;ymax=2;

[v,y]=ndgrid((vmin:(vmax-vmin)/N:vmax),(ymin:(ymax-ymin)/M:ymax)); 
Points=[v(:),y(:)]; 

TKn=[1,2,N+2;N+3,N+2,2]; 
TKn=kron(TKn,ones(N,1))+kron(ones(size(TKn)),(0:N-1)');
TKn=kron(TKn,ones(M,1))+kron(ones(size(TKn)),(0:M-1)'*(N+1));


%%%get the Points and TKn from "Solve.m"
TR=triangulation(TKn,Points);
%%%%%
FigHandle1 = figure;
triplot(TR);
xlabel('Var','FontSize',12);
ylabel('log(S/K)','FontSize',12);
axis off;
set(FigHandle1, 'Position', [100, 100, 560, 420]);
boundaryedges_TR = freeBoundary(TR)';
hold on
plot(Points(boundaryedges_TR,1),Points(boundaryedges_TR,2),'-r','LineWidth',2);
hold off

IC_TR = incenter(TR);
hold on
numtri_TR = size(TR,1);
trilabels_TR = arrayfun(@(P) {sprintf('T%d', P)}, (1:numtri_TR)');
 text(IC_TR(:,1),IC_TR(:,2),trilabels_TR,'FontWeight','bold', ...
'HorizontalAlignment','center','Color','blue','FontSize',12);
hold off


%%%%
FigHandle2=figure
triplot(TR);
xlabel('Var','FontSize',12);
ylabel('log(S/K)','FontSize',12);
axis off
set(FigHandle2, 'Position', [100, 100, 560, 420]);
boundaryedges_TR = freeBoundary(TR)';
hold on
plot(Points(boundaryedges_TR,1),Points(boundaryedges_TR,2),'-r','LineWidth',2);
hold off


hold on
numtri_P = size(Points,1);
trilabels_P = arrayfun(@(P) {sprintf('D%d', P)}, (1:numtri_P)');
text(Points(:,1)*1.01,Points(:,2)*1.01,trilabels_P,'FontWeight','bold', ...
'HorizontalAlignment','center','Color','red','EdgeColor','red',...
'BackgroundColor','white','FontSize',12);
hold off


