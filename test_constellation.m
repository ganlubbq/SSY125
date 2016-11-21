%% test bpsk (passed)
bits = [0 1];
symbol = bits2sym(bits,1);
disp(symbol)
y = symbol + -0.1;
bits_hat = symbol_detect_hard(y,1);
disp(bits_hat)
%% test qpsk (passed)
bits = [0 0 0 1 1 0 1 1];
symbol = bits2sym(bits,2);
disp(symbol)
y = symbol + -0.1 + 0.1*1j;
bits_hat = symbol_detect_hard(y,2);
disp(bits_hat)
%% test AMPM (passed)
bits = [0 0 0 0 0 1 0 1 0 0 1 1 1 0 0 1 0 1 1 1 0 1 1 1];
symbol = bits2sym(bits,3);
disp(symbol)
y = symbol + -0.1 + 0.1*1j;
bits_hat = symbol_detect_hard(y,3);
disp(bits_hat)