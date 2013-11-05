function [vals inds]=topK(a,k)
    b = a;
    mn = min(a);
    
    for i=1:k
        [val ind]=max(b);
        vals(i) = val;
        inds(i) = ind;
        b(ind)=mn-1;
        mn = mn-1;
        
    end
    
    

end