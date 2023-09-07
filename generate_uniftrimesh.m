function [coord,elem,dirich] = generate_uniftrimesh(N,dom,x,a,b,opt)

%time=tic;
c=@(x)[mod(x,N+1)  floor(x/(N+1))]/N;
coord=c((0:((N+1)^2-1))');

if strcmp(opt,'diagonal')
    coord=c((0:((N+1)^2-1))'); % Coordinates.
    I = ((N+1)*(0:(N-1))'+ (1:N))'; I = I(:);
    elem=kron(I,[1;1])+kron(ones(N^2,1),[0 1 N+2;0 N+2 N+1]); % Element indexing.
elseif strcmp(opt,'crisscross')
    h=1/(2*N); M=(N+1)^2; d=@(x)h+[mod(x,N) floor(x/N)]/N;
    coord=[c((0:((N+1)^2-1))'); d((0:(N^2-1))')];
    I = ((N+1)*(0:(N-1))'+ (1:N))'; I = I(:); J=(M+(1:N^2))';
    elem=[kron(J,[1;1;1;1]) kron(I,[1;1;1;1])+...
          kron(ones(N^2,1),[0 1; 1 N+2; N+2 N+1; N+1 0])]; % Element indexing.
end

%C = (coord(:,1) > 0 & coord(:,1) < 1 & coord(:,2) > 0 & coord(:,2) < 1);
%coord(C,:) = coord(C,:)+.05/N*(1-2*rand(sum(C),2));

dirich=(coord(:,1)==0) | (coord(:,1)==1) | (coord(:,2)==0) | (coord(:,2)==1);
%dirich = coord(:,2) == 0;

%elem=kron((1:(N+1)^2)',[1;1])+kron(ones((N+1)^2,1),[0 1 N+2;0 N+2 N+1]);
%elem=elem(mod(kron(1:(N*(N+1)),[1 1]),N+1)>0,:);
coord(:,1)=x(1)+a*coord(:,1); coord(:,2)=x(2)+b*coord(:,2);

end

