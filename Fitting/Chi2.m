function [chisquared] = Chi2(experimental,error,fitted)

difference = experimental - fitted;

chisquared = nansum((difference./HenryMethod(error)).^2);

end