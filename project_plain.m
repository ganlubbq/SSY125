% ======================================================================= %
% SSY125 Project
% ======================================================================= %
clc
clear
close all

% ======================================================================= %
% Simulation Options
% ======================================================================= %
N = 3e3;  % simulate N bits each transmission (one block)
maxNumErrs = 250; % get at least 100 bit errors (more is better)
maxNum = 1e6; % OR stop if maxNum bits have been simulated
EbN0 = -1:0.5:12; % power efficiency range
% ======================================================================= %
% Other Options
% ======================================================================= %
% modulationtype:
 mod_type = 2;
 code_rate = 0.5;
% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results
% theoratical BER
BER_th = qfunc(sqrt(2*10.^(EbN0/10)));
for i = 1:length(EbN0) % use parfor ('help parfor') to parallelize  
  totErr = 0;  % Number of errors observed
  num = 0; % Number of bits processed

  while((totErr < maxNumErrs) && (num < maxNum))
  % ===================================================================== %
  % Begin processing one block of information
  % ===================================================================== %
  % [SRC] generate N information bits 
  % ... 
    u = randsrc(1,N,[0,1]); % Creates random bit pattern
  % [ENC] convolutional encoder
  % ...
    u_coded = conv_encode(u);
  % [MOD] symbol mapper
  % ...
    symbol = bits2sym(u_coded,mod_type);
  
  % [CHA] add Gaussian noise
    EsN0 = 10^(EbN0(i)/10)*mod_type*code_rate;%linear scale
    sigma = sqrt(1/(EsN0*2*1));%Es = 1
    white_noise = (sigma)*...
        (randn(1,length(symbol)) + 1j*randn(1,length(symbol)));
    y = white_noise+symbol;
  % scatterplot: plot(y, 'b.')  

  % [HR] Hard Receiver
  u_hat = symbol_detect_hard(y,mod_type);
  % [DEC] viterbi decoder
  info_hat = conv_decode(u_hat);
  info_hat = info_hat(1:end-2);% the last two bits are zero-padded
  % [SR] Soft Receiver
  % ...
  % ===================================================================== %
  % End processing one block of information
  % ===================================================================== %
  BitErrs = sum(abs(info_hat-u)); % count the bit errors and evaluate the bit error rate
  totErr = totErr + BitErrs;
  num = num + N; 

%   disp(['+++ ' num2str(totErr) '/' num2str(maxNumErrs) ' errors. '...
%       num2str(num) '/' num2str(maxNum) ' bits. Projected error rate = '...
%       num2str(totErr/num, '%10.1e') '. +++']);
  end 
  BER(i) = totErr/num; 
end
% ======================================================================= %
% End
% ======================================================================= %