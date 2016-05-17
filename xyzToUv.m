function [ uv ] = xyzToUv( xyz )
%XYTOUV Converts CIE1931 xyz color coordinates to CIE1960 uv coordinates
%Syntax
%   uv = xyzToUv(xyz)
%Input
%   xyz := Relative tristimuluz values
%Output
%   uv := CIE 1960 color coordinates

x = xyz(1); y = xyz(2);
u = 4*x / (-2*x + 12*y + 3);
v = 6*y / (-2*x + 12*y + 3);
uv = [u, v];

end

