function _helper_read_edges(file,last_vertex = -1,start_vertex = 0)
  edges = Int[0,3]
  try
    edges = readdlm(file,Int)
  catch e
    print(e)
    return Union{}
  end

  if (last_vertex != -1)
    v = collect(start_vertex:last_vertex)
  else
    v = sort(unique([edges[1:end,1];edges[1:end,2]]))
  end
  vertxs = Dict()
  for vert in v
    vertxs[vert] = 1
  end
  return v,vertxs,edges
end

function read_edges_from_file_1(file;last_vertex= -1,directed = false,start_vertex = 0,key_of_edge_attr="cost")

  v,vertxs,edges = _helper_read_edges(file,last_vertex,start_vertex)
  e = ExEdge[]
  for i = 1 : size(edges)[1]
    if (haskey(vertxs,edges[i,1])) && (haskey(vertxs,edges[i,2]))
      edge = ExEdge(i,edges[i,1],edges[i,2])
      edge.attributes[key_of_edge_attr] = edges[i,3]
      push!(e,edge)
    end
  end
  new_graph = graph(Int64[],ExEdge{Int64}[],is_directed = directed)
  for vertex in v
    add_vertex!(new_graph,vertex)
  end
  for edge in e
      add_edge!(new_graph,edge)
  end
  return new_graph
end

function read_edges_from_file_no_selfloops(file;last_vertex= -1,directed = false,start_vertex = 0,key_of_edge_attr="cost")

  v,vertxs,edges = _helper_read_edges(file,last_vertex,start_vertex)
  e = ExEdge[]
  for i = 1 : size(edges)[1]
    if (haskey(vertxs,edges[i,1])) && (haskey(vertxs,edges[i,2]))
      if (edges[i,1] != edges[i,2])
        edge = ExEdge(i,edges[i,1],edges[i,2])
        edge.attributes[key_of_edge_attr] = edges[i,3]
        push!(e,edge)
      end
    end
  end
  new_graph = graph(Int64[],ExEdge{Int64}[],is_directed = directed)
  for vertex in v
    add_vertex!(new_graph,vertex)
  end
  for edge in e
      add_edge!(new_graph,edge)
  end
  return new_graph
end

function read_edges_from_file_no_parallel_e(file;last_vertex= -1,directed = false,start_vertex = 0,key_of_edge_attr="cost")

  v,vertxs,edges = _helper_read_edges(file,last_vertex,start_vertex)
  e = ExEdge[]
  already_in = Dict()
  for i = 1 : size(edges)[1]
    if (haskey(vertxs,edges[i,1])) && (haskey(vertxs,edges[i,2]))
      if (haskey(already_in,sort([edges[i,1],edges[i,2]])) == false)
        already_in[sort([edges[i,1],edges[i,2]])] = 1
        edge = ExEdge(i,edges[i,1],edges[i,2])
        edge.attributes[key_of_edge_attr] = edges[i,3]
        push!(e,edge)
      end
    end
  end
  new_graph = graph(Int64[],ExEdge{Int64}[],is_directed = directed)
  for vertex in v
    add_vertex!(new_graph,vertex)
  end
  for edge in e
      add_edge!(new_graph,edge)
  end
  return new_graph
end

function read_edges_from_file_no_selfl_or_parallel_e(file;last_vertex= -1,directed = false,start_vertex = 0,key_of_edge_attr="cost")

  v,vertxs,edges = _helper_read_edges(file,last_vertex,start_vertex)
  e = ExEdge[]
  already_in = Dict()
  for i = 1 : size(edges)[1]
    if (haskey(vertxs,edges[i,1])) && (haskey(vertxs,edges[i,2]))
      if (edges[i,1] != edges[i,2])
        if (haskey(already_in,sort([edges[i,1],edges[i,2]])) == false)
          already_in[sort([edges[i,1],edges[i,2]])] = 1
          edge = ExEdge(i,edges[i,1],edges[i,2])
          edge.attributes[key_of_edge_attr] = edges[i,3]
          push!(e,edge)
        end
      end
    end
  end
  new_graph = graph(Int64[],ExEdge{Int64}[],is_directed = directed)
  for vertex in v
    add_vertex!(new_graph,vertex)
  end
  for edge in e
      add_edge!(new_graph,edge)
  end
  return new_graph
end


function read_edges_from_file(file::AbstractString;last_vertex::Int64 = -1,directed::Bool = false,start_vertex::Int64 = 0,key_of_edge_attr::AbstractString="cost",selfloops::Bool = true,parallel_edges::Bool =true )
  if (selfloops) && (parallel_edges)
    read_edges_from_file_1(file,last_vertex = last_vertex,directed = directed,key_of_edge_attr = key_of_edge_attr)
  elseif (selfloops == false) && (parallel_edges)
    read_edges_from_file_no_selfloops(file,last_vertex = last_vertex,directed = directed,key_of_edge_attr = key_of_edge_attr)
  elseif (selfloops) && (parallel_edges == false)
    read_edges_from_file_no_parallel_e(file,last_vertex = last_vertex,directed = directed,key_of_edge_attr = key_of_edge_attr)
  else
    read_edges_from_file_no_selfl_or_parallel_e(file,last_vertex = last_vertex,directed = directed,key_of_edge_attr = key_of_edge_attr)
  end
end

function save_graph_to_file(g::GenericGraph;file::AbstractString = "graph.txt",edge_key_att::AbstractString = "")

  edgs = edges(g)
  arr = Array(Int64,length(edgs),3)
  if edge_key_att == ""
    for i=1:length(edgs)
    arr[i,1] = edgs[i].source
    arr[i,2] = edgs[i].target
    arr[i,3] = 1
    end
  else
  for i=1:length(edgs)
    arr[i,1] = edgs[i].source
    arr[i,2] = edgs[i].target
    arr[i,3] = edgs[i].attributes[edge_key_att]
  end
  end
  writedlm(file,arr," ")

end


