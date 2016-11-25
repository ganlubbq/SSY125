function [ symbols ] = bits2sym( bits,mod_type )
%BITS2SYM Summary of this function goes here
%   Detailed explanation goes here
%   mod_type 1 -> BPSK; 2->QPSK; 3->AMPM
%   'symbols' is a row vector
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

switch mod_type
    case 1
        %BPSK
        symbols = 2*bits-1;
    case 2
        %QPSK
        symbols_index = bi2de((buffer(bits,2))','left-msb');
        symbols = QPSK_const(symbols_index+1);
    case 3
        %AMPM
        symbols_index = bi2de((buffer(bits,3))','left-msb');
        symbols = AMPM_const(symbols_index+1);
end
end

