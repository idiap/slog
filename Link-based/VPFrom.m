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

%%%%%%%%%%%%%%%%%%% e-truncated VP from a -- cyclic


function [vp T]= VPFrom(alpha,tr, N,e, a)

      
      VPs = zeros(N,1);
      remain = ones(N,1);
      remain(a)=0;
      remainIndex = find(remain>e);
      
      samples(1,1)= a;
      probs(1,1) = 1;
      T=0;
      while ~isempty(remainIndex),
          T=T+1;

          remain = remain*alpha;
          ind = 1;
          for j=1:size(samples,1),
              
            sample = samples(j,:);
            prob = probs(j);
            currentid = sample(end);
            children =find(tr(currentid, :)  )';
            if isempty(children)
                newsamples(ind,:) = [sample currentid];
                newprobs(ind) = prob*alpha;
                ind=ind+1;
                continue;
            end
            
            childrennum = length(children);

            newsamples(ind: ind+childrennum-1,:)=[repmat(sample,childrennum,1) children];
            newprobs(ind:ind+childrennum-1) = (prob*alpha)*ones(1,childrennum).* (tr(currentid,children));            
            ind = ind + childrennum;
            
            VPs(children) = VPs(children) + prob*alpha*(tr(currentid, children))';
            remain(children) = remain(children)-prob*alpha*(tr(currentid, children))';         
            
              
          end
          
          samples = newsamples;
          probs = newprobs;
          newprobs=[];
          newsamples = [];
          remainIndex = find(remain>e);

          
       end
       
       vp = VPs;
   
   


end
