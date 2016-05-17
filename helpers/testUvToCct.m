n = 10000;
uvs = [rand(n, 1)*0.32 rand(n, 1)*0.15+0.25];
tic
for i = 1:n
    cct = uvToCct(uvs(i,:));
end
toc
clear n uvs res u v cct i