function pp = GetBinCenterHyperCube(cube)

% input: 2 x dim
% output: 2 x dim % (1/4 & 3/4)

dd = (cube(2, :) - cube(1, :))/4;

pp = zeros(2, size(cube, 2));
pp(1, :) = cube(1, :) + dd;
pp(2, :) = cube(2, :) - dd;

