function [one_back,two_back,three_back]=amp_ratio(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [one_back,two_back,three_back]=amp_ratio(x,y)
% Calculates length ratio between i-th and i-nth saccade amplitude
%
% INPUT ARGUMENTS:
%   x:              column vector with the x-coordinate of the i-th fixation
%   y:              column vector with the y-coordinate of the i-th fixation
% OUTPUT ARGUMENTS:
%   one_back:       average one-back-amplitude ratio
%   two_back:       average two_back-amplitude ratio
%   three_back:     average three_back-amplitude ratio
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate average one-back-amplitude ratio
if size(x,1)>=3
    r_master=zeros(size(x,1)-2,1);
    for i=1:size(x,1)-2
        d_1=sqrt((x(i)-x(i+1))^2+(y(i)-y(i+1))^2);
        d_2=sqrt((x(i+1)-x(i+2))^2+(y(i+1)-y(i+2))^2);
        r_master(i)=d_1/d_2;
    end
    one_back=mean(r_master);
else
    one_back=1;
end

% calculate average two-back-amplitude ratio
if size(x,1)>=4
    r_master=zeros(size(x,1)-3,1);
    for i=1:size(x,1)-3
        d_1=sqrt((x(i)-x(i+1))^2+(y(i)-y(i+1))^2);
        d_2=sqrt((x(i+2)-x(i+3))^2+(y(i+2)-y(i+3))^2);
        r_master(i)=d_1/d_2;
    end
    two_back=mean(r_master);
else
    two_back=1;
end

% calculate average three-back-amplitude ratio
if size(x,1)>=5
    r_master=zeros(size(x,1)-4,1);
    for i=1:size(x,1)-4
        d_1=sqrt((x(i)-x(i+1))^2+(y(i)-y(i+1))^2);
        d_2=sqrt((x(i+3)-x(i+4))^2+(y(i+3)-y(i+4))^2);
        r_master(i)=d_1/d_2;
    end
    three_back=mean(r_master);
else
    three_back=1;
end

