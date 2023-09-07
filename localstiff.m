function S = localstiff(area,G)

D{1} = G(:,1)*[1 1 1];
D{2} = G(:,2)*[1 1 1];

I = area/12*[2 1 1;1 2 1;1 1 2];

S = D{1}*I*D{1}'+D{2}*I*D{2}';

end

