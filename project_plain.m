% ======================================================================= %
% SSY125 Project AMPM modulation
% ======================================================================= %
clc
clear
close all

% ======================================================================= %
% Simulation Options
% ======================================================================= %
N = 1e5;  % simulate N bits each transmission (one block)
maxNumErrs = 500; % get at least 100 bit errors (more is better)
maxNum = 1e7; % OR stop if maxNum bits have been simulated
EbN0 = -1:0.5:12; % power efficiency range
load('AMPM_const.mat')
% ======================================================================= %
% Other Options
% ======================================================================= %
% modulationtype:
 mod_type = 3;
 code_rate = 2/3;
 E4_trellis;%get trellis for E4
% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results
for i = 1:length(EbN0) % use parfor ('help parfor') to parallelize  
  totErr = 0;  % Number of errors observed
  num = 0; % Number of bits processed
  EsN0 = 10^(EbN0(i)/10)*mod_type*code_rate;%linear scale
  sigma = sqrt(1/(EsN0*2*1));%Es = 1
  fprintf('progress:%d/%d\n',i,length(EbN0))
  while((totErr < maxNumErrs) && (num < maxNum))
  % ===================================================================== %
  % Begin processing one block of information
  % ===================================================================== %
  % [SRC] generate N information bits 
  % ... 
    u = randsrc(1,N,[0,1]); % Creates random bit pattern
  % [ENC] convolutional encoder
  % ...
    [coded,final_state] = convenc(u,trellis);
  % [MOD] symbol mapper
  % ...
    symbol = bits2sym(coded,mod_type);
  
  % [CHA] add Gaussian noise
    white_noise = (sigma)*...
        (randn(1,length(symbol)) + 1j*randn(1,length(symbol)));
    y = white_noise+symbol;
  % [SR] Soft Receiver
    u_hat_soft = conv_decode(y,AMPM_const,final_state);
  % ===================================================================== %
  % End processing one block of information
  % ===================================================================== %
  BitErrs = sum(abs(u_hat_soft-u)); % count the bit errors and evaluate the bit error rate
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