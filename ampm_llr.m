function [ llr ] = ampm_llr( y,sigma )
%AMPM_LLR Summary of this function goes here
%   Detailed explanation goes here
%   LLR demod for AMPM

llr = zeros(length(y),3);

AMPM_const = [...
            (1 + -1i)...% 000 - index 0
            (-3 + 3i)...% 001 - index 1
            (1 +  3i)...% 010 - index 2
            (-3 - 1i)...% 011 - index 3
            (3 - 3i)...% 100 - index 4
            (-1 + 1i)...% 101 - index 5
            (+3 + 1i)...% 110 - index 6
            (-1 - 3i)...% 111 - index 7
            ]/sqrt(10);
for i = 1:length(y)
    d_matric = (abs(y(i) - AMPM_const)).^2;
    llr(i,1) = log(sum(exp((-1/sigma^2)*(d_matric([2 3 4 1]))))/sum(exp((-1/sigma^2)*(d_matric([5 6 7 8])))));
    llr(i,2) = log(sum(exp((-1/sigma^2)*(d_matric([1 2 5 6]))))/sum(exp((-1/sigma^2)*(d_matric([3 4 7 8])))));
    llr(i,3) = log(sum(exp((-1/sigma^2)*(d_matric([1 3 5 7]))))/sum(exp((-1/sigma^2)*(d_matric([2 4 6 8])))));
end
llr = reshape(llr',1,[]);
end

