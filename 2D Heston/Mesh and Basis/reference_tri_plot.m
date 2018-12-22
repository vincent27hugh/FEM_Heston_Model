%%%reference_tri_plot.m
MS=26;DIS1=0.04;DIS2=0.06;
T=[1,2,3];
P=[0,0
   1,0
   0,1];
TR=triangulation(T,P);
FigHandle1=figure;
triplot(TR,'k','LineWidth',2);
axis off
set(FigHandle1, 'Position', [100, 100, 560, 420]);
hold on
h = plot(P(1,1),P(1,2),'o',P(2,1),P(2,2),'o',P(3,1),P(3,2),'o');
set(h(1),'MarkerEdgeColor','none','MarkerFaceColor','k','MarkerSize',MS);
set(h(2),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
set(h(3),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
plabel=[0,1,2]';
trilabels_P = arrayfun(@(P) {sprintf('%d',P)}, plabel);
text(P(:,1)+DIS2,P(:,2)+DIS1,trilabels_P,'FontWeight','bold', ...
'HorizontalAlignment','center','Color','black',...
'EdgeColor','black','BackgroundColor','white','FontSize',MS);
hold off


%%%2
FigHandle2=figure;
triplot(TR,'k','LineWidth',2);
axis off
set(FigHandle2, 'Position', [100, 100, 560, 420]);
hold on
h = plot(P(1,1),P(1,2),'o',P(2,1),P(2,2),'o',P(3,1),P(3,2),'o');
set(h(2),'MarkerEdgeColor','none','MarkerFaceColor','k','MarkerSize',MS);
set(h(1),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
set(h(3),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
plabel=[0,1,2]';
trilabels_P = arrayfun(@(P) {sprintf('%d',P)}, plabel);
text(P(:,1)+DIS2,P(:,2)+DIS1,trilabels_P,'FontWeight','bold', ...
'HorizontalAlignment','center','Color','black',...
'EdgeColor','black','BackgroundColor','white','FontSize',MS);
hold off

%%%3
figure
triplot(TR,'k','LineWidth',2);
axis off
hold on
h = plot(P(1,1),P(1,2),'o',P(2,1),P(2,2),'o',P(3,1),P(3,2),'o');
set(h(3),'MarkerEdgeColor','none','MarkerFaceColor','k','MarkerSize',MS);
set(h(1),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
set(h(2),'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',MS);
plabel=[0,1,2]';
trilabels_P = arrayfun(@(P) {sprintf('%d',P)}, plabel);
text(P(:,1)+DIS2,P(:,2)+DIS1,trilabels_P,'FontWeight','bold', ...
'HorizontalAlignment','center','Color','black',...
'EdgeColor','black','BackgroundColor','white','FontSize',MS);
hold off