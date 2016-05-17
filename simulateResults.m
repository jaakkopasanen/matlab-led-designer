%% Simulates results based on mixing data generated in previous step
%
% This script is part of tunable white script pipe
% Variables needed in this script are initialized in generateMixingData.m
%

%% Generate spectrums for each 10 Kelvins
% Array of CCTs
ccts = minCCT:10:maxCCT;
% Spectrums generated with mixing coefficients
% Each row contains one spectrum
spds = zeros(length(ccts), length(L));
% Reference spectrums to which the mixed spectrums are compared
% Uses black body radiator below 5000K and IlluminantD above 5000K
%refs = spds;
% Color rendering indexes for each generated spectrum
%cris = zeros(length(ccts), 1);
% Rf and Rg for each spectrum
Rfs = zeros(length(ccts), 1);
Rgs = zeros(length(ccts), 1);
goodnesses = zeros(length(ccts), 1);
duvs = zeros(length(ccts), 1);
XYZs = zeros(length(ccts), 3);
% Luminous Efficacy Radiation functions
LERs = zeros(length(ccts), 1);
% Maximum lumens
maxLumens = zeros(length(ccts), 1);
% Mixing coefficients based on polynomial fit functions
% Each row contains mixing coefficients for respective spectrum
% Columns red, warm white and cold white coefficients repectively
fitCoeffs = zeros(length(ccts), length(leds));
% True coefficients needed for LED mixing with taking powers into account
trueCoeffs = zeros(length(ccts), length(leds));
for i = 1:length(ccts)
    % Save mixing coefficients
    %fc = estimateCoeffs(ccts(i), mixingData);
    %size(fc)
    fitCoeffs(i, :) = estimateCoeffs(ccts(i), mixingData);
    
    % Generate mixed spectrum with the generated mixing coefficients
    spds(i, :) = mixSpd(ledSpds, fitCoeffs(i, :)');
    
    % Save CRI for the generated spectrum
    % Save Rf and Rg for the generated spectrum
    [Rfs(i), Rgs(i)] = spdToRfRg(spds(i, :));
    XYZs(i, :) = spdToXyz(spds(i, :));
    XYZw = spdToXyz(refSpd(ccts(i)));
    [goodnesses(i), duvs(i)] = lightGoodness(Rfs(i), Rgs(i), XYZs(i, :), XYZw, targetRg, RfPenalty, RgPenalty, duvPenalty);
    
    % Save luminous efficacy of spectrum normalized to Y=100
    LERs(i) = spdToLER(spds(i, :));
    
    % Save max lumens and true coefficients
    [maxLumens(i), trueCoeffs(i, :)] = calMaxLumens(leds, fitCoeffs(i, :)');
    
    % Generate reference spectrum with current CCT
    % Scale reference spectrum so that luminosity outputs for mixed spectrum
    % and reference spectrum are equal
    %refs(i, :) = refs(i, :) * (Y / Yw);
end