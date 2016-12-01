function [ metric ] = distance_metric( ri,C )
%DISTANCE_METRIC Summary of this function goes here
%   Detailed explanation goes here
metric = sum(bitxor(repmat(ri,8,1),C),2);
end

