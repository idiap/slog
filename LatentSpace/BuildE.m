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


function E = BuildTrainingEdges( matrix, Tre,type)
   
   E = [];
   it=1;
   for a=1:size(matrix,1),
       
       connected = [];
       vector = matrix(a,:);
       
       vector(a)=0;
       [val ind]= sort(vector,'descend');
       if(val(1)==0)
           continue;
       end
       if type ==1,
            % approach: percentage
            totalsum= sum(val(1:50));
            s = 0;
            counter = 1;
            
            while(s/totalsum < Tre),
                s = s+val(counter);
                counter = counter+1;
            end
    
            connected = ind(1: counter-1);
   
       end
       
       if type == 2,
           connected = ind(1:Tre);
       end
       
       if type == 3,
            vector= vector/(max(vector)-mn);
            [val ind]= sort(vector,'descend');
            totalsum= sum(val);
            s = 0;
            counter = 1;
            
            while(s/totalsum < Tre),
                s = s+val(counter);
                counter = counter+1;
            end
    
            connected = ind(1: counter-1);
           
       end
       
       
       for i=1:length(connected),
           E(it,1) = a;
           E(it,2) = connected(i);
           it= it+1;
       end
       
   end


   
end