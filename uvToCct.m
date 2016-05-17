function [ cct, d_min ] = uvToCct( uv )
%UVTOCCT Finds correlated color temperature from CIE1960 color coordinates
%Syntax
%   [cct, d_min] = uvToCct(u, v)
%Input
%   u := u coordinate
%   v := v coordinate
%Outpu
%   cct   := Correlated color temperature in Kelvins
%   d_min := Minimum euclidean distance to Planckian locus

persistent cie1960PlanckianLocusUv;
if isempty(cie1960PlanckianLocusUv)
    load('cie.mat', 'cie1960PlanckianLocusUv');
end

persistent cie1960Cct;
if isempty(cie1960Cct)
    load('cie.mat', 'cie1960Cct');
end

u = uv(1); v = uv(2);
uInd = floor(u / 0.01 + 1);
vInd = floor(v / 0.01 + 1);
minCct = min(min(cie1960Cct(vInd:vInd+1, uInd:uInd+1)));
maxCct = max(max(cie1960Cct(vInd:vInd+1, uInd:uInd+1)));
%minCct = 1; maxCct = 25000;

[d_min, cct] = min(sqrt((cie1960PlanckianLocusUv(minCct:maxCct,1) - u).^2 + (cie1960PlanckianLocusUv(minCct:maxCct,2) - v).^2));
cct = minCct + cct - 1;

end

