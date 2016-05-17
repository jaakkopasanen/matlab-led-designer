L = 380:5:780;
red = gaussmf(L, [10/2.355 630]); redL = 160;
green = gaussmf(L, [10/2.355 525]); greenL = 320;
r = 0.5; g = 0.4; b = 0.1;
target = xyzToCie1976UcsUv(spdToXyz(mixSpd([red;green;blue], [r g b]), 2));

plotCieLuv([], false);
hold on;
plot(sourceUvs(:,1), sourceUvs(:,2), 'k');
plot(target(1), target(2), 'ok');

% Red
[r, dR, dL] = findLevel2(target, sourceUvs(1,:), sourceUvs(2,:), sourceUvs(3,:), rgFit, rbFit);
%[r dR dL]
ru = sourceUvs(1,1) + (sourceUvs(2,1) - sourceUvs(1,1)) * dR;
rv = sourceUvs(1,2) + (sourceUvs(2,2) - sourceUvs(1,2)) * dR;
lu = sourceUvs(1,1) + (sourceUvs(3,1) - sourceUvs(1,1)) * dL;
lv = sourceUvs(1,2) + (sourceUvs(3,2) - sourceUvs(1,2)) * dL;
plot([ru lu], [rv lv], 'k');

% Green
[g, dR, dL] = findLevel2(target, sourceUvs(2,:), sourceUvs(3,:), sourceUvs(1,:), gbFit, grFit);
%[g dR dL]
ru = sourceUvs(2,1) + (sourceUvs(3,1) - sourceUvs(2,1)) * dR;
rv = sourceUvs(2,2) + (sourceUvs(3,2) - sourceUvs(2,2)) * dR;
lu = sourceUvs(2,1) + (sourceUvs(1,1) - sourceUvs(2,1)) * dL;
lv = sourceUvs(2,2) + (sourceUvs(1,2) - sourceUvs(2,2)) * dL;
plot([ru lu], [rv lv], 'k');

% Blue
[b, dR, dL] = findLevel2(target, sourceUvs(3,:), sourceUvs(1,:), sourceUvs(2,:), brFit, bgFit);
%[b dR dL]
ru = sourceUvs(3,1) + (sourceUvs(1,1) - sourceUvs(3,1)) * dR;
rv = sourceUvs(3,2) + (sourceUvs(1,2) - sourceUvs(3,2)) * dR;
lu = sourceUvs(3,1) + (sourceUvs(2,1) - sourceUvs(3,1)) * dL;
lv = sourceUvs(3,2) + (sourceUvs(2,2) - sourceUvs(3,2)) * dL;
plot([ru lu], [rv lv], 'k');

hold off;