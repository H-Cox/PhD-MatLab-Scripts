
    figure
    hold on
    for i = 1
        plot(xnm,ynm,'.','MarkerSize',1)
        %plot(xnm1,ynm1,'.','MarkerSize',1)
       
        %plot(Images(i).dataAF(:,1),Images(i).dataAF(:,2),'.','MarkerSize',1)
        hold on
        %plot(Images(i).dataCY(:,1),Images(i).dataCY(:,2),'.','MarkerSize',1)
        hold on
        for j = 1:length(Images(i).xy(:))
            hold on
            plot(Images(i).xy_nm{j}(1,:),Images(i).xy_nm{j}(2,:),'b','LineWidth',1)
        end
        axis equal
        %for j = 1:length(Images2(i).xy(:))
        %    hold on
        %    plot(Images2(i).xy_nm{j}(1,:),Images2(i).xy_nm{j}(2,:),'g','LineWidth',1)
       %end
       % for j = 1:length(Images3(i).xy(:))
       %     hold on
        %    plot(Images3(i).xy_nm{j}(1,:),Images3(i).xy_nm{j}(2,:),'r','LineWidth',1)
       % end
    end
