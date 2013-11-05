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


function [A ]= EmbedToLatentSpace_SGD_loss2(Iter, X, E, A, lr, margin1, margin2)


    error = 0;
    errorval = 0;
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
        x = normr(x);
        y = normr(y);
        z = normr(z);

        xA = x*A;
        yA = (y)*A;
        zA = z*A;

        d1 = xA*yA';
        d2 = xA*zA';


        if(d1< margin1)

            error = error +1;
            errorval = errorval+ (margin1-d1);
            Ga =  x'*yA + (y)'*xA;

            A = A+ lr*Ga;


        end

        if(d2> margin2)

            error = error +1;
            errorval = errorval+ (d2-margin2);
            Ga =  x'*zA+ (z)'*xA;

            A = A- lr*Ga;


        end


        if rem(it, step) == 0,
            fprintf('error: %e errorval: %e\n', error/step, errorval/step);
            error = 0;
            errorval =0;
        end






    end
    
    
end