clear; clc
load('cie.mat', 'cieSpectralLuminousEfficiency');
tic
% Wavelengths
L = 380:5:780;
%figure;

% LEDs
% Parameters for these shold come from rgbCalibration.m
red = gaussmf(L, [10/2.355 630]); redL = 160;
green = gaussmf(L, [10/2.355 525]); greenL = 320;
blue = gaussmf(L, [10/2.355 465]); blueL = 240;
powers = [
    redL / spdToLER(red)
    greenL / spdToLER(green)
    blueL / spdToLER(blue)
];
powers = powers * (1 / max(powers));
red = red * powers(1);
green = green * powers(2);
blue = blue * powers(3);

% Led u'v' coordinates
sourceUvs = [
    xyzToCie1976UcsUv(spdToXyz(red));
    xyzToCie1976UcsUv(spdToXyz(green));
    xyzToCie1976UcsUv(spdToXyz(blue));
    xyzToCie1976UcsUv(spdToXyz(red));
];

c = 0:0.01:1;

% Red to green
D_rg = sqrt(sum((sourceUvs(1,:)-sourceUvs(2,:)).^2));
d_rg = [];
i = 1;
for r = c
    g = 1 - r;
    spd = mixSpd([red;green], [r;g]);
    XYZ = spdToXyz(spd, 2);
    uv = xyzToCie1976UcsUv(XYZ);
    % Distance from red
    d_rg(i) = sqrt(sum((sourceUvs(1, :) - uv).^2)) / D_rg;
    i = i + 1;
end
d_gr = flip(1 - d_rg, 2);
%
subplot(2,2,1);
plot(d_rg, c, 'r',  d_gr, c, 'g');
title('Red to green, Green to red');
xlabel('Distance from source');
ylabel('Source level');
legend('Red', 'Green');
grid on;
%}

% Green to blue
D_gb = sqrt(sum((sourceUvs(2,:)-sourceUvs(3,:)).^2));
d_gb = [];
i = 1;
for g = c
    b = 1 - g;
    spd = mixSpd([green;blue], [g;b]);
    XYZ = spdToXyz(spd, 2);
    uv = xyzToCie1976UcsUv(XYZ);
    % Distance from green
    d_gb(i) = sqrt(sum((sourceUvs(2, :) - uv).^2)) / D_gb;
    i = i + 1;
end
d_bg = flip(1 - d_gb, 2);
%
subplot(2,2,2);
plot(c, d_gb, 'g', c, d_bg, 'b');
title('Green to blue, Blue to green');
xlabel('Distance from source');
ylabel('Source level');
legend('Green', 'Blue');
grid on;
%}

% Blue to red
D_br = sqrt(sum((sourceUvs(3,:)-sourceUvs(1,:)).^2));
d_br = [];
i = 1;
for b = c
    r = 1 - b;
    spd = mixSpd([blue;red], [b;r]);
    XYZ = spdToXyz(spd, 2);
    uv = xyzToCie1976UcsUv(XYZ);
    % Distance from red
    d_br(i) = sqrt(sum((sourceUvs(3, :) - uv).^2)) / D_br;
    i = i + 1;
end
d_rb = flip(1 - d_br, 2);
%
subplot(2,2,3);
plot(c, d_br, 'b', c, d_rb, 'r');
title('Blue to red, Red to blue');
xlabel('Distance from source');
ylabel('Source level');
legend('Blue', 'Red');
grid on;
%}

% Create fits
fits = createRgb2Fits(c, d_rg, d_rb, d_gb, d_gr, d_br, d_bg, false);
redToGreenFit = fits{1};
redToBlueFit = fits{2};
greenToBlueFit = fits{3};
greenToRedFit = fits{4};
blueToRedFit = fits{5};
blueToGreenFit = fits{6};

% Test points
subplot(2,2,4);
plotCieLuv([], false);
hold on;
% Plot gamut
plot(sourceUvs(:,1), sourceUvs(:,2), '-k');
err = [];

%testPoints = [0.1934 0.4985];

for i = 1:100
    % Test point
    target = [rand*0.55 rand*0.6];
    %target = testPoints(i,:);
    
    % Not inside gamut, omit point
    if ~inpolygon(target(1), target(2), sourceUvs(1:3,1), sourceUvs(1:3,2))
        continue;
    end
    
    % Find mixing coefficients
    %disp('RED');
    [r, ~, line_r] = findLevel(sourceUvs(1:3, :), target, redToGreenFit, redToBlueFit, 0.001, 20);
    %disp('GREEN');
    [g, ~, line_g,] = findLevel([sourceUvs(2:3, :); sourceUvs(1, :)], target, greenToBlueFit, greenToRedFit, 0.001, 20);
    %disp('BLUE');
    [b, ~, line_b] = findLevel([sourceUvs(3, :); sourceUvs(1:2, :)], target, blueToRedFit, blueToGreenFit, 0.001, 20);
    
    rgb = [r g b];
    rgb = rgb .* (1/max(rgb));
    %uvRgb =  [target rgb]
    
    % Simulate color
    uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green;blue], [r;g;b])));
    
    % Error
    err(i) = sqrt( sum( (uv - target).^2 ) );
    
    % Plot dashed line from sources to test point
    %plot([sourceUvs(1,1) target(1)], [sourceUvs(1,2) target(2)], '--ok');
    %plot([sourceUvs(2,1) target(1)], [sourceUvs(2,2) target(2)], '--ok');
    %plot([sourceUvs(3,1) target(1)], [sourceUvs(3,2) target(2)], '--ok');
    
    % Plot lines
    %plot(line_r(:,1)', line_r(:,2)', 'k');
    %plot(line_g(:,1)', line_g(:,2)', 'k');
    %plot(line_b(:,1)', line_b(:,2)', 'k');
    
    % Plot target and result
    plot(target(1), target(2), 'ok');
    plot(uv(1), uv(2), '+k');
    plot([target(1) uv(1)], [target(2) uv(2)], 'k');
end

title(['Mean error = ' num2str(mean(err))]);
hold off;

% Luminous efficiencies
luminousFluxes = [
    sum(bsxfun(@times, red, cieSpectralLuminousEfficiency))
    sum(bsxfun(@times, green, cieSpectralLuminousEfficiency))
    sum(bsxfun(@times, blue, cieSpectralLuminousEfficiency))
];
luminousFluxes = luminousFluxes * (1 / max(luminousFluxes));
%}
%
disp([
    '----------------------------'
    'Relative luminous fluxes    '
    '----------------------------'
    'Rows                        '
    '    red                     '
    '    green                   '
    '    blue                    '
    '----------------------------'
]);
disp(luminousFluxes);

disp([
    '----------------------------'
    'u'' v'' coordinates           '
    '----------------------------'
    'Rows                        '
    '    red                     '
    '    green                   '
    '    blue                    '
    'Columns                     '
    '    u''  v''                  '
    '----------------------------'
]);
disp(sourceUvs(1:3,:));

disp([
    '----------------------------'
    'LED fit data                '
    '----------------------------'
    '       p1*x + p2            '
    'y = ---------------         '
    '    x^2 + q1*x + q2         '
    'Rows                        '
    '    red to green            '
    '    red to blue             '
    '    green to blue           '
    '    green to red            '
    '    blue to red             '
    '    blue to green           '
    'Columns                     '
    '    p1  p2  q1  q2          '
    '----------------------------'
]);
disp([
    coeffvalues(redToGreenFit)
    coeffvalues(redToBlueFit)
    coeffvalues(greenToBlueFit)
    coeffvalues(greenToRedFit)
    coeffvalues(blueToRedFit)
    coeffvalues(blueToGreenFit)
]);
%}
%toc