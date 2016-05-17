function [ result, inversed ] = fitRat11( x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


startPoint = [-1 1 1];
inversed = false;
% Raising x -> inverse it
if x(round(length(x)/2)) > y(round(length(y)/2))
    x = 1 - x;
    startPoint = [1 -1 1];
    inversed = true;
end
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'rat11' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = startPoint;

% Fit model to data.
fitResult = fit( xData, yData, ft, opts );

result = coeffvalues(fitResult);

end

