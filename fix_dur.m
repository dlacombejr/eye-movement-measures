function [fix_master]=fix_dur(n_fix,fix_min,fix_max,fix_indices,fix_durs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [fix_master]=fix_dur(n_fix,fix_min,fix_max,fix_indices,fix_durs)
% Generates fix_master matrix
%
% INPUT ARGUMENTS:
% OUTPUT ARGUMENTS:
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize fix_master at zero with length of n_fix
fix_master=zeros(n_fix,1);

f_count=1;
for f=fix_min:fix_max
    f_index=find(fix_indices==f);
    if isempty(f_index)
        continue
    else
        fix_master(f_count,1)=unique(fix_durs(f_index));
    end
    f_count=f_count+1;
end
empty_fix=fix_master==0;
fix_master(empty_fix)=[];
