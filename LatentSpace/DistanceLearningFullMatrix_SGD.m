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


function [ M ]= DistanceLearningFullMatrix_SGD(Iter, X, E, M, lr, margin )


    error = 0;
    errorval = 0;

    %M = rand(size(X,2), size(X,2));

    step = Iter/100;

    for it = 1:Iter,

        i = randi(size(E,1));

        x = X(E(i,1),:);
        y = X(E(i,2),:);
        z = randi(size(X,1));
        while(ismember(z,E(E(:,1)==E(i,1),2)))
            z = randi(size(X,1));
        end
        z = X(z,:);

        

        xM = x*M;
        yz = (y-z);

        d = xM*yz';

        if(d< margin)

            error = error +1;
            errorval = errorval+ (margin-d);
            Gm = x'*yz;

            M = M+ lr*Gm;


        end

        if rem(it, step) == 0,
            fprintf('error: %e errorval: %e\n', error/step, errorval/step);
            error = 0;
            errorval =0;
        end






    end
end
