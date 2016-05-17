function [ level, dR, dL ] = findLevel2( PT, P0, P1, P2, rf, lf )
%FINDLEVEL2 Find level for led

PTu = PT(1);
PTv = PT(2);
P0u = P0(1);
P0v = P0(2);
P1u = P1(1);
P1v = P1(2);
P2u = P2(1);
P2v = P2(2);
Rp1 = rf(1);
Rp2 = rf(2);
Rq1 = rf(3);
Lp1 = lf(1);
Lp2 = lf(2);
Lq1 = lf(3);

if Lp1 < 0 % Inversed

    % dL = f(1 - dR)
    %dR = ((Lp1^2*P0u^2*P1v^2 - 2*Lp1^2*P0u^2*P1v*PTv + Lp1^2*P0u^2*PTv^2 - 2*Lp1^2*P0u*P1u*P0v*P1v + 2*Lp1^2*P0u*P1u*P0v*PTv + 2*Lp1^2*P0u*P1u*P1v*P2v - 2*Lp1^2*P0u*P1u*P2v*PTv - 2*Lp1^2*P0u*P2u*P1v^2 + 4*Lp1^2*P0u*P2u*P1v*PTv - 2*Lp1^2*P0u*P2u*PTv^2 + 2*Lp1^2*P0u*P0v*P1v*PTu - 2*Lp1^2*P0u*P0v*PTu*PTv - 2*Lp1^2*P0u*P1v*P2v*PTu + 2*Lp1^2*P0u*P2v*PTu*PTv + Lp1^2*P1u^2*P0v^2 - 2*Lp1^2*P1u^2*P0v*P2v + Lp1^2*P1u^2*P2v^2 + 2*Lp1^2*P1u*P2u*P0v*P1v - 2*Lp1^2*P1u*P2u*P0v*PTv - 2*Lp1^2*P1u*P2u*P1v*P2v + 2*Lp1^2*P1u*P2u*P2v*PTv - 2*Lp1^2*P1u*P0v^2*PTu + 4*Lp1^2*P1u*P0v*P2v*PTu - 2*Lp1^2*P1u*P2v^2*PTu + Lp1^2*P2u^2*P1v^2 - 2*Lp1^2*P2u^2*P1v*PTv + Lp1^2*P2u^2*PTv^2 - 2*Lp1^2*P2u*P0v*P1v*PTu + 2*Lp1^2*P2u*P0v*PTu*PTv + 2*Lp1^2*P2u*P1v*P2v*PTu - 2*Lp1^2*P2u*P2v*PTu*PTv + Lp1^2*P0v^2*PTu^2 - 2*Lp1^2*P0v*P2v*PTu^2 + Lp1^2*P2v^2*PTu^2 + 2*Lp1*Lp2*P0u^2*P1v^2 - 2*Lp1*Lp2*P0u^2*P1v*P2v - 2*Lp1*Lp2*P0u^2*P1v*PTv + 2*Lp1*Lp2*P0u^2*P2v*PTv - 4*Lp1*Lp2*P0u*P1u*P0v*P1v + 2*Lp1*Lp2*P0u*P1u*P0v*P2v + 2*Lp1*Lp2*P0u*P1u*P0v*PTv + 4*Lp1*Lp2*P0u*P1u*P1v*P2v - 2*Lp1*Lp2*P0u*P1u*P2v^2 - 2*Lp1*Lp2*P0u*P1u*P2v*PTv + 2*Lp1*Lp2*P0u*P2u*P0v*P1v - 2*Lp1*Lp2*P0u*P2u*P0v*PTv - 4*Lp1*Lp2*P0u*P2u*P1v^2 + 2*Lp1*Lp2*P0u*P2u*P1v*P2v + 4*Lp1*Lp2*P0u*P2u*P1v*PTv - 2*Lp1*Lp2*P0u*P2u*P2v*PTv + 2*Lp1*Lp2*P0u*P0v*P1v*PTu - 2*Lp1*Lp2*P0u*P0v*P2v*PTu - 2*Lp1*Lp2*P0u*P1v*P2v*PTu + 2*Lp1*Lp2*P0u*P2v^2*PTu + 2*Lp1*Lp2*P1u^2*P0v^2 - 4*Lp1*Lp2*P1u^2*P0v*P2v + 2*Lp1*Lp2*P1u^2*P2v^2 - 2*Lp1*Lp2*P1u*P2u*P0v^2 + 4*Lp1*Lp2*P1u*P2u*P0v*P1v + 2*Lp1*Lp2*P1u*P2u*P0v*P2v - 2*Lp1*Lp2*P1u*P2u*P0v*PTv - 4*Lp1*Lp2*P1u*P2u*P1v*P2v + 2*Lp1*Lp2*P1u*P2u*P2v*PTv - 2*Lp1*Lp2*P1u*P0v^2*PTu + 4*Lp1*Lp2*P1u*P0v*P2v*PTu - 2*Lp1*Lp2*P1u*P2v^2*PTu - 2*Lp1*Lp2*P2u^2*P0v*P1v + 2*Lp1*Lp2*P2u^2*P0v*PTv + 2*Lp1*Lp2*P2u^2*P1v^2 - 2*Lp1*Lp2*P2u^2*P1v*PTv + 2*Lp1*Lp2*P2u*P0v^2*PTu - 2*Lp1*Lp2*P2u*P0v*P1v*PTu - 2*Lp1*Lp2*P2u*P0v*P2v*PTu + 2*Lp1*Lp2*P2u*P1v*P2v*PTu - 2*Lp1*Lq1*P0u^2*P1v^2 + 4*Lp1*Lq1*P0u^2*P1v*P2v - 4*Lp1*Lq1*P0u^2*P2v*PTv + 2*Lp1*Lq1*P0u^2*PTv^2 + 4*Lp1*Lq1*P0u*P1u*P0v*P1v - 4*Lp1*Lq1*P0u*P1u*P0v*P2v - 2*Lp1*Lq1*P0u*P1u*P1v*P2v - 2*Lp1*Lq1*P0u*P1u*P1v*PTv + 6*Lp1*Lq1*P0u*P1u*P2v*PTv - 2*Lp1*Lq1*P0u*P1u*PTv^2 - 4*Lp1*Lq1*P0u*P2u*P0v*P1v + 4*Lp1*Lq1*P0u*P2u*P0v*PTv + 2*Lp1*Lq1*P0u*P2u*P1v^2 - 2*Lp1*Lq1*P0u*P2u*PTv^2 + 4*Lp1*Lq1*P0u*P0v*P2v*PTu - 4*Lp1*Lq1*P0u*P0v*PTu*PTv + 2*Lp1*Lq1*P0u*P1v^2*PTu - 6*Lp1*Lq1*P0u*P1v*P2v*PTu + 2*Lp1*Lq1*P0u*P1v*PTu*PTv + 2*Lp1*Lq1*P0u*P2v*PTu*PTv - 2*Lp1*Lq1*P1u^2*P0v^2 + 2*Lp1*Lq1*P1u^2*P0v*P2v + 2*Lp1*Lq1*P1u^2*P0v*PTv - 2*Lp1*Lq1*P1u^2*P2v*PTv + 4*Lp1*Lq1*P1u*P2u*P0v^2 - 2*Lp1*Lq1*P1u*P2u*P0v*P1v - 6*Lp1*Lq1*P1u*P2u*P0v*PTv + 2*Lp1*Lq1*P1u*P2u*P1v*PTv + 2*Lp1*Lq1*P1u*P2u*PTv^2 - 2*Lp1*Lq1*P1u*P0v*P1v*PTu + 2*Lp1*Lq1*P1u*P0v*PTu*PTv + 2*Lp1*Lq1*P1u*P1v*P2v*PTu - 2*Lp1*Lq1*P1u*P2v*PTu*PTv - 4*Lp1*Lq1*P2u*P0v^2*PTu + 6*Lp1*Lq1*P2u*P0v*P1v*PTu + 2*Lp1*Lq1*P2u*P0v*PTu*PTv - 2*Lp1*Lq1*P2u*P1v^2*PTu - 2*Lp1*Lq1*P2u*P1v*PTu*PTv + 2*Lp1*Lq1*P0v^2*PTu^2 - 2*Lp1*Lq1*P0v*P1v*PTu^2 - 2*Lp1*Lq1*P0v*P2v*PTu^2 + 2*Lp1*Lq1*P1v*P2v*PTu^2 - 2*Lp1*P0u^2*P1v^2 + 4*Lp1*P0u^2*P1v*PTv - 2*Lp1*P0u^2*PTv^2 + 4*Lp1*P0u*P1u*P0v*P1v - 4*Lp1*P0u*P1u*P0v*PTv - 2*Lp1*P0u*P1u*P1v*P2v - 2*Lp1*P0u*P1u*P1v*PTv + 2*Lp1*P0u*P1u*P2v*PTv + 2*Lp1*P0u*P1u*PTv^2 + 2*Lp1*P0u*P2u*P1v^2 - 4*Lp1*P0u*P2u*P1v*PTv + 2*Lp1*P0u*P2u*PTv^2 - 4*Lp1*P0u*P0v*P1v*PTu + 4*Lp1*P0u*P0v*PTu*PTv + 2*Lp1*P0u*P1v^2*PTu + 2*Lp1*P0u*P1v*P2v*PTu - 2*Lp1*P0u*P1v*PTu*PTv - 2*Lp1*P0u*P2v*PTu*PTv - 2*Lp1*P1u^2*P0v^2 + 2*Lp1*P1u^2*P0v*P2v + 2*Lp1*P1u^2*P0v*PTv - 2*Lp1*P1u^2*P2v*PTv - 2*Lp1*P1u*P2u*P0v*P1v + 2*Lp1*P1u*P2u*P0v*PTv + 2*Lp1*P1u*P2u*P1v*PTv - 2*Lp1*P1u*P2u*PTv^2 + 4*Lp1*P1u*P0v^2*PTu - 2*Lp1*P1u*P0v*P1v*PTu - 4*Lp1*P1u*P0v*P2v*PTu - 2*Lp1*P1u*P0v*PTu*PTv + 2*Lp1*P1u*P1v*P2v*PTu + 2*Lp1*P1u*P2v*PTu*PTv + 2*Lp1*P2u*P0v*P1v*PTu - 2*Lp1*P2u*P0v*PTu*PTv - 2*Lp1*P2u*P1v^2*PTu + 2*Lp1*P2u*P1v*PTu*PTv - 2*Lp1*P0v^2*PTu^2 + 2*Lp1*P0v*P1v*PTu^2 + 2*Lp1*P0v*P2v*PTu^2 - 2*Lp1*P1v*P2v*PTu^2 + Lp2^2*P0u^2*P1v^2 - 2*Lp2^2*P0u^2*P1v*P2v + Lp2^2*P0u^2*P2v^2 - 2*Lp2^2*P0u*P1u*P0v*P1v + 2*Lp2^2*P0u*P1u*P0v*P2v + 2*Lp2^2*P0u*P1u*P1v*P2v - 2*Lp2^2*P0u*P1u*P2v^2 + 2*Lp2^2*P0u*P2u*P0v*P1v - 2*Lp2^2*P0u*P2u*P0v*P2v - 2*Lp2^2*P0u*P2u*P1v^2 + 2*Lp2^2*P0u*P2u*P1v*P2v + Lp2^2*P1u^2*P0v^2 - 2*Lp2^2*P1u^2*P0v*P2v + Lp2^2*P1u^2*P2v^2 - 2*Lp2^2*P1u*P2u*P0v^2 + 2*Lp2^2*P1u*P2u*P0v*P1v + 2*Lp2^2*P1u*P2u*P0v*P2v - 2*Lp2^2*P1u*P2u*P1v*P2v + Lp2^2*P2u^2*P0v^2 - 2*Lp2^2*P2u^2*P0v*P1v + Lp2^2*P2u^2*P1v^2 - 2*Lp2*Lq1*P0u^2*P1v^2 + 2*Lp2*Lq1*P0u^2*P1v*P2v + 2*Lp2*Lq1*P0u^2*P1v*PTv - 2*Lp2*Lq1*P0u^2*P2v*PTv + 4*Lp2*Lq1*P0u*P1u*P0v*P1v - 2*Lp2*Lq1*P0u*P1u*P0v*P2v - 2*Lp2*Lq1*P0u*P1u*P0v*PTv - 2*Lp2*Lq1*P0u*P1u*P1v*P2v - 2*Lp2*Lq1*P0u*P1u*P1v*PTv + 4*Lp2*Lq1*P0u*P1u*P2v*PTv - 2*Lp2*Lq1*P0u*P2u*P0v*P1v + 2*Lp2*Lq1*P0u*P2u*P0v*PTv + 2*Lp2*Lq1*P0u*P2u*P1v^2 - 2*Lp2*Lq1*P0u*P2u*P1v*PTv - 2*Lp2*Lq1*P0u*P0v*P1v*PTu + 2*Lp2*Lq1*P0u*P0v*P2v*PTu + 2*Lp2*Lq1*P0u*P1v^2*PTu - 2*Lp2*Lq1*P0u*P1v*P2v*PTu - 2*Lp2*Lq1*P1u^2*P0v^2 + 2*Lp2*Lq1*P1u^2*P0v*P2v + 2*Lp2*Lq1*P1u^2*P0v*PTv - 2*Lp2*Lq1*P1u^2*P2v*PTv + 2*Lp2*Lq1*P1u*P2u*P0v^2 - 2*Lp2*Lq1*P1u*P2u*P0v*P1v - 2*Lp2*Lq1*P1u*P2u*P0v*PTv + 2*Lp2*Lq1*P1u*P2u*P1v*PTv + 2*Lp2*Lq1*P1u*P0v^2*PTu - 2*Lp2*Lq1*P1u*P0v*P1v*PTu - 2*Lp2*Lq1*P1u*P0v*P2v*PTu + 2*Lp2*Lq1*P1u*P1v*P2v*PTu - 2*Lp2*Lq1*P2u*P0v^2*PTu + 4*Lp2*Lq1*P2u*P0v*P1v*PTu - 2*Lp2*Lq1*P2u*P1v^2*PTu - 2*Lp2*P0u^2*P1v^2 - 2*Lp2*P0u^2*P1v*P2v + 6*Lp2*P0u^2*P1v*PTv + 2*Lp2*P0u^2*P2v*PTv - 4*Lp2*P0u^2*PTv^2 + 4*Lp2*P0u*P1u*P0v*P1v + 2*Lp2*P0u*P1u*P0v*P2v - 6*Lp2*P0u*P1u*P0v*PTv - 2*Lp2*P0u*P1u*P1v*P2v - 2*Lp2*P0u*P1u*P1v*PTv + 4*Lp2*P0u*P1u*PTv^2 + 2*Lp2*P0u*P2u*P0v*P1v - 2*Lp2*P0u*P2u*P0v*PTv + 2*Lp2*P0u*P2u*P1v^2 - 6*Lp2*P0u*P2u*P1v*PTv + 4*Lp2*P0u*P2u*PTv^2 - 6*Lp2*P0u*P0v*P1v*PTu - 2*Lp2*P0u*P0v*P2v*PTu + 8*Lp2*P0u*P0v*PTu*PTv + 2*Lp2*P0u*P1v^2*PTu + 6*Lp2*P0u*P1v*P2v*PTu - 4*Lp2*P0u*P1v*PTu*PTv - 4*Lp2*P0u*P2v*PTu*PTv - 2*Lp2*P1u^2*P0v^2 + 2*Lp2*P1u^2*P0v*P2v + 2*Lp2*P1u^2*P0v*PTv - 2*Lp2*P1u^2*P2v*PTv - 2*Lp2*P1u*P2u*P0v^2 - 2*Lp2*P1u*P2u*P0v*P1v + 6*Lp2*P1u*P2u*P0v*PTv + 2*Lp2*P1u*P2u*P1v*PTv - 4*Lp2*P1u*P2u*PTv^2 + 6*Lp2*P1u*P0v^2*PTu - 2*Lp2*P1u*P0v*P1v*PTu - 6*Lp2*P1u*P0v*P2v*PTu - 4*Lp2*P1u*P0v*PTu*PTv + 2*Lp2*P1u*P1v*P2v*PTu + 4*Lp2*P1u*P2v*PTu*PTv + 2*Lp2*P2u*P0v^2*PTu - 4*Lp2*P2u*P0v*PTu*PTv - 2*Lp2*P2u*P1v^2*PTu + 4*Lp2*P2u*P1v*PTu*PTv - 4*Lp2*P0v^2*PTu^2 + 4*Lp2*P0v*P1v*PTu^2 + 4*Lp2*P0v*P2v*PTu^2 - 4*Lp2*P1v*P2v*PTu^2 + Lq1^2*P0u^2*P1v^2 - 2*Lq1^2*P0u^2*P1v*PTv + Lq1^2*P0u^2*PTv^2 - 2*Lq1^2*P0u*P1u*P0v*P1v + 2*Lq1^2*P0u*P1u*P0v*PTv + 2*Lq1^2*P0u*P1u*P1v*PTv - 2*Lq1^2*P0u*P1u*PTv^2 + 2*Lq1^2*P0u*P0v*P1v*PTu - 2*Lq1^2*P0u*P0v*PTu*PTv - 2*Lq1^2*P0u*P1v^2*PTu + 2*Lq1^2*P0u*P1v*PTu*PTv + Lq1^2*P1u^2*P0v^2 - 2*Lq1^2*P1u^2*P0v*PTv + Lq1^2*P1u^2*PTv^2 - 2*Lq1^2*P1u*P0v^2*PTu + 2*Lq1^2*P1u*P0v*P1v*PTu + 2*Lq1^2*P1u*P0v*PTu*PTv - 2*Lq1^2*P1u*P1v*PTu*PTv + Lq1^2*P0v^2*PTu^2 - 2*Lq1^2*P0v*P1v*PTu^2 + Lq1^2*P1v^2*PTu^2 + 2*Lq1*P0u^2*P1v^2 - 4*Lq1*P0u^2*P1v*PTv + 2*Lq1*P0u^2*PTv^2 - 4*Lq1*P0u*P1u*P0v*P1v + 4*Lq1*P0u*P1u*P0v*PTv + 4*Lq1*P0u*P1u*P1v*PTv - 4*Lq1*P0u*P1u*PTv^2 + 4*Lq1*P0u*P0v*P1v*PTu - 4*Lq1*P0u*P0v*PTu*PTv - 4*Lq1*P0u*P1v^2*PTu + 4*Lq1*P0u*P1v*PTu*PTv + 2*Lq1*P1u^2*P0v^2 - 4*Lq1*P1u^2*P0v*PTv + 2*Lq1*P1u^2*PTv^2 - 4*Lq1*P1u*P0v^2*PTu + 4*Lq1*P1u*P0v*P1v*PTu + 4*Lq1*P1u*P0v*PTu*PTv - 4*Lq1*P1u*P1v*PTu*PTv + 2*Lq1*P0v^2*PTu^2 - 4*Lq1*P0v*P1v*PTu^2 + 2*Lq1*P1v^2*PTu^2 + P0u^2*P1v^2 - 2*P0u^2*P1v*PTv + P0u^2*PTv^2 - 2*P0u*P1u*P0v*P1v + 2*P0u*P1u*P0v*PTv + 2*P0u*P1u*P1v*PTv - 2*P0u*P1u*PTv^2 + 2*P0u*P0v*P1v*PTu - 2*P0u*P0v*PTu*PTv - 2*P0u*P1v^2*PTu + 2*P0u*P1v*PTu*PTv + P1u^2*P0v^2 - 2*P1u^2*P0v*PTv + P1u^2*PTv^2 - 2*P1u*P0v^2*PTu + 2*P1u*P0v*P1v*PTu + 2*P1u*P0v*PTu*PTv - 2*P1u*P1v*PTu*PTv + P0v^2*PTu^2 - 2*P0v*P1v*PTu^2 + P1v^2*PTu^2)^(1/2) + P0u*P1v - P1u*P0v - P0u*PTv + P0v*PTu + P1u*PTv - P1v*PTu - Lp1*P0u*P1v + Lp1*P1u*P0v + 2*Lp1*P0u*P2v - 2*Lp1*P2u*P0v - Lp2*P0u*P1v + Lp2*P1u*P0v - Lp1*P1u*P2v + Lp1*P2u*P1v + Lp2*P0u*P2v - Lp2*P2u*P0v - Lp2*P1u*P2v + Lp2*P2u*P1v + Lq1*P0u*P1v - Lq1*P1u*P0v - Lp1*P0u*PTv + Lp1*P0v*PTu + Lp1*P2u*PTv - Lp1*P2v*PTu - Lq1*P0u*PTv + Lq1*P0v*PTu + Lq1*P1u*PTv - Lq1*P1v*PTu)/(2*(P0u*P1v - P1u*P0v - P0u*PTv + P0v*PTu + P1u*PTv - P1v*PTu - Lp1*P0u*P1v + Lp1*P1u*P0v + Lp1*P0u*P2v - Lp1*P2u*P0v - Lp1*P1u*P2v + Lp1*P2u*P1v));
    % C code:
    dR = (sqrt((P0u*P0u)*(P1v*P1v)+(P1u*P1u)*(P0v*P0v)+(P0u*P0u)*(PTv*PTv)+(P0v*P0v)*(PTu*PTu)+(P1u*P1u)*(PTv*PTv)+(P1v*P1v)*(PTu*PTu)-Lp1*(P0u*P0u)*(P1v*P1v)*2.0-Lp1*(P1u*P1u)*(P0v*P0v)*2.0-Lp2*(P0u*P0u)*(P1v*P1v)*2.0-Lp2*(P1u*P1u)*(P0v*P0v)*2.0+Lq1*(P0u*P0u)*(P1v*P1v)*2.0+Lq1*(P1u*P1u)*(P0v*P0v)*2.0-Lp1*(P0u*P0u)*(PTv*PTv)*2.0-Lp1*(P0v*P0v)*(PTu*PTu)*2.0-Lp2*(P0u*P0u)*(PTv*PTv)*4.0-Lp2*(P0v*P0v)*(PTu*PTu)*4.0+Lq1*(P0u*P0u)*(PTv*PTv)*2.0+Lq1*(P0v*P0v)*(PTu*PTu)*2.0+Lq1*(P1u*P1u)*(PTv*PTv)*2.0+Lq1*(P1v*P1v)*(PTu*PTu)*2.0+(Lp1*Lp1)*(P0u*P0u)*(P1v*P1v)+(Lp1*Lp1)*(P1u*P1u)*(P0v*P0v)+(Lp2*Lp2)*(P0u*P0u)*(P1v*P1v)+(Lp2*Lp2)*(P1u*P1u)*(P0v*P0v)+(Lp1*Lp1)*(P1u*P1u)*(P2v*P2v)+(Lp1*Lp1)*(P2u*P2u)*(P1v*P1v)+(Lp2*Lp2)*(P0u*P0u)*(P2v*P2v)+(Lp2*Lp2)*(P2u*P2u)*(P0v*P0v)+(Lp2*Lp2)*(P1u*P1u)*(P2v*P2v)+(Lp2*Lp2)*(P2u*P2u)*(P1v*P1v)+(Lq1*Lq1)*(P0u*P0u)*(P1v*P1v)+(Lq1*Lq1)*(P1u*P1u)*(P0v*P0v)+(Lp1*Lp1)*(P0u*P0u)*(PTv*PTv)+(Lp1*Lp1)*(P0v*P0v)*(PTu*PTu)+(Lp1*Lp1)*(P2u*P2u)*(PTv*PTv)+(Lp1*Lp1)*(P2v*P2v)*(PTu*PTu)+(Lq1*Lq1)*(P0u*P0u)*(PTv*PTv)+(Lq1*Lq1)*(P0v*P0v)*(PTu*PTu)+(Lq1*Lq1)*(P1u*P1u)*(PTv*PTv)+(Lq1*Lq1)*(P1v*P1v)*(PTu*PTu)-P0u*P1u*(PTv*PTv)*2.0-P0u*(P1v*P1v)*PTu*2.0-P1u*(P0v*P0v)*PTu*2.0-P0v*P1v*(PTu*PTu)*2.0-(P0u*P0u)*P1v*PTv*2.0-(P1u*P1u)*P0v*PTv*2.0+Lp1*Lp2*(P0u*P0u)*(P1v*P1v)*2.0+Lp1*Lp2*(P1u*P1u)*(P0v*P0v)*2.0+Lp1*Lp2*(P1u*P1u)*(P2v*P2v)*2.0+Lp1*Lp2*(P2u*P2u)*(P1v*P1v)*2.0-Lp1*Lq1*(P0u*P0u)*(P1v*P1v)*2.0-Lp1*Lq1*(P1u*P1u)*(P0v*P0v)*2.0-Lp2*Lq1*(P0u*P0u)*(P1v*P1v)*2.0-Lp2*Lq1*(P1u*P1u)*(P0v*P0v)*2.0+Lp1*Lq1*(P0u*P0u)*(PTv*PTv)*2.0+Lp1*Lq1*(P0v*P0v)*(PTu*PTu)*2.0-(Lp1*Lp1)*P0u*P2u*(P1v*P1v)*2.0-(Lp2*Lp2)*P0u*P1u*(P2v*P2v)*2.0-(Lp2*Lp2)*P0u*P2u*(P1v*P1v)*2.0-(Lp2*Lp2)*P1u*P2u*(P0v*P0v)*2.0-(Lp1*Lp1)*(P1u*P1u)*P0v*P2v*2.0-(Lp2*Lp2)*(P0u*P0u)*P1v*P2v*2.0-(Lp2*Lp2)*(P1u*P1u)*P0v*P2v*2.0-(Lp2*Lp2)*(P2u*P2u)*P0v*P1v*2.0-(Lp1*Lp1)*P1u*(P0v*P0v)*PTu*2.0-(Lp1*Lp1)*P0u*P2u*(PTv*PTv)*2.0-(Lp1*Lp1)*P1u*(P2v*P2v)*PTu*2.0-(Lp1*Lp1)*(P0u*P0u)*P1v*PTv*2.0-(Lp1*Lp1)*P0v*P2v*(PTu*PTu)*2.0-(Lp1*Lp1)*(P2u*P2u)*P1v*PTv*2.0-(Lq1*Lq1)*P0u*P1u*(PTv*PTv)*2.0-(Lq1*Lq1)*P0u*(P1v*P1v)*PTu*2.0-(Lq1*Lq1)*P1u*(P0v*P0v)*PTu*2.0-(Lq1*Lq1)*P0v*P1v*(PTu*PTu)*2.0-(Lq1*Lq1)*(P0u*P0u)*P1v*PTv*2.0-(Lq1*Lq1)*(P1u*P1u)*P0v*PTv*2.0-P0u*P1u*P0v*P1v*2.0+P0u*P1u*P0v*PTv*2.0+P0u*P0v*P1v*PTu*2.0+P0u*P1u*P1v*PTv*2.0+P1u*P0v*P1v*PTu*2.0-P0u*P0v*PTu*PTv*2.0+P0u*P1v*PTu*PTv*2.0+P1u*P0v*PTu*PTv*2.0-P1u*P1v*PTu*PTv*2.0+Lp1*P0u*P2u*(P1v*P1v)*2.0+Lp2*P0u*P2u*(P1v*P1v)*2.0-Lp2*P1u*P2u*(P0v*P0v)*2.0+Lp1*(P1u*P1u)*P0v*P2v*2.0-Lp2*(P0u*P0u)*P1v*P2v*2.0+Lp2*(P1u*P1u)*P0v*P2v*2.0+Lp1*P0u*P1u*(PTv*PTv)*2.0+Lp1*P0u*(P1v*P1v)*PTu*2.0+Lp1*P1u*(P0v*P0v)*PTu*4.0+Lp1*P0u*P2u*(PTv*PTv)*2.0+Lp2*P0u*P1u*(PTv*PTv)*4.0+Lp2*P0u*(P1v*P1v)*PTu*2.0+Lp2*P1u*(P0v*P0v)*PTu*6.0-Lp1*P1u*P2u*(PTv*PTv)*2.0-Lp1*P2u*(P1v*P1v)*PTu*2.0+Lp2*P0u*P2u*(PTv*PTv)*4.0+Lp2*P2u*(P0v*P0v)*PTu*2.0-Lp2*P1u*P2u*(PTv*PTv)*4.0-Lp2*P2u*(P1v*P1v)*PTu*2.0+Lp1*P0v*P1v*(PTu*PTu)*2.0+Lp1*(P0u*P0u)*P1v*PTv*4.0+Lp1*(P1u*P1u)*P0v*PTv*2.0+Lp1*P0v*P2v*(PTu*PTu)*2.0+Lp2*P0v*P1v*(PTu*PTu)*4.0+Lp2*(P0u*P0u)*P1v*PTv*6.0+Lp2*(P1u*P1u)*P0v*PTv*2.0-Lp1*P1v*P2v*(PTu*PTu)*2.0-Lp1*(P1u*P1u)*P2v*PTv*2.0+Lp2*P0v*P2v*(PTu*PTu)*4.0+Lp2*(P0u*P0u)*P2v*PTv*2.0-Lp2*P1v*P2v*(PTu*PTu)*4.0-Lp2*(P1u*P1u)*P2v*PTv*2.0-Lq1*P0u*P1u*(PTv*PTv)*4.0-Lq1*P0u*(P1v*P1v)*PTu*4.0-Lq1*P1u*(P0v*P0v)*PTu*4.0-Lq1*P0v*P1v*(PTu*PTu)*4.0-Lq1*(P0u*P0u)*P1v*PTv*4.0-Lq1*(P1u*P1u)*P0v*PTv*4.0-Lp1*Lp2*P0u*P1u*(P2v*P2v)*2.0-Lp1*Lp2*P0u*P2u*(P1v*P1v)*4.0-Lp1*Lp2*P1u*P2u*(P0v*P0v)*2.0-Lp1*Lp2*(P0u*P0u)*P1v*P2v*2.0-Lp1*Lp2*(P1u*P1u)*P0v*P2v*4.0-Lp1*Lp2*(P2u*P2u)*P0v*P1v*2.0+Lp1*Lq1*P0u*P2u*(P1v*P1v)*2.0+Lp1*Lq1*P1u*P2u*(P0v*P0v)*4.0+Lp2*Lq1*P0u*P2u*(P1v*P1v)*2.0+Lp2*Lq1*P1u*P2u*(P0v*P0v)*2.0+Lp1*Lq1*(P0u*P0u)*P1v*P2v*4.0+Lp1*Lq1*(P1u*P1u)*P0v*P2v*2.0+Lp2*Lq1*(P0u*P0u)*P1v*P2v*2.0+Lp2*Lq1*(P1u*P1u)*P0v*P2v*2.0-Lp1*Lp2*P1u*(P0v*P0v)*PTu*2.0+Lp1*Lp2*P0u*(P2v*P2v)*PTu*2.0+Lp1*Lp2*P2u*(P0v*P0v)*PTu*2.0-Lp1*Lp2*P1u*(P2v*P2v)*PTu*2.0-Lp1*Lp2*(P0u*P0u)*P1v*PTv*2.0+Lp1*Lp2*(P0u*P0u)*P2v*PTv*2.0+Lp1*Lp2*(P2u*P2u)*P0v*PTv*2.0-Lp1*Lp2*(P2u*P2u)*P1v*PTv*2.0-Lp1*Lq1*P0u*P1u*(PTv*PTv)*2.0+Lp1*Lq1*P0u*(P1v*P1v)*PTu*2.0-Lp1*Lq1*P0u*P2u*(PTv*PTv)*2.0-Lp1*Lq1*P2u*(P0v*P0v)*PTu*4.0+Lp2*Lq1*P0u*(P1v*P1v)*PTu*2.0+Lp2*Lq1*P1u*(P0v*P0v)*PTu*2.0+Lp1*Lq1*P1u*P2u*(PTv*PTv)*2.0-Lp1*Lq1*P2u*(P1v*P1v)*PTu*2.0-Lp2*Lq1*P2u*(P0v*P0v)*PTu*2.0-Lp2*Lq1*P2u*(P1v*P1v)*PTu*2.0-Lp1*Lq1*P0v*P1v*(PTu*PTu)*2.0+Lp1*Lq1*(P1u*P1u)*P0v*PTv*2.0-Lp1*Lq1*P0v*P2v*(PTu*PTu)*2.0-Lp1*Lq1*(P0u*P0u)*P2v*PTv*4.0+Lp2*Lq1*(P0u*P0u)*P1v*PTv*2.0+Lp2*Lq1*(P1u*P1u)*P0v*PTv*2.0+Lp1*Lq1*P1v*P2v*(PTu*PTu)*2.0-Lp1*Lq1*(P1u*P1u)*P2v*PTv*2.0-Lp2*Lq1*(P0u*P0u)*P2v*PTv*2.0-Lp2*Lq1*(P1u*P1u)*P2v*PTv*2.0-(Lp1*Lp1)*P0u*P1u*P0v*P1v*2.0-(Lp2*Lp2)*P0u*P1u*P0v*P1v*2.0+(Lp1*Lp1)*P0u*P1u*P1v*P2v*2.0+(Lp1*Lp1)*P1u*P2u*P0v*P1v*2.0+(Lp2*Lp2)*P0u*P1u*P0v*P2v*2.0+(Lp2*Lp2)*P0u*P2u*P0v*P1v*2.0+(Lp2*Lp2)*P0u*P1u*P1v*P2v*2.0-(Lp2*Lp2)*P0u*P2u*P0v*P2v*2.0+(Lp2*Lp2)*P1u*P2u*P0v*P1v*2.0-(Lp1*Lp1)*P1u*P2u*P1v*P2v*2.0+(Lp2*Lp2)*P0u*P2u*P1v*P2v*2.0+(Lp2*Lp2)*P1u*P2u*P0v*P2v*2.0-(Lp2*Lp2)*P1u*P2u*P1v*P2v*2.0-(Lq1*Lq1)*P0u*P1u*P0v*P1v*2.0+(Lp1*Lp1)*P0u*P1u*P0v*PTv*2.0+(Lp1*Lp1)*P0u*P0v*P1v*PTu*2.0-(Lp1*Lp1)*P0u*P1u*P2v*PTv*2.0+(Lp1*Lp1)*P0u*P2u*P1v*PTv*4.0-(Lp1*Lp1)*P0u*P1v*P2v*PTu*2.0-(Lp1*Lp1)*P1u*P2u*P0v*PTv*2.0+(Lp1*Lp1)*P1u*P0v*P2v*PTu*4.0-(Lp1*Lp1)*P2u*P0v*P1v*PTu*2.0+(Lp1*Lp1)*P1u*P2u*P2v*PTv*2.0+(Lp1*Lp1)*P2u*P1v*P2v*PTu*2.0+(Lq1*Lq1)*P0u*P1u*P0v*PTv*2.0+(Lq1*Lq1)*P0u*P0v*P1v*PTu*2.0+(Lq1*Lq1)*P0u*P1u*P1v*PTv*2.0+(Lq1*Lq1)*P1u*P0v*P1v*PTu*2.0-(Lp1*Lp1)*P0u*P0v*PTu*PTv*2.0+(Lp1*Lp1)*P0u*P2v*PTu*PTv*2.0+(Lp1*Lp1)*P2u*P0v*PTu*PTv*2.0-(Lp1*Lp1)*P2u*P2v*PTu*PTv*2.0-(Lq1*Lq1)*P0u*P0v*PTu*PTv*2.0+(Lq1*Lq1)*P0u*P1v*PTu*PTv*2.0+(Lq1*Lq1)*P1u*P0v*PTu*PTv*2.0-(Lq1*Lq1)*P1u*P1v*PTu*PTv*2.0+Lp1*P0u*P1u*P0v*P1v*4.0+Lp2*P0u*P1u*P0v*P1v*4.0-Lp1*P0u*P1u*P1v*P2v*2.0-Lp1*P1u*P2u*P0v*P1v*2.0+Lp2*P0u*P1u*P0v*P2v*2.0+Lp2*P0u*P2u*P0v*P1v*2.0-Lp2*P0u*P1u*P1v*P2v*2.0-Lp2*P1u*P2u*P0v*P1v*2.0-Lq1*P0u*P1u*P0v*P1v*4.0-Lp1*P0u*P1u*P0v*PTv*4.0-Lp1*P0u*P0v*P1v*PTu*4.0-Lp1*P0u*P1u*P1v*PTv*2.0-Lp1*P1u*P0v*P1v*PTu*2.0-Lp2*P0u*P1u*P0v*PTv*6.0-Lp2*P0u*P0v*P1v*PTu*6.0+Lp1*P0u*P1u*P2v*PTv*2.0-Lp1*P0u*P2u*P1v*PTv*4.0+Lp1*P0u*P1v*P2v*PTu*2.0+Lp1*P1u*P2u*P0v*PTv*2.0-Lp1*P1u*P0v*P2v*PTu*4.0+Lp1*P2u*P0v*P1v*PTu*2.0-Lp2*P0u*P1u*P1v*PTv*2.0-Lp2*P0u*P2u*P0v*PTv*2.0-Lp2*P0u*P0v*P2v*PTu*2.0-Lp2*P1u*P0v*P1v*PTu*2.0+Lp1*P1u*P2u*P1v*PTv*2.0+Lp1*P1u*P1v*P2v*PTu*2.0-Lp2*P0u*P2u*P1v*PTv*6.0+Lp2*P0u*P1v*P2v*PTu*6.0+Lp2*P1u*P2u*P0v*PTv*6.0-Lp2*P1u*P0v*P2v*PTu*6.0+Lp2*P1u*P2u*P1v*PTv*2.0+Lp2*P1u*P1v*P2v*PTu*2.0+Lq1*P0u*P1u*P0v*PTv*4.0+Lq1*P0u*P0v*P1v*PTu*4.0+Lq1*P0u*P1u*P1v*PTv*4.0+Lq1*P1u*P0v*P1v*PTu*4.0+Lp1*P0u*P0v*PTu*PTv*4.0-Lp1*P0u*P1v*PTu*PTv*2.0-Lp1*P1u*P0v*PTu*PTv*2.0+Lp2*P0u*P0v*PTu*PTv*8.0-Lp1*P0u*P2v*PTu*PTv*2.0-Lp1*P2u*P0v*PTu*PTv*2.0-Lp2*P0u*P1v*PTu*PTv*4.0-Lp2*P1u*P0v*PTu*PTv*4.0+Lp1*P1u*P2v*PTu*PTv*2.0+Lp1*P2u*P1v*PTu*PTv*2.0-Lp2*P0u*P2v*PTu*PTv*4.0-Lp2*P2u*P0v*PTu*PTv*4.0+Lp2*P1u*P2v*PTu*PTv*4.0+Lp2*P2u*P1v*PTu*PTv*4.0-Lq1*P0u*P0v*PTu*PTv*4.0+Lq1*P0u*P1v*PTu*PTv*4.0+Lq1*P1u*P0v*PTu*PTv*4.0-Lq1*P1u*P1v*PTu*PTv*4.0-Lp1*Lp2*P0u*P1u*P0v*P1v*4.0+Lp1*Lp2*P0u*P1u*P0v*P2v*2.0+Lp1*Lp2*P0u*P2u*P0v*P1v*2.0+Lp1*Lp2*P0u*P1u*P1v*P2v*4.0+Lp1*Lp2*P1u*P2u*P0v*P1v*4.0+Lp1*Lp2*P0u*P2u*P1v*P2v*2.0+Lp1*Lp2*P1u*P2u*P0v*P2v*2.0-Lp1*Lp2*P1u*P2u*P1v*P2v*4.0+Lp1*Lq1*P0u*P1u*P0v*P1v*4.0-Lp1*Lq1*P0u*P1u*P0v*P2v*4.0-Lp1*Lq1*P0u*P2u*P0v*P1v*4.0+Lp2*Lq1*P0u*P1u*P0v*P1v*4.0-Lp1*Lq1*P0u*P1u*P1v*P2v*2.0-Lp1*Lq1*P1u*P2u*P0v*P1v*2.0-Lp2*Lq1*P0u*P1u*P0v*P2v*2.0-Lp2*Lq1*P0u*P2u*P0v*P1v*2.0-Lp2*Lq1*P0u*P1u*P1v*P2v*2.0-Lp2*Lq1*P1u*P2u*P0v*P1v*2.0+Lp1*Lp2*P0u*P1u*P0v*PTv*2.0+Lp1*Lp2*P0u*P0v*P1v*PTu*2.0-Lp1*Lp2*P0u*P2u*P0v*PTv*2.0-Lp1*Lp2*P0u*P0v*P2v*PTu*2.0-Lp1*Lp2*P0u*P1u*P2v*PTv*2.0+Lp1*Lp2*P0u*P2u*P1v*PTv*4.0-Lp1*Lp2*P0u*P1v*P2v*PTu*2.0-Lp1*Lp2*P1u*P2u*P0v*PTv*2.0+Lp1*Lp2*P1u*P0v*P2v*PTu*4.0-Lp1*Lp2*P2u*P0v*P1v*PTu*2.0-Lp1*Lp2*P0u*P2u*P2v*PTv*2.0-Lp1*Lp2*P2u*P0v*P2v*PTu*2.0+Lp1*Lp2*P1u*P2u*P2v*PTv*2.0+Lp1*Lp2*P2u*P1v*P2v*PTu*2.0-Lp1*Lq1*P0u*P1u*P1v*PTv*2.0+Lp1*Lq1*P0u*P2u*P0v*PTv*4.0+Lp1*Lq1*P0u*P0v*P2v*PTu*4.0-Lp1*Lq1*P1u*P0v*P1v*PTu*2.0-Lp2*Lq1*P0u*P1u*P0v*PTv*2.0-Lp2*Lq1*P0u*P0v*P1v*PTu*2.0+Lp1*Lq1*P0u*P1u*P2v*PTv*6.0-Lp1*Lq1*P0u*P1v*P2v*PTu*6.0-Lp1*Lq1*P1u*P2u*P0v*PTv*6.0+Lp1*Lq1*P2u*P0v*P1v*PTu*6.0-Lp2*Lq1*P0u*P1u*P1v*PTv*2.0+Lp2*Lq1*P0u*P2u*P0v*PTv*2.0+Lp2*Lq1*P0u*P0v*P2v*PTu*2.0-Lp2*Lq1*P1u*P0v*P1v*PTu*2.0+Lp1*Lq1*P1u*P2u*P1v*PTv*2.0+Lp1*Lq1*P1u*P1v*P2v*PTu*2.0+Lp2*Lq1*P0u*P1u*P2v*PTv*4.0-Lp2*Lq1*P0u*P2u*P1v*PTv*2.0-Lp2*Lq1*P0u*P1v*P2v*PTu*2.0-Lp2*Lq1*P1u*P2u*P0v*PTv*2.0-Lp2*Lq1*P1u*P0v*P2v*PTu*2.0+Lp2*Lq1*P2u*P0v*P1v*PTu*4.0+Lp2*Lq1*P1u*P2u*P1v*PTv*2.0+Lp2*Lq1*P1u*P1v*P2v*PTu*2.0-Lp1*Lq1*P0u*P0v*PTu*PTv*4.0+Lp1*Lq1*P0u*P1v*PTu*PTv*2.0+Lp1*Lq1*P1u*P0v*PTu*PTv*2.0+Lp1*Lq1*P0u*P2v*PTu*PTv*2.0+Lp1*Lq1*P2u*P0v*PTu*PTv*2.0-Lp1*Lq1*P1u*P2v*PTu*PTv*2.0-Lp1*Lq1*P2u*P1v*PTu*PTv*2.0)*(1.0/2.0)+P0u*P1v*(1.0/2.0)-P1u*P0v*(1.0/2.0)-P0u*PTv*(1.0/2.0)+P0v*PTu*(1.0/2.0)+P1u*PTv*(1.0/2.0)-P1v*PTu*(1.0/2.0)-Lp1*P0u*P1v*(1.0/2.0)+Lp1*P1u*P0v*(1.0/2.0)+Lp1*P0u*P2v-Lp1*P2u*P0v-Lp2*P0u*P1v*(1.0/2.0)+Lp2*P1u*P0v*(1.0/2.0)-Lp1*P1u*P2v*(1.0/2.0)+Lp1*P2u*P1v*(1.0/2.0)+Lp2*P0u*P2v*(1.0/2.0)-Lp2*P2u*P0v*(1.0/2.0)-Lp2*P1u*P2v*(1.0/2.0)+Lp2*P2u*P1v*(1.0/2.0)+Lq1*P0u*P1v*(1.0/2.0)-Lq1*P1u*P0v*(1.0/2.0)-Lp1*P0u*PTv*(1.0/2.0)+Lp1*P0v*PTu*(1.0/2.0)+Lp1*P2u*PTv*(1.0/2.0)-Lp1*P2v*PTu*(1.0/2.0)-Lq1*P0u*PTv*(1.0/2.0)+Lq1*P0v*PTu*(1.0/2.0)+Lq1*P1u*PTv*(1.0/2.0)-Lq1*P1v*PTu*(1.0/2.0))/(P0u*P1v-P1u*P0v-P0u*PTv+P0v*PTu+P1u*PTv-P1v*PTu-Lp1*P0u*P1v+Lp1*P1u*P0v+Lp1*P0u*P2v-Lp1*P2u*P0v-Lp1*P1u*P2v+Lp1*P2u*P1v);
    dL = (Lp1 * (1-dR) + Lp2) / ((1-dR) + Lq1);
    
else % Direct
        
    % dR = 1 - dR, dL = f(dR)
    %dR = 1 + -((Lp1^2*P0u^2*P2v^2 - 2*Lp1^2*P0u^2*P2v*PTv + Lp1^2*P0u^2*PTv^2 - 2*Lp1^2*P0u*P2u*P0v*P2v + 2*Lp1^2*P0u*P2u*P0v*PTv + 2*Lp1^2*P0u*P2u*P2v*PTv - 2*Lp1^2*P0u*P2u*PTv^2 + 2*Lp1^2*P0u*P0v*P2v*PTu - 2*Lp1^2*P0u*P0v*PTu*PTv - 2*Lp1^2*P0u*P2v^2*PTu + 2*Lp1^2*P0u*P2v*PTu*PTv + Lp1^2*P2u^2*P0v^2 - 2*Lp1^2*P2u^2*P0v*PTv + Lp1^2*P2u^2*PTv^2 - 2*Lp1^2*P2u*P0v^2*PTu + 2*Lp1^2*P2u*P0v*P2v*PTu + 2*Lp1^2*P2u*P0v*PTu*PTv - 2*Lp1^2*P2u*P2v*PTu*PTv + Lp1^2*P0v^2*PTu^2 - 2*Lp1^2*P0v*P2v*PTu^2 + Lp1^2*P2v^2*PTu^2 - 2*Lp1*Lp2*P0u^2*P1v*P2v + 2*Lp1*Lp2*P0u^2*P1v*PTv + 2*Lp1*Lp2*P0u^2*P2v^2 - 2*Lp1*Lp2*P0u^2*P2v*PTv + 2*Lp1*Lp2*P0u*P1u*P0v*P2v - 2*Lp1*Lp2*P0u*P1u*P0v*PTv - 2*Lp1*Lp2*P0u*P1u*P2v^2 + 2*Lp1*Lp2*P0u*P1u*P2v*PTv + 2*Lp1*Lp2*P0u*P2u*P0v*P1v - 4*Lp1*Lp2*P0u*P2u*P0v*P2v + 2*Lp1*Lp2*P0u*P2u*P0v*PTv + 2*Lp1*Lp2*P0u*P2u*P1v*P2v - 4*Lp1*Lp2*P0u*P2u*P1v*PTv + 2*Lp1*Lp2*P0u*P2u*P2v*PTv - 2*Lp1*Lp2*P0u*P0v*P1v*PTu + 2*Lp1*Lp2*P0u*P0v*P2v*PTu + 2*Lp1*Lp2*P0u*P1v*P2v*PTu - 2*Lp1*Lp2*P0u*P2v^2*PTu - 2*Lp1*Lp2*P1u*P2u*P0v^2 + 2*Lp1*Lp2*P1u*P2u*P0v*P2v + 2*Lp1*Lp2*P1u*P2u*P0v*PTv - 2*Lp1*Lp2*P1u*P2u*P2v*PTv + 2*Lp1*Lp2*P1u*P0v^2*PTu - 4*Lp1*Lp2*P1u*P0v*P2v*PTu + 2*Lp1*Lp2*P1u*P2v^2*PTu + 2*Lp1*Lp2*P2u^2*P0v^2 - 2*Lp1*Lp2*P2u^2*P0v*P1v - 2*Lp1*Lp2*P2u^2*P0v*PTv + 2*Lp1*Lp2*P2u^2*P1v*PTv - 2*Lp1*Lp2*P2u*P0v^2*PTu + 2*Lp1*Lp2*P2u*P0v*P1v*PTu + 2*Lp1*Lp2*P2u*P0v*P2v*PTu - 2*Lp1*Lp2*P2u*P1v*P2v*PTu - 2*Lp1*Lq1*P0u^2*P1v*P2v + 2*Lp1*Lq1*P0u^2*P1v*PTv + 2*Lp1*Lq1*P0u^2*P2v*PTv - 2*Lp1*Lq1*P0u^2*PTv^2 + 2*Lp1*Lq1*P0u*P1u*P0v*P2v - 2*Lp1*Lq1*P0u*P1u*P0v*PTv - 2*Lp1*Lq1*P0u*P1u*P2v*PTv + 2*Lp1*Lq1*P0u*P1u*PTv^2 + 2*Lp1*Lq1*P0u*P2u*P0v*P1v - 2*Lp1*Lq1*P0u*P2u*P0v*PTv - 2*Lp1*Lq1*P0u*P2u*P1v*PTv + 2*Lp1*Lq1*P0u*P2u*PTv^2 - 2*Lp1*Lq1*P0u*P0v*P1v*PTu - 2*Lp1*Lq1*P0u*P0v*P2v*PTu + 4*Lp1*Lq1*P0u*P0v*PTu*PTv + 4*Lp1*Lq1*P0u*P1v*P2v*PTu - 2*Lp1*Lq1*P0u*P1v*PTu*PTv - 2*Lp1*Lq1*P0u*P2v*PTu*PTv - 2*Lp1*Lq1*P1u*P2u*P0v^2 + 4*Lp1*Lq1*P1u*P2u*P0v*PTv - 2*Lp1*Lq1*P1u*P2u*PTv^2 + 2*Lp1*Lq1*P1u*P0v^2*PTu - 2*Lp1*Lq1*P1u*P0v*P2v*PTu - 2*Lp1*Lq1*P1u*P0v*PTu*PTv + 2*Lp1*Lq1*P1u*P2v*PTu*PTv + 2*Lp1*Lq1*P2u*P0v^2*PTu - 2*Lp1*Lq1*P2u*P0v*P1v*PTu - 2*Lp1*Lq1*P2u*P0v*PTu*PTv + 2*Lp1*Lq1*P2u*P1v*PTu*PTv - 2*Lp1*Lq1*P0v^2*PTu^2 + 2*Lp1*Lq1*P0v*P1v*PTu^2 + 2*Lp1*Lq1*P0v*P2v*PTu^2 - 2*Lp1*Lq1*P1v*P2v*PTu^2 + Lp2^2*P0u^2*P1v^2 - 2*Lp2^2*P0u^2*P1v*P2v + Lp2^2*P0u^2*P2v^2 - 2*Lp2^2*P0u*P1u*P0v*P1v + 2*Lp2^2*P0u*P1u*P0v*P2v + 2*Lp2^2*P0u*P1u*P1v*P2v - 2*Lp2^2*P0u*P1u*P2v^2 + 2*Lp2^2*P0u*P2u*P0v*P1v - 2*Lp2^2*P0u*P2u*P0v*P2v - 2*Lp2^2*P0u*P2u*P1v^2 + 2*Lp2^2*P0u*P2u*P1v*P2v + Lp2^2*P1u^2*P0v^2 - 2*Lp2^2*P1u^2*P0v*P2v + Lp2^2*P1u^2*P2v^2 - 2*Lp2^2*P1u*P2u*P0v^2 + 2*Lp2^2*P1u*P2u*P0v*P1v + 2*Lp2^2*P1u*P2u*P0v*P2v - 2*Lp2^2*P1u*P2u*P1v*P2v + Lp2^2*P2u^2*P0v^2 - 2*Lp2^2*P2u^2*P0v*P1v + Lp2^2*P2u^2*P1v^2 - 2*Lp2*Lq1*P0u^2*P1v^2 + 2*Lp2*Lq1*P0u^2*P1v*P2v + 2*Lp2*Lq1*P0u^2*P1v*PTv - 2*Lp2*Lq1*P0u^2*P2v*PTv + 4*Lp2*Lq1*P0u*P1u*P0v*P1v - 2*Lp2*Lq1*P0u*P1u*P0v*P2v - 2*Lp2*Lq1*P0u*P1u*P0v*PTv - 2*Lp2*Lq1*P0u*P1u*P1v*P2v - 2*Lp2*Lq1*P0u*P1u*P1v*PTv + 4*Lp2*Lq1*P0u*P1u*P2v*PTv - 2*Lp2*Lq1*P0u*P2u*P0v*P1v + 2*Lp2*Lq1*P0u*P2u*P0v*PTv + 2*Lp2*Lq1*P0u*P2u*P1v^2 - 2*Lp2*Lq1*P0u*P2u*P1v*PTv - 2*Lp2*Lq1*P0u*P0v*P1v*PTu + 2*Lp2*Lq1*P0u*P0v*P2v*PTu + 2*Lp2*Lq1*P0u*P1v^2*PTu - 2*Lp2*Lq1*P0u*P1v*P2v*PTu - 2*Lp2*Lq1*P1u^2*P0v^2 + 2*Lp2*Lq1*P1u^2*P0v*P2v + 2*Lp2*Lq1*P1u^2*P0v*PTv - 2*Lp2*Lq1*P1u^2*P2v*PTv + 2*Lp2*Lq1*P1u*P2u*P0v^2 - 2*Lp2*Lq1*P1u*P2u*P0v*P1v - 2*Lp2*Lq1*P1u*P2u*P0v*PTv + 2*Lp2*Lq1*P1u*P2u*P1v*PTv + 2*Lp2*Lq1*P1u*P0v^2*PTu - 2*Lp2*Lq1*P1u*P0v*P1v*PTu - 2*Lp2*Lq1*P1u*P0v*P2v*PTu + 2*Lp2*Lq1*P1u*P1v*P2v*PTu - 2*Lp2*Lq1*P2u*P0v^2*PTu + 4*Lp2*Lq1*P2u*P0v*P1v*PTu - 2*Lp2*Lq1*P2u*P1v^2*PTu + 4*Lp2*P0u^2*P1v*P2v - 4*Lp2*P0u^2*P1v*PTv - 4*Lp2*P0u^2*P2v*PTv + 4*Lp2*P0u^2*PTv^2 - 4*Lp2*P0u*P1u*P0v*P2v + 4*Lp2*P0u*P1u*P0v*PTv + 4*Lp2*P0u*P1u*P2v*PTv - 4*Lp2*P0u*P1u*PTv^2 - 4*Lp2*P0u*P2u*P0v*P1v + 4*Lp2*P0u*P2u*P0v*PTv + 4*Lp2*P0u*P2u*P1v*PTv - 4*Lp2*P0u*P2u*PTv^2 + 4*Lp2*P0u*P0v*P1v*PTu + 4*Lp2*P0u*P0v*P2v*PTu - 8*Lp2*P0u*P0v*PTu*PTv - 8*Lp2*P0u*P1v*P2v*PTu + 4*Lp2*P0u*P1v*PTu*PTv + 4*Lp2*P0u*P2v*PTu*PTv + 4*Lp2*P1u*P2u*P0v^2 - 8*Lp2*P1u*P2u*P0v*PTv + 4*Lp2*P1u*P2u*PTv^2 - 4*Lp2*P1u*P0v^2*PTu + 4*Lp2*P1u*P0v*P2v*PTu + 4*Lp2*P1u*P0v*PTu*PTv - 4*Lp2*P1u*P2v*PTu*PTv - 4*Lp2*P2u*P0v^2*PTu + 4*Lp2*P2u*P0v*P1v*PTu + 4*Lp2*P2u*P0v*PTu*PTv - 4*Lp2*P2u*P1v*PTu*PTv + 4*Lp2*P0v^2*PTu^2 - 4*Lp2*P0v*P1v*PTu^2 - 4*Lp2*P0v*P2v*PTu^2 + 4*Lp2*P1v*P2v*PTu^2 + Lq1^2*P0u^2*P1v^2 - 2*Lq1^2*P0u^2*P1v*PTv + Lq1^2*P0u^2*PTv^2 - 2*Lq1^2*P0u*P1u*P0v*P1v + 2*Lq1^2*P0u*P1u*P0v*PTv + 2*Lq1^2*P0u*P1u*P1v*PTv - 2*Lq1^2*P0u*P1u*PTv^2 + 2*Lq1^2*P0u*P0v*P1v*PTu - 2*Lq1^2*P0u*P0v*PTu*PTv - 2*Lq1^2*P0u*P1v^2*PTu + 2*Lq1^2*P0u*P1v*PTu*PTv + Lq1^2*P1u^2*P0v^2 - 2*Lq1^2*P1u^2*P0v*PTv + Lq1^2*P1u^2*PTv^2 - 2*Lq1^2*P1u*P0v^2*PTu + 2*Lq1^2*P1u*P0v*P1v*PTu + 2*Lq1^2*P1u*P0v*PTu*PTv - 2*Lq1^2*P1u*P1v*PTu*PTv + Lq1^2*P0v^2*PTu^2 - 2*Lq1^2*P0v*P1v*PTu^2 + Lq1^2*P1v^2*PTu^2)^(1/2) + 2*P0u*P1v - 2*P1u*P0v - 2*P0u*PTv + 2*P0v*PTu + 2*P1u*PTv - 2*P1v*PTu - 2*Lp1*P0u*P1v + 2*Lp1*P1u*P0v + Lp1*P0u*P2v - Lp1*P2u*P0v - Lp2*P0u*P1v + Lp2*P1u*P0v - 2*Lp1*P1u*P2v + 2*Lp1*P2u*P1v + Lp2*P0u*P2v - Lp2*P2u*P0v - Lp2*P1u*P2v + Lp2*P2u*P1v + Lq1*P0u*P1v - Lq1*P1u*P0v + Lp1*P0u*PTv - Lp1*P0v*PTu - Lp1*P2u*PTv + Lp1*P2v*PTu - Lq1*P0u*PTv + Lq1*P0v*PTu + Lq1*P1u*PTv - Lq1*P1v*PTu)/(2*(P0u*P1v - P1u*P0v - P0u*PTv + P0v*PTu + P1u*PTv - P1v*PTu - Lp1*P0u*P1v + Lp1*P1u*P0v + Lp1*P0u*P2v - Lp1*P2u*P0v - Lp1*P1u*P2v + Lp1*P2u*P1v));
    dR = 1 -(sqrt(Lp1*Lp1*P0u*P0u*P2v*P2v - 2*Lp1*Lp1*P0u*P0u*P2v*PTv + Lp1*Lp1*P0u*P0u*PTv*PTv - 2*Lp1*Lp1*P0u*P2u*P0v*P2v + 2*Lp1*Lp1*P0u*P2u*P0v*PTv + 2*Lp1*Lp1*P0u*P2u*P2v*PTv - 2*Lp1*Lp1*P0u*P2u*PTv*PTv + 2*Lp1*Lp1*P0u*P0v*P2v*PTu - 2*Lp1*Lp1*P0u*P0v*PTu*PTv - 2*Lp1*Lp1*P0u*P2v*P2v*PTu + 2*Lp1*Lp1*P0u*P2v*PTu*PTv + Lp1*Lp1*P2u*P2u*P0v*P0v - 2*Lp1*Lp1*P2u*P2u*P0v*PTv + Lp1*Lp1*P2u*P2u*PTv*PTv - 2*Lp1*Lp1*P2u*P0v*P0v*PTu + 2*Lp1*Lp1*P2u*P0v*P2v*PTu + 2*Lp1*Lp1*P2u*P0v*PTu*PTv - 2*Lp1*Lp1*P2u*P2v*PTu*PTv + Lp1*Lp1*P0v*P0v*PTu*PTu - 2*Lp1*Lp1*P0v*P2v*PTu*PTu + Lp1*Lp1*P2v*P2v*PTu*PTu - 2*Lp1*Lp2*P0u*P0u*P1v*P2v + 2*Lp1*Lp2*P0u*P0u*P1v*PTv + 2*Lp1*Lp2*P0u*P0u*P2v*P2v - 2*Lp1*Lp2*P0u*P0u*P2v*PTv + 2*Lp1*Lp2*P0u*P1u*P0v*P2v - 2*Lp1*Lp2*P0u*P1u*P0v*PTv - 2*Lp1*Lp2*P0u*P1u*P2v*P2v + 2*Lp1*Lp2*P0u*P1u*P2v*PTv + 2*Lp1*Lp2*P0u*P2u*P0v*P1v - 4*Lp1*Lp2*P0u*P2u*P0v*P2v + 2*Lp1*Lp2*P0u*P2u*P0v*PTv + 2*Lp1*Lp2*P0u*P2u*P1v*P2v - 4*Lp1*Lp2*P0u*P2u*P1v*PTv + 2*Lp1*Lp2*P0u*P2u*P2v*PTv - 2*Lp1*Lp2*P0u*P0v*P1v*PTu + 2*Lp1*Lp2*P0u*P0v*P2v*PTu + 2*Lp1*Lp2*P0u*P1v*P2v*PTu - 2*Lp1*Lp2*P0u*P2v*P2v*PTu - 2*Lp1*Lp2*P1u*P2u*P0v*P0v + 2*Lp1*Lp2*P1u*P2u*P0v*P2v + 2*Lp1*Lp2*P1u*P2u*P0v*PTv - 2*Lp1*Lp2*P1u*P2u*P2v*PTv + 2*Lp1*Lp2*P1u*P0v*P0v*PTu - 4*Lp1*Lp2*P1u*P0v*P2v*PTu + 2*Lp1*Lp2*P1u*P2v*P2v*PTu + 2*Lp1*Lp2*P2u*P2u*P0v*P0v - 2*Lp1*Lp2*P2u*P2u*P0v*P1v - 2*Lp1*Lp2*P2u*P2u*P0v*PTv + 2*Lp1*Lp2*P2u*P2u*P1v*PTv - 2*Lp1*Lp2*P2u*P0v*P0v*PTu + 2*Lp1*Lp2*P2u*P0v*P1v*PTu + 2*Lp1*Lp2*P2u*P0v*P2v*PTu - 2*Lp1*Lp2*P2u*P1v*P2v*PTu - 2*Lp1*Lq1*P0u*P0u*P1v*P2v + 2*Lp1*Lq1*P0u*P0u*P1v*PTv + 2*Lp1*Lq1*P0u*P0u*P2v*PTv - 2*Lp1*Lq1*P0u*P0u*PTv*PTv + 2*Lp1*Lq1*P0u*P1u*P0v*P2v - 2*Lp1*Lq1*P0u*P1u*P0v*PTv - 2*Lp1*Lq1*P0u*P1u*P2v*PTv + 2*Lp1*Lq1*P0u*P1u*PTv*PTv + 2*Lp1*Lq1*P0u*P2u*P0v*P1v - 2*Lp1*Lq1*P0u*P2u*P0v*PTv - 2*Lp1*Lq1*P0u*P2u*P1v*PTv + 2*Lp1*Lq1*P0u*P2u*PTv*PTv - 2*Lp1*Lq1*P0u*P0v*P1v*PTu - 2*Lp1*Lq1*P0u*P0v*P2v*PTu + 4*Lp1*Lq1*P0u*P0v*PTu*PTv + 4*Lp1*Lq1*P0u*P1v*P2v*PTu - 2*Lp1*Lq1*P0u*P1v*PTu*PTv - 2*Lp1*Lq1*P0u*P2v*PTu*PTv - 2*Lp1*Lq1*P1u*P2u*P0v*P0v + 4*Lp1*Lq1*P1u*P2u*P0v*PTv - 2*Lp1*Lq1*P1u*P2u*PTv*PTv + 2*Lp1*Lq1*P1u*P0v*P0v*PTu - 2*Lp1*Lq1*P1u*P0v*P2v*PTu - 2*Lp1*Lq1*P1u*P0v*PTu*PTv + 2*Lp1*Lq1*P1u*P2v*PTu*PTv + 2*Lp1*Lq1*P2u*P0v*P0v*PTu - 2*Lp1*Lq1*P2u*P0v*P1v*PTu - 2*Lp1*Lq1*P2u*P0v*PTu*PTv + 2*Lp1*Lq1*P2u*P1v*PTu*PTv - 2*Lp1*Lq1*P0v*P0v*PTu*PTu + 2*Lp1*Lq1*P0v*P1v*PTu*PTu + 2*Lp1*Lq1*P0v*P2v*PTu*PTu - 2*Lp1*Lq1*P1v*P2v*PTu*PTu + Lp2*Lp2*P0u*P0u*P1v*P1v - 2*Lp2*Lp2*P0u*P0u*P1v*P2v + Lp2*Lp2*P0u*P0u*P2v*P2v - 2*Lp2*Lp2*P0u*P1u*P0v*P1v + 2*Lp2*Lp2*P0u*P1u*P0v*P2v + 2*Lp2*Lp2*P0u*P1u*P1v*P2v - 2*Lp2*Lp2*P0u*P1u*P2v*P2v + 2*Lp2*Lp2*P0u*P2u*P0v*P1v - 2*Lp2*Lp2*P0u*P2u*P0v*P2v - 2*Lp2*Lp2*P0u*P2u*P1v*P1v + 2*Lp2*Lp2*P0u*P2u*P1v*P2v + Lp2*Lp2*P1u*P1u*P0v*P0v - 2*Lp2*Lp2*P1u*P1u*P0v*P2v + Lp2*Lp2*P1u*P1u*P2v*P2v - 2*Lp2*Lp2*P1u*P2u*P0v*P0v + 2*Lp2*Lp2*P1u*P2u*P0v*P1v + 2*Lp2*Lp2*P1u*P2u*P0v*P2v - 2*Lp2*Lp2*P1u*P2u*P1v*P2v + Lp2*Lp2*P2u*P2u*P0v*P0v - 2*Lp2*Lp2*P2u*P2u*P0v*P1v + Lp2*Lp2*P2u*P2u*P1v*P1v - 2*Lp2*Lq1*P0u*P0u*P1v*P1v + 2*Lp2*Lq1*P0u*P0u*P1v*P2v + 2*Lp2*Lq1*P0u*P0u*P1v*PTv - 2*Lp2*Lq1*P0u*P0u*P2v*PTv + 4*Lp2*Lq1*P0u*P1u*P0v*P1v - 2*Lp2*Lq1*P0u*P1u*P0v*P2v - 2*Lp2*Lq1*P0u*P1u*P0v*PTv - 2*Lp2*Lq1*P0u*P1u*P1v*P2v - 2*Lp2*Lq1*P0u*P1u*P1v*PTv + 4*Lp2*Lq1*P0u*P1u*P2v*PTv - 2*Lp2*Lq1*P0u*P2u*P0v*P1v + 2*Lp2*Lq1*P0u*P2u*P0v*PTv + 2*Lp2*Lq1*P0u*P2u*P1v*P1v - 2*Lp2*Lq1*P0u*P2u*P1v*PTv - 2*Lp2*Lq1*P0u*P0v*P1v*PTu + 2*Lp2*Lq1*P0u*P0v*P2v*PTu + 2*Lp2*Lq1*P0u*P1v*P1v*PTu - 2*Lp2*Lq1*P0u*P1v*P2v*PTu - 2*Lp2*Lq1*P1u*P1u*P0v*P0v + 2*Lp2*Lq1*P1u*P1u*P0v*P2v + 2*Lp2*Lq1*P1u*P1u*P0v*PTv - 2*Lp2*Lq1*P1u*P1u*P2v*PTv + 2*Lp2*Lq1*P1u*P2u*P0v*P0v - 2*Lp2*Lq1*P1u*P2u*P0v*P1v - 2*Lp2*Lq1*P1u*P2u*P0v*PTv + 2*Lp2*Lq1*P1u*P2u*P1v*PTv + 2*Lp2*Lq1*P1u*P0v*P0v*PTu - 2*Lp2*Lq1*P1u*P0v*P1v*PTu - 2*Lp2*Lq1*P1u*P0v*P2v*PTu + 2*Lp2*Lq1*P1u*P1v*P2v*PTu - 2*Lp2*Lq1*P2u*P0v*P0v*PTu + 4*Lp2*Lq1*P2u*P0v*P1v*PTu - 2*Lp2*Lq1*P2u*P1v*P1v*PTu + 4*Lp2*P0u*P0u*P1v*P2v - 4*Lp2*P0u*P0u*P1v*PTv - 4*Lp2*P0u*P0u*P2v*PTv + 4*Lp2*P0u*P0u*PTv*PTv - 4*Lp2*P0u*P1u*P0v*P2v + 4*Lp2*P0u*P1u*P0v*PTv + 4*Lp2*P0u*P1u*P2v*PTv - 4*Lp2*P0u*P1u*PTv*PTv - 4*Lp2*P0u*P2u*P0v*P1v + 4*Lp2*P0u*P2u*P0v*PTv + 4*Lp2*P0u*P2u*P1v*PTv - 4*Lp2*P0u*P2u*PTv*PTv + 4*Lp2*P0u*P0v*P1v*PTu + 4*Lp2*P0u*P0v*P2v*PTu - 8*Lp2*P0u*P0v*PTu*PTv - 8*Lp2*P0u*P1v*P2v*PTu + 4*Lp2*P0u*P1v*PTu*PTv + 4*Lp2*P0u*P2v*PTu*PTv + 4*Lp2*P1u*P2u*P0v*P0v - 8*Lp2*P1u*P2u*P0v*PTv + 4*Lp2*P1u*P2u*PTv*PTv - 4*Lp2*P1u*P0v*P0v*PTu + 4*Lp2*P1u*P0v*P2v*PTu + 4*Lp2*P1u*P0v*PTu*PTv - 4*Lp2*P1u*P2v*PTu*PTv - 4*Lp2*P2u*P0v*P0v*PTu + 4*Lp2*P2u*P0v*P1v*PTu + 4*Lp2*P2u*P0v*PTu*PTv - 4*Lp2*P2u*P1v*PTu*PTv + 4*Lp2*P0v*P0v*PTu*PTu - 4*Lp2*P0v*P1v*PTu*PTu - 4*Lp2*P0v*P2v*PTu*PTu + 4*Lp2*P1v*P2v*PTu*PTu + Lq1*Lq1*P0u*P0u*P1v*P1v - 2*Lq1*Lq1*P0u*P0u*P1v*PTv + Lq1*Lq1*P0u*P0u*PTv*PTv - 2*Lq1*Lq1*P0u*P1u*P0v*P1v + 2*Lq1*Lq1*P0u*P1u*P0v*PTv + 2*Lq1*Lq1*P0u*P1u*P1v*PTv - 2*Lq1*Lq1*P0u*P1u*PTv*PTv + 2*Lq1*Lq1*P0u*P0v*P1v*PTu - 2*Lq1*Lq1*P0u*P0v*PTu*PTv - 2*Lq1*Lq1*P0u*P1v*P1v*PTu + 2*Lq1*Lq1*P0u*P1v*PTu*PTv + Lq1*Lq1*P1u*P1u*P0v*P0v - 2*Lq1*Lq1*P1u*P1u*P0v*PTv + Lq1*Lq1*P1u*P1u*PTv*PTv - 2*Lq1*Lq1*P1u*P0v*P0v*PTu + 2*Lq1*Lq1*P1u*P0v*P1v*PTu + 2*Lq1*Lq1*P1u*P0v*PTu*PTv - 2*Lq1*Lq1*P1u*P1v*PTu*PTv + Lq1*Lq1*P0v*P0v*PTu*PTu - 2*Lq1*Lq1*P0v*P1v*PTu*PTu + Lq1*Lq1*P1v*P1v*PTu*PTu) + 2*P0u*P1v - 2*P1u*P0v - 2*P0u*PTv + 2*P0v*PTu + 2*P1u*PTv - 2*P1v*PTu - 2*Lp1*P0u*P1v + 2*Lp1*P1u*P0v + Lp1*P0u*P2v - Lp1*P2u*P0v - Lp2*P0u*P1v + Lp2*P1u*P0v - 2*Lp1*P1u*P2v + 2*Lp1*P2u*P1v + Lp2*P0u*P2v - Lp2*P2u*P0v - Lp2*P1u*P2v + Lp2*P2u*P1v + Lq1*P0u*P1v - Lq1*P1u*P0v + Lp1*P0u*PTv - Lp1*P0v*PTu - Lp1*P2u*PTv + Lp1*P2v*PTu - Lq1*P0u*PTv + Lq1*P0v*PTu + Lq1*P1u*PTv - Lq1*P1v*PTu)/(2*(P0u*P1v - P1u*P0v - P0u*PTv + P0v*PTu + P1u*PTv - P1v*PTu - Lp1*P0u*P1v + Lp1*P1u*P0v + Lp1*P0u*P2v - Lp1*P2u*P0v - Lp1*P1u*P2v + Lp1*P2u*P1v));
    % C code:
    % dR = 1 + (sqrt(Lp2*(P0u*P0u)*(PTv*PTv)*4.0+Lp2*(P0v*P0v)*(PTu*PTu)*4.0+(Lp1*Lp1)*(P0u*P0u)*(P2v*P2v)+(Lp1*Lp1)*(P2u*P2u)*(P0v*P0v)+(Lp2*Lp2)*(P0u*P0u)*(P1v*P1v)+(Lp2*Lp2)*(P1u*P1u)*(P0v*P0v)+(Lp2*Lp2)*(P0u*P0u)*(P2v*P2v)+(Lp2*Lp2)*(P2u*P2u)*(P0v*P0v)+(Lp2*Lp2)*(P1u*P1u)*(P2v*P2v)+(Lp2*Lp2)*(P2u*P2u)*(P1v*P1v)+(Lq1*Lq1)*(P0u*P0u)*(P1v*P1v)+(Lq1*Lq1)*(P1u*P1u)*(P0v*P0v)+(Lp1*Lp1)*(P0u*P0u)*(PTv*PTv)+(Lp1*Lp1)*(P0v*P0v)*(PTu*PTu)+(Lp1*Lp1)*(P2u*P2u)*(PTv*PTv)+(Lp1*Lp1)*(P2v*P2v)*(PTu*PTu)+(Lq1*Lq1)*(P0u*P0u)*(PTv*PTv)+(Lq1*Lq1)*(P0v*P0v)*(PTu*PTu)+(Lq1*Lq1)*(P1u*P1u)*(PTv*PTv)+(Lq1*Lq1)*(P1v*P1v)*(PTu*PTu)+Lp1*Lp2*(P0u*P0u)*(P2v*P2v)*2.0+Lp1*Lp2*(P2u*P2u)*(P0v*P0v)*2.0-Lp2*Lq1*(P0u*P0u)*(P1v*P1v)*2.0-Lp2*Lq1*(P1u*P1u)*(P0v*P0v)*2.0-Lp1*Lq1*(P0u*P0u)*(PTv*PTv)*2.0-Lp1*Lq1*(P0v*P0v)*(PTu*PTu)*2.0-(Lp2*Lp2)*P0u*P1u*(P2v*P2v)*2.0-(Lp2*Lp2)*P0u*P2u*(P1v*P1v)*2.0-(Lp2*Lp2)*P1u*P2u*(P0v*P0v)*2.0-(Lp2*Lp2)*(P0u*P0u)*P1v*P2v*2.0-(Lp2*Lp2)*(P1u*P1u)*P0v*P2v*2.0-(Lp2*Lp2)*(P2u*P2u)*P0v*P1v*2.0-(Lp1*Lp1)*P0u*P2u*(PTv*PTv)*2.0-(Lp1*Lp1)*P0u*(P2v*P2v)*PTu*2.0-(Lp1*Lp1)*P2u*(P0v*P0v)*PTu*2.0-(Lp1*Lp1)*P0v*P2v*(PTu*PTu)*2.0-(Lp1*Lp1)*(P0u*P0u)*P2v*PTv*2.0-(Lp1*Lp1)*(P2u*P2u)*P0v*PTv*2.0-(Lq1*Lq1)*P0u*P1u*(PTv*PTv)*2.0-(Lq1*Lq1)*P0u*(P1v*P1v)*PTu*2.0-(Lq1*Lq1)*P1u*(P0v*P0v)*PTu*2.0-(Lq1*Lq1)*P0v*P1v*(PTu*PTu)*2.0-(Lq1*Lq1)*(P0u*P0u)*P1v*PTv*2.0-(Lq1*Lq1)*(P1u*P1u)*P0v*PTv*2.0+Lp2*P1u*P2u*(P0v*P0v)*4.0+Lp2*(P0u*P0u)*P1v*P2v*4.0-Lp2*P0u*P1u*(PTv*PTv)*4.0-Lp2*P1u*(P0v*P0v)*PTu*4.0-Lp2*P0u*P2u*(PTv*PTv)*4.0-Lp2*P2u*(P0v*P0v)*PTu*4.0+Lp2*P1u*P2u*(PTv*PTv)*4.0-Lp2*P0v*P1v*(PTu*PTu)*4.0-Lp2*(P0u*P0u)*P1v*PTv*4.0-Lp2*P0v*P2v*(PTu*PTu)*4.0-Lp2*(P0u*P0u)*P2v*PTv*4.0+Lp2*P1v*P2v*(PTu*PTu)*4.0-Lp1*Lp2*P0u*P1u*(P2v*P2v)*2.0-Lp1*Lp2*P1u*P2u*(P0v*P0v)*2.0-Lp1*Lp2*(P0u*P0u)*P1v*P2v*2.0-Lp1*Lp2*(P2u*P2u)*P0v*P1v*2.0-Lp1*Lq1*P1u*P2u*(P0v*P0v)*2.0+Lp2*Lq1*P0u*P2u*(P1v*P1v)*2.0+Lp2*Lq1*P1u*P2u*(P0v*P0v)*2.0-Lp1*Lq1*(P0u*P0u)*P1v*P2v*2.0+Lp2*Lq1*(P0u*P0u)*P1v*P2v*2.0+Lp2*Lq1*(P1u*P1u)*P0v*P2v*2.0+Lp1*Lp2*P1u*(P0v*P0v)*PTu*2.0-Lp1*Lp2*P0u*(P2v*P2v)*PTu*2.0-Lp1*Lp2*P2u*(P0v*P0v)*PTu*2.0+Lp1*Lp2*P1u*(P2v*P2v)*PTu*2.0+Lp1*Lp2*(P0u*P0u)*P1v*PTv*2.0-Lp1*Lp2*(P0u*P0u)*P2v*PTv*2.0-Lp1*Lp2*(P2u*P2u)*P0v*PTv*2.0+Lp1*Lp2*(P2u*P2u)*P1v*PTv*2.0+Lp1*Lq1*P0u*P1u*(PTv*PTv)*2.0+Lp1*Lq1*P1u*(P0v*P0v)*PTu*2.0+Lp1*Lq1*P0u*P2u*(PTv*PTv)*2.0+Lp1*Lq1*P2u*(P0v*P0v)*PTu*2.0+Lp2*Lq1*P0u*(P1v*P1v)*PTu*2.0+Lp2*Lq1*P1u*(P0v*P0v)*PTu*2.0-Lp1*Lq1*P1u*P2u*(PTv*PTv)*2.0-Lp2*Lq1*P2u*(P0v*P0v)*PTu*2.0-Lp2*Lq1*P2u*(P1v*P1v)*PTu*2.0+Lp1*Lq1*P0v*P1v*(PTu*PTu)*2.0+Lp1*Lq1*(P0u*P0u)*P1v*PTv*2.0+Lp1*Lq1*P0v*P2v*(PTu*PTu)*2.0+Lp1*Lq1*(P0u*P0u)*P2v*PTv*2.0+Lp2*Lq1*(P0u*P0u)*P1v*PTv*2.0+Lp2*Lq1*(P1u*P1u)*P0v*PTv*2.0-Lp1*Lq1*P1v*P2v*(PTu*PTu)*2.0-Lp2*Lq1*(P0u*P0u)*P2v*PTv*2.0-Lp2*Lq1*(P1u*P1u)*P2v*PTv*2.0-(Lp2*Lp2)*P0u*P1u*P0v*P1v*2.0-(Lp1*Lp1)*P0u*P2u*P0v*P2v*2.0+(Lp2*Lp2)*P0u*P1u*P0v*P2v*2.0+(Lp2*Lp2)*P0u*P2u*P0v*P1v*2.0+(Lp2*Lp2)*P0u*P1u*P1v*P2v*2.0-(Lp2*Lp2)*P0u*P2u*P0v*P2v*2.0+(Lp2*Lp2)*P1u*P2u*P0v*P1v*2.0+(Lp2*Lp2)*P0u*P2u*P1v*P2v*2.0+(Lp2*Lp2)*P1u*P2u*P0v*P2v*2.0-(Lp2*Lp2)*P1u*P2u*P1v*P2v*2.0-(Lq1*Lq1)*P0u*P1u*P0v*P1v*2.0+(Lp1*Lp1)*P0u*P2u*P0v*PTv*2.0+(Lp1*Lp1)*P0u*P0v*P2v*PTu*2.0+(Lp1*Lp1)*P0u*P2u*P2v*PTv*2.0+(Lp1*Lp1)*P2u*P0v*P2v*PTu*2.0+(Lq1*Lq1)*P0u*P1u*P0v*PTv*2.0+(Lq1*Lq1)*P0u*P0v*P1v*PTu*2.0+(Lq1*Lq1)*P0u*P1u*P1v*PTv*2.0+(Lq1*Lq1)*P1u*P0v*P1v*PTu*2.0-(Lp1*Lp1)*P0u*P0v*PTu*PTv*2.0+(Lp1*Lp1)*P0u*P2v*PTu*PTv*2.0+(Lp1*Lp1)*P2u*P0v*PTu*PTv*2.0-(Lp1*Lp1)*P2u*P2v*PTu*PTv*2.0-(Lq1*Lq1)*P0u*P0v*PTu*PTv*2.0+(Lq1*Lq1)*P0u*P1v*PTu*PTv*2.0+(Lq1*Lq1)*P1u*P0v*PTu*PTv*2.0-(Lq1*Lq1)*P1u*P1v*PTu*PTv*2.0-Lp2*P0u*P1u*P0v*P2v*4.0-Lp2*P0u*P2u*P0v*P1v*4.0+Lp2*P0u*P1u*P0v*PTv*4.0+Lp2*P0u*P0v*P1v*PTu*4.0+Lp2*P0u*P2u*P0v*PTv*4.0+Lp2*P0u*P0v*P2v*PTu*4.0+Lp2*P0u*P1u*P2v*PTv*4.0+Lp2*P0u*P2u*P1v*PTv*4.0-Lp2*P0u*P1v*P2v*PTu*8.0-Lp2*P1u*P2u*P0v*PTv*8.0+Lp2*P1u*P0v*P2v*PTu*4.0+Lp2*P2u*P0v*P1v*PTu*4.0-Lp2*P0u*P0v*PTu*PTv*8.0+Lp2*P0u*P1v*PTu*PTv*4.0+Lp2*P1u*P0v*PTu*PTv*4.0+Lp2*P0u*P2v*PTu*PTv*4.0+Lp2*P2u*P0v*PTu*PTv*4.0-Lp2*P1u*P2v*PTu*PTv*4.0-Lp2*P2u*P1v*PTu*PTv*4.0+Lp1*Lp2*P0u*P1u*P0v*P2v*2.0+Lp1*Lp2*P0u*P2u*P0v*P1v*2.0-Lp1*Lp2*P0u*P2u*P0v*P2v*4.0+Lp1*Lp2*P0u*P2u*P1v*P2v*2.0+Lp1*Lp2*P1u*P2u*P0v*P2v*2.0+Lp1*Lq1*P0u*P1u*P0v*P2v*2.0+Lp1*Lq1*P0u*P2u*P0v*P1v*2.0+Lp2*Lq1*P0u*P1u*P0v*P1v*4.0-Lp2*Lq1*P0u*P1u*P0v*P2v*2.0-Lp2*Lq1*P0u*P2u*P0v*P1v*2.0-Lp2*Lq1*P0u*P1u*P1v*P2v*2.0-Lp2*Lq1*P1u*P2u*P0v*P1v*2.0-Lp1*Lp2*P0u*P1u*P0v*PTv*2.0-Lp1*Lp2*P0u*P0v*P1v*PTu*2.0+Lp1*Lp2*P0u*P2u*P0v*PTv*2.0+Lp1*Lp2*P0u*P0v*P2v*PTu*2.0+Lp1*Lp2*P0u*P1u*P2v*PTv*2.0-Lp1*Lp2*P0u*P2u*P1v*PTv*4.0+Lp1*Lp2*P0u*P1v*P2v*PTu*2.0+Lp1*Lp2*P1u*P2u*P0v*PTv*2.0-Lp1*Lp2*P1u*P0v*P2v*PTu*4.0+Lp1*Lp2*P2u*P0v*P1v*PTu*2.0+Lp1*Lp2*P0u*P2u*P2v*PTv*2.0+Lp1*Lp2*P2u*P0v*P2v*PTu*2.0-Lp1*Lp2*P1u*P2u*P2v*PTv*2.0-Lp1*Lp2*P2u*P1v*P2v*PTu*2.0-Lp1*Lq1*P0u*P1u*P0v*PTv*2.0-Lp1*Lq1*P0u*P0v*P1v*PTu*2.0-Lp1*Lq1*P0u*P2u*P0v*PTv*2.0-Lp1*Lq1*P0u*P0v*P2v*PTu*2.0-Lp2*Lq1*P0u*P1u*P0v*PTv*2.0-Lp2*Lq1*P0u*P0v*P1v*PTu*2.0-Lp1*Lq1*P0u*P1u*P2v*PTv*2.0-Lp1*Lq1*P0u*P2u*P1v*PTv*2.0+Lp1*Lq1*P0u*P1v*P2v*PTu*4.0+Lp1*Lq1*P1u*P2u*P0v*PTv*4.0-Lp1*Lq1*P1u*P0v*P2v*PTu*2.0-Lp1*Lq1*P2u*P0v*P1v*PTu*2.0-Lp2*Lq1*P0u*P1u*P1v*PTv*2.0+Lp2*Lq1*P0u*P2u*P0v*PTv*2.0+Lp2*Lq1*P0u*P0v*P2v*PTu*2.0-Lp2*Lq1*P1u*P0v*P1v*PTu*2.0+Lp2*Lq1*P0u*P1u*P2v*PTv*4.0-Lp2*Lq1*P0u*P2u*P1v*PTv*2.0-Lp2*Lq1*P0u*P1v*P2v*PTu*2.0-Lp2*Lq1*P1u*P2u*P0v*PTv*2.0-Lp2*Lq1*P1u*P0v*P2v*PTu*2.0+Lp2*Lq1*P2u*P0v*P1v*PTu*4.0+Lp2*Lq1*P1u*P2u*P1v*PTv*2.0+Lp2*Lq1*P1u*P1v*P2v*PTu*2.0+Lp1*Lq1*P0u*P0v*PTu*PTv*4.0-Lp1*Lq1*P0u*P1v*PTu*PTv*2.0-Lp1*Lq1*P1u*P0v*PTu*PTv*2.0-Lp1*Lq1*P0u*P2v*PTu*PTv*2.0-Lp1*Lq1*P2u*P0v*PTu*PTv*2.0+Lp1*Lq1*P1u*P2v*PTu*PTv*2.0+Lp1*Lq1*P2u*P1v*PTu*PTv*2.0)*(-1.0/2.0)+P0u*P1v-P1u*P0v-P0u*PTv+P0v*PTu+P1u*PTv-P1v*PTu-Lp1*P0u*P1v+Lp1*P1u*P0v+Lp1*P0u*P2v*(1.0/2.0)-Lp1*P2u*P0v*(1.0/2.0)-Lp2*P0u*P1v*(1.0/2.0)+Lp2*P1u*P0v*(1.0/2.0)-Lp1*P1u*P2v+Lp1*P2u*P1v+Lp2*P0u*P2v*(1.0/2.0)-Lp2*P2u*P0v*(1.0/2.0)-Lp2*P1u*P2v*(1.0/2.0)+Lp2*P2u*P1v*(1.0/2.0)+Lq1*P0u*P1v*(1.0/2.0)-Lq1*P1u*P0v*(1.0/2.0)+Lp1*P0u*PTv*(1.0/2.0)-Lp1*P0v*PTu*(1.0/2.0)-Lp1*P2u*PTv*(1.0/2.0)+Lp1*P2v*PTu*(1.0/2.0)-Lq1*P0u*PTv*(1.0/2.0)+Lq1*P0v*PTu*(1.0/2.0)+Lq1*P1u*PTv*(1.0/2.0)-Lq1*P1v*PTu*(1.0/2.0))/(P0u*P1v-P1u*P0v-P0u*PTv+P0v*PTu+P1u*PTv-P1v*PTu-Lp1*P0u*P1v+Lp1*P1u*P0v+Lp1*P0u*P2v-Lp1*P2u*P0v-Lp1*P1u*P2v+Lp1*P2u*P1v);

    dL = (Lp1 * (dR) + Lp2) / ((dR) + Lq1);
    
end

%dR = dR

if Rp1 < 0
    level = (Rp1*dR + Rp2) / (dR + Rq1);
else
    level = (Rp1*(1 - dR) + Rp2) / ((1 - dR) + Rq1);
end

end

