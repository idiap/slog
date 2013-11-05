% Copyright (c) 2013 Idiap Research Institute, http://www.idiap.ch/
% Written by Majid Yazdani <majid.yazdaani@gmail.com>,
% Majid Yazdani <majid.yazdaani@gmail.com>

% This file is part of SLOG.

% SLOG is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License version 3 as
% published by the Free Software Foundation.

% SLOG is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with SLOG. If not, see <http://www.gnu.org/licenses/>.

function [vals inds] = returnComm(VPs, tre, k)

        [thisvals thisinds]=sort(VPs,'descend');
        
        s=0;
        s2 = sum(thisvals);
        if s2 ==0,
            vals= thisvals(1);
            inds =thisinds(1);
            return;
        end
        ratio = s/s2;
        ii=1;
        while ratio < tre && ii < k,
  
            s= thisvals(ii)+s;
            ratio = s/s2;
            ii= ii+1;
            
        end
        
        vals = thisvals(1:ii);
        inds = thisinds(1:ii);
        

end