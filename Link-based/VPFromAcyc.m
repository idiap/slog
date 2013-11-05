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

%%%%%%%%%%%%%%%%%%% e-truncated VP from a -- Acyclic
function vp = VPFromAcyc(alpha,e, tr, N,a)

       VPpre = sparse(1,N);
       remain = ones(N,1);
       remain(a)=0;
       VPpre(a) = 1;
       remainIndex = find(remain>e);
       T =0;
       while ~isempty(remainIndex),
           VPnew = VPpre*tr*alpha;
           T=T+1;
           VPnew(a)=1;
           
           remain = alpha^T-(VPnew);
           

           remainIndex = find(remain>e);
           VPpre = VPnew;
       end
       %T
       vp = VPpre;
       

end