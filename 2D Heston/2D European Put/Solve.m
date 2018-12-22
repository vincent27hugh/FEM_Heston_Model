%%20160427 Set_temp.m
function VW=Solve(K,eta)
global M N ymin ymax vmin vmax T NT 
global dtau r q
global v y
tic


[v,y]=ndgrid((vmin:(vmax-vmin)/N:vmax),(ymin:(ymax-ymin)/M:ymax)); 
tau=linspace(0,T,NT);
Points=[v(:),y(:)]; 

TKn=[1,2,N+2;N+3,N+2,2]; 
TKn=kron(TKn,ones(N,1))+kron(ones(size(TKn)),(0:N-1)');
TKn=kron(TKn,ones(M,1))+kron(ones(size(TKn)),(0:M-1)'*(N+1));


global Boundary
Boundary1=(1:N+1)';% bottom
Boundary2=(N+2:N+1:(N+1)*(M-1)+1)';% left, 
Boundary3=(2*(N+1):N+1:(N+1)*M)';%right
Boundary4=((N+1)*M+1:(N+1)*(M+1))';%top
Boundary=[Boundary1;Boundary2;Boundary3;Boundary4];


global Nodesn Nodesc Nodesf FreePoint 

Nodesn=size(Points,1);
Nodesc=size(Boundary,1);
Nodesf=size(Points,1)-Nodesc;


FreePoint=(1:Nodesn)';%Inner Points
for i = 1:Nodesc
    FreePoint=FreePoint(FreePoint~=Boundary(i));
end


Trianglen=size(TKn,1);


MS=sparse(Nodesf,Nodesf); 
MMf=sparse(Nodesf,Nodesf);
MMc=sparse(Nodesf,Nodesc);
MP=sparse(Nodesf,Nodesc);

bar1=waitbar(0,'Process1:Please Wait...');

for i = 1:Trianglen
    str1=['Process1:Please Wait...',num2str(floor(100*i/Trianglen)),'%'];
    waitbar(i/Trianglen,bar1,str1)
    
    NodesIndex=TKn(i,:); 
    [flag,FCIndex]=isboundary(NodesIndex);type=(1:3);
        %%%flag(i)=1,point is on the boundary
        %%%FCIndex is the index of point in Freepoint set or Boundary set
        %%%type is the index in the Sij&Mij
        
    Indexc=FCIndex.*flag;typec=type'.*flag;  
    Indexc=Indexc(Indexc~=0);
    typec=typec(typec~=0);
        
    flag2=ones(3,1)-flag;  
    Indexf=FCIndex.*flag2;typef=type'.*flag2;  
    Indexf=Indexf(Indexf~=0);
    typef=typef(typef~=0);
       
    Pi=Points(NodesIndex,:); 
        % 2 by 3 matrix with 
        % [v0 y0
        %  v1 y1
        %  v2 y2]
    P1 = fun_P1(Pi);
    P2 = fun_P2(Pi);
    P3 = fun_P3(Pi);
    
    Sij=-P1/2-P2/2+(1/dtau-r/2)*P3;
    Mij=P1/2+P2/2+(1/dtau+r/2)*P3;
    if isempty(Indexf)==0  
        IndexI=reshape(repmat(Indexf,1,size(Indexf,1)),1,[]);
        IndexJ=reshape(repmat(Indexf',size(Indexf,1),1),1,[]);
        ValueK=reshape(Sij(typef,typef),1,[]);
        tempMS=sparse(IndexI,IndexJ,ValueK,Nodesf,Nodesf);
        MS=MS+tempMS;
        clear IndexI IndexJ ValueK tempMS
            
        IndexI=reshape(repmat(Indexf,1,size(Indexf,1)),1,[]);
        IndexJ=reshape(repmat(Indexf',size(Indexf,1),1),1,[]);
        ValueK=reshape(Mij(typef,typef),1,[]);
        tempMS=sparse(IndexI,IndexJ,ValueK,Nodesf,Nodesf);
        MMf=MMf+tempMS;
        clear IndexI IndexJ ValueK tempMS
        
        if isempty(Indexc)==0
            IndexI=reshape(repmat(Indexf,1,size(Indexc,1)),1,[]);
            IndexJ=reshape(repmat(Indexc',size(Indexf,1),1),1,[]);
            ValueK=reshape(Sij(typef,typec),1,[]);
            tempMS=sparse(IndexI,IndexJ,ValueK,Nodesf,Nodesc);
            MP=MP+tempMS;
            clear IndexI IndexJ ValueK tempMS
            
            IndexI=reshape(repmat(Indexf,1,size(Indexc,1)),1,[]);
            IndexJ=reshape(repmat(Indexc',size(Indexf,1),1),1,[]);
            ValueK=reshape(Mij(typef,typec),1,[]);
            tempMS=sparse(IndexI,IndexJ,ValueK,Nodesf,Nodesc);
            MMc=MMc+tempMS;
            clear IndexI IndexJ ValueK tempMS
        end 
    end
end
close(bar1);

%%%Initial Condition
VW=zeros(Nodesn,1);
VU=zeros(Nodesf,1);VG=zeros(Nodesc,1);
NVG=zeros(Nodesc,1);
VW(:)=max(eta*(K*exp(Points(:,2))-K*ones(Nodesn,1)),0);
VU(:)=VW(FreePoint);
VG(:)=VW(Boundary);

bar2=waitbar(0,'Process2:Please Wait...');
for j = 1:NT-1
    str2=['Process1:Please Wait...',num2str(floor(100*j/(NT-1))),'%'];
    waitbar(j/(NT-1),bar2,str2)
    
    %%Boundary Condition
    b1=size(Boundary1,1);b2=b1+size(Boundary2,1);
    b3=b2+size(Boundary3,1);b4=b3+size(Boundary4,1);
    
    tempvg1=eta*(K*exp(ymin-q*tau(j+1))-K*exp(-r*tau(j+1)));
    NVG(1:b1)=0.5*(1-eta)*max(0,tempvg1);%bottom,ymin
    
    tempvg2=K*exp(Points(Boundary2,2)-q*tau(j+1))-K*exp(-r*tau(j+1));
    NVG(b1+1:b2)=max(0,eta*(tempvg2));%left,vmin
    
    tempvg3=Points(Boundary3,2)-q*tau(j+1);
    NVG(b2+1:b3)=0.5*(1+eta)*K*exp(tempvg3)+...
        0.5*(1-eta)*K*exp(-r*tau(j+1));%right,vmax
    
    tempvg4=eta*(K*exp(ymax-q*tau(j+1))-K*exp(-r*tau(j+1)));
    NVG(b3+1:b4)=0.5*(1+eta)*max(0,tempvg4);%top,ymax
    
    %%%%%%%
    VU(:)=MMf\(MS*VU(:)+MP*VG(:)-MMc*NVG(:));
    %%%%%%
    VG(:)=NVG(:); 
end
VW(FreePoint)=VU(:);
VW(Boundary)=VG(:);
toc

close(bar2);
return

function [flag,Index]=isboundary(NodesIndex)
global  Boundary  FreePoint
flag=zeros(3,1);Index=zeros(3,1);
for j=1:3
    [Indextempj,~]=find(Boundary==NodesIndex(j));
    if isempty(Indextempj)==0
        flag(j)=1;
        Index(j)=Indextempj;
    end
    [Indextempk,~]=find(FreePoint==NodesIndex(j));
    if isempty(Indextempk)==0
        flag(j)=0;
        Index(j)=Indextempk;
    end
end

return

%%%P1
function P1 = fun_P1(Pi)
global ksi rho
temp = [-1,-1;1,0;0,1];
J=Pi'*temp;
Ghat=[-1,1,0;-1,0,1];
vbar=sum(Pi(:,1))/3;
cmA=0.5*[ksi^2,rho*ksi;rho*ksi,1];
Abar = vbar*cmA;
P1=0.5*abs(det(J))*Ghat'*inv(J)*Abar*inv(J')*Ghat;
return

%P2
function P2 = fun_P2(Pi)
global ksi rho theta r q kappa
temp = [-1,-1;1,0;0,1];
J=Pi'*temp;
Ghat=[-1,1,0;-1,0,1];
vbar=sum(Pi(:,1))/3;
bbar= [ksi^2/2-kappa*(theta-vbar);0.5*(vbar+rho*ksi)-(r-q)];
P2 = abs(det(J))*ones(3,1)*bbar'*inv(J')*Ghat/6;
return

%P2
function P3 = fun_P3(Pi)
temp = [-1,-1;1,0;0,1];
J=Pi'*temp;
temp2 = [2,1,1;1,2,1;1,1,2];
P3 = abs(det(J))*temp2/24;
return