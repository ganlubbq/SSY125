%plot result of part 1
%% uncoded QPSK vs theoratical
figure
semilogy(EbN0,BER,'*')
hold on
%semilogy(EbN0,BER_th)
xlabel('EBN0 / dB')
ylabel('BER')
grid on
axis([-1 10 1E-5 1])
legend('simulation')