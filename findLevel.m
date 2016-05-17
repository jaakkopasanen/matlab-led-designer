function [ level, err, rightToLeft ] = findLevel( sourceUvs, target, rightHandFit, leftHandFit, maxErr, maxIterations )
%FINDLEVEL Finds LED level with calibration data
%Syntax
%
%Input
%   sourceUvs := 3-by-2 matrix where columns are u' and v', rows are source,
%                source on the right hand side and source on the left hand
%                side
%Output
%   level       := Estimated LED level
%   err         := Error as in distance from the intersection to target
%   rightToLeft := Line from right side point to left side point

%sourceUvs

%target

%rightHandFit

%leftHandFit

% Find intersection point on opposite edge
sourceToTarget = [
    sourceUvs(1, :)
    target
];

oppositeEdge = [
    sourceUvs(2, :)
    sourceUvs(3, :)
];
p_intersection = intersection(sourceToTarget, oppositeEdge);

% Relative distance is source-to-target divided by source-to-intersection
d_opposite = sqrt( sum( (sourceUvs(1, :) - p_intersection).^2 ) );
d_target = sqrt( sum( (sourceUvs(1, :) - target).^2) ) / d_opposite;

% Gotta start form somewhere, start from the middle
level = 1 - d_target;

% Annealing speed based on fit linearity
nonLinearityCoeff = 1.2;
rightHandLinearity = 1 - nonLinearityCoeff * abs(rightHandFit(0.5) - 0.5);
leftHandLinearity = 1 - nonLinearityCoeff * abs(leftHandFit(0.5) - 0.5);
fitScaling = 1 - sqrt( sum( (sourceUvs(2,:) - p_intersection).^2 ) ) / sqrt( sum( (sourceUvs(2,:) - sourceUvs(3,:)).^2 ) );
linearity = rightHandLinearity * fitScaling + leftHandLinearity * (1 - fitScaling);
annealing = linearity;

% Keep searching until error is small enough or max iterations reached
err = 1;
iterations = 0;
while err > maxErr && iterations < maxIterations
    
    % Find point on right hand side with level guess
    %d = evaluateRational(level, rightHandFit(1, :), rightHandFit(2, :));
    d = rightHandFit(level);
    p_right = sourceUvs(1, :) + (sourceUvs(2, :) - sourceUvs(1, :)) * d;
    
    % Find point on left hand side with level guess
    %d = evaluateRational(level, leftHandFit(1, :), leftHandFit(2, :));
    d = leftHandFit(level);
    p_left = sourceUvs(1, :) + (sourceUvs(3, :) - sourceUvs(1, :)) * d;
    
    % Find intersection of side points and source-to-target
    rightToLeft = [
        p_right
        p_left
    ];

    % Intersection point
    p_intersection = intersection(rightToLeft, sourceToTarget);
    
    % Intersection point is behind source point (out of gamut)
    % limit to source
    if ((target(1) > sourceUvs(1,1)) ~= (p_intersection(1) > sourceUvs(1,1))) ||...
    ((target(2) > sourceUvs(1,2)) ~= (p_intersection(2) > sourceUvs(1,2)))
        p_intersection = sourceUvs(1, :);
    end
    
    %plot(rightToLeft(:,1), rightToLeft(:,2), 'k')
    
    % Calculate relative source-to-intersection distance
    d = sqrt( sum( (sourceUvs(1, :) - p_intersection).^2 ) ) / d_opposite;
    
    % Error is intersection-to-target distance
    err = sqrt( sum( (p_intersection - target).^2 ) );
    
    % New guess
    if err > maxErr
        c = (1 - d_target) / (1 - d);
        c = 1 - (1 - c) * annealing;
        %[level c c*level]
        level = level * c;
        level = max(min(level, 1), 0);
    end
    
    % Increment loop index
    iterations = iterations + 1;
end

if iterations == maxIterations
    %target = target
end

end

