%test the convolution encoder and decoder
load('AMPM_const.mat')
N = 10000;
u = randsrc(1,N,[0,1]);
E4_trellis
[code,final_state] = convenc(u,trellis);
y = bits2sym(code,3);
u_hat = conv_decode(y,AMPM_const,final_state+1);
fprintf('N_ERR/N = %d/%d',sum(bitxor(u,u_hat)),N)