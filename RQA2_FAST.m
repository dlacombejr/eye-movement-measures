function [out]=RQA2_FAST(x, y)
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

% % create rqa_matrix the size of n_fixations x n_fixations
% rqa_matrix=zeros(size(x,1),size(x,1));
% 
% set distance parameter
d_p=100;
% 
% % generate recurrence plot
% for j=1:size(x,1)
%     for i=1:size(x,1);
%         rqa_matrix(i,j)=sqrt((x(j)-x(i))^2 + (y(j)-y(i))^2);
% %         if d<=d_p
% %             rqa_matrix(i,j)=1;
% %         else
% %             rqa_matrix(i,j)=0;
% %         end
%     end
% end

xTemp = repmat(x, [1, size(x,1)]); 
yTemp = repmat(y, [1, size(x,1)]);
rqa_matrix = sqrt((xTemp - xTemp').^2 + (yTemp - yTemp').^2); 
rqa_matrix = double(rqa_matrix <= d_p); 

% % normalize recurrence plot
% maximum=max(max(rqa_matrix));
% rqa_matrix=rqa_matrix./maximum;
% 

upTri = triu(rqa_matrix, 1); 

% compute number of diagonal lines
% count_diagonal=0;
% for j=2:size(x,1)-1
%     for i=1:j-1
% %         count_diagonal = count_diagonal + rqa_matrix(i,j)*rqa_matrix(i+1,j+1);
%         count_diagonal = count_diagonal + (rqa_matrix(i,j)+rqa_matrix(i+1,j+1));
% 
% %         if rqa_matrix(i,j)==1
% %             index=rqa_matrix(i+1,j+1);
% %             if index==1
% %                 count_diagonal=count_diagonal+1;
% %             else
% %                 count_diagonal=count_diagonal+0;
% %             end
% %         end
%     end
% end

temp1 = circshift(upTri, -1); 
temp1 = circshift(temp1, -1, 2); 
count_diagonal = sum(sum(upTri.*temp1)); 

% % compute number of vertical lines
% count_vertical=0;
% for j=3:size(x,1)
%     for i=1:j-2
% %         count_vertical = count_vertical + rqa_matrix(i,j)*rqa_matrix(i+1,j);
%         count_vertical = count_vertical + (rqa_matrix(i,j)+rqa_matrix(i+1,j));
% 
% %         if rqa_matrix(i,j)==1
% %             index=rqa_matrix(i+1,j);
% %             if index==1
% %                 count_vertical=count_vertical+1;
% %             else
% %                 count_vertical=count_vertical+0;
% %             end
% %         end
%     end
% end

temp1 = circshift(upTri, -1); 
count_vertical = sum(sum(upTri.*temp1)); 


% compute number of horizontal lines
% count_horizontal=0;
% for j=2:size(x,1)-1
%     for i=1:j-1
% %         count_horizontal = count_horizontal + rqa_matrix(i,j)*rqa_matrix(i,j+1);
%         count_horizontal = count_horizontal + (rqa_matrix(i,j)+rqa_matrix(i,j+1));
% %         if rqa_matrix(i,j)==1
% %             index=rqa_matrix(i,j+1);
% %             if index==1
% %                 count_horizontal=count_horizontal+1;
% %             else
% %                 count_horizontal=count_horizontal+0;
% %             end
% %         end
%     end
% end

temp1 = circshift(upTri, -1, 2); 
count_horizontal = sum(sum(upTri.*temp1)); 

% compute center of recurrence mass
% corm_sum=0;
% for j=2:size(x,1)
%     for i=1:j-1
%         corm_sum = corm_sum + rqa_matrix(i,j)*(j-i);
% %         if rqa_matrix(i,j)==1
% %             corm_sum=corm_sum+(j-i);
% %         else
% %             corm_sum=corm_sum+0;
% %         end
%     end
% end

cormTemp = repmat(linspace(1,size(x,1),size(x,1)), [size(x,1), 1]); 
cormTemp0 = cormTemp - cormTemp'; 
corm_sum = sum(sum(triu(rqa_matrix.*cormTemp0, 1))); 

% compute size of rqa matrix
% rqa_size=0;
% for j=2:size(x,1)
%     for i=1:j-1
%         rqa_size=rqa_size+(j-i);
%     end
% end
rqa_size = size(rqa_matrix, 1); 

% compute retracing (regressions)
% retracing=0;
% for j=2:size(x,1)-1
%     for i=2:j-1
%         retracing=retracing+(rqa_matrix(i,j)*rqa_matrix(i-1,j+1));
%     end
% end

temp1 = circshift(upTri, 1); 
temp1 = circshift(temp1, -1, 2); 
retracing = sum(sum(upTri.*temp1)); 


% compute LORC (latency of recurrence mass)
% LORC=0;
% for j=2:size(x,1)
%     for i=1:j-1
%         LORC=LORC+((j+i)*rqa_matrix(i,j));
%     end
% end

cormTemp = cormTemp + cormTemp'; 
LORC = sum(sum(triu(rqa_matrix.*cormTemp, 1))); 


% compute R (frequency of recurrent fixations in recurrence plot)
% R=0;
% for j=2:size(x,1)
%     for i=1:j-1
%         R = R + rqa_matrix(i,j);
% %         if rqa_matrix(i,j)==1
% %             R=R+1;
% %         else
% %             R=R+0;
% %         end
%     end
% end

R = sum(sum(rqa_matrix)); 

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
    LAM=100*((count_vertical+count_horizontal)/(2*R));
    CORM=100*((corm_sum)/((size(x,1)-1)*(R)));
%     SIZE=100*((rqa_size)/((size(x,1)-1)*(R)));
    SIZE = rqa_size; 
    RET=100*(retracing/(R));
    LORC=100*((LORC)/((size(x,1)-1)*(R)));
end

% output RQA values
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



