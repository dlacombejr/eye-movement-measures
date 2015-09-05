function [nnd_avg]=nnd(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [nnd_avg]=nnd(x,y)
% Calculates average nearest-neighbor distance for a trial
%
% INPUT ARGUMENTS:
%   x:              column vector with the x-coordinate of the i-th fixation
%   y:              column vector with the y-coordinate of the i-th fixation
% OUTPUT ARGUMENTS:
%   nnd_avg:        average nearest-neighbor distance
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate average nearest-neighbor distance
nnd_master=zeros(size(x));
for i=1:size(x)
    d_master=inf(size(x));
    for j=1:size(x)
        if j~=i
        d_master(j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        end
    end
    nnd_master(i)=min(d_master);
end
nnd_avg=mean(nnd_master);