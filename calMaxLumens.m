function [ maxLumens, trueCoeffs ] = calMaxLumens( leds, coeffs )
%CALMAXLUMENS Calculates maximum lumens
%Syntax
%   [maxLumens, trueCoeffs] = calMaxLumens(leds, coeffs); 
%Input
%   leds   := Vector of LED class instances
%   coeffs := Column vector of mixing coefficients for LEDS. Coefficients
%             must be normalized so they sum up to 1
%Output
%   maxLumen   := Maximum lumens achievable with given LEDs and coeffs
%   trueCoeffs := True coeffients needed for mixing given LEDs with LED
%                 lumens taken into account. True coefficients are scaled
%                 so that greates coefficient equals 1 (No LED can be
%                 powered more than it's full power).

powers = zeros(length(leds), 1); % Radiation power
LERs = zeros(length(leds), 1); % Luminous efficiency of radiation
powerKs = zeros(length(leds), 1); % Power coefficient

for i = 1:length(leds)
    powers(i) = leds(i).power;
    % Power coefficient: LED true power divided by power of LED's
    % normalized spectral power distribution (5nm is the sample width)
    powerKs(i) = powers(i) / (sum(leds(i).spd*5));
    LERs(i) = leds(i).ler;
end

K = 1 / max(coeffs);
normalizedCoeffs = K*coeffs; % Largest coefficient now equals 1
scaledCoeffs = normalizedCoeffs ./ powerKs; % Normalize with LED powers
trueCoeffs = scaledCoeffs * (1/max(scaledCoeffs)); % Largest equals 1
truePowers = trueCoeffs .* powers; % LED powers with true coefficients
maxLumens = sum(truePowers .* LERs); % Total lumen output

end

