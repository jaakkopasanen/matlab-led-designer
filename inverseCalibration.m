%{
This script will find analytical solution to right hand side distance from
LED source to the target point on the CIE 1976 UCS color space.

Run this scipt twice: first with inverse = false and the with inverse =
true to get matlab and C code expressions for right hand side distance

Left hand side distance can be calculated with the left hand side distance
by right hand side distance fit function

Side points can be calculated with the sides' endpoint coordinates and the
distances on the sides.

Line from right hand side point to left hand side point will pass through
the target point when correct solution to both side distances is obtained.
LED level can be calculated from the right hand side distance with LED
level vs right hand side distance fit function.

Variables
    dR  := Right hand side point's distance from the source point relative
           to the right hand side length
    dL  := Left hand side point's distance from the source point relative
           to the lefth hand side length
    Lp1 := Left hand side fit "p1" coefficient
    Lp2 := Left hand side fit "p2" coefficient
    Lq1 := Left hand side fit "q1" coefficient
    PRu := Right hand side point's u' coordinate
    PRv := Right hand side point's v' coordinate
    LRu := Left hand side point's u' coordinate
    LRv := Left hand side point's v' coordinate
    P0u := LED source point's u' coordinate
    P0v := LED source point's v' coordinate
    P1u := Right hand side LED source point's u' coordinate
    P1v := Right hand side LED source point's v' coordinate
    P2u := Left hand side LED source point's u' coordinate
    P2v := Left hand side LED source point's v' coordinate
    PTu := Target point's u' coordinate
    PTv := Target point's v' coordinate

When calculating level for the red LED
    PR is the point on the red-to-green edge
    PL is the point on the red-to-blue edge
    P0 is the red LED coordinates
    P1 is the green LED coordinates
    P2 is the blue LED coordinates

Left hand side distance is expressed as a function of mirrored right hand
side distance. Expression for left hand side distance is obtained with
fitting rational function (num degree of 1, denom degree of 1) to right
hand side data. Both datas for curve fitting are obtained from simulated
colors where source LED levels are iterated from 0 to 1 and both distances
are calculated from the simulated color coordintes. See rgb3.m for details
how to do the data fitting.

      Lp1*(1-dR) + Lp2
dL = ------------------
        (1-dR) + Lq1

Left hand side distance is expressed as a function of mirrored right hand
side distance (as seen in the formula above) since matlab solver cannot
find solution if right hand side distance is not mirrored. If the true fit
function is not fitted with mirrored data, the point on the right hand side
must be calculated with right hand side distance's complement. 
%}

clear; clc;

% Left hand distance (yData) by right hand distance (xData) fit was made
% with right hand distance (xData) mirrored
inverse = false;

syms Rp1 Rp2 Rq1 Rq2 Lp1 Lp2 Lq1 Lq2 dR dL
syms PRu PRv PLu PLv
syms P0u P0v P1u P1v P2u P2v
syms PTu PTv

dL = ( Lp1*(1-dR) + Lp2 ) / ( (1-dR) + Lq1 );

if inverse
    PRu = P0u + (P1u - P0u) * (dR);
    PRv = P0v + (P1v - P0v) * (dR);
else 
    PRu = P0u + (P1u - P0u) * (1-dR);
    PRv = P0v + (P1v - P0v) * (1-dR);
end

PLu = P0u + (P2u - P0u) * dL;
PLv = P0v + (P2v - P0v) * dL;

%assume(PRu > PRv);
eq = (PTu - PRu)*(PLv - PRv) == (PTv - PRv) * ( PLu - PRu);
sol = solve(eq, dR, 'Real', true);
if length(sol) > 1
    sol = sol(1);
end

matlabFormula = sol
cCodeFormula = ccode(sol, 'file', 'ccodetest')