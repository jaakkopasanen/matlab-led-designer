function [ Rf, Rg, bins ] = spdToRfRg( spd, cct )
%SPDTORFRG Calculates TM-30-15 Rf and Rg metrics from SPD
%Syntax
%   [Rf, Rg, bins] = spdToRfRg(spd, cct)
%Input
%   spd := Spectral power distribution sampled from 380nm to 780nm at 5nm
%          intervals
%   cct := Optional correlated color temperature. Not needed but will skip
%          the CCT calculation speeding up the calculation if CCT has
%          already been calculated
%Output
%   Rf     := Fidelity score [0,100]
%   Rg     := Gamut score
%   bins   := Data for all 16 bins. Row per bin, columns are:
%             a_r := a coordinate under reference illuminant
%             b_r := b coordinate under reference illuminant
%             a_t := a coordinate under test illuminant
%             b_t := b coordinate under test illuminant
%             x_r := Color icon path x coordinate under reference illuminant
%             y_r := Color icon path y coordinate under reference illuminant
%             x_t := Color icon path x coordinate under test illuminant
%             y_t := Color icon path y coordinate under test illuminant
%             Rfb := Average fidelity score

% Load test colors if not yet loaded
persistent TM3015TestColors;
if isempty(TM3015TestColors)
    % Creates variable TM3015TestColors
    % each row is spectral radiance factors for TM-30-15 test color sample
    % Wavelengths span 380nm to 780nm with 5nm sampling
    load('TM3015.mat', 'TM3015TestColors');
end

% Error/score factor
cfactor = 7.54;

% Calculate colorimetry for test illuminant
XYZ_t = spdToXyz(spd, 10);
XYZ_t = XYZ_t';
K_t = 100 / XYZ_t(2);
XYZ_t = K_t * XYZ_t;
%X_t = K_t * X_t;
%Y_t = K_t * Y_t;
%Z_t = K_t * Z_t;

% Calculate correlated color temperature CCT
if ~exist('cct', 'var')
    cct = spdToCct(spd);
end

% Calculate reference spd
ref = refSpd(cct, true);

% Calculate colorimetry for reference illuminant
XYZ_r = spdToXyz(ref, 10);
XYZ_r = XYZ_r';
K_r = 100 / XYZ_r(2);
XYZ_r = K_r * XYZ_r;
%X_r = K_r * X_r;
%Y_r = K_r * Y_r;
%Z_r = K_r * Z_r;

% Parameters for CIECAM02 color appearance model
LA = 100; % Absolute luminance
Yb = 20; % Relative background luminance
Did = 2; % Adaptation mode: <1 := Manual, 1 := Full adaptation, 2 := Partial adaptation
F = 1; % Adaptation factor, 1 for bright environment
c = 0.69; % Impact of surrounding
Nc = 1; % Chromatic induction factor
% Degree of adaptation (discounting)
if Did == 1
    D = 1;
elseif Did < 1
    D = Did;
else
    D = F * (1 - 1/3.6*exp((-LA-42) / 92));
end

% Errors
dEi = zeros(1, 99);

    function [ t ] = calculateTheta( a, b )
    % Calculates angle for color
        t = atan(b / a);
        if and(a < 0, b > 0)
            t = t + pi;
        end
        if and(a < 0, b < 0)
            t = t + pi;
        end
        if and(a > 0, b < 0)
            t = t + 2*pi;
        end
    end

% Temporary bin data
binData = zeros(99, 9);

% Calculate Jc, aMc, bMc and error for all test color samples
for i = 1:99
    % Reference light
    JcaMcbMc_r = xyzToCiecam02Ucs(spdToXyz(TM3015TestColors(i,:).*ref.*K_r, 10), XYZ_r, LA, Yb, D, c, Nc);
    
    % Test light
    JcaMcbMc_t = xyzToCiecam02Ucs(spdToXyz(TM3015TestColors(i,:).*spd.*K_t, 10), XYZ_t, LA, Yb, D, c, Nc);
    
    % Error
    dEi(i) = sqrt(sum((JcaMcbMc_r - JcaMcbMc_t).^2));
    
    % Bin data
    theta = calculateTheta(JcaMcbMc_r(2), JcaMcbMc_r(3));
    binN = floor(((theta/2)/pi)*16) + 1;
    % Jc_r, aMc_r, bMc_r, Jc_t, aMc_t, bMc_t, theta, binNumber dE
    binData(i, :) = [JcaMcbMc_r JcaMcbMc_t theta binN dEi(i)];
end

% Calculate average a, b coordinates for bins
binCoords = zeros(17, 6);
for i = 1:16
    % Select all test color samples from bin data where bin number is <i>
    tcs = binData(binData(:, 8) == i, :);

    dE = mean(tcs(:, 9));
    Rfb = 10 * log(exp((100 - cfactor * dE) / 10) + 1);
    % Bin averages for: aMc_r, bMc_r, aMc_t, bMc_t, theta, Rf
    binCoords(i, :) = [mean(tcs(:, 2)) mean(tcs(:, 3)) mean(tcs(:, 5)) mean(tcs(:, 6)) mean(tcs(:, 7)) Rfb];
end

% Copy first bin coordinates to 17th bin for stats calculations
binCoords(17, :) = binCoords(1, :);

% Calculate bin, bin+1 stats from bin coordinates
binStats = zeros(16, 9);
for i = 1:16
    % aMc_r difference between next sample and this one
    dar = binCoords(i + 1, 1) - binCoords(i, 1);
    % bMc_r average from next sample and this one
    mbr = (binCoords(i + 1, 2) + binCoords(i, 2)) / 2;
    
    % aMc_r difference between next sample and this one
    dat = binCoords(i + 1, 3) - binCoords(i, 3);
    % bMc_r average from next sample and this one
    mbt = (binCoords(i + 1, 4) + binCoords(i, 4)) / 2;
    
    % Path for icon plot
    theta = binCoords(i, 5);
    x_r = cos(theta);
    y_r = sin(theta);
    %[x_r;y_r]
    % da_rel = (aMc_t - aMc_r) / sqrt(aMc_r^2 + bMc_r^2)
    da_rel = (binCoords(i, 3) - binCoords(i, 1)) / sqrt(binCoords(i, 1)^2 + binCoords(i, 2)^2);
    % db_rel = (bMc_t - bMc_r) / sqrt(aMc_r^2 + bMc_r^2)
    db_rel = (binCoords(i, 4) - binCoords(i, 2)) / sqrt(binCoords(i, 1)^2 + binCoords(i, 2)^2);
    x_t = x_r + da_rel;
    y_t = y_r + db_rel;
    
    % Average fidelity score
    Rfb = binCoords(i, 6);
    
    % Save stats for current bin
    binStats(i, :) = [dar, mbr, dat, mbt, x_r, y_r, x_t, y_t, Rfb];
end

bins = binStats;
bins(17, :) = bins(1, :);

A0 = sum(bsxfun(@times, binStats(:, 1), binStats(:, 2)));
A1 = sum(bsxfun(@times, binStats(:, 3), binStats(:, 4)));
Rg = A1 / A0 * 100;
if isnan(Rg)
    Rg = 150;
end
% Gamut score
Rg = max(min(150, Rg), 50);

% Average error
dEavg = mean(dEi);

% Special fidelity scores
%Rfi = 10*log(exp((100 - cfactor .* dEi') / 10) + 1);

% General fidelity score
Rf = 10*log(exp((100 - cfactor * dEavg) / 10) + 1);

end