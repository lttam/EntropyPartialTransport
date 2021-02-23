function cube = RandomExpandHyperCube(cube_org)

% 2 x dim

randProp = rand(1, size(cube_org, 2));

lengthCube = cube_org(2, :) - cube_org(1, :);
randExpand = randProp .* lengthCube;

cube = cube_org;
cube(2, :) = cube(2, :) + randExpand;

end
