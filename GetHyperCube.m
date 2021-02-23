function cube = GetHyperCube(allXX)

% n x dim
cube = zeros(2, size(allXX, 2));

cube(1, :) = min(allXX);
cube(2, :) = max(allXX);

