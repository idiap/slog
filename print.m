function out=print(varargin)

    varargin(2:end)=cellfun(@full,varargin(2:end),'uni',0);

    if nargout
      out=builtin('fprintf',varargin{:});
    else
      builtin('fprintf',varargin{:});
    end

end