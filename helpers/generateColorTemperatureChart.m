%
minT = 1000;
maxT = 10000;
% Larger exponent will give more room for reds, smaller for blues
exponent = 2;

rgb = [];
D = [];
T = [];
u_prev = cie1976PlanckianLocusUv(minT, 1);
v_prev = cie1976PlanckianLocusUv(minT, 2);

ind = 1;
for c = 0:0.005:1
    %ind = (t-1000)/res+1;
    
    t = c^exponent*(maxT-minT) + minT;
    t = round(t);
    T(i) = t;
    
    u = cie1976PlanckianLocusUv(t, 1);
    v = cie1976PlanckianLocusUv(t, 2);
    d = sqrt((u-u_prev)^2+(v-v_prev)^2);
    if ind > 1
        D(ind) = D(ind - 1) + d;
    else
        D(ind) = 0;
    end
    
    X = -(9*u)/(3*u + 20*v - 12);
    Y = -(4*v)/(3*u + 20*v - 12);
    Z = 1;
    x = X / (X+Y+Z);
    y = Y / (X+Y+Z);
    z = Z / (X+Y+Z);
    xyz = [x y z];
    
    rgb(1, ind, :) = xyz2rgb(xyz);
    rgb(1, ind, :) = rgb(1, ind, :) * (1 / max(rgb(1, ind, :)));
    
    u_prev = u;
    v_prev = v;
    
    ind = ind + 1;
end
imagesc([minT maxT], [0 1], rgb);
%}