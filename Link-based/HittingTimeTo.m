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

%%%%%%%%%%%%%%%%%%%%%% T-truncated Hitting time to a
function h = HittingTimeTo(T, a ,tr, N)
   
       
       
       Hpre = sparse(N,1);
       
       
       for t=1:T,
           Hnew = 1+ tr*Hpre;
           Hnew(a)=0;
           Hpre = Hnew;
       end
       
       h = Hpre;
  

end