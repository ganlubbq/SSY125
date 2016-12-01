function [ info_bit,pos_r_new ] = trace_back( pos_r,pos_c,I )
%TRACE_BACK Summary of this function goes here
%   Detailed explanation goes here
node = I(pos_r,pos_c);
switch pos_r
    case 1
        if node == 1
            info_bit = 0;
            pos_r_new = 1;
        else
            info_bit = 0;
            pos_r_new = 2;
        end
    case 2
        if node == 1
            info_bit = 0;
            pos_r_new = 3;
        else
            info_bit = 0;
            pos_r_new = 4;
        end
    case 3
        if node == 1
            info_bit = 1;
            pos_r_new = 1;
        else
            info_bit = 1;
            pos_r_new = 2;
        end
    case 4
        if node == 1
            info_bit = 1;
            pos_r_new = 3;
        else
            info_bit = 1;
            pos_r_new = 4;
        end
end
end

