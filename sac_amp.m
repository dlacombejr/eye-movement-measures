function [sac_master]=sac_amp(n_sac,sac_min,sac_max,sac_indices,sac_xy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [fix_master]=fix_dur(n_sac,fix_min,fix_max,fix_indices,fix_durs)
% Generates sac_master matrix
%
% INPUT ARGUMENTS:
% OUTPUT ARGUMENTS:
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sac_master=zeros(n_sac,1);
s_count=1;
for s=sac_min:sac_max
    s_index=find(sac_indices==s);
    if isempty(s_index)
        continue
    else
        x_current=sac_xy(s_index,1);
        y_current=sac_xy(s_index,2);
        [q, r]=size(x_current);
        if q==r
            continue
        else
            sac_master(s_count,1)=sqrt((x_current(r)-x_current(q))^2 + (y_current(r)-y_current(q))^2);
        end
    end
    s_count=s_count+1;
end
empty_sac=sac_master==0;
sac_master(empty_sac)=[];
