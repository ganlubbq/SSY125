% ======================================================================= %
% SSY125 Project
% ======================================================================= %
clc
clear
close all

% ======================================================================= %
% Simulation Options
% ======================================================================= %
N = 1e5;  % simulate N bits each transmission (one block)
maxNumErrs = 100; % get at least 100 bit errors (more is better)
maxNum = 1e7; % OR stop if maxNum bits have been simulated
EbN0 = -1:0.5:12; % power efficiency range

% ======================================================================= %
% Other Options
% ======================================================================= %
% modulationtype:
 mod_type = 1;

% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results

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

  % [MOD] symbol mapper
  % ...
    %symbol = bits2sym(bits,mod_type)
  
  % [CHA] add Gaussian noise
  % y = awgn(symbols,SNR,'measured')

  % scatterplot: plot(y, 'b.')  

  % [HR] Hard Receiver
  u_hat = symbol_detect_hard(y,mod_type);
  % [SR] Soft Receiver
  % ...
  % ===================================================================== %
  % End processing one block of information
  % ===================================================================== %
  BitErrs = abs(sum(u_hat-u)); % count the bit errors and evaluate the bit error rate
  totErr = totErr + BitErrs;
  num = num + N; 

  disp(['+++ ' num2str(totErr) '/' num2str(maxNumErrs) ' errors. '...
      num2str(num) '/' num2str(maxNum) ' bits. Projected error rate = '...
      num2str(totErr/num, '%10.1e') '. +++']);
  end 
  BER(i) = totErr/num; 
end
% ======================================================================= %
% End
% ======================================================================= %