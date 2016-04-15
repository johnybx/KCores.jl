#References
  #     [1] An O(m) Algorithm for Cores Decomposition of Networks
  #     Vladimir Batagelj and Matjaz Zaversnik, 2003.
  #     http://arxiv.org/abs/cs.DS/0310049

function core_number(g::GenericGraph)

  warning = false
  degrees = Dict{Int64,Int64}()
  nbrs = Dict()
  for v in vertices(g)
    degrees[v] = all_degree(v,g)
    neighbr = all_neighbors(v,g)
    arr = Array(Int,length(neighbr))
    for i =1: length(neighbr)
      arr[i] = neighbr[i]
    end
    # test if there are parallel edges in graph
    # if there are parallel edges they are deleted
    # and warning is raised
    arr1 = unique(arr)
    if length(arr1) != length(arr)
      warning = true
      degrees[v] = length(arr1)
      arr = arr1
    end
    # test if there are selfloops in graph
    # if there are selfloops they are deleted
    # and warning is raised
    if v in arr
      warning = true
      splice!(arr,findfirst(arr,v))
      degrees[v] -=1
    end
    nbrs[v] = arr
  end
  if warning
    warn("Graph contains parallel edges or selfloops which will by deleted for k-core algorithm !!")
  end

  nodes = sort(collect(degrees),by = x-> (x[2],x[1]))
  bin_boundaries = [1]
  curr_degree = 0

  for (i,v) in enumerate(nodes)
    if degrees[v[1]] > curr_degree
      for j = 1:(degrees[v[1]] -curr_degree)
        append!(bin_boundaries,[(i)])
      end
      curr_degree = degrees[v[1]]
    end
  end
  sort!(bin_boundaries)
  node_pos = Dict()
  for (pos, v) in enumerate(nodes)
    node_pos[v[1]] = pos
  end

  core = degrees
  for v in nodes
    for u in nbrs[v[1]]
       if core[u] > core[v[1]]
        splice!(nbrs[u],findfirst(nbrs[u],v[1]))
        pos = node_pos[u]
        bin_start = bin_boundaries[core[u]+1]
        node_pos[u] = bin_start
        node_pos[nodes[bin_start][1]] = pos
        nodes[bin_start], nodes[pos] = nodes[pos], nodes[bin_start]
        bin_boundaries[core[u]+1] += 1
        core[u] -= 1
      end
    end
  end
  return core
end

function _core_helper(g::GenericGraph, func::Function, k::Int64=-1, core::Dict{Int64,Int64}=Dict{Int64,Int64}())

  if core == Dict{Int64,Int64}()
    core = core_number(g)
  end
  if k == -1
    k = maximum(values(core))
  end
  nodes = Int[]
  for vertex in keys(core)
    if func(vertex, k, core)
      push!(nodes,vertex)
    end
  end

  return create_subgraph(deepcopy(nodes),edges(g),is_directed(g))

end


function k_core(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())

  func(v, k, core_number) = core_number[v] >= k
  return _core_helper(g, func, k, core_number)
end

function k_shell(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())

  func(v, k, core_number) = core_number[v] == k
  return _core_helper(g, func, k, core_number)

end

function k_crust(g::GenericGraph;k::Int64=-1,core_num::Dict{Int64,Int64}=Dict{Int64,Int64}())
  func(v, k, core_number) = core_number[v] <= k
  if core_num == Dict{Int64,Int64}()
    core_num = core_number(g)
  end
  if k == -1
    k = maximum(values(core_num)) -1
  end
  return _core_helper(g, func, k, core_num)
end

function k_corona(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())

  func(v, k, core_number) = begin
    if core_number[v] == k
      sum_n = 0
      for w in all_neighbors(v,g)
        if core_number[w] >= k
          sum_n += 1
        end
      end
      if sum_n == k
        return true
      else
        return false
      end
    else
      return false
    end
  end

  return _core_helper(g, func, k, core_number)
end

