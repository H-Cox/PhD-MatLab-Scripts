function [varargout] = HenryMethod(varargin)

if length(varargin) > 1
    
    for k = 1:length(varargin)
        varargout{k} = HenryMethod(varargin{k});
    end
else
    data = varargin{1};
    data(data==0) = NaN;
    varargout{1} = data;
end

end