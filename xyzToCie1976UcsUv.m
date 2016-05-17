function [ uv ] = xyzToCie1976UcsUv( XYZ )
%XYZTOCIE1976UCSUV Calculates CIE 1976 Lu'v' coordinates from CIE 1931 XYZ
%Syntax
%   uv = xyzToCie1976UcsUv(XYZ)
%Input
%   XYZ := CIE 1931 tristimulus values [X Y Z]
%Output
%   uv := CIE 1976 UCS coordinates u'v'

u = 4*XYZ(1)  / (XYZ(1) + 15*XYZ(2) + 3*XYZ(3));
v = 9*XYZ(2) / (XYZ(1) + 15*XYZ(2) + 3*XYZ(3));
uv = [u v];

end

