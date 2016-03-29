function create_subgraph(vertex_set::AbstractArray,edge_list::AbstractArray,directed::Bool)
  new_graph = graph(Int64[],ExEdge{Int64}[],is_directed = directed)
  vertex_set_d = Dict()
  for vertex in vertex_set
    add_vertex!(new_graph,vertex)
    vertex_set_d[vertex] = 1
  end
  for edge in edge_list
    if (haskey(vertex_set_d,edge.source)) && (haskey(vertex_set_d,edge.target))
      new_edge = ExEdge(edge.index,edge.source,edge.target)
      for (k,v) in edge.attributes
        new_edge.attributes[k] = v
      end
        add_edge!(new_graph,new_edge)
    end
  end
  return new_graph
end

function all_neighbors(v::Int64,g::GenericGraph)
  if is_directed(g)
    neighbr = out_neighbors(v,g)
    for n in in_neighbors(v,g)
      append!(neighbr,n)
    end
    return neighbr
  else
    return out_neighbors(v,g)
  end
end

function all_degree(v::Int64,g::GenericGraph)
  if is_directed(g)
    return out_degree(v,g) + in_degree(v,g)
  else
    return out_degree(v,g)
  end
end

function occurrence_of_degree(g::GenericGraph)
  g_vertices = vertices(g)
  degrees = zeros(Int64,0)
  max = 0
  d = 0
  for i = 1:length(g_vertices)
    d = all_degree(g_vertices[i],g)+1
    if max < d
      for j=1:(d-max)
        push!(degrees,0)
      end
      degrees[d] +=1
      max = d
    else
      degrees[d] +=1
    end
  end
  return degrees
end
