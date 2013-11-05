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


%%%%%%%%%%%%%%%%%%%%%% Make the transformation matrix


function T = makeTransformationMatrix( E, N)

   T = sparse(E(:,1) , E(:,2), E(:,3), N, N );
   s = sum(T, 2);
   
   T = bsxfun(@times, T, 1./(sum(T, 2)));
   T(s==0,:)=0;
   zeroind = find(s==0);
   for ii=1:length(zeroind),
       T(zeroind(ii), zeroind(ii))=1;
   end
   
   
   
end