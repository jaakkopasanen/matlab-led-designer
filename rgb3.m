clear; clc
load('cie.mat', 'cieSpectralLuminousEfficiency');
tic
% Wavelengths
L = 380:5:780;
%figure;

% LEDs
% Parameters for these shold come from rgbCalibration.m
%red = gaussmf(L, [10/2.355 (627+rand()*5)])*(1+rand()*0.5);
%green = gaussmf(L, [10/2.355 (525+rand()*5)])*(1+rand()*0.5);
%blue = gaussmf(L, [10/2.355 (465+rand()*5)])*(1+rand()*0.5);

red = gaussmf(L, [5/2.355 630]); redL = 11;
green = gaussmf(L, [5/2.355 525]); greenL = 100;
blue = gaussmf(L, [5/2.355 465]); blueL = 20;
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
sRgbUvs = [
   xyzToCie1976UcsUv(rgb2xyz([1 0 0])); 
   xyzToCie1976UcsUv(rgb2xyz([0 1 0])); 
   xyzToCie1976UcsUv(rgb2xyz([0 0 1])); 
   xyzToCie1976UcsUv(rgb2xyz([1 0 0])); 
];

c = 0:0.01:1;

% Red to green
D_rg = sqrt(sum((sourceUvs(1,:)-sourceUvs(2,:)).^2));
d_rg = []; i = 1;
for r = c
    g = 1 - r;
    uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green], [r;g]), 2));
    d_rg(i) = sqrt(sum((sourceUvs(1, :) - uv).^2)) / D_rg;
    i = i + 1;
end
d_gr = flip(1 - d_rg, 2);

% Green to blue
D_gb = sqrt(sum((sourceUvs(2,:)-sourceUvs(3,:)).^2));
d_gb = []; i = 1;
for g = c
    b = 1 - g;
    uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([green;blue], [g;b]), 2));
    d_gb(i) = sqrt(sum((sourceUvs(2, :) - uv).^2)) / D_gb;
    i = i + 1;
end
d_bg = flip(1 - d_gb, 2);

% Blue to red
D_br = sqrt(sum((sourceUvs(3,:)-sourceUvs(1,:)).^2));
d_br = []; i = 1;
for b = c
    r = 1 - b;
    uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([blue;red], [b;r]), 2));
    d_br(i) = sqrt(sum((sourceUvs(3, :) - uv).^2)) / D_br;
    i = i + 1;
end
d_rb = flip(1 - d_br, 2);

% Create fits
[rgFit, rgInv] = fitRat11(d_rg, c);
[gbFit, gbInv] = fitRat11(d_gb, c);
[brFit, brInv] = fitRat11(d_br, c);

% Test fits
x = 0:0.01:1;
c_rg = rat11(x, rgFit);
c_gr = 1 - rat11(1 - x, rgFit);
c_gb = rat11(x, gbFit);
c_bg = 1 - rat11(1 - x, gbFit);
c_br = rat11(x, brFit);
c_rb = 1 - rat11(1 - x, brFit);

% Red - Green
subplot(2,3,4);
plot(d_rg, c, 'r', d_gr, c, 'g',  x, c_rg, 'r.', x, c_gr, 'g.');
title('Red to green, Green to red');
xlabel('Distance from source');
ylabel('Source level');
legend('Red', 'Green');
grid on;
axis([0 1 0 1]);

% Green - Blue
subplot(2,3,5);
plot(d_gb, c, 'g', d_bg, c, 'b',  x, c_gb, 'g.', x, c_bg, 'b.');
title('Green to blue, Blue to green');
xlabel('Distance from source');
ylabel('Source level');
legend('Green', 'Blue');
grid on;
axis([0 1 0 1]);

% Blue - Red
subplot(2,3,6);
plot(d_br, c, 'b', d_rb, c, 'r',  x, c_br, 'b.', x, c_rb, 'r.');
title('Blue to red, Red to blue');
xlabel('Distance from source');
ylabel('Source level');
legend('Blue', 'Red');
grid on;
axis([0 1 0 1]);

% TODO: fit left hand side functions by right hand side distances
% e.g. d_rb vs d_rg
[rbFit, rbInv] = fitRat11(d_rg, d_rb);
[grFit, grInv] = fitRat11(d_gb, d_gr);
[bgFit, bgInv] = fitRat11(d_br, d_bg);

% Test left hand fit
d_rb_t = rat11(1-d_rg, rbFit);
d_gr_t = rat11(1-d_gb, grFit);
d_bg_t = rat11(1-d_br, bgFit);
subplot(2,3,2);
plot(d_rg, d_rb, 'r', d_gb, d_gr, 'g', d_br, d_bg, 'b', d_rg, d_rb_t, 'r.', d_gb, d_gr_t, 'g.', d_br, d_bg_t, 'b.');
title('Left hand side distance by right hand side distance');
xlabel('Right hand side distance');
ylabel('Left hand side distance');
legend('Red to Blue', 'Green to Red', 'Blue to Green', 'Location', 'SouthEast');
grid on;
axis([0 1 0 1]);

% Gamuts
subplot(2,3,1);
plotCieLuv([], false);
hold on;
plot(sourceUvs(:,1), sourceUvs(:,2), 'k');
plot(sRgbUvs(:,1), sRgbUvs(:,2), '--k');
hold off;
title('Gamut');
legend('Photopic vision', 'RGB LED', 'sRGB', 'Location', 'SouthEast');

% Test points
subplot(2,3,3);
plotCieLuv([], false);
hold on;
plot(sourceUvs(:,1), sourceUvs(:,2), 'k');
err = [];
testPoints = [
    0.205 0.562
    0.079 0.443
    0.334 0.292
];

for i = 1:3
    % Test point
    %target = [rand*0.55 rand*0.6];
    target = testPoints(i,:);
    
    % Not inside gamut, omit point
    if ~inpolygon(target(1), target(2), sourceUvs(1:3,1), sourceUvs(1:3,2))
        continue;
    end
    
    % Find mixing coefficients
    %disp('-- RED --');
    r = findLevel2(target, sourceUvs(1,:), sourceUvs(2,:), sourceUvs(3,:), rgFit, gbFit);
    %disp('-- GREEN --');
    g = findLevel2(target, sourceUvs(2,:), sourceUvs(3,:), sourceUvs(1,:), gbFit, brFit);
    %disp('-- BLUE --');
    b = findLevel2(target, sourceUvs(3,:), sourceUvs(1,:), sourceUvs(2,:), brFit, rgFit);
    
    rgb = [r g b];
    rgb = rgb .* (1/max(rgb));
    uv_rgb =  [target rgb]
    
    % Simulate color
    uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green;blue], [r;g;b])));
    
    % Error
    err(i) = sqrt( sum( (uv - target).^2 ) );
    
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
    'Red-to-blue VS Green-to-blue'
    '----------------------------'
]);
disp([rbFit; gbFit]);
disp([
    '----------------------------'    
    'Green-to-red VS Blue-to-red '
    '----------------------------'
]);
disp([grFit; brFit]);
disp([
    '---------------------------- '
    'Blue-to-green VS Red-to-green'
    '---------------------------- '
]);
disp([bgFit; rgFit]);

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
    '     p1*x + p2              '
    'y = -----------             '
    '       x + q1               '
    'Rows                        '
    '    red to green            '
    '    green to blue           '
    '    blue to red             '
    'Columns                     '
    '    p1  p2  q1              '
    '----------------------------'
]);
disp([
    rgFit
    gbFit
    brFit
]);
%}
%toc