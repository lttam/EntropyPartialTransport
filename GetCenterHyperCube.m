function pp = GetCenterHyperCube(cube)

% input: 2 x dim
% output: dim x 1

pp = (cube(1, :) + cube(2, :))/2;
pp = pp';

