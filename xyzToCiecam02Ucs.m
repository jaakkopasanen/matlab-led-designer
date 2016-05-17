function [ JcaMcbMc, C ] = xyzToCiecam02Ucs( XYZ, XYZw, LA, Yb, D, c, Nc )
%XYZTOCIECAM02UCS Calculates CIECAM02-UCS coordinates from CIE1931 XYZ
%Syntax
%   [JcaMcbMc, C] = xyzToCiecam02Ucs(XYZ, XYZw, La, Yb, D, c, Nc)
%Input
%   XYZ  := CIE1931 tristimulus values [X Y Z] for test color
%   XYZw := CIE1931 tristimulus values [X Y Z] for reference white
%   La   := Absolute luminance
%   Yb   := Relative background luminance
%   D    := Degree of chromatic adaptation (discounting)
%   c    := Impact of surrounding
%   Nc   := Chromatic induction factor
%Output
%   JcaMcbMc := CIECAM02-UCS color coordinates [Jc' aMc' bMc']
%   C        := Chroma

% Chromatic adaptation transformation matrix
persistent MCAT02;
if isempty(MCAT02)
    MCAT02 = [
        0.7328	0.4296	-0.1624
        -0.7036	1.6975	0.0061
        0.0030	0.0136	0.9834
    ];
end

% Hunt-Point-Estévez transformation matrix
persistent MHEP
if isempty(MHEP)
    MHEP = [
        0.38971 0.68898 -0.07868
        -0.22981 1.1834 0.04641
        0 0 1
    ];
end

% Force XYZs as column vectors
if size(XYZ,2) > size(XYZ,1)
    XYZ = XYZ';
end
if size(XYZw,2) > size(XYZw,1)
    XYZw = XYZw';
end

k = 1 / (5 * LA + 1);
FL = 1/5*k^4 * 5*LA + 1/10*(1 - k^4)^2 * (5*LA)^(1/3);
n = Yb / XYZw(2);
Nbb = 0.725 * (1/n)^0.2;
Ncb = Nbb;
z = 1.48 + sqrt(n);
RGB = MCAT02 * XYZ; % Column vector!

% If any of the RGB values are negative, a and b for hue angle are not real
RGB(RGB<0) = 0;

RGBw = MCAT02 * XYZw; % Column vector!
RGBc = [
    (D * XYZw(2) / RGBw(1) + 1 - D) * RGB(1)
    (D * XYZw(2) / RGBw(2) + 1 - D) * RGB(2)
    (D * XYZw(2) / RGBw(3) + 1 - D) * RGB(3)];
RGBcw = [
    (D * XYZw(2) / RGBw(1) + 1 - D) * RGBw(1)
    (D * XYZw(2) / RGBw(2) + 1 - D) * RGBw(2)
    (D * XYZw(2) / RGBw(3) + 1 - D) * RGBw(3)];
XYZc = MCAT02 \ RGBc; % inv(MCAT02) * RGBc
XYZcw = MCAT02 \ RGBcw; % inv(MCAT02) * RGBcw
RGBp = MHEP * XYZc;
RGBpw = MHEP * XYZcw;
RGBpa = [
    ((400 * (FL*RGBp(1)/100)^0.42) / (((FL*RGBp(1)/100)^0.42) + 27.13)) + 0.1
    ((400 * (FL*RGBp(2)/100)^0.42) / (((FL*RGBp(2)/100)^0.42) + 27.13)) + 0.1
    ((400 * (FL*RGBp(3)/100)^0.42) / (((FL*RGBp(3)/100)^0.42) + 27.13)) + 0.1];
RGBpaw = [
    ((400 * (FL*RGBpw(1)/100)^0.42) / (((FL*RGBpw(1)/100)^0.42) + 27.13)) + 0.1
    ((400 * (FL*RGBpw(2)/100)^0.42) / (((FL*RGBpw(2)/100)^0.42) + 27.13)) + 0.1
    ((400 * (FL*RGBpw(3)/100)^0.42) / (((FL*RGBpw(3)/100)^0.42) + 27.13)) + 0.1];
a = RGBpa(1) - 12 * RGBpa(2) / 11 + RGBpa(3) / 11;
b = 1/9 * (RGBpa(1) + RGBpa(2) - 2*RGBpa(3));

% h
% Matlab: atan2(Y,X) instead of atan2(X,Y), help atan2
if a == 0
    if b == 0
        h = 0;
    else
        if b >= 0
            h = (360/(2*pi))*atan2(b,a);
        else
            h = 360+(360/(2*pi))*atan2(b,a);
        end
    end
else
    if b >= 0
        h = (360/(2*pi))*atan2(b,a);
    else
        h = 360+(360/(2*pi))*atan2(b,a);
    end
end

% H
%{
if h < 20.14
    H = 385.9+(14.1*(h)/0.856)/((h)/0.856+(20.14-h)/0.8);
elseif h < 90
    H = (100*(h-20.14)/0.8)/((h-20.14)/0.8+(90-h)/0.7);
elseif h < 164.25
    H = 100+(100*(h-90)/0.7)/((h-90)/0.7+(164.25-h)/1);
elseif h < 237.53
    H = 200+(100*(h-164.25)/1)/((h-164.25)/1+(237.53-h)/1.2);
else
    H = 300+(85.9*(h-237.53)/1.2)/((h-237.53)/1.2+(360-h)/0.856);
end

%
Hc = zeros(4,1);
% Hc (red)
if H > 300
    Hc(1) = H - 300;
elseif H < 100
    Hc(1) = 100 - H;
else
    Hc(1) = 0;
end
% Hc (yellow)
if H <= 100
    Hc(2) = H;
elseif H < 200
    Hc(2) = 200 - H;
else
    Hc(2) = 0;
end
% Hc (green)
if H > 100
    if H <= 200
        Hc(3) = H - 100;
    else
        if H < 300
            Hc(3) = 300 - H;
        else
            Hc(3) = 0;
        end
    end
else
    Hc(3) = 0;
end
% Hc ( blue)
if H > 300
    Hc(4) = 400 - H;
elseif H > 200
    Hc(4) = H - 200;
else
    Hc(4) = 0;
end
%}

e = ((12500/13) * Nc * Ncb) * (cos((h*pi/180) + 2) + 3.8);
A = (2*RGBpa(1) + RGBpa(2) + 1/20*RGBpa(3) - 0.305) * Nbb;
Aw = (2*RGBpaw(1) + RGBpaw(2) + 1/20*RGBpaw(3) - 0.305) * Nbb;
J = 100*(A / Aw)^(c * z);
%Q = (4 / c) * sqrt(J / 100) * (Aw + 4) * FL^0.25;
t = (e * sqrt(a^2 + b^2)) / (RGBpa(1) + RGBpa(2) + 21/20*RGBpa(3));
C = (t^0.9) * sqrt(J / 100) * ((1.64 - 0.29^n)^0.73);
M = C * FL^0.25;
%s = 100 * sqrt(M / Q);
%ac = C * cos(pi * h / 180);
%bc = C * sin(pi * h / 180);
%aM = M * cos(pi * h / 180);
%bM = M * sin(pi * h / 180);
%as = s * cos(pi * h / 180);
%bs = s * sin(pi * h / 180);
% CAM02UCS
Jc = (1 + 100*0.007) * J / (1 + 0.007 * J);
Mc = (1 / 0.0228) * log(1 + 0.0228 * M);
aMc = Mc * cos(h * pi / 180);
bMc = Mc * sin(h * pi / 180);
JcaMcbMc = [Jc aMc bMc];

end

