clear;
tic
% Wavelengths
L = 380:5:780;

% True SPDs of the LEDs, parameters for these we are trying to find
red_hidden = gaussmf(L, [20/2.355 630])*1.5;
green_hidden = gaussmf(L, [20/2.355 525]);
blue_hidden = gaussmf(L, [20/2.355 465])*1.9;

% sRGB u'v' coordinates
sRgbUvs = [
   xyzToCie1976UcsUv(rgb2xyz([1 0 0])); 
   xyzToCie1976UcsUv(rgb2xyz([0 1 0])); 
   xyzToCie1976UcsUv(rgb2xyz([0 0 1])); 
   xyzToCie1976UcsUv(rgb2xyz([1 0 0])); 
];

% Calibration points
calPoints = [
    1 1 1
    1 0.4 0.4
    0.4 1 0.4
    0.4 0.4 1
    1 1 0.4
    1 0.4 1
    0.4 1 1
    1 1 0.7
    1 0.7 1
    0.7 1 1
];

% sRGB camera simulated measurements
% These are in real case obtained from the smart phone camera
data = [];
measurements = [];
for i = 1:size(calPoints, 1)
    XYZ = spdToXyz(mixSpd([red_hidden;green_hidden;blue_hidden], calPoints(i,:)));
    
    % Simulate sRGB calibrated camera
    rgb = xyz2rgb(XYZ);
    rgb(rgb<0) = 0;
    XYZ = rgb2xyz(rgb);
    
    measurements(i, :) = xyzToCie1976UcsUv(XYZ);
end

% Parameter search
minRMSE = Inf;
params = zeros(1, 5);
data = [];
k = 1;
for redC = 1.3:0.1:1.7 % Red LED factor relative to green LED
    for blueC = 1.7:0.1:2.1 % Blue LED factor relative to green LED
        for redWl = 628:1:632 % Red LED peak wavelength
            for greenWl = 523:1:527 % Green LED peak wavelength
                for blueWl = 463:1:467 % Blue LED peak wavelength
                    % Generate SPDs with current parameters
                    red = gaussmf(L, [20/2.355 redWl])*redC;
                    green = gaussmf(L, [20/2.355 greenWl]);
                    blue = gaussmf(L, [20/2.355 blueWl])*blueC;
                    
                    e = [];
                    % Error for each calibration point
                    for i = 1:size(calPoints, 1)
                        XYZ = spdToXyz(mixSpd([red;green;blue], calPoints(i,:)));
                        uv = xyzToCie1976UcsUv(XYZ);
                        e = sqrt(sum((measurements(i,:)- uv).^2));
                    end
                    
                    % Root mean squares error of the individual calibration
                    % points errors
                    RMSE = sqrt(sum(e.^2) / size(calPoints, 1));
                    
                    % New best result
                    if RMSE < minRMSE
                        minRMSE = RMSE;
                        params = [redC blueC redWl greenWl blueWl k];
                    end
                    
                    % Save params and RMSE
                    data(k, :) = [redC blueC redWl greenWl blueWl RMSE];
                    
                    k = k + 1;
                end
            end
        end
    end
end

% Generate SPDs with calibrated parameters
params = params
redC = params(1);
blueC = params(2);
redWl = params(3);
greenWl = params(4);
blueWl = params(5);
red = gaussmf(L, [20/2.355 redWl])*redC;
green = gaussmf(L, [20/2.355 greenWl]);
blue = gaussmf(L, [20/2.355 blueWl])*blueC;

% Calibration points by the calibrated LEDs
calibrated = [];
for i = 1:size(calPoints, 1)
    XYZ = spdToXyz(mixSpd([red;green;blue], calPoints(i,:)));
    calibrated(i, :) = xyzToCie1976UcsUv(XYZ);
end

% Plot
plotCieLuv([], false);
hold on;
plot(sRgbUvs(:,1), sRgbUvs(:,2), '--k');
% Plot +----o from measurement to calibrated point for each point
for i = 1:size(measurements, 1)
    plot(measurements(i,1), measurements(i,2), 'ok');
    plot(calibrated(i,1), calibrated(i,2), '+k');
    plot([measurements(i,1) calibrated(i,1)], [measurements(i,2) calibrated(i,2)], '-k');
end
legend('Photopic vision', 'sRGB', 'Measurement', 'Guess', 'Location', 'SouthEast');
hold off;
axis([0 0.63 0 0.6]);
clear blue_hidden blueC blueWl calibrated calPoints data e green_hidden;
clear greenWl i k L measurements minRMSE params red_hidden redC redWl;
clear resolution rgb RMSE sRgbUvs uv XYZ;
toc