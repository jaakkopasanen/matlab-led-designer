clear all;
load('led_data.mat');
L = 380:5:780;
leds = [
    Led('warm', Yuji_BC2835L_2700K, 700, 1)
    Led('cold', Yuji_BC2835L_6500K, 900, 1)
];
coeffs = [0.9;0.1];


powers = zeros(length(leds), 1);
LERs = powers;
powerKs = LERs;
for i = 1:length(leds)
    powers(i) = leds(i).power;
    % Power coefficient: LED true power divided by power of LED's
    % normalized spectral power distribution
    powerKs(i) = powers(i) / (sum(leds(i).spd) / 400);
    LERs(i) = leds(i).ler;
end

K = 1 / max(coeffs);
normalizedCoeffs = K*coeffs;
scaledCoeffs = normalizedCoeffs ./ powerKs;
trueCoeffs = scaledCoeffs * (1/max(scaledCoeffs));
truePowers = trueCoeffs .* powers;
maxLumens = sum(truePowers .* LERs);



spd1 = leds(1).spd*coeffs(1)+leds(2).spd*coeffs(2);
spd2 = leds(1).spd*powerKs(1)*trueCoeffs(1)+leds(2).spd*powerKs(2)*trueCoeffs(2);
spd2 = spd2 * (max(spd1)/max(spd2));

subplot(1,2,1);
plot(L,spd1,L,spd2,'--');
legend('Unscaled', 'TC');
subplot(1,2,2);
l1 = leds(1).spd.*powerKs(1);
l1 = l1 * ( 1 / max(l1));
l2 = leds(2).spd.*powerKs(2) * scaledCoeffs(1);
plot(L,l1,L,l2);
legend('LED 1', 'LED 2');
