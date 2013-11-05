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

function [ A B]= EmbedToLatentSpaceDirected_SGD_WithoutFeatures(Iter, E, A,B, lr, margin)

    
    

error = 0;
errorval = 0;
step = Iter/100;
N = max(max(E(:,1)),max(E(:,2)) );

for it = 1:Iter,
    
    i = randi(size(E,1));
    
    x = A(E(i,1),:);
    y = B(E(i,2),:);
     z = randi(N);
        
    while(ismember(z,E(E(:,1)==E(i,1),2)))
        z = randi(N);
    end
    xz = B(z,:);
    
    yz = (y-xz);
    
    d = x*yz';
    
    if(d< margin)
        
        error = error +1;
        errorval = errorval+ (margin-d);
        
         A(E(i,1),:) = A(E(i,1),:)+lr*yz;
         B(E(i,2),:) = B(E(i,2),:)+lr*x;
         B(z,:) = B(z,:)-lr*x;
        
        
    end
    
    if rem(it, step) == 0,
        fprintf('error: %e errorval: %e\n', error/step, errorval/step);
        error = 0;
        errorval =0;
    end
    
    
    
end
    
end