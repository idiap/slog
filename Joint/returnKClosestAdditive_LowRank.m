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

function [ closest  ] = returnKClosestAdditive_LowRank( xi, ei, X, A,M, K)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


Mi = M{ei};

xiA = (xi*A);
XA = X*A;

xiMi = xi*Mi;
XMi = X*Mi;

d = xiA*XA' + xiMi*XMi';

[val ind]= sort(d, 'descend');
closest = ind(1:K);



end
