function [ cct ] = spdToCct( spd )
%SPDTOCCT Calculates correlated color temperature for a spectrum
%Syntax
%   cct = spdToCct(spd)
%Input
%   spd := Spectral power distribution sampled from 380nm to 780nm at 5nm
%          intervals
%Output
%   cct := Correlated color temperature in Kelvins

% Calculate CIE 1931 color coordinates x, y
[~, xyz] = spdToXyz(spd);

% Transform into CIE1960 color coordinates u, v
uv = xyzToUv(xyz);

% Calculate correlated color temperature
cct = uvToCct(uv);

end

