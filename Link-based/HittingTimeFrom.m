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


%%%%%%%%%%%%%%%%%%%%%% T-tructaed Hitting time from a --- Monte carlo

function h = HittingTimeFrom(a,T,tr,N,samplenum)


       
       Hs = sparse(N,1);
       
       for i=1:samplenum,
           
          j=1;
          currentid = a;
          samples= zeros(1,T);
          samples(j) = currentid;
          Hs(currentid) = Hs(currentid) + (j-1)*1;
          for j=2:T,
            
            
            children =find(tr(currentid, :)  );
            if isempty(children),
                break;
            end
            r = rand;
            s = 0;
            for kk=1:length(children),
                s = s+ tr(currentid,children(kk));
                if(s>r)
                    choosen = children(kk);
                    break;
                end
            end
            
            
            currentid = choosen;
            if ~ismember(choosen, samples),
                
                 Hs(currentid) = Hs(currentid) + (j-1)*1;
            end
            
            samples(j) = choosen;
            
              
          end
          newHs = Hs+T;
          
          newHs(samples(samples>0)) = Hs(samples(samples>0)); 
          Hs = newHs;
          
          
       end
       h= Hs/samplenum;
      
       
       


end