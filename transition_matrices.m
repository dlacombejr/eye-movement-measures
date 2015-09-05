function [transition]=transition_matrices(x,y,n,roi_array)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [master]=roi_matrices_partsep(x,y,roi_array,participant)
% Generates a master transition/markov/successor matrix for each
% participant separately given the rois read in.
%
% INPUT ARGUMENTS:
%   x:      column vector with the x-coordiante of the i-th fixation
%   y:      column vector with the y-coordiante of the i-th fixation
%   n:          number of rois
%   roi_array:      nx4 matrix, where n is equal to the number of rois
% OUTPUT ARGUMENTS:
%   master: an nxn matrix that represents the probability of transitioning
%   from the i-th to the j-th position in the search array
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% identity matrix
I=eye(n,n);

% return error if the x and y vectors are not the same length
if size(x)~=size(y)
    error('x and y vector lengths are unequal')
end

% initialize transition matrix at zero
transition=zeros(n,n);

% calculate transition matrix
for m=1:size(x,1)-1
    % create index for roi in which current and subsequent fixation land
    i=find(roi_array(:,1)<=x(m)& x(m)<=roi_array(:,2) & roi_array(:,3)>=y(m) & y(m)>=roi_array(:,4));
    j=find(roi_array(:,1)<=x(m+1) & x(m+1)<=roi_array(:,2) & roi_array(:,3)>=y(m+1) & y(m+1)>=roi_array(:,4));
    
    % randomly choose roi if fixation falls on the border of two rois
    if size(i,1)>=2
        r=randi(size(i,1));
        i=i(r);
    end
    
    if size(j,1)>=2
        r=randi(size(i,1));
        j=j(r);
    end
    
    % transition matrix
    transition(:,i)=transition(:,i)+I(:,j);
    
end

% markov matrix
s=sum(transition);
s=repmat(s,n,1);
divide_index=transition==0;
s(divide_index)=1;
transition=transition./s;
end



