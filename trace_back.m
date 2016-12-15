function [ info,pos_r_new ] = trace_back( pos_r,pos_c,I,map )
%TRACE_BACK Summary of this function goes here
%   Detailed explanation goes here
%   needs final state of the encoder!
node = I(pos_r,pos_c);
pos_r_new = map(pos_r,node);
%current state = pos_r
info = node-1;
end

