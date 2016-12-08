%test the convolution encoder and decoder
N = 10000;
trellis  = poly2trellis(3,{'1+x^2','1+x+x^2'});
u = randsrc(1,N,[0,1]);
u_true = [u 0 0];%pad zeros
c_convenc = convenc(u_true,trellis);
c_conv_encode = conv_encode(u);
encoder_error = sum(abs(c_conv_encode-c_convenc));
fprintf('The encoder has %d errors\n',encoder_error)
error_pattern = randsrc(1,length(c_convenc),[0 1;0.90 0.10]);
fprintf('Number of ones in the error pattern: %d\n',sum(error_pattern))
u_hat_conv_decode = conv_decode(bitxor(c_convenc , error_pattern));
u_hat_vitdec = vitdec(bitxor(c_convenc , error_pattern),trellis,15,'term','hard');
decoder_error = sum(abs(u_hat_conv_decode-u_true));
decoder_error1 = sum(abs(u_hat_vitdec - u_hat_conv_decode));
decoder_std_error = sum(abs(u_hat_vitdec - u_true));
fprintf('Error in My|Std|My-Std\n    %d|%d|%d|\n',decoder_error,decoder_std_error,decoder_error1)