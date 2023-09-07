function PlotMesh(coord,elem,edge)

    patch('Faces',elem,'Vertices',coord,'FaceColor','w');
    %axis([min(coord(:,1))-0.04 max(coord(:,1))+0.04 min(coord(:,2))-0.04 max(coord(:,2))+0.04])
       axis([min(coord(:,1)) max(coord(:,1)) min(coord(:,2)) max(coord(:,2))])
    if ~isempty(elem)
        for l = 1 : length(elem(:,1))
            ss=sum(coord(elem(l,:),:))/length(elem(l,:));
            text(ss(1),ss(2),num2str(l),'BackgroundColor',[.2 .99 .3],...
                                              'Margin',0.25,'FontSize',6);
        end
    end
        for l = 1 : length(coord(:,1))
            text ( coord(l,1), coord(l,2) , num2str(l),'BackgroundColor',[0 .7 0],...
                                               'Margin',0.25,'FontSize',6);
        end
    if ~isempty(edge)
        for l = 1 : length(edge(:,1))
            ss=sum(coord(edge(l,:),:))/2;
            text(ss(1),ss(2),num2str(l),'BackgroundColor',[.1 .85 .2],...
                                              'Margin',0.25,'FontSize',6);
        end
    end
end
