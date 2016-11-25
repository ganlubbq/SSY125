function [ codeword ] = conv_encode( info_bits )
%CONV_ENCODE Summary of this function goes here
%   Detailed explanation goes here
%   info_bits length = 3000
%   for encoder G = (1+D^2,1+D+D^2)
info_bits = logical(info_bits);
%   calculate register number, define register
num_reg = 2;
reg = zeros(1,num_reg);
%   pad zeros to ensure zero termination
info_bits = [info_bits zeros(1,num_reg)];
%   number of iterations
l_info_bits = length(info_bits);
%   define output streams
codeword = zeros(1,l_info_bits*2);
%   encode loop
for i = 1:l_info_bits
    codeword((i-1)*2+1) = bitxor(info_bits(i),reg(2));
    codeword((i-1)*2+2) = bitxor(bitxor(info_bits(i),reg(2)),reg(1));
    %shift the register by 1
    reg(2) = reg(1);
    reg(1) = info_bits(i);
end
end

