function dd = TreeMetricFromRoot(id_x, TM)

dd = 0; % root node

if id_x > 1 % not root
    dd = sum(TM.Edge_Weight(TM.Vertex_EdgeIdPath{id_x}));
end

end


