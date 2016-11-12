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
QPSK_const = [];
AMPM_const = [];


%% different decision making process for different
switch mod_type
    case 1
    	% the output bit vector length will be equal to symbol vec length in BPSK
    	c_hat=zeros(1,length(y))

        % Descision of symbols
		for k = 1:length(y)
    		x_abs = abs(BPSK_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end

    case 2
        %QPSK
        % bit vector length will be symbol length divided by 2
        c_hat=zeros(1,(length(y)/2)

        for k=1:length(y)
        	x_abs = abs(QPSK_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end

    case 3
        %AMPM
        % bit vector length will be symbol vector length divided by 3
        c_hat=zeros(1,(length(y)/3)

        for k=1:length(y)
        	x_abs = abs(AMPM_const - y(k));
    		[~,I] = min(x_abs);
    		c_hat(k)=I;
		end
		
	otherwise
		disp('no valid mod_type')

end

