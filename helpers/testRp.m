% Test Rp function
Rp = zeros((140-60)*5+1, (100-50)*5+1);
x = 1; y = 1;
for Rg = 60:0.2:140
    x = 1;
    for Rf = 50:0.2:100
        %Rp(y,x) = RfRgToRp(Rf,Rg,110);
        if Rf > 100 - abs(100 - Rg)
            Rp(y,x) = 3;
        elseif Rf > 100 - abs(100 - Rg)*5/4
            Rp(y,x) = 2;
        else
            Rp(y,x) = 1;
        end
        x = x + 1;
    end
    y = y + 1;
end
colormap([1 1 1; 0.8 0.8 0.8; 0.6 0.6 0.6])
image([50 100], [60 140], Rp);
set(gca, 'ydir', 'normal');
clear x y Rf Rg