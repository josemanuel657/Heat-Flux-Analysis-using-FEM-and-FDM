function T = Heat(n)
%% Creation of mesh and boundary conditions

F = @(x)zeros(size(x,1),1);
T_a = 10;
rho = 1.204;
c_p = 1.012;
kappa = 0.02435;
lambda = @(x)0.6*(x(1)<1/2)+2*(x(1)>1/2);
dt = .01;
theta = 0.5;
t_max = 20;

[coord,elem,dirich] = generate_uniftrimesh(n,1,[0 0],1,1,'crisscross');
[edge,~,~]=GetEdges(elem);
[D,NE,RE]=BoundaryConditions(coord,dirich,edge);
%figure(3), PlotMesh(coord,elem,edge)

T_total = t_max/dt;
N = size(coord,1);
h = 0;
M = zeros(9*size(elem,1),1);
S = zeros(9*size(elem,1),1);
R = sparse(N,N);
r = zeros(N,1);
f = zeros(N,1);

ind = elem';
cols_a = ind(kron(1:3,ones(1,3)),:); cols_a = cols_a(:);
rows_a = ind(kron(ones(1,3),1:3),:); rows_a = rows_a(:);

mat2vec = @(A) A(:);

areas=(coord(elem(:,1),1).*coord(elem(:,2),2)...
      -coord(elem(:,2),1).*coord(elem(:,1),2)...
      +coord(elem(:,2),1).*coord(elem(:,3),2)...
      -coord(elem(:,3),1).*coord(elem(:,2),2)...
      +coord(elem(:,3),1).*coord(elem(:,1),2)...
      -coord(elem(:,1),1).*coord(elem(:,3),2))/2;

Gx = [(coord(elem(:,2),2)-coord(elem(:,3),2))./(2*areas) ...
      (coord(elem(:,3),2)-coord(elem(:,1),2))./(2*areas) ...
      (coord(elem(:,1),2)-coord(elem(:,2),2))./(2*areas)];
Gy = [(coord(elem(:,3),1)-coord(elem(:,2),1))./(2*areas) ...
      (coord(elem(:,1),1)-coord(elem(:,3),1))./(2*areas) ...
      (coord(elem(:,2),1)-coord(elem(:,1),1))./(2*areas)];
barys = [coord(elem(:,1),1)+coord(elem(:,2),1)+coord(elem(:,3),1) ...
         coord(elem(:,1),2)+coord(elem(:,2),2)+coord(elem(:,3),2)]/3;

for E=1:size(elem,1)
    indices = elem(E,:);

    x = coord(elem(E,:),1); y = coord(elem(E,:),2);
    area = (x(1)*y(2)-x(2)*y(1)+x(2)*y(3)-x(3)*y(2)+x(3)*y(1)-x(1)*y(3))/2;
    G = [y(2)-y(3) x(3)-x(2); y(3)-y(1) x(1)-x(3); y(1)-y(2) x(2)-x(1)]/(2*area);
    h(E) = max(sqrt((x([2 3 1])-x).^2+(y([2 3 1])-y).^2));
    
    S(9*(E-1)+(1:9)) = mat2vec(localstiff(area,G));
    M(9*(E-1)+(1:9)) = mat2vec(localmass(area));
    f(indices) = f(indices) + area*F(coord(indices,:))/3;
end

Redges = 1:length(RE); Redges = Redges(RE);
for e = Redges
    indices = edge(e,:);
    le = sqrt((coord(edge(e,1),1)-coord(edge(e,2),1))^2+(coord(edge(e,1),2)-coord(edge(e,2),2))^2);
    R(indices,indices) = R(indices,indices) + le*lambda(coord(edge(e,1),:))*[1/3 1/6; 1/6 1/3];
    r (indices) = r(indices) + le*lambda(coord(edge(e,1),:))*[1;1]/2;
end

S = sparse(cols_a,rows_a,S,N,N);
M = sparse(cols_a,rows_a,M,N,N);

K = kappa*S + R;
b = T_a*r + f;

T = 5*coord(:,2);
FN = ~D;

for j=1:T_total
    T(D) = 0;
    
    T(FN) = (rho*c_p*M(FN,FN) + theta*dt*K(FN,FN))\((rho*c_p*M(FN,FN)-(1-theta)*dt*K(FN,FN))*T(FN)+dt*b(FN));
    Flux_x = -kappa*(T(elem(:,1)).*Gx(:,1)+T(elem(:,2)).*Gx(:,2)+T(elem(:,3)).*Gx(:,3))/3;
    Flux_y = -kappa*(T(elem(:,1)).*Gy(:,1)+T(elem(:,2)).*Gy(:,2)+T(elem(:,3)).*Gy(:,3))/3;
    figure(1)
    set(gcf,'Position', [400 100 500 500])



    trisurf(elem,coord(:,1),coord(:,2),T), axis([0 1 0 1 0 10]), view(0,90), colormap, shading interp, caxis([0 10]), title(strcat('t=',num2str(j*dt)),'interpreter','latex'), colormap('jet'),set(gca, 'FontSize', 20), xlabel('X Axis', 'interpreter','latex'), ylabel('Y Axis', 'interpreter','latex'),;
    %quiver(barys(:,1),barys(:,2),0.25*Flux_x./sqrt(Flux_x.^2+Flux_y.^2),0.25*Flux_y./sqrt(Flux_x.^2+Flux_y.^2)), axis([0 1 0 1]), title(strcat('t=',num2str(j*dt)),'interpreter','latex'), set(gca, 'FontSize', 20), xlabel('X Axis', 'interpreter','latex'), ylabel('Y Axis', 'interpreter','latex');
    pause(0.01)
    

    if j*dt == 10
        break
    end
end

end

