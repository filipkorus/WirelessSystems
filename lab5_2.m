clear all; close all;

%data

estDist = [];
z = 1;
error = [100, 70];
%pitch

pitch_xSize = 100;
pitch_ySize = 70;

results = zeros([100*70*50, 2]);
positions = zeros([100*70*50, 2]);

%stations

stat1_x = 0; stat1_y = 0;
stat2_x = 0; stat2_y = 70;
stat3_x = 70; stat3_y = 100;
stat4_x = 100; stat4_y = 0;

for i=1:100
    for j=1:70
        for k=1:50
            positions(z, 1) = i;
            positions(z, 2) = j;

            d1 = sqrt((i - stat1_x)^2 + (j - stat1_y)^2);
            d2 = sqrt((i - stat2_x)^2 + (j - stat2_y)^2);
            d3 = sqrt((i - stat3_x)^2 + (j - stat3_y)^2);mean(estDist),
            d4 = sqrt((i- stat4_x)^2 + (j - stat4_y)^2);

            path_loss1 = 68 + 20*log10(d1) + 0.2 * randn();
            path_loss2 = 68 + 20*log10(d2) + 0.2 * randn();
            path_loss3 = 68 + 20*log10(d3) + 0.2 * randn();
            path_loss4 = 68 + 20*log10(d4) + 0.2 * randn();

            final_d1 = 10^((path_loss1 - 60)/25);
            final_d2 = 10^((path_loss2 - 60)/25);
            final_d3 = 10^((path_loss3 - 60)/25);
            final_d4 = 10^((path_loss4 - 60)/25);

            A = [
                [stat2_x, stat2_y];
                [stat3_x, stat3_y];
                [stat4_x, stat4_y];
                ];

            b = [final_d1^2 - final_d2^2 + stat2_x^2 + stat2_y^2;
                  final_d1^2 - final_d3^2 + stat3_x^2 + stat3_y^2;
                  final_d1^2 - final_d4^2 + stat4_x^2 + stat4_y^2]/2;

            r = inv((transpose(A)*A))*transpose(A)*b;
            results(z, :) = r;

            estDist(k) = sqrt((positions(z, 1) - results(z, 1))^2 + (positions(z, 2) - results(z, 2))^2);
            z = z + 1;
        end
        error(i, j) = mean(estDist);
    end
end
%plot(positions(:, 1), positions(:, 2), 'bx');
%hold on;
%plot(results(:, 1), results(:, 2), 'rx');

pcolor(transpose(error));
shading("interp");
colorbar;

mean(estDist),
