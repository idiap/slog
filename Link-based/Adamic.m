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

function adam = Adamic(a, E, N)
    
       
       adam = zeros(N,1);
       
       children = E(E(:,1) == a, 2);
       candids  =  E(ismember(E(:,2), children),1);
       
       for i=1:size(candids,1),
           childreni = E(E(:,1) == candids(i),2);
           adam(candids(i)) = 0;
           inter = intersect(children, childreni);
           for j=1:length(inter), 
            adam(candids(i))= adam(candids(i))+   1/length(E(E(:,2) == inter(j), 1));
           end
       end
       
       
       
           
   


end