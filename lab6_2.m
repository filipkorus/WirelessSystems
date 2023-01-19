close all; clear all;
                  % wymiary x y 
rectangle('Position', [0 0 40 56], 'EdgeColor', 'b', 'LineWidth', 1);
hold on;

uwb = [10.5, 24.5;
       2.5, 2.5];

odb = [4, 10.5, 18.5, 26, 35.5;       % x1 x2 x3 x4 x5
       52.5, 52.5, 52.5, 52.5, 52.5]; % y1 y2 y3 y4 y5

obj_x = 25; obj_y = 32;

axis equal;
rectangle('Position', [obj_x obj_y 1 1], 'EdgeColor', 'r', 'LineWidth', 0.5);

real_lines = zeros(4,3);



for i=1:length(uwb(1,:))
    for j=1:length(odb(1,:))
        plot(uwb(1, i), uwb(2, i), 'O');
        plot(odb(1, j), odb(2, j), 'O');
        line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)]);
        hold on;

        res = wektorsektor(uwb(1, i), uwb(2,1), odb(1,j), odb(2,i), obj_x, obj_y, 1, 1);
        if res == 1 || res == 0
            line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)], 'Color', 'r');
            real_lines(j,i) = 1;
        end
    end
end

for k=0:49
    for m=0:49
        lines = zeros(4,3);
        for i=1:length(uwb(1,:))
            for j=1:length(odb(1,:))
                res = wektorsektor(uwb(1,i), uwb(2,i), odb(1,j),odb(2,j),k,m,1,1);
                if res ~= -1
                    lines(j,i) = 1;
                end
            end
        end
        if isequal(real_lines, lines)
            rectangle('Position', [k m 1 1], 'FaceColor', 'g');
        end
    end
end
