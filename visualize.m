%% Plots visualization tools for results estimation
%
% This script is part of tunable white script pipe
% Variables needed in this script are initialized in previous steps
%

%% Plot results
figure;
colors = [
    0.6350    0.0780    0.1840 % Red
    0.4660    0.6740    0.1880 % Green
    0         0.4470    0.7410 % Blue
    0.9290    0.6940    0.1250 % Yellow
    0.3010    0.7450    0.9330 % Light blue
    0.8500    0.3250    0.0980 % Orange
    0.4940    0.1840    0.5560 % Purple
];

%% Plot mixing coefficients
subplot(2,3,1);
hold on;
legendMatrix = cell(length(leds), 1);
for i = 1:length(leds)
    plot(ccts, fitCoeffs(:,i), 'LineWidth', 1.5, 'Color', colors(i,:));
    legendMatrix{i} = leds(i).name;
end
title('Relative power coefficients');
legend(legendMatrix);
xlabel('CCT (K)');
ylabel('Relative LED Power');
axis([minCCT maxCCT -0.2 1.2]);
grid on;

%% Plot true coefficients
subplot(2,3,4);
hold on;
legendMatrix = cell(length(leds), 1);
for i = 1:length(leds)
    plot(ccts, trueCoeffs(:,i), 'LineWidth', 1.5, 'Color', colors(i,:));
    legendMatrix{i} = leds(i).name;
end
title('True power coefficients');
legend(legendMatrix);
xlabel('CCT (K)');
ylabel('Relative LED Power');
axis([minCCT maxCCT -0.2 1.2]);
grid on;

%% Plot Rf, Rg and Rp
subplot(2,3,2);
plot(ccts, Rfs, ccts, Rgs, ccts, goodnesses, 'linewidth', 1.5);
axis([minCCT maxCCT 50 125]);
title('Fidelity (Rf), Saturation (Rg) and Goodness');
xlabel('CCT (K)');
legend('Rf', 'Rg', 'CRI Ra');
grid on;

%% Plot CIE 1976 UCS
ax = subplot(2,3,5);
plotCieLuv(XYZs, true, ax);
title('CIE 1976 UCS');

%% Plot Luminous efficacy radiation function
subplot(2,3,3);
plot(ccts, LERs, 'LineWidth', 1.5);
title('Luminous Efficacy of Radiation');
xlabel('CCT (K)');
ylabel('LER (lm/w)');
axis([minCCT maxCCT 150 300]);
grid on;

%% Plot max lumens
subplot(2,3,6);
plot(ccts, maxLumens, 'linewidth', 1.5);
axis([minCCT maxCCT 0 max(maxLumens)*1.2]);
title('Max Lumens per Meter');
xlabel('CCT (K)');
ylabel('Luminous intensity (lm/m)');
grid on;

%%
if exist('supertitle', 'var')
    suptitle(supertitle);
end

%% Inspect spectrums at 2000K, 2700K, 4000K and 5600K
if ~isempty(inspectSpds)
    for i = 1:length(inspectSpds)
        c = estimateCoeffs(inspectSpds(i), mixingData);
        str = [];
        for j = 1:length(c)
            str = [str leds(j).name ' = ' num2str(round(c(j)*100)) '%, '];
        end
        str = str(1:end-2);
        inspectSpd(mixSpd(ledSpds, c), targetRg, RfPenalty, RgPenalty, duvPenalty, str);
    end
end