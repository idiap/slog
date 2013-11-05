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


function [vals inds T] = returnClosestAcyc(alpha,E,N,e,a,tre,k)

trans = sparse(E(:,1) , E(:,2), E(:,3), N,N );
trans = bsxfun(@times, trans, 1./(sum(trans, 2)));
trans(isnan(trans))=0;

%%%%%%%%%%%%%%%%%%%%% To
VPtopre = zeros(N,1);
remainto = ones(N,1);
remainto(a)=0;
VPtopre(a) = 1;

%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% From
VPfrompre =  zeros(N,1)';

%%%%%%%%%%%%%%%%%%% From
T=0;
while 1,
    T = T+1;
    
    %%%%%%%%%%%%% To
    VPtonew = trans*VPtopre*alpha;
    VPtonew(a)=1;
    remainto = remainto*alpha-(VPtonew-VPtopre);
    VPtopre = VPtonew;
    
    %%%%%%%%%%%%% To
    
    
    %%%%%%%%%%%% From Acyclic
    
    
     VPfroms = VPfrompre*trans*alpha;
     VPfroms(a)=1;
           
     remainfrom = alpha^T-(VPfroms);
     VPfrompre = VPfroms;
           
           
    %%%%%%%%%%%%%%%%%%%% From cyclic       
%     remainfrom = remainfrom*alpha;
%     ind = 1;
%     for j=1:size(samples,1),
%         sample = samples(j,:);
%         prob = probs(j);
%         currentid = sample(end);
%         childrennum = index(currentid,2);
%         if childrennum ==0,
%             newsamples(ind,:) = [sample currentid];
%             newprobs(ind) = prob*alpha;
%             ind=ind+1;
%             continue;
%          end
%             
%          children = ed(ed(:,1)==currentid,2);
%          newsamples(ind: ind+childrennum-1,:)=[repmat(sample,childrennum,1) children];
%          newprobs(ind:ind+childrennum-1) = prob*(1/childrennum)*alpha*ones(1,childrennum);            
%          ind = ind + childrennum;
%                         
%          for c=1:length(children),
%             child = children(c);
%                 
%             if ~ismember(child,sample),
%                 VPfroms(child) = VPfroms(child) + prob*(1/childrennum)*alpha;
%                 remainfrom(child) = remainfrom(child)-prob*(1/childrennum)*alpha;
%             end
%          end
%             
%             
%             
%             
%               
%     end
%     samples = newsamples;
%     probs = newprobs;
%     newprobs=[];
%     newsamples = [];
%     
%     
%           
    %%%%%%%%%%%%%%%%%%%% From
    
    %%%%%%%%%%%%%%%%%%%% K closest
    
    VPs = VPfroms' + VPtopre;
    
    newVPs = VPs;
    newVPs(a)=0;
    newVPs(trainpos)=0;
    remains = remainto+ remainfrom';
    upperbounds = remains*alpha+newVPs;
    upperbounds(a)=0;
    upperbounds(trainpos)=0;
     [thisvals thisinds]=sort(newVPs,'descend');
    if isempty(find(remains>e, 1)),
        s=0;
        s2 = sum(thisvals);
        if s2 ==0,
            vals= thisvals(1);
            inds =thisinds(1);
            return;
        end
        ratio = s/s2;
        ii=1;
        while ratio < tre && ii < k,
            s= thisvals(ii)+s;
            ratio = s/s2;
            ii= ii+1;
            
        end
        
        vals = thisvals(1:ii);
        inds = thisinds(1:ii);
        return;
    
    end
    
    if sum(thisvals(1:k))/sum(upperbounds) > c
        s=0;
        s2 = sum(upperbounds);
        ratio = s/s2;
        ii=1;
        while ratio < tre && ii < k,
            s= thisvals(ii)+s;
            ratio = s/s2;
            ii= ii+1;
            
        end
        
        vals = thisvals(1:ii);
        inds = thisinds(1:ii);
        return;
        
        
    end
    
    
    %%%%%%%%%%%%%%%%%%%% K closest
    
    
    
end

end
