redLum = 0.5;
greenLum = 1;
blueLum = 0.75;
maxLum = 0.8 * (redLum + greenLum + blueLum);

L = 75;

raw = [0.9 0.9 0.9];

Y = (raw(1)*redLum + raw(2)*greenLum + raw(3)*blueLum) / maxLum
Y_target = ((L+16)/116)^3

C = Y_target / Y
raw = [raw(1)*C, raw(2)*C, raw(3)*C]
if max(raw) > 1
    raw = raw * (1 / max(raw))
end

Y = (raw(1)*redLum + raw(2)*greenLum + raw(3)*blueLum) / maxLum