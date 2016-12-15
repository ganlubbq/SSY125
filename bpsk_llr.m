function [ y_llr ] = bpsk_llr( y,sigma )
%BPSK_LLR Summary of this function goes here
%   Detailed explanation goes here
BPSK_const = [-1 1];
y_mat = repmat(y,2,1);
l_y = length(y);
const_mat = repmat(transpose(BPSK_const),1,l_y);
dist_mat = (abs(y_mat - const_mat)).^2; %distance square matric
y_llr = log(exp((-1/sigma^2)*dist_mat(1,:))./exp((-1/sigma^2)*dist_mat(2,:)));
end

