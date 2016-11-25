function [ bits_hat ] = symbol_detect_hard( y,mod_type )
%SYMBOL_DETECT Summary of this function goes here
%   Detailed explanation goes here
%   ML detection, hard receiver
%       mod_type 1 -> BPSK;
%       mod_type 2-> QPSK; 
%       mod_type 3-> AMPM
%   'y' is a row vector
%   c_hat is row vector of symbol index (from 0 to M-1)
%   bits_hat is the estimated bits of ML detection

%% Constellation definition
BPSK_const = [-1 1];

QPSK_const = [...
            (+1 + 1i)...% 00 - index 0
            (-1 + 1i)...% 01 - index 1
            (+1 - 1i)...% 10 - index 2
            (-1 - 1i)...% 11 - index 3
            ]/sqrt(2);
        
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
%length of y
l_y = length(y);
%% different decision making process for different
switch mod_type
    case 1
        y_mat = repmat(y,2,1);
        const_mat = repmat(transpose(BPSK_const),1,l_y);
        x_abs_mat = abs(y_mat - const_mat);
        [~,symbol_index_hat] = min(x_abs_mat);
        bits_hat = de2bi((symbol_index_hat-1)','left-msb');
        bits_hat = reshape(bits_hat',1,l_y);
    case 2
        y_mat = repmat(y,4,1);
        const_mat = repmat(transpose(QPSK_const),1,l_y);
        x_abs_mat = abs(y_mat - const_mat);
        [~,symbol_index_hat] = min(x_abs_mat);
        bits_hat = de2bi((symbol_index_hat-1)','left-msb');
        bits_hat = reshape(bits_hat',1,2*l_y);
    case 3
        y_mat = repmat(y,8,1);
        const_mat = repmat(transpose(AMPM_const),1,l_y);
        x_abs_mat = abs(y_mat - const_mat);
        [~,symbol_index_hat] = min(x_abs_mat);
        bits_hat = de2bi((symbol_index_hat-1)','left-msb');
        bits_hat = reshape(bits_hat',1,3*l_y);
	otherwise
		error('no valid mod_type')

end
