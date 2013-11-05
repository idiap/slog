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

function [ A M ] = AdditiveSim_LowRank_SGD( Iter, X, Edges, A, M, lr, margin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


Enum = size(Edges,2);
error = 0;
errorval = 0;
step = Iter/100;

for it = 1:Iter,

    for ei=1:Enum,


        E = Edges{ei};
        Mi = M{ei};
        
        i = randi(size(E,1));

        x = X(E(i,1),:);
        y = X(E(i,2),:);
        z = randi(size(X,1));
        while(ismember(z,E(E(:,1)==E(i,1),2)))
            z = randi(size(X,1));
        end
        z = X(z,:);


        xA = x*A;
        yzA = (y-z)*A;
       
        xMi = x*Mi;
        yzMi = (y-z)*Mi;
        
        d = (xA*yzA')+(xMi*yzMi');

        if(d< margin)

            error = error +1;
            errorval = errorval+ (margin-d);
            Ga =  x'*yzA+(y-z)'*xA;
            A = A+ lr*Ga;
            
            Gmi =  x'*yzMi+(y-z)'*xMi;
            Mi = Mi+lr*Gmi;
            M{ei} = Mi;

        end












    end
    if rem(it, step) == 0,
            fprintf('error: %e errorval: %e\n', error/step, errorval/step);
            error = 0;
            errorval =0;
    end

end






































end











