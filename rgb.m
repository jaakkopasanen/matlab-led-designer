%clear;
tic
% Wavelengths
L = 380:5:780;
figure;
% LEDs
red = gaussmf(L, [20/2.355 630]); redL = 160;
green = gaussmf(L, [20/2.355 525]); greenL = 320;
blue = gaussmf(L, [20/2.355 465]); blueL = 240;

% Parameters
resolution = 0.02;
HMsize = [150 150];
interpolationMethod = 'linear';
extrapolationMethod = 'nearest';

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

% Mixing data
data = [];
i = 1;
for r = 0:resolution:1
    for g = 0:resolution:1-r
        b = 1-r-g;
        uv = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green;blue], [r;g;b])));
        data(i, :) = [uv r g b];
        i = i + 1;
    end
end

% Heatmap data
HM = ones(HMsize(1), HMsize(2), 3);
[U,V] = meshgrid(linspace(0,0.63,HMsize(2)),linspace(0,0.6,HMsize(1)));
Fr = scatteredInterpolant(data(:,1),data(:,2),data(:,3),interpolationMethod,extrapolationMethod);
HM(:,:,1) = Fr(U,V);
Fg = scatteredInterpolant(data(:,1),data(:,2),data(:,4),interpolationMethod,extrapolationMethod);
HM(:,:,2) = Fg(U,V);
Fb = scatteredInterpolant(data(:,1),data(:,2),data(:,5),interpolationMethod,extrapolationMethod);
HM(:,:,3) = Fb(U,V);

% Gamuts
subplot(2,3,1);
plotCieLuv([], false);
hold on;
plot(sourceUvs(:,1), sourceUvs(:,2), 'k');
plot(sRgbUvs(:,1), sRgbUvs(:,2), '--k');
hold off;
title('Gamut');
legend('Photopic vision', 'RGB LED', 'sRGB', 'Location', 'SouthEast');

% RGB heatmap
subplot(2,3,2);
imagesc([0 0.63], [0 0.6], HM);
hold on; plot(sourceUvs(:,1), sourceUvs(:,2), 'k'); hold off;
axis([0 0.63 0 0.6]);
set(gca, 'ydir', 'normal');
title('RGB heatmap');
xlabel('u'''); ylabel('v''');

% Heatmap for red
subplot(2,3,4);
contourf(U,V,HM(:,:,1),100,'LineColor','none');
hold on; plot(sourceUvs(:,1), sourceUvs(:,2), 'k'); hold off;
axis([0 0.63 0 0.6]);
%colorbar;
title('Red LED heatmap');
xlabel('u'''); ylabel('v''');
% Heatmap for green
subplot(2,3,5);
contourf(U,V,HM(:,:,2),100,'LineColor','none');
hold on; plot(sourceUvs(:,1), sourceUvs(:,2), 'k'); hold off;
axis([0 0.63 0 0.6]);
%colorbar;
title('Green LED heatmap');
xlabel('u'''); ylabel('v''');
% Heatmap for blue
subplot(2,3,6);
contourf(U,V,HM(:,:,3),100,'LineColor','none');
hold on; plot(sourceUvs(:,1), sourceUvs(:,2), 'k'); hold off;
axis([0 0.63 0 0.6]);
%colorbar;
title('Blue LED heatmap');
xlabel('u'''); ylabel('v''');

% Color error
subplot(2,3,3);
plotCieLuv([], false);
hold on; plot(sourceUvs(:,1), sourceUvs(:,2), 'k'); hold off;
hold on;
err = [];
for i = 1:1000
    u = rand*0.55;
    v = rand*0.6;
    if ~inpolygon(u, v, sourceUvs(1:3,1), sourceUvs(1:3,2))
        continue;
    end
    plot(u,v,'ok');
    uInd = min(HMsize(1), max(1, round(u/0.63*HMsize(1))));
    vInd = min(HMsize(2), max(1, round(v/0.6*HMsize(2))));
    c = HM(vInd, uInd, :);
    uv_t = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green;blue], [c(1);c(2);c(3)])));
    plot(uv_t(1), uv_t(2), '+k');
    plot([u uv_t(1)], [v uv_t(2)], 'k');
    err(i) = sqrt(sum(([u v]-uv_t).^2));
end
title(['Mean error = ' num2str(mean(err))]);
hold off;

suptitle('Estimating LED mixing coefficients by RGB heatmap');

toc