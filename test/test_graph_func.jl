using k_cores
using Base.Test

v = collect(0:10)
edg = Array{Int,1}[[0,1],[0,5],[0,7],[1,3],[1,6],[2,1],[3,4],[3,5],[3,2],[4,1],[5,6],[8,6],[1,10],[1,1],[1,0]]
g = Graphs.graph(Int64[],Graphs.ExEdge{Int64}[],is_directed = false)
for vert in v
  Graphs.add_vertex!(g,vert)
end
i = 1
for e in edg
  Graphs.add_edge!(g,Graphs.ExEdge(i,e[1],e[2]))
end
save_graph_to_file(g,file ="GraphtestgraphsExt.txt")
g = read_edges_from_file("GraphtestgraphsExt.txt")
@test Graphs.vertices(g) == [0:8;10]
@test Graphs.edges(g) == [Graphs.ExEdge(1,0,1),Graphs.ExEdge(2,0,5),Graphs.ExEdge(3,0,7),Graphs.ExEdge(4,1,3),Graphs.ExEdge(5,1,6),
                          Graphs.ExEdge(6,2,1),Graphs.ExEdge(7,3,4),Graphs.ExEdge(8,3,5),Graphs.ExEdge(9,3,2),Graphs.ExEdge(10,4,1),
                          Graphs.ExEdge(11,5,6),Graphs.ExEdge(12,8,6),Graphs.ExEdge(13,1,10),Graphs.ExEdge(14,1,1),Graphs.ExEdge(15,1,0)]
g = read_edges_from_file("GraphtestgraphsExt.txt",last_vertex = 10)
@test Graphs.vertices(g) == collect(0:10)
@test Graphs.edges(g) == [Graphs.ExEdge(1,0,1),Graphs.ExEdge(2,0,5),Graphs.ExEdge(3,0,7),Graphs.ExEdge(4,1,3),Graphs.ExEdge(5,1,6),
                          Graphs.ExEdge(6,2,1),Graphs.ExEdge(7,3,4),Graphs.ExEdge(8,3,5),Graphs.ExEdge(9,3,2),Graphs.ExEdge(10,4,1),
                          Graphs.ExEdge(11,5,6),Graphs.ExEdge(12,8,6),Graphs.ExEdge(13,1,10),Graphs.ExEdge(14,1,1),Graphs.ExEdge(15,1,0)]
g = read_edges_from_file("GraphtestgraphsExt.txt",selfloops = false)
@test Graphs.vertices(g) == [0:8;10]
@test Graphs.edges(g) == [Graphs.ExEdge(1,0,1),Graphs.ExEdge(2,0,5),Graphs.ExEdge(3,0,7),Graphs.ExEdge(4,1,3),Graphs.ExEdge(5,1,6),
                          Graphs.ExEdge(6,2,1),Graphs.ExEdge(7,3,4),Graphs.ExEdge(8,3,5),Graphs.ExEdge(9,3,2),Graphs.ExEdge(10,4,1),
                          Graphs.ExEdge(11,5,6),Graphs.ExEdge(12,8,6),Graphs.ExEdge(13,1,10),Graphs.ExEdge(15,1,0)]
g = read_edges_from_file("GraphtestgraphsExt.txt",parallel_edges = false)
@test Graphs.vertices(g) == [0:8;10]
@test Graphs.edges(g) == [Graphs.ExEdge(1,0,1),Graphs.ExEdge(2,0,5),Graphs.ExEdge(3,0,7),Graphs.ExEdge(4,1,3),Graphs.ExEdge(5,1,6),
                          Graphs.ExEdge(6,2,1),Graphs.ExEdge(7,3,4),Graphs.ExEdge(8,3,5),Graphs.ExEdge(9,3,2),Graphs.ExEdge(10,4,1),
                          Graphs.ExEdge(11,5,6),Graphs.ExEdge(12,8,6),Graphs.ExEdge(13,1,10),Graphs.ExEdge(14,1,1)]

g = read_edges_from_file("GraphtestgraphsExt.txt",selfloops = false,parallel_edges = false)
@test Graphs.vertices(g) == [0:8;10]
@test Graphs.edges(g) == [Graphs.ExEdge(1,0,1),Graphs.ExEdge(2,0,5),Graphs.ExEdge(3,0,7),Graphs.ExEdge(4,1,3),Graphs.ExEdge(5,1,6),
                          Graphs.ExEdge(6,2,1),Graphs.ExEdge(7,3,4),Graphs.ExEdge(8,3,5),Graphs.ExEdge(9,3,2),Graphs.ExEdge(10,4,1),
                          Graphs.ExEdge(11,5,6),Graphs.ExEdge(12,8,6),Graphs.ExEdge(13,1,10)]

rm("GraphtestgraphsExt.txt")
