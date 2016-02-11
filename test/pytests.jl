using k_cores
using PyCall
using Graphs
using Base.Test
@pyimport networkx


function random_graph(num_of_vertices,num_of_edges)
  v = collect(0:num_of_vertices)
  edges = Array{Int,1}[]
  e = Dict{Array{Int,1},Int}()
  for i=1:num_of_edges
    e1 = rand(0:num_of_vertices)
    e2 = rand(0:num_of_vertices)
    while haskey(e,sort([e1,e2])) || e1 == e2
      e1 = rand(0:num_of_vertices)
      e2 = rand(0:num_of_vertices)
    end
      e[sort([e1,e2])] = 1
      push!(edges,sort([e1,e2]))
  end
  julia_graph = graph(Int64[],ExEdge{Int64}[],is_directed = false)
  for vert in v
    add_vertex!(julia_graph,vert)
  end
  i = 0
  for edg in edges
    add_edge!(julia_graph,ExEdge(i,edg[1],edg[2]))
    i +=1
  end
  python_graph = networkx.Graph()
  python_graph[:add_nodes_from](v)
  python_graph[:add_edges_from](edges)
  return julia_graph,python_graph
end

num_of_vertices = 20
num_of_edges = 100

for i = 1:10
  julia_graph,python_graph = random_graph(num_of_vertices,num_of_edges)
  jul_core_number = core_number(julia_graph)
  py_core_num = networkx.core_number(python_graph)
  @test jul_core_number == py_core_num
end
