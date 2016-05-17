function [ p ] = intersection( line1, line2 )
%INTERSECTION Calculates intersection point for two lines
%Syntax
%   p = intersection(line1, line2)
%Input
%   line1 := 2-by-2 matrix where each row contains one point along the
%            line and the first column is x and the second column is y
%            [x1 y1; x2 y2]
%   line2 := 2-by-2 matrix where each row contains one point along the
%            line and the first column is x and the second column is y
%            [x1 y1; x2 y2]
%Output
%   p := The intersection point [x, y]

x = [line1(:,1); line2(:,1)];
y = [line1(:,2); line2(:,2)];

denom = (x(1)-x(2)) * (y(3)-y(4)) - (y(1)-y(2)) * (x(3)-x(4));
px = ( (x(1)*y(2)-y(1)*x(2)) * (x(3)-x(4)) - (x(1)-x(2)) * (x(3)*y(4)-y(3)*x(4)) ) / denom;
py = ( (x(1)*y(2)-y(1)*x(2)) * (y(3)-y(4)) - (y(1)-y(2)) * (x(3)*y(4)-y(3)*x(4)) ) / denom;

p = [px py];

end

