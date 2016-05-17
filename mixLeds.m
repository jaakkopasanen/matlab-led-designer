function [ mixingData ] = mixLeds( leds, res, coeffs )
%UNTITLED8 Mix leds by brute force
%Syntax
%   mixingData = mixLeds(leds, res, coeffs)
%Input
%   leds := Column array Led objects
%   res  := Mixing resolution eg 0.01
%Output
%   mixingData := All mixtures. Each row contains one mixture, columns are
%                 [cct, led1C, led2C, ... , ledNC]

%{
if l < length(leds)
    mixLeds( leds, resolution, l + 1);
else
    maxC = min(leds(l).maxCoeff, 1-sum(coeffs));
    for c = maxC:-resolution:0
        spd = mixSpd(leds, [coeffs c]);
        cct = spdToCct(spd);
        mixingData(i, :) = [cct coeffs c];
        i = i + 1;
    end
end
%}

if ~exist('coeffs', 'var')
    coeffs = [];
end

mixingData = [];

% Last LED reached -> calculate data sample
if length(coeffs) == length(leds)
    % Do not add mixing coeffs that do not sum to 1 (avoids duplicates)
    if sum(coeffs) < 1
        mixingData = [];
        return
    end
    
    % Read spds from LEDs
    spds = zeros(length(leds), length(leds(1).spd));
    for i = 1:length(leds)
        spds(i, :) = leds(i).spd;
    end
    
    % Mix spds
    spd = mixSpd(spds, coeffs');
    
    % Calculate correlated color temperature
    cct = spdToCct(spd);
    
    % Add row to mixing data
    mixingData = [cct coeffs];
    
% Not yet last LED -> recursive call for all coefficients
else
    % Maximum coefficient for current LED is the smaller of LEDs internal
    % max coeff and whats left from other LED coeffs
    maxC = min(leds(length(coeffs) + 1).maxCoeff, 1-sum(coeffs));
    
    % Iterate all coefficients
    for c = maxC:-res:0
        mixingData = [mixingData; mixLeds(leds, res, [coeffs c])];
    end
end

end

