using k_cores
using Graphs
g = read_edges_from_file(string(Pkg.dir("k_cores"),"/test/trgr_C.mat"))
g_core_number = core_number(g)
for i in [3,10,18,22,26,30,33]
  g_k_core1 = k_core(g,k=i,core_number = g_core_number)
  edg = Graphs.edges(g_k_core1)
  edg_dict = Dict{typeof(Int[]),Int}()
  for e in edg
    edg_dict[sort([e.source,e.target])] = 0
  end
  try
    trgr_g = readdlm(string(Pkg.dir("k_cores"),"/test/trgr_c_kcores/trgr_C_k$i.mat",Int)
  catch
    println("empty input at file trgr_C_k$i.mat")
    continue
  end
  if (length(edg) != size(trgr_g)[1])
    println("Different edge size k_core func have $(length(edg)) edges and trgr_C_k$(i).mat have $(size(trgr_g)[1])")
  end
  for i=1:size(trgr_g)[1]
    if haskey(edg_dict,sort([trgr_g[i,1],trgr_g[i,2]]))
      edg_dict[sort([trgr_g[i,1],trgr_g[i,2]])] = 1
    else
      println("edge $(trgr_g[i,1]) --> $(trgr_g[i,2]) no key")
    end
  end
  for (k,v) in edg_dict
    if v == 0
      println("zero $k")
    end
  end
end

