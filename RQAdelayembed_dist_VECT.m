function [out]=RQAdelayembed_dist_VECT(x, y, delay)
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

%define parameters
w=size(x,1)-(delay-1);

% determine whether fixation sequences exceeds minimum 
if length(x) <= delay
    out.R=1;
    out.REC=100;
    out.DET=100;
    out.LAM=100;
    out.CORM=100;
    out.SIZE=1;
    out.RET=100;
    out.LORC=100;
    out.rqa_matrix=1;
    return;
end

% create rqa_matrix the size of n_fixations x n_fixations (-4 for window)
% rqa_matrix=zeros(w,w);

% % generate recurrence plot
% for j=1:w
%     for i=1:w;
%         X=[x(j:j+(delay-1)),y(j:j+(delay-1))];
%         mu=[x(i:i+(delay-1)),y(i:i+(delay-1))];
%         distance=norm(X-mu);
%         rqa_matrix(i,j)=distance;
% %         if distance <= d
% %             rqa_matrix(i,j)=1;
% %         end
%     end
% end
m = delay; tau = 1;
N = length(y);
N2 = N - tau * (m - 1);
clear xe
for mi = 1:m;
    xe(:, mi) = y([1:N2] + tau * (mi-1));
end
x1 = repmat(xe, N2, 1);
x2 = reshape(repmat(xe(:), 1, N2)', N2 * N2, m);
S = sqrt(sum( (x1 - x2) .^ 2, 2 ));
rqa_matrix = reshape(S, N2, N2);

% normalize recurrence plot
maximum=max(max(rqa_matrix));
rqa_matrix=rqa_matrix./maximum;

% compute number of diagonal lines
count_diagonal=0;
for j=2:w-1
    for i=1:j-1
        count_diagonal=count_diagonal+(rqa_matrix(i,j)*rqa_matrix(i+1,j+1));
    end
end

% % compute number of vertical lines
% count_vertical=0;
% for j=3:w
%     for i=1:j-2
%         count_vertical=count_vertical+(rqa_matrix(i,j)*rqa_matrix(i+1,j));
%     end
% end

% compute number of horizontal lines
count_horizontal=0;
for j=2:w-1
    for i=1:j-1
        count_horizontal=count_horizontal+(rqa_matrix(i,j)*rqa_matrix(i,j+1));
    end
end

% compute center of recurrence mass
corm_sum=0;
for j=2:w
    for i=1:j-1
        corm_sum=corm_sum+((j-i)*rqa_matrix(i,j));
    end
end

% compute size of rqa matrix
rqa_size=0;
for j=2:w
    for i=1:j-1
        rqa_size=rqa_size+(j-i);
    end
end

% compute retracing (regressions)
retracing=0;
for j=2:w-1
    for i=2:j-1
        retracing=retracing+(rqa_matrix(i,j)*rqa_matrix(i-1,j+1));
    end
end

% compute LORC (latency of recurrence mass)
LORC=0;
for j=2:w
    for i=1:j-1
        LORC=LORC+((j+i)*rqa_matrix(i,j));
    end
end


% compute R (frequency of recurrent fixations in recurrence plot)
R=0;
for j=2:w
    for i=1:j-1
        R=R+rqa_matrix(i,j);
    end
end

REC=100*((2*R)/(size(x,1)*(size(x,1)-1)));

% compute RQA measures
if R==0
    DET=0;
    LAM=0;
    CORM=0;
    SIZE=0;
    RET=0;
    LORC=0;
else
    DET=100*(count_diagonal/(R));
    LAM=100*((count_horizontal)/(2*R));
    CORM=100*((corm_sum)/((size(x,1)-1)*(R)));
    SIZE=100*((rqa_size)/((size(x,1)-1)*(R)));
    RET=100*(retracing/(R));
    LORC=100*((LORC)/((size(x,1)-1)*(R)));
end

% output RQA values
out.R=R;
out.REC=REC;
out.DET=DET;
out.LAM=LAM;
out.CORM=CORM;
out.SIZE=SIZE;
out.RET=RET;
out.LORC=LORC;
out.rqa_matrix=rqa_matrix;




