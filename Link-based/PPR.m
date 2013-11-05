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


function ppr = PPR(alpha,T, tr, N, a)

    preppr = sparse(1 , N);
    preppr(a)=1;
    avector = preppr;
    newppr = sparse(1 , N);

    for t=1:T,
        newppr = preppr*tr*alpha+ avector*(1-alpha);
        preppr = newppr;    
    end

    ppr = newppr;


end
