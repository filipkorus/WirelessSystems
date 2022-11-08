% losowe dane -> randi [0,1]
% modulator -> comm.PSKModulator(2, 0)
% step -> modulator na dane
% tworzymy kanal radiowy
% AWGNChannel
% demodulacja
% comm.ErrorRate -> BER

clear all;
close all;
errRatioArr = [];

for SNR=1:15
    originalData = randi([0, 1], 400000, 1);

    modulator = comm.PSKModulator(2, 0);
    modulatedData = step(modulator, originalData);

    TXpower = 10*log10(2); % dBm
    pathLoss = 126; % dB
    noiseRatio = -129; % dBm

    %SNR = TXpower - pathLoss - noiseRatio,

    channel = comm.AWGNChannel("NoiseMethod", "Signal to Noise Ratio (SNR)", "SNR", SNR);
    transmittedData = step(channel, modulatedData);


    demodulator = comm.PSKDemodulator(2, 0);
    demodulatedData = step(demodulator, transmittedData);

    %scatterplot(modulatedData);
    %scatterplot(transmittedData);

    errorRate = comm.ErrorRate;

    err = errorRate(originalData, demodulatedData);

    errRatio = err(1),
    errRatioArr(length(errRatioArr) + 1) = errRatio;

end;

semilogy(errRatioArr);

% 1 -> bledy
% 2 -> liczba bledow
% 3 -> l. bitow testowanych
