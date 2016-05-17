function [ Ra, Ri ] = spdToCri( spd )
%SPDTOCRI Calculates CRI Ra and special indexes Ri for a spectrum
%Syntax
%   [Ra, Ri] = spdToCri(spd)
%Input
%   spd := Spectral power distribution sampled from 380nm to 780nm at 5nm
%          intervals
%Output
%   Ra := General color rendering index from the first 8 test color samples
%   Ri := Special color rendering indexes for all 14 test color samples

% Load test colors if not yet loaded
persistent cieRaTestColors;
if isempty(cieRaTestColors)
    % Creates variable cieRa95TestColors
    % each row is spectral radiance factors for CIE CRI Ra95 test color
    % samples 1 - 14 respectively
    % Wavelengths span 380nm to 780nm with 5nm sampling
    load('cie.mat', 'cieRaTestColors');
end

nSamples = 14;

% Calculate color temperature
CCT = spdToCct(spd);

% Calculate colorimetry
[XYZ_t, xyz_t] = spdToXyz(spd); % CI1931 color coordinates
K_t = 100 / XYZ_t(2);
uv_t = xyzToUv(xyz_t); % CIE1960
u_t = uv_t(1); v_t = uv_t(2);
c_t = 1/v_t*(4-u_t-10*v_t); % c function for von Kries transformation
d_t = (1.708*v_t + 0.404 - 1.481*u_t)/v_t; % d functoin for von Kries transformation

% Generate reference illuminant and calculate colorimetry
ref = refSpd(CCT);
[XYZ_r, xyz_r] = spdToXyz(ref);
K_r = 100 / XYZ_r(2);
uv_r = xyzToUv(xyz_r);
u_r = uv_r(1); v_r = uv_r(2);
c_r = (4-u_r-10*v_r)/v_r;
d_r = (1.708*v_r + 0.404 - 1.481*u_r)/v_r;

    function [UaVaWa] = spdToUaVaWa( spd_, isRef )
        % CIE1931
        [XYZ, xyz] = spdToXyz(spd_); Y = XYZ(2);
        
        % Move to CIE1960 color space
        uv = xyzToUv(xyz); u = uv(1); v = uv(2);
       
        % CIE 1964 U*V*W* color coordinates
        % https://en.wikipedia.org/wiki/CIE_1964_color_space
        Wa = 25*Y^(1/3) - 17;
        if isRef
            % Color coordinates of test color sample under the reference
            % illuminant is not transformed with von Kries chromatic
            % adaptation function
            
            % Move u, v color coordinates to CIE1964 color space
            Va = 13*Wa*(v - v_r);
            Ua = 13*Wa*(u - u_r);
        else
            % Transform color coordinates of test color sample under the
            % test illuminant with von Kries chromatic adaptation function
            
            % c and d are functions needed for up and vp calculations
            c = (4-u-10*v) / v;
            d =(1.708*v - 1.481*u + 0.404 ) / v;
            
            % Transformed coordinates
            up = (10.872 + 0.404*c_r/c_t*c - 4*d_r/d_t*d) / (16.518 + 1.481*c_r/c_t*c - d_r/d_t*d);
            vp = 5.52 / (16.518 + 1.481*c_r/c_t*c - d_r/d_t*d);
            
            % Move chromatically adapted u,v color coordinates to
            % CIE1964 color space
            Va = 13*Wa*(vp - v_r);
            Ua = 13*Wa*(up - u_r);
        end
        UaVaWa = [Ua Va Wa];
    end

% Calculate colorimetries for test colors
Ri = zeros(1, nSamples);
for i = 1:nSamples
    
    % Reference light
    UaVaWa_r = spdToUaVaWa(cieRaTestColors(i,:).*ref.*K_r, true);
    
    % Test light
    UaVaWa_t = spdToUaVaWa(cieRaTestColors(i,:).*spd.*K_t, false);
    
    % Color rendering index for currect test color sample
    dE = sqrt(sum((UaVaWa_r - UaVaWa_t).^2));
    Ri(i) = 100 - 4.6 * dE;
end
Ra = mean(Ri(1:8));

end