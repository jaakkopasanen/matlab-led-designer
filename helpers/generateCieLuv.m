%imagesc([0 0.62345], [0 0.6], cie1976Ucs);
hold on;

%% Generate border by iterating all visible light wavelengths
wavelengths = zeros(60, 2);
for l = 1:59
    spd = zeros(1, 81);
    spd(l+6) = 1;
    [~, ~, ~, X, Y, Z] = spdToXyz(spd);
    denom = X + 15*Y + 3*Z;
    up = 4*X  / denom;
    vp = 9*Y / denom;
    wavelengths(l, :) = [up vp];
end
wavelengths(60, :) = wavelengths(1, :);

%% Background
resolution = 0.001;
bg = ones(length(lim(3):resolution:lim(4)), length(lim(1):resolution:lim(2)), 3);
i = 1;
for v = 0:resolution:0.6
    j = 1;
    for u = 0:resolution:0.63
        
        X = -(9*u)/(3*u + 20*v - 12);
        Y = -(4*v)/(3*u + 20*v - 12);
        Z = 1;
        x = X / (X+Y+Z);
        y = Y / (X+Y+Z);
        z = Z / (X+Y+Z);
        bg(i, j, :) = xyz2rgb([x y z]);
        bg(i, j, :) = bg(i, j, :) ./ max(bg(i, j, :));
        j = j + 1;
    end
    i = i + 1;
end
bg(bg > 1) = 1;
bg(bg < 0) = 0;

%% Planckian locus
cie1976PlanckianLocusUv = zeros(25000, 2);
for t = 1:25000
    spd = planckSpd(t, :);
    [~, ~, ~, X, Y, Z] = spdToXyz(spd);
    denom = X + 15*Y + 3*Z;
    up = 4*X  / denom;
    vp = 9*Y / denom;
    cie1976PlanckianLocusUv(t, :) = [up vp];
end

%% Plots
imagesc([0 0.63], [0 0.6], bg);
%plot(cie1976PlanckianLocusUv(:, 1), cie1976PlanckianLocusUv(:, 2), 'k');
plot(wavelengths(:, 1), wavelengths(:, 2), 'k', 'LineWidth', 1.5);
set(gca, 'ydir', 'normal');
axis([0 0.63 0 0.6]);
xlabel('u');
ylabel('v');

%% Cleanup
clear i j l resolution t time u up v vp wavelengths x y z X Y Z denom duration
hold off;