function [ u_hat ] = conv_decode( r,AMPM_const,final_state)
%CONV_DECODE Summary of this function goes here
%   Detailed explanation goes here
%   Decoder of conv_encoder.m
%   r is the recived complex signal
% constellation
% Accumulate distance
D = [0 inf inf inf inf inf inf inf]';
% D_mat = [D1537; D3715; D5173; D7351; D2648; D4826; D6284; D8462]
D_mat = ones(8,4)*inf;
[D_mat(1,1), D_mat(2,3), D_mat(3,2), D_mat(4,4)] = deal(0);
%traceback map
map = [1 5 3 7; 3 7 1 5;5 1 7 3;7 3 5 1;2 6 4 8;4 8 2 6;6 2 8 4;8 4 6 2];
% number of iteration
t_max = length(r);
%infomation in dec
info_dec = zeros(t_max,1);
% information bits
% reshape r
r = transpose(r);
% distance matrix at each section
% lamda_mat = [L1537_1; L3715_2; L5173_3; L7351_4; L2648_5; L4826_6; L6284_7; L8462_8];
% codeword generated at each section
% matrix to store path
I = -1*ones(8,t_max);
output_mat = [repmat([1 2 3 4],4,1);repmat([5 6 7 8],4,1)];
C = AMPM_const(output_mat);
for t=1:t_max
    lamda_mat = (abs(r(t) - C)).^2;
    D_mat = D_mat+lamda_mat;
    [D,I(:,t)] = min(D_mat,[],2);
    D_mat = [D(1) D(5) D(3) D(7);...
        D(3) D(7) D(1) D(5);...
        D(5) D(1) D(7) D(3);...
        D(7) D(3) D(5) D(1);...
        D(2) D(6) D(4) D(8);...
        D(4) D(8) D(2) D(6);...
        D(6) D(2) D(8) D(4);...
        D(8) D(4) D(6) D(2)];
end
%start from the last column with known final state
pos_r = final_state;
for t = t_max:-1:1
    [info_dec(t),pos_r] = trace_back(pos_r,t,I,map);
end
u_hat = reshape(transpose(de2bi(info_dec,2,'left-msb')),1,[]);