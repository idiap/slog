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

function [vals inds T] = returnClosest(alpha,tr,N,e,a,tre,k)



%%%%%%%%%%%%%%%%%%%%% To
VPtopre = zeros(N,1);
remainto = ones(size(content,1),1);
remainto(a)=0;
VPtopre(a) = 1;

%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% From

VPfroms = zeros(N,1);
remainfrom = ones(N,1);
remainfrom(a)=0;

samples(1,1)= a;
probs(1,1) = 1;
%%%%%%%%%%%%%%%%%%% From

T=0;

while 1,
    
    T = T+1;
    
    %%%%%%%%%%%%% To
    VPtonew = tr*VPtopre*alpha;
    VPtonew(a)=1;
    remainto = remainto*alpha-(VPtonew-VPtopre);
    VPtopre = VPtonew;
    
    %%%%%%%%%%%%% To
    
           
           
    %%%%%%%%%%%%%%%%%%%% From cyclic       
    remainfrom = remainfrom*alpha;
    ind = 1;
    for j=1:size(samples,1),
        sample = samples(j,:);
        prob = probs(j);
        currentid = sample(end);
        children = find(tr(currentid,:))';
        childrennum = length(children);
        if childrennum ==0,
            newsamples(ind,:) = [sample currentid];
            newprobs(ind) = prob*alpha;
            ind=ind+1;
            continue;
         end
            
         
         childrennum = length(children);

         newsamples(ind: ind+childrennum-1,:)=[repmat(sample,childrennum,1) children];
         newprobs(ind:ind+childrennum-1) = (prob*alpha)*ones(1,childrennum).* (tr(currentid,children));            
         ind = ind + childrennum;
            
         VPfroms(children) = VPfroms(children) + prob*alpha*(tr(currentid, children))';
         remainfrom(children) = remainfrom(children)-prob*alpha*(tr(currentid, children))';      
            
            
            
            
              
    end
    samples = newsamples;
    probs = newprobs;
    newprobs=[];
    newsamples = [];
    
    
          
    %%%%%%%%%%%%%%%%%%%% From
    
    %%%%%%%%%%%%%%%%%%%% K closest
    
    VPs = VPfroms + VPtopre;
    
    newVPs = VPs;
    newVPs(a)=0;
    
    
    remains = remainto+ remainfrom;
    upperbounds = remains*alpha+newVPs;
    upperbounds(a)=0;
    
    %mx = max(upperbounds);
    %mn = min(newVPs);
    %uuperbounds = (upperbounds-mn)/(mx-mn);
    %newVPs = (newVPs-mn)/(mx-mn);
   [thisvals thisinds]=sort(newVPs,'descend');
   
  
   
%    s1= thisvals(1:k)-2*upperbounds(thisinds(2:k+1))+thisvals(3:k+2);
%    s2= upperbounds(thisinds(1:k))-2*thisvals(2:k+1)+upperbounds(thisinds(3:k+2));
% 
%    
%    
%    s = max(s1,-s2);
%    
   
   
   
%    ii=1; 
%    diff = upperbounds(thisinds(1:k))-thisvals(2:k+1);
%     less = find(diff < tre);
%     if ~isempty(less),
%         
%         vals = thisvals(1:less(1));
%         inds = thisinds(1:less(1));
%         T
%         return
%     end
            
            
   
        

   

%s
%s
% sindex = find(s>tre);
% 
% if ~isempty(sindex) %&& thisvals(s(1))>tre
%         vals = thisvals(1:sindex(1));
%         inds = thisinds(1:sindex(1));
%         return;
%         
%         
% end
s = 0;
s2 = sum(upperbounds(1:k));
if sum(thisvals(1:k))/s2 > tre,
    for ii=1:k,
        s= s+ thisvals(ii);
        if s/s2>tre,
            vals = thisvals(1:ii);
            inds = thisinds(1:ii);
            return; 
        end
    end
end
if isempty(find(remains*alpha>e, 1)),
    s2 = sum(thisvals(1:k));
    if(s2 == 0)

        vals = thisvals(1:1);
        inds = thisinds(1:1);
        return; 
    end
    for ii=1:k,
        s= s+ thisvals(ii);
        if s/s2>tre,
            vals = thisvals(1:ii);
            inds = thisinds(1:ii);
            return; 
        end
    end

end  
    
end

end