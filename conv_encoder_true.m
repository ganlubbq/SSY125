%test the convolution encoder and decoder
N = 100;
trellis  = poly2trellis(3,{'1+x^2','1+x+x^2'});
u = randsrc(1,N,[0,1]);
u_true = [u 0 0];%pad zeros
c_convenc = convenc(u_true,trellis);
c_conv_encode = conv_encode(u);
encoder_error = sum(abs(c_conv_encode-c_convenc));
fprintf('The encoder has %d errors\n',encoder_error)
u_hat_vitdec = vitdec(c_convenc,trellis,15,'term','hard');
error_pattern = randsrc(1,length(c_convenc),[0 1;0.95 0.05]);
fprintf('Number of ones in the error pattern: %d\n',sum(error_pattern))
u_hat_conv_decode = conv_decode(c_convenc + error_pattern);
decoder_error = sum(abs(u_hat_conv_decode-u_true));
fprintf('The decoder has %d errors\n',decoder_error)