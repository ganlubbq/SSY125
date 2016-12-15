function [ metric ] = distance_metric( ri,C )
%DISTANCE_METRIC Summary of this function goes here
%   Detailed explanation goes here
metric = (abs(C-ri)).^2;
end

