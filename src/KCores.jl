module KCores
  using Graphs
  export core_number,k_core,k_shell,k_crust,k_corona,
         read_edges_from_file,save_graph_to_file,
         create_subgraph,all_neighbors,all_degree,occurrence_of_degree

  
  include("k_cores.jl")
  include("I_O_graphs.jl")
  include("graphs_ext.jl")
end
