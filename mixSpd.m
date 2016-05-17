function [ spd ] = mixSpd( spds, coeffs )
%MIXSPD Sum spectral power distributions and scale peak to 100
%Syntax
%   spd = mixSpd(spds, coeffs)
%Input
%   spds   := Matrix of spectral power distributions where each row
%             represents single SPD. SPDs must be from 380nm to 780nm
%             sampled at 5nm.
%   coeffs := Column vector of coefficients for respective SPDs
%Output
%   spd := SPD result from mixing input SPDs with input coefficients

% Coeffs should be column vector, transpose if it's row vector
if size(coeffs, 1) < size(coeffs, 2)
    coeffs = coeffs';
end

% Multiply each row of spds with respective coefficient. Sum everything
% together
spd = sum(bsxfun(@times,spds,coeffs));
% Normalize so that maximum value equals 1
spd = spd.*(1/max(spd));

end

