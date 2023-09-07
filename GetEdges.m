function [edge,elem2edge,edge2elem]=GetEdges(elem)

L = length(elem(:,1)); e = cell(2,1);

%time=tic;
%tic
%% Edges and elements (with repetitions)
e{1}=elem'; e{2}=elem(:,[2 3 1])';
edge=[e{1}(:) e{2}(:)];
E=[elem 3*(1:L)'-[2 1 0]];
%toc
%fprintf('Parte 1 con repeticiones: %2.4f seconds.\n',toc(time))

%time=tic;
%% Identifying repeated edges and getting edges with no repetitions
EE=sin(edge(:,1))+sin(edge(:,2));
[~,b,c]=unique(EE,'stable');
elem2edge=c(E(:,4:6));
edge=edge(b,:);
%fprintf('Parte 2 sin repeticiones: %2.4f seconds.\n',toc(time))

% time=tic;
% %% Edge --> Element
edge2elem=zeros(length(edge),2);
for K=1:length(elem(:,1))
    I=elem2edge(K,:);
    edge2elem(I(1),:)=[K 0]*(edge2elem(I(1),1)==0)+[edge2elem(I(1),1) K]*(edge2elem(I(1),1)>0);
    edge2elem(I(2),:)=[K 0]*(edge2elem(I(2),1)==0)+[edge2elem(I(2),1) K]*(edge2elem(I(2),1)>0);
    edge2elem(I(3),:)=[K 0]*(edge2elem(I(3),1)==0)+[edge2elem(I(3),1) K]*(edge2elem(I(3),1)>0);
end
% fprintf('Parte 3, edge2elem: %2.4f seconds.\n',toc(time))

%  eedge2elem=zeros(length(edge),3);
%  J=(1:length(elem))';
%  eedge2elem(elem2edge(:,1),1)=J; eedge2elem(elem2edge(:,2),2)=J; eedge2elem(elem2edge(:,3),3)=J;
%  eedge2elem=maxk(eedge2elem,2,2);
%  
 
% 
%  rows=elem'; rows=rows(:); cols=elem(:,[2 3 1])'; cols=cols(:);
% rows=elem'; rows=rows(:); cols=elem(:,[2 3 1])'; cols=cols(:);
% A=sparse(rows,cols,1:length(rows),length(rows),length(rows))

%% Connectivity matrix
% time=tic;
% vertex2edge(N*(edge(:,2)-1)+edge(:,1))=1:length(edge); vertex2edge=vertex2edge-vertex2edge';
% fprintf('Parte 4, vertex2edge: %2.4f seconds.\n',toc(time))
% time=tic;
% conn(vertex2edge>0)=1; conn(vertex2edge<0)=-1;
% fprintf('Parte 5, connectivity matrix: %2.4f seconds.\n',toc(time))
%% Orientations

% time=tic;
% 
% aux=zeros(length(edge(:,1)),1);
% for e=1:length(elem2edge(:,1))
%     orient(e,:)=aux(elem2edge(e,:),:);
%     aux(elem2edge(e,:))=aux(elem2edge(e,:))+1;
% end
% orient=logical(orient);
% 
% fprintf('Parte 6, orientacion: %2.4f seconds.\n',toc(time))





end