tic
u = 0:0.01:1;
v = 0:0.01:0.4;
cie1960Cct = zeros(length(v), length(u));

for i = 1:length(u)
    for j = 1:length(v)
        cie1960Cct(j, i) = uvToCct([u(i), v(j)]);
    end
end
imagesc([0 1], [0 0.4], cie1960Cct)
set(gca, 'ydir', 'normal');
axis([0 1 0 0.4]);
xlabel('u');
ylabel('v');
clear u v i j
toc