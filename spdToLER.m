function [ LER ] = spdToLER( spd )
%SPDTOLER Calculates luminous efficacy of radiation for spd
%Syntax
%   LER = spdToLER(spd)
%Input
%   spd := Spectral power distribution sampled from 380nm to 780nm at 5nm
%          intervals
%Output
%   LER := Luminous efficacy of radiation

persistent cieSpectralLuminousEfficiency;
if isempty(cieSpectralLuminousEfficiency)
    load('cie.mat', 'cieSpectralLuminousEfficiency');
end
LER = 683 * sum(cieSpectralLuminousEfficiency.*spd) / sum(spd);

end

