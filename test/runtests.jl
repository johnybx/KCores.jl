tests = ["pytests.jl","test_graph_func.jl","tests.jl"]
for t in tests
    include(t)
end