clear all; close all;

[Y, X] = meshgrid(0.1:0.1:12, 0.1:0.1:20);

x_tx = 5.05;
y_tx = 6.55;

line([13.05, 13.05], [0, 5]);
line([13.05, 13.0], [7, 12]);

wsp = 0.8;
c = 3 * 10^8;
f = 2.4;
lambda = c / f;
txPower = 10*log10(1);

power = zeros(200, 120);

axis([0, 20, 0, 12]);

for x=1:200
    for y=1:120
        dist = sqrt((x_tx - x/10)^2 + (y_tx - y/10)^2);
        FSL = 32.44 + 20*log10(dist) + 20*log10(f);

        sciana1 = dwawektory(13.05, 0, 13.05, 5, x_tx, y_tx, x/10, y/10);
        sciana2 = dwawektory(13.05, 7, 13.05, 12, x_tx, y_tx, x/10, y/10);

        if sciana1 == -1 && sciana2 == -1
            power(x, y) = txPower - FSL;
        else
            power(x, y) = -100;
        end
    end
end

pcolor(X, Y, power);
shading("interp");
colorbar;
