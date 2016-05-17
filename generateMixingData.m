%% Generates Mixing Data
%
% This script is part of tunable white script pipe
% Variables needed in this script are initialized in tunableWhite.m
%

%% Helpers
ledSpds = zeros(length(leds), length(L));
for i = 1:length(leds)
    ledSpds(i, :) = leds(i).spd;
end

%% Loop through all possible coefficient combinations
rawMixingData = [];
for i = 1:size(ledGroups, 1)
    ledGroup = ledGroups(i, :);
    ledGroup(ledGroup < 1) = []; % Remove zeros
    md = mixLeds(leds(ledGroup), resolution); % Mix leds in led group

    % Pad excluded LEDs as zeros
    rmd = zeros(size(md, 1), length(leds) + 1);
    rmd(:,1) = md(:,1); % CCT
    for j = 1:size(md, 2)-1
        rmd(:, ledGroup(j)+1) = md(:, j+1);
    end

    rawMixingData = [ % Concatenate to raw mixing data
        rawMixingData
        rmd;
    ];
end

%% Select best results
% goodness, index
cctBins = zeros(ceil((maxCCT - minCCT) / cctBinSize) + 1, 2);
nSkipped = 0;
% Iterate all bins and find largest Rp for each bin
for i = 1:length(rawMixingData)
    % Skip results outside of CCT range
    if rawMixingData(i, 1) < minCCT || rawMixingData(i, 1) > maxCCT
        nSkipped = nSkipped + 1;
        continue;
    end
    
    spd = mixSpd(ledSpds, rawMixingData(i, 2:end));
    XYZ = spdToXyz(spd);
    uv = xyzToCie1976UcsUv(XYZ);
    XYZw = spdToXyz(refSpd(rawMixingData(i, 1), true));
    uvw = xyzToCie1976UcsUv(XYZw);
    duv = sqrt(sum((uv-uvw).^2));
    % Skip samples that deviate from planckian locus too much
    if duv > maxDuv
        nSkipped = nSkipped + 1;
        continue;
    end
    
    % CCT bin index
    %cctBin = floor(rawMixingData(i, 1) / cctBinSize) - minCCT / cctBinSize + 1;
    cctBin = floor((rawMixingData(i, 1) - minCCT) / cctBinSize) + 1;

    [Rf, Rg] = spdToRfRg(spd, rawMixingData(i, 1));
    goodness = lightGoodness(Rf, Rg, XYZ, XYZw, targetRg, RfPenalty, RgPenalty, duvPenalty);
    
    % Best so far -> update
    if goodness > cctBins(cctBin, 1)
        cctBins(cctBin, 1) = goodness;
        cctBins(cctBin, 2) = i;
    end

end
disp(['Skipped ' num2str(nSkipped) ' combinations']);

%% Copy to mixing data
mixingData = zeros(length(cctBins), length(leds) + 1);
for i = 1:length(cctBins)
    if cctBins(i, 2) == 0 % index is 0 -> missed bin
        continue;
    end
    mixingData(i, :) = rawMixingData(cctBins(i, 2), :);
end

%% Remove empty bins
mixingData(mixingData(:, 1) == 0, :) = [];