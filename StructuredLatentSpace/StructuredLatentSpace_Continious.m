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

function [ closest ] = StructuredLatentSpace_Continious( xi, A , X, lambda, p, B )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% matlab optimization settings

options = optimset('GradObj','on', 'Display','off');
options.TolFun = 1e-10;
options.TolX = 1e-10;
options.MaxIter = 1000;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


XA = X*A;
xiA = xi*A;


minw = zeros(size(xind));
minfval = 100000;

for b=1:B,
    
    w0 = rand(1, size(X,1));
    [f df] = NoneLinearLatentSpace(w0, XA, xiA, p , lambda);
    [w fval] = fmincon(@(w)NoneLinearLatentSpace(w, XA, xiA, p , lambda),w0,[],[],[],[],zeros(size(w0)),ones(size(w0)),[],options);
    %[w fval]= L1GeneralProjectedSubGradient(@(w)NoneLinearLatentSpace(w, wtopics, xP, p , lambda, normp),w0,lambda,options);

    if fval< minfval,
        minfval = fval;
        minw = w;
    end

end

w = minw;
closest = find(w);








end



function [f df] = NoneLinearLatentSpace(w, XA, xiA, p , lambda)

base = 0.001;
f1 =  sum(sum(repmat(w',1 , size(XA,2)).*XA .* repmat(xiA, size(XA,1),1)+base).^p);
f2 = norm(lambda .*w, 1);


f = -f1 +  f2;

df1 = p*(sum(repmat(w',1 , size(XA,2)).*XA .* repmat(xiX, size(XA,1),1)+ base).^(p-1));
df2 = sum(XA .* repmat(xiA, size(XA,1),1));
df3 = sum(df1 .* df2);
df4 = (abs(w)./w);
df4(w==0) = 0;

df = - df3+ lambda .* df4;



end


