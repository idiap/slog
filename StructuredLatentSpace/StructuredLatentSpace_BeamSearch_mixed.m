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

function [ closest ] = StructuredLatentSpace_BeamSearch_mixed( xi, A , X,k, p,q ,a, B )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



%%%%%%%%%%%%%%%%% Greedy : BeamSearch
xiA = xi*A;
XA = X*A;


w = zeros(B,size(X,1));

gain = zeros(size(w));
pref = zeros(B,1);

thisRoundVal = 0;

thisRoundGain = w;
thisRound =w;

for kk=1:k,
    
    
    index = 1;
    if kk>1
        it = B;
    else
        it = 1;
    end
    for b=1:it,
       zeroElements = find(~w(b,:));
       wb = w(b,:);
       g= gain(b,:);
       pf = pref(b);
       for ii=1:length(zeroElements),
           el = zeroElements(ii);

           thisRound(index, :) = wb;
           thisRound(index, el)=1;
           
           [f ]=NoneLinearLatentSpaceEvalMixed( thisRound(index,:), XA, xiA, p, q, a);
           thisRoundVal(index) = f;
           
           thisRoundGain(index,:) = g;
           thisRoundGain(index, el) = f-pf;
           

           
           index = index +1;
           
       end
       
       
        
    end
   
    
   for b =1:B,
          
        [val ind] = max(thisRoundVal);
        
        w(b,:) = thisRound(ind,:);
        gain(b,:) = thisRoundGain(ind,:);
        thisRoundVal(ind)= min(thisRoundVal);
        pref(b) = val;
           
   end
   
    thisRoundVal = 0;
    thisRound = zeros(size(w));
    thisRoundGain = zeros(size(w));
       

end


maxval = 0;
maxw = 0;
maxgain=0;
for bb=1:B,
    val = NoneLinearLatentSpaceEvalMixed( w(bb,:),XA, xiA, p,q,a);
    if val > maxval,
        maxval = val;
        maxw = w(bb,:);
        maxgain = gain(bb,:);
    end
end

closest = find(maxw);










end


% function [f] = NoneLinearLatentSpaceEval(w , A, xi, p)
%     
%     f =    sum(sum(repmat(w',1 , size(A,2)).*A .* repmat(xi, size(A,1),1)).^p);
% 
% end

% function [f df] = NoneLinearLatentSpace(w, wtopics, xP, p , lambda)
% 
% base = 0.001;
% f1 =  sum(sum(repmat(w',1 , size(wtopics,2)).*wtopics .* repmat(xP, size(wtopics,1),1)+base).^p);
% f2 = norm(lambda .*w, 1);
% f1
% f2
% f = -f1 +  f2;
% 
% df1 = p*(sum(repmat(w',1 , size(wtopics,2)).*wtopics .* repmat(xP, size(wtopics,1),1)+ base).^(p-1));
% df2 = sum(wtopics .* repmat(xP, size(wtopics,1),1));
% df3 = sum(df1 .* df2);
% df4 = (abs(w)./w);
% df4(w==0) = 0;
% 
% df = - df3+ lambda .* df4;
% 
% 
% 
% end
% 
% 
 function [f] = NoneLinearLatentSpaceEvalMixed(w , XA, xiA, p,q, a)
 
     f =sum(nthroot(sum(repmat(w',1 , size(XA,2)).*XA .* repmat(xiA, size(XA,1),1)-a).^q, p));
 
 end
% 
% function [f df] = NoneLinearLatentSpaceMixed(w, wtopics, xP, p ,q, lambda, a)
% f1 = sum(nthroot(sum(repmat(w',1 , size(wtopics,2)).*wtopics .* repmat(xP, size(wtopics,1),1)-a).^q, p));
% f2 = norm(lambda .*w, 1);
% 
% 
% f = -f1+  f2;
% 
% df1 = (q/p)*(nthroot((sum(repmat(w',1 , size(wtopics,2)).*wtopics .* repmat(xP, size(wtopics,1),1) - a).^(q-p)), p));
% df2 = sum(wtopics .* repmat(xP, size(wtopics,1),1));
% df3 = sum(df1.*df2);
% df4 = (abs(w)./w);
% df4(w==0) = 0;
% 
% df = -df3 + lambda .* df4;
% 
% 
% 
% end

