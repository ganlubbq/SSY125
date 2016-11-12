function [ c_hat ] = symbol_detect_hard( y,mod_type )
%SYMBOL_DETECT Summary of this function goes here
%   Detailed explanation goes here
%   ML detection, hard receiver
%   mod_type 1 -> BPSK;
% 	mod_type 2-> QPSK; 
%	mod_type 3-> AMPM
%   'y' is a row vector
%   c_hat is row vector of bits

%% Constellation definition
BPSK_const = [-1 1];

QPSK_const = [...
            (+1 + 1i)...% 11 - index 1
            (+1 - 1i)...% 10 - index 2
            (-1 + 1i)...% 01 - index 3
            (-1 - 1i)...% 00 - index 4
            ]/sqrt(2);
        
AMPM_const = [...
            (-3 + 3i)...% 001 - index 1
            (+3 - 3i)...% 100 - index 2
            (+3 + 1i)...% 110 - index 3
            (-3 - 1i)...% 011 - index 4
            (-1 + 1i)...% 101 - index 5
            (+1 - 1i)...% 000 - index 6
            (+1 + 3i)...% 010 - index 7
            (-1 - 3i)...% 111 - index 8
            ]/sqrt(10);


%% different decision making process for different
switch mod_type
    case 1
    	% the output bit vector length will be equal to symbol vec length in BPSK
    	c_hat=zeros(1,length(y));

        % Descision of symbols
		for k = 1:length(y)
    		x_abs = abs(BPSK_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end

    case 2
        %QPSK
        % bit vector length will be symbol length multiplied by 2
        c_hat=zeros(1,(length(y)*2));

        for k=1:length(y)
        	x_abs = abs(QPSK_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end

    case 3
        %AMPM
        % bit vector length will be symbol vector length multiplied by 3
        c_hat=zeros(1,(length(y)*3));

        for k=1:length(y)
        	x_abs = abs(AMPM_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end
		
	otherwise
		disp('no valid mod_type')

end

