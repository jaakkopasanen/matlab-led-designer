function [ spd ] = refSpd( cct, linearTransition )
%REFSPD Generates reference spd
%Syntax
%   spd = refSpd(T, linearTransition)
%Input
%   cct              := Correlated color temperature in Kelvins
%   linearTransition := Use linear transition from black body radiator to
%                       Illuminant D in the temperature range from 4500K to
%                       5500K. If false then the reference SPD has
%                       non-continuous point at 5000K
%Output
%   spd := Spectral power distribution for the reference illuminant.
%          Sampled from 380nm to 780nm at 5nm interval

% Load planck spd data
persistent planckSpd;
if isempty(planckSpd)
    % Creates variable planckSpd
    % each row is spectral power distribution for planck radiator at
    % temperature
    % Temperatures range from 1K to 25000K with 1K sampling rate
    load('cie.mat', 'planckSpd');
end

% Load CIE illuminant D data
persistent cieIlluminantDSpd;
if isempty(cieIlluminantDSpd)
    % Creates variable cieIlluminantDSpd
    % each row is spectral power distribution for illuminant D at
    % temperature
    % Temperatures range from 1K to 25000K with 1K sampling rate
    load('cie.mat', 'cieIlluminantDSpd');
end

if ~exist('linearTransition', 'var')
    linearTransition = false;
end

% Use linear transition from Planckian radiator to IlluminantD in the CCT
% range of 4500K to 5500K
if linearTransition
    if cct < 4500 % Planckian radiator
        spd = planckSpd(cct, :);
    elseif cct < 5500 % Linear combination
        c = (5500 - cct) / 1000;
        spd = sum(bsxfun(@times,[planckSpd(cct, :); cieIlluminantDSpd(cct, :)],[c; 1-c]));
    else % Illuminant D
        spd = cieIlluminantDSpd(cct, :);
    end
    
% Normal hard breakoff point in the 5000K
else
    if cct < 5000
        spd = planckSpd(cct, :);
    else
        spd = cieIlluminantDSpd(cct, :);
    end
end

end

