clear all; close all;

size_X = 80; size_Y = 110;
numberOfRobots = 120;

xy = zeros([numberOfRobots, 6]);
xy_robot_pov = zeros([numberOfRobots, 6]);
r = zeros([2, 1]);

sum = 0;

for i=1:120
    xy(i,1) = rand()*size_X;
    xy(i,2) = rand()*size_Y;

    xy(i, 3) = atand(xy(i,1)/xy(i,2));
    xy(i, 4) = atand(xy(i,1)/(xy(i,2)-size_Y));
    xy(i, 5) = atand((xy(i,1)-size_X)/(xy(i,2)-size_Y));
    xy(i, 6) = atand((xy(i,1)-size_X)/xy(i,2));
    
    for j=3:6
        xy_robot_pov(i,j) = xy(i,j) + rand()*6 - 3;
    end

    A = [1, -tand(xy_robot_pov(i,3));
        1, -tand(xy_robot_pov(i,4));
        1, -tand(xy_robot_pov(i,5));
        1, -tand(xy_robot_pov(i,6))];

    b = [0-0*tand(xy_robot_pov(i,3));
        0-size_Y*tand(xy_robot_pov(i,4));
        size_X-size_Y*tand(xy_robot_pov(i,5));
        size_X-0*tand(xy_robot_pov(i,6))];

    r = inv(transpose(A)*A) * transpose(A) * b;
    xy_robot_pov(i,1) = r(1,1);
    xy_robot_pov(i,2) = r(2,1);

    d = sqrt((xy(i,1)-xy_robot_pov(i,1))^2 + (xy(i,1)-xy_robot_pov(i,2))^2);

    sum = d+sum;
end

err = sum / numberOfRobots,

plot(xy(:,1), xy(:,2), 'bx');
hold on;
plot(xy_robot_pov(:,1), xy_robot_pov(:,2), 'rx');
