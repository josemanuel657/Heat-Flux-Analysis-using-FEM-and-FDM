function [DirichletNodes,NeumannEdges,RobinEdges]=BoundaryConditions(coord,dirich,edge)

J=1:length(dirich); I=J(dirich); L=zeros(length(dirich),2);

% \Gamma_D=[0,1]x{0}, \Gamma_N=[0,1]x{1}, \Gamma_R={0,1}x[0,1]

DirichletNodes = coord(:,2)==0;
NeumannEdges = sum([coord(edge(:,1),2)==1 coord(edge(:,2),2)==1],2) == 2;
RobinEdges = (sum([coord(edge(:,1),1)==0 coord(edge(:,2),1)==0],2) == 2) | ...
             (sum([coord(edge(:,1),1)==1 coord(edge(:,2),1)==1],2) == 2);


end

