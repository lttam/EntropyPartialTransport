function dd = TreeMetric_Root2CA(id_x, id_z, TM)

dd = 0;

if (id_x > 1) && (id_z > 1)
    ep_idx = TM.Vertex_EdgeIdPath{id_x};
    ep_idz = TM.Vertex_EdgeIdPath{id_z};
    for ii = 1:min(length(ep_idx), length(ep_idz))
        if ep_idx(ii) == ep_idz(ii)
            dd = dd + TM.Edge_Weight(ep_idx(ii));
        else
            break;
        end
    end
end

end