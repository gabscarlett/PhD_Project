function [f, P1] = F_F_T(sig,Fs,psd)
%
% REQUIRES SAMPLING PERIOD, AND SIGNAL
% FFT psd=0;
% PSD psd=1;

m=mean(sig);

sig0 = sig-m; % to avoid peak at 0Hz
NFFT = 2^(nextpow2(length(sig0))-1);
alphafft = sig0(1:NFFT);
L = length(alphafft);    % Length of signal
f = Fs*(0:(L/2))/L;

Y = fft(alphafft); % FFT

P2 = abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

if psd==1 % PDS
P1=P1.^2/(L*Fs);
end

end