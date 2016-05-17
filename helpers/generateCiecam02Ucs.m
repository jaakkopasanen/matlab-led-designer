
% I'm fairly certain that this script does not produce desired results

clear;
resolution = 0.01;
u_range = 0:resolution:0.63;
v_range = 0:resolution:0.6;
rgb = ones(length(v_range), length(u_range), 3);
ciecam02ucs = ones(length(v_range), length(u_range), 3);

tic
i = 1;
for v = v_range
    j = 1;
    for u = u_range
        if limCieLuv(u, v)
            % Tristimulus values
            X = -(9*u)/(3*u + 20*v - 12);
            Y = -(4*v)/(3*u + 20*v - 12);
            Z = 1;
            XYZ = [X Y Z];

            % Relative tristimulus values
            x = X / (X+Y+Z);
            y = Y / (X+Y+Z);
            z = Z / (X+Y+Z);

            % Reference white
            xyz = [x y z];
            %[u v x y z]
            XYZw = spdToXyz(refSpd(uvToCct(xyzToUv(xyz)), true), 10);

            % sRGB
            rgb(i, j, :) = xyz2rgb([x y z]);
            rgb(i, j, :) = rgb(i, j, :) ./ max(rgb(i, j, :));

            % CIECAM02-UCS
            ciecam02ucs(i, j, :) = xyzToCiecam02Ucs(XYZ, XYZw, 100, 20, 1, 0.69, 1);
            %}
        end
        j = j + 1;
    end
    i = i + 1;
end

rgb(rgb<0) = 0;
hold on;
for i = 1:size(rgb, 1) % v
    for j = 1:size(rgb, 2) % u
        plot(ciecam02ucs(i,j,2), ciecam02ucs(i,j,3), '.', 'Color', rgb(i,j,:), 'LineWidth', 3);
    end
end
axis([-100 100 -100 100])
hold off;

toc

clear x y z X Y Z XYZ XYZw resolution i j