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

function [M  w] = NeighborAwareRanker_Diag(Iter, X, E, M,w, lr, margin,alpha)


error = 0;
errorval = 0;

step = Iter/100;

for it =1: Iter,

    
        i = randi(size(E,1));
        f = E(i,1);
        s = E(i,2);
        x = X(f,:);
        y = X(s,:);
        t = randi(size(X,1));
        while(ismember(t,E(E(:,1)==f,2)))
            t = randi(size(X,1));
        end
        z = X(t,:);

        

        
        out = E(E(:,1)==s , 2);
        in = E(E(:,2) == s , 1);

        infriend=0;
        for jj=1:length(in),
            infriend = ismember([f in(jj)] , E,'rows')+ infriend;

        end
        infriend = infriend/length(in);
        if(isempty(in))
            infriend = 0;
        end
        outfriend=0;
        for jj=1:length(out),
            outfriend = ismember([f out(jj)] , E,'rows')+ outfriend;

        end
        outfriend = outfriend/length(out);

        if(isempty(out))
            outfriend = 0;
        end
        fy = [infriend outfriend];

        out = E(E(:,1)==t , 2);
        in = E(E(:,2) == t , 1);
        infriend=0;

        for jj=1:length(in),
            infriend = ismember([f in(jj)] , E,'rows')+ infriend;

        end
        infriend = infriend/length(in);
        if(isempty(in))
            infriend = 0;
        end
        outfriend=0;
        for jj=1:length(out),
            outfriend = ismember([f out(jj)] , E,'rows')+ outfriend;

        end
        outfriend = outfriend/length(out);
        if(isempty(out))
            outfriend = 0;
        end
        fz = [infriend outfriend];
        fy = alpha*fy;
        fz = alpha*fz;
        
        sim1 = (x.*M)*y';
        d1 = sim1 + w*fy';
        
        sim2 = (x.*M)*z';
        d2 = sim2 + w*fz';
        
        d = (d1-d2);
        
        if(d < margin),

            
          error = error+1;
          errorval = errorval+(margin-d);
          
          
          Ga = (x.*(y-z));
          M = M+lr*Ga; 
          
          
          w = w+ lr*(fy- fz);
          
          
         M(M>1) = 1;
         M(M<-1) = -1;
         
         w(w>1) =1;
         w(w<-1) = -1;
          
        end
        




    

     if rem(it, step) == 0,
            fprintf('error: %e errorval: %e\n', error/step, errorval/step);
            error = 0;
            errorval =0;
     end
 


end

end

         

