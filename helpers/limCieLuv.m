function [ visible, reason ] = limCieLuv( u, v )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if 3*u + 20*v - 12 == 0
    reason = 'upper limit';
    visible = false;
    return;
end

persistent cie1976UcsBorder
if isempty(cie1976UcsBorder)
    load('cie.mat', 'cie1976UcsBorder');
end

lim = cie1976UcsBorder(1:end-1,:);
lim = [lim(end,:); lim];
[~, minUInd] = min(lim(:,1));

% Too far left
if u < lim(minUInd, 1)
    reason = 'left limit';
    visible = false;
    return;
end

% Too far right
if u > lim(end, 1)
    reason = 'right limit';
    visible = false;
    return;
end

% Test upper limit
ind = 0;
for k = minUInd:length(lim)
    if lim(k,1) == u
        ind = k;
        break;
    elseif k < length(lim)&&  lim(k,1) < u && lim(k+1,1) > u
        ind = k;
        break;
    end
end

% WTF happened u was not in the limits?!?
if ~ind
    reason = 'top limit index';
    visible = false;
    return;
else
    if ind == length(lim) % Last sample
        if v ~= lim(end, 2)
            reason = 'top limit last sample';
            visible = false;
            return;
        end
    else
        uRange = lim(ind+1,1) - lim(ind,1);
        uD = (u - lim(ind,1)) / uRange;
        vRange = lim(ind+1,2) - lim(ind,2);
        if v > lim(ind,2) + uD * vRange
            reason = 'top limit';
            visible = false;
            return;
        end
    end
end

% Test lower limit
ind = 0;
%u = u
for k = 1:minUInd
    if lim(k,1) >= u && lim(k+1,1) < u
        ind = k;
        break;
    end
end

% WTF happened u was not in the limits?!?
if ~ind
    reason = 'bottom limit index';
    visible = false;
    return;
else
    if ind == minUInd % Last sample
        if v ~= lim(minUInd, 2)
            reason = 'bottom limit last sample';
            visible = false;
            return;
        end
    else
        uRange = lim(ind+1,1) - lim(ind,1);
        uD = (u - lim(ind,1)) / uRange;
        vRange = lim(ind+1,2) - lim(ind,2);
        if v < lim(ind,2) + uD * vRange + 0.001
            reason = 'bottom limit';
            visible = false;
            return;
        end
    end
end

visible = true;
reason = '';

end

