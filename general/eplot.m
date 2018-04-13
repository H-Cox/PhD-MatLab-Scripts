function [  ] = eplot( Y )
%eplot Input a table with three columns, X, Y, error on Y and it plots with
%error bars

if length(Y(1,:))==3

errorbar(Y(:,1),Y(:,2),Y(:,3));


elseif length(Y(1,:))==4
    
    errorbar(Y(:,1),Y(:,2),Y(:,3));
    plot(Y(:,1),Y(:,4));
    
else
    
    disp('input must have three or four columns');
    
end

end

