function [out]=RQAvarpar(x, y,d_p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%     [rqa_data]=rqa_all_participants_v2(participant, trial, practice, p_a, n_collumns, correct, x, y)
%   Calculates RQA measures recurrence, determinism, laminarity, and CORM.
%
% INPUT ARGUMENTS:
%   x:              column vector with the x-coordinate of the i-th fixation
%   y:              column vector with the y-coordinate of the i-th fixation
%
% OUTPUT ARGUMENTS:
%   rqa_data:       num_part*num_trials x nargout matrix
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert(size(x,1)>=size(x,2), 'fixation vector must be collumnar not horizontal')

% create rqa_matrix the size of n_fixations x n_fixations
rqa_matrix=zeros(size(x,1),size(x,1));

% generate recurrence plot
for j=1:size(x,1)
    for i=1:size(x,1);
        d=sqrt((x(j)-x(i))^2 + (y(j)-y(i))^2);
        if d<=d_p
            rqa_matrix(i,j)=1;
        else
            rqa_matrix(i,j)=0;
        end
    end
end

% compute number of diagonal lines
count_diagonal=0;
for j=2:size(x,1)-1
    for i=1:j-1
        if rqa_matrix(i,j)==1
            index=rqa_matrix(i+1,j+1);
            if index==1
                count_diagonal=count_diagonal+1;
            else
                count_diagonal=count_diagonal+0;
            end
        end
    end
end

% compute number of vertical lines
count_vertical=0;
for j=3:size(x,1)
    for i=1:j-2
        if rqa_matrix(i,j)==1
            index=rqa_matrix(i+1,j);
            if index==1
                count_vertical=count_vertical+1;
            else
                count_vertical=count_vertical+0;
            end
        end
    end
end

% compute number of horizontal lines
count_horizontal=0;
for j=2:size(x,1)-1
    for i=1:j-1
        if rqa_matrix(i,j)==1
            index=rqa_matrix(i,j+1);
            if index==1
                count_horizontal=count_horizontal+1;
            else
                count_horizontal=count_horizontal+0;
            end
        end
    end
end

% compute center of recurrence mass
corm_sum=0;
for j=2:size(x,1)
    for i=1:j-1
        if rqa_matrix(i,j)==1
            corm_sum=corm_sum+(j-i);
        else
            corm_sum=corm_sum+0;
        end
    end
end


% compute R (frequency of recurrent fixations in recurrence plot)
R=0;
for j=2:size(x,1)
    for i=1:j-1
        if rqa_matrix(i,j)==1
            R=R+1;
        else
            R=R+0;
        end
    end
end

REC=100*((2*R)/(size(x,1)*(size(x,1)-1)));

% compute RQA measures
if R==0
    DET=0;
    LAM=0;
    CORM=0;
else
    DET=100*(count_diagonal/(R));
    LAM=100*((count_vertical+count_horizontal)/(2*R));
    CORM=100*((corm_sum)/((size(x,1)-1)*(R)));
end

% output RQA values
% output RQA values
out.R=R;
out.REC=REC;
out.DET=DET;
out.LAM=LAM;
out.CORM=CORM;
% out.SIZE=SIZE;
% out.RET=RET;
% out.LORC=LORC;
out.rqa_matrix=rqa_matrix;


