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

%%%%%%%%%%%%%%%%%%%%% T-truncated VP to all
function VP = VisitingProbability(alpha,T, tr, N)
   

    VP = sparse(N,N);
    
    for a = 1: size(trans,1),

           VPpre = sparse(N,1);



           VPpre(a) = 1;
           for t=1:T,
               VPnew = tr*VPpre*alpha;
               VPnew(a)=1;
               VPpre = VPnew;
           end

           VP(:,a) = VPpre;
    end


end
