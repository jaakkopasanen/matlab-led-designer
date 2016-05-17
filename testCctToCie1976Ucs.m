t = 1000:10000;
%{
load('cie.mat', 'cie1976PlanckianLocusUv');
uv = cie1976PlanckianLocusUv(t,:);
u = uv(:,1);
v = uv(:,2);
plot(t,u,t,v);
legend('u','v');
%}
%
u = [];
v = [];
for i = 1:length(t)
    T = t(i);
    % With centering and scaling
    x = (T-5500)/2599;
    u(i) = (-0.0001747*pow(x,3) + 0.1833*pow(x,2) + 0.872*x + 1.227) / (pow(x,2) + 4.813*x + 5.933);
    v(i) = (0.000311*pow(x,4) + 0.0009124*pow(x,3) + 0.3856*pow(x,2) + 1.873*x + 2.619) / (pow(x,2) + 4.323*x + 5.485);
end
plotCieLuv([], true);
hold on;
plot(u, v, 'k');
hold off;
%}