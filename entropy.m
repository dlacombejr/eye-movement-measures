function [ent]=entropy(transition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [ent_master]=entropy_roi_partsep(transition)
% Calculates entropy of a markov transition matrix
%
% INPUT ARGUMENTS:
%   master:     nxn matrix, where n is the number of rois
% OUTPUT ARGUMENTS:
%   ent:        a single element with the entropy value of the matrix
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate entropy of markov_matrix
ent=-sum(transition(transition~=0).*log2(transition(transition~=0)));
