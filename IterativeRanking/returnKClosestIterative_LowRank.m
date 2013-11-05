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

function [ closest] = returnKClosestIterative_LowRank(maxIter, E,N,  i,xi, X, A,w,Alocal, K,c,alpha) %frac
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here




   T = sparse(E(:,1),E(:,2),1, N,N);

   invT = sparse(E(:,2),E(:,1),1, N, N);
   

   
   trainind = E(E(:,1) == i, 2);
   preD = zeros(1,size(X,1));
   XAlocal = X*Alocal;
   XA = X*A;
   d = (xi*Alocal)*XAlocal';
   
   mx = max(d);
   mn = min(d);

   if mx == mn
       preD = zeros(1,size(X,1));
   else
       preD = (d-mn)/(mx-mn); 
   end
   
   preD(preD(i,:)<=c) = 0;
   
   preD(preD(i,:)>c) = d(preD(i,:)>c);
   
   preD(trainind) = 1;
   
   
   
    
    it=1;
    
    
        
    sim = (xi*A)*XA';
    
    for counter=1:maxIter,
        
        
        
        fr = zeros(size(X,1),2);
        
        it = it+1;
    

        fr(:,1) = preD*T;
        fr(:,2) = preD*invT;

        fri = w*fr';
        fri = alpha*fri;
        d = sim+fri;
        
        mx = max(d);
        mn = min(d);
        
        if (mx-mn) == 0
            zeros(1,size(X,1));
        else
            preD = (d-mn)/(mx-mn); 
        end
        
       
        preD(preD(i,:)<= c) = 0;
        preD( preD(i,:)>c) = d(preD(i,:)>c);
        preD(trainind) = 1;
        
        d(i) = 0;
        d(trainind) = 0;
        
        
        [val ind] = sort(d,'descend');
        closest = ind(1:K);
            

    
    end
    
    
end



