function [ u_hat ] = conv_decode( r )
%CONV_DECODE Summary of this function goes here
%   Detailed explanation goes here
%   Decoder of conv_encoder.m
% Accumulate distance
D = [0 inf inf inf]';
% D_mat = [D1 D2; D3 D4; D1 D2; D3 D4]
D_mat = [0 inf; inf inf;0 inf;inf inf];
% number of iteration
t_max = length(r)/2;
% information bits
u_hat = -1*zeros(1,t_max);
% reshape r
r = reshape(r,2,[])';
% distance matrix at each section
% lamda = [L11 L21 L32 L42 L13 L23 L34 L44]';
% lamda_mat = [L11 L21; L32 L42; L13 L23; L34 L44];
% codeword generated at each section
% matrix to store path
I = -1*ones(4,t_max);
global C
C = [0 0;1 1;0 1;1 0;1 1;0 0;1 0;0 1];
for t=1:t_max
    lamda = distance_metric(r(t,:),C);
    lamda_mat = reshape(lamda,2,[])';
    D_mat = D_mat+lamda_mat;
    [D,I(:,t)] = min(D_mat,[],2);
    D_mat = reshape([D' D'],2,[])';
end
%start from the last column(we know the finial state is 1)
pos_r = 1;
for t = t_max:-1:1
    [u_hat(t),pos_r] = trace_back(pos_r,t,I);
end