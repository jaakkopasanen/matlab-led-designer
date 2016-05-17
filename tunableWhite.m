clear; t = cputime; % Save current time for duration calculations
load('cie.mat'); % Load lookup tables for colorimetry calculations
load('led_data.mat'); % Load spectrums for various LEDs
L = 380:5:780; % Wavelengths: from 380nm to 780nm sampled at 5nm
time = clock; disp(['Started at ' num2str(time(4)) ':' num2str(time(5))]); % Display start time

%% Parameters for simulations

% LED mixing coefficient resolution. Higher the resolution, better the
% results but time requirement is higher (in high order)
% 5 LED mixing with resolution of 0.01 should take several hours.
resolution = 0.05;

% Color temperature bin size in Kelvins for selecting best results.
% Raw mixing results are binned by color temperature and for each bin the
% mixing combination which yields best light goodness is selected.
% Larger bin sizes produce more robust results but may cause errors due to
% inaccurate linearization of mixing coefficients between the samples.
% Good baseline value for resolution of 0.01 is 100.
cctBinSize = 200;

% Minimum correlated color temperature. All combinations producing
% temperatures below this value are ignored. Also used as lower limit for
% plotting various visualization aids.
minCCT = 1000; 

% Maximum correlated color temperature. All combinations producing
% temperatures over this value are ignored. Also used as upper limit for
% plotting the various visualization aids.
maxCCT = 6500;

% Target IES TM-30-15 Rg value for light quality optimization. Higher the
% value more the light will oversaturate the colors. Some oversaturation is
% generally preferred since human visual system desaturates color in dimmer
% than daylight lighting. Setting too high target may cause hue distortions
% and also too high color saturation is not preferred.
% Good baseline values are 100 to 110.
targetRg = 105;

% Relative penalty for Rf fidelity score in light goodness optimization.
% Larger values will result in better fidelity values but worse gamut and
% whiteness scores.
% Good baseline values are somewhere 1.0 to 2.0.
RfPenalty = 1;

% Relative penalty for Rg gamut score in light goodness optimization.
% Larger values will result in gamut scores closer to target Rg but worse
% fidelity and whiteness scores.
% Good baseline values are somewhere 0.5 to 1.0.
RgPenalty = 1;

% Penalty for deviating from the Planckian locus in CIE 1976 UCS u', v'
% units in light goodness optimization. Larger values will result in whiter
% light but worse fidelity and gamut.
% Good baseline value is 10.
duvPenalty = 10;

% Maximum deviation from planckian locus in CIE 1976 CIELUV UCS u', v'
% units. All LED mixing combinations producing ligth deviating more from
% the Planckian locus are ignore. This parameter is only for simulation
% speed optimization. Too low values may lead into ignoring good results,
% too high value may lead to longer calculation times.
maxDuv = 0.01;

% Color temperature samples for inspection. inspectSpd function is called
% with spds resulting in all of these correlated color temperatures.
%inspectSpds = [1500, 2000, 2700, 4000, 5600, 6500];
inspectSpds = [];

% Spectrums for red, green and blue LEDs. First value in the array (second
% parameter for gaussmf) is the peak width in nanometers, and the second
% value is the dominating wavelength of the led in nanometers.
red = gaussmf(L, [20/2.355 625]); redL = 160;
green = gaussmf(L, [20/2.355 524]); greenL = 320;
blue = gaussmf(L, [20/2.355 471]); blueL = 200;

% Spectrum for warm white LED. Yuji BC5730L strips are not recommended
% anymore by the manufacturer since all new and improved strips use BC2835L
% chips. Remove comment from one of the lines or add your own spectrum.
warm = Yuji_BC2835L_2700K; warmL = 700; % Yuji BC2835L
%warm = Yuji_VTC5730_2700K; warmL = 800; % Yuji Violet chip 
%warm = Cree_A19_2700K; warmL = 1000; % Represents decent warm white LED
%warm = Generic_3000K; warmL = 500; % Represents cheap Chinese warm white

% Spectrum for cold white LED
%cold = Yuji_BC2835L_5600K; coldL = 1700; coldL = 2700;
cold = Yuji_BC2835L_6500K; coldL = 900;
%cold = Yuji_VTC5730_5600K; coldL = 1000;
%cold = Generic_6500K; coldL = 1000;

%
supertitle = [
    'SIRS-E RGB + Yuji Hybrid'
    '   625nm, 524nm, 471nm  '
    '    Peak width = 20nm   '];
%
%{
supertitle = [
    'SIRS-E RGB + Yuji Hybrid'
    '  Optimized for CRI Ra  '];
%}
% LEDs used for simulations
% Parameters for Led contructor are:
%   name:string Name of the LED, used in the plots
%   spd:[double] Row vector of doubles in range [0,1]
%   lumens:double Luminous intensity of the LED, used to calculate power
%   maxCoeff:double Maximum coefficient for the LED
leds = [
    Led('red', red, redL, 1)
    Led('green', green, greenL, 0.3)
    %Led('blue', blue, blueL, 0.3)
    Led('warm', warm, warmL, 1)
    Led('cold', cold, coldL, 1)
];

% LEDs are combined in groups. LEDs in a group are combined only with other
% LEDs in the same group. This way combining too many LEDs can be avoided
% to ensure faster simulation. Each row contains one group and the values
% in a group are indexes to leds array created above.
%
% Examples:
% [1 2 3 4 5] := Combining 5 LEDs with each other, will result in very long
%                simulation time
% [1 2; 2 3] := Combines only consecutive LEDs e.g. red with warm white and
%               warm white with cold white
ledGroups = [
    %1 2 4 5 % From red to cold white
    %2 3 5 0  % From cold white onwards
    1 2 3 4 
    %1 2
    %2 3
];

%% Generate mixing data for simulations
generateMixingData

%% Simulate results
simulateResults

%% Plots for visual estimations
visualize

%% Display total duration in minutes
disp(['Total duration is ' num2str(round((cputime - t) / 60)) 'min']);