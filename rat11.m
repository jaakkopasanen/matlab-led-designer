function [ y ] = rat11( x, fitData )
%RAT11 Evaluate rational function with nominator and denominator deg of 1

% Mirror x if first fit coefficient is positive
% Only fits created with mirrored data have positive first fit coeff
if fitData(1) > 0
    y = (fitData(1) .* (1-x) + fitData(2)) ./ ((1-x) + fitData(3));
else
    y = (fitData(1) .* x + fitData(2)) ./ (x + fitData(3));
end

end

