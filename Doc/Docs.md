Documentation
======

### Functions

#### core_number(g::GenericGraph)

A k-core is a maximal subgraph that contains nodes of degree k or more.
The core number of a node is the largest value k of a k-core containing that node.

**Parameters:**	

*	g - Generic graph from package Graphs.jl. Graph can be directed or undirected.
*	Returns - core_number - Dict{Int64,Int64} : a dictionary where key is node and value is core number.

Return the core number for each vertex (Dict{Vertex => k}).

#### k_core(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())
Create maximal subgraph that contains nodes of degree k or more.

**Parameters:**

*	g - Generic graph from package Graphs.jl. Graph can be directed or undirected.
*	k - optional parameter of type int: k is order of core if not specified the maximal k is calculated. 
*	core number - optional parameter: a dictionary where key is node and value is core number.

Returns - g - Generic graph from package Graphs.jl


#### k_shell(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())
Create k-shell which is the subgraph of nodes in the k-core but not in the (k+1) core.

**Parameters:**

*	g - Generic graph from package Graphs.jl. Graph can be directed or undirected.
*	k - optional parameter of type int: k is order of core if not specified the maximal k is calculated. 
*	core number - optional parameter: a dictionary where key is node and value is core number.

Returns - g - Generic graph from package Graphs.jl


#### k_crust(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())
Create k-crust which is the graph G with the k-core removed.

**Parameters:**	

*	g - Generic graph from package Graphs.jl. Graph can be directed or undirected.
*	k - optional parameter of type int: k is order of core if not specified the maximal k is calculated. 
*	core number - optional parameter: a dictionary where key is node and value is core number.

Returns - g - Generic graph from package Graphs.jl


#### k_corona(g::GenericGraph;k::Int64=-1,core_number::Dict{Int64,Int64}=Dict{Int64,Int64}())
Return k-corona which is the subgraph of nodes in the k-core which have exactly k neighbours in the k-core.

**Parameters:**

*	g - Generic graph from package Graphs.jl. Graph can be directed or undirected.
*	k - optional parameter of type int: k is order of core if not specified the maximal k is calculated. 
*	core number - optional parameter: a dictionary where key is node and value is core number.

Returns - g - Generic graph from package Graphs.jl

**NOTE: **Core number is not defined for parallel edges or selfloops. If graph given to the functions contain parallel edges or selfloops they are deleted and warning is raised.

### Helper functions

#### read_edges_from_file(file::String;last_vertex::Int64 = None,directed::Bool = false,start_vertex::Int64 = 0,key_of_edge_attr::String="cost",selfloops::Bool = true,parallel_edges::Bool =true )

Read edges from file using [Graphs](http://julialang.org/Graphs.jl/#) package. Vertices in graph are of type Int and edges are of type [ExEdge](http://julialang.org/Graphs.jl/vertex_edge.html#edge-types). 

**Parameters:**

* file - string: path to the file in which edges are save. Delimiter between edges is new line character (\n) and delimiter between values of edge is space " ". Edges are in form "source node target node cost \n"
* star_vertex - optional parameter int: vertex from which the vertices start. Default is 0. If parameter last_vertex not passed to function this parameter has no influence on function. 
* last_vertex - optional parameter int:  last vertex of graph. If passed to the function then all vertices will be from start_vertex to last_vertex. If this argument is not passed then the graph contain all vertices which are in file with edges.
* directed - optional parameter boolean: if true graph is directed otherwise graph is undirected by default.
* key_of_edge_attr - optional parameter string: edges in graph are of type ExEdge which is defined with dictionary. Third parameter from edge file can by named by this attribute default is "cost".
* selfloops - optional parameter boolean: if false all selfloops from edge file will be ignored otherwise graph will contain all selfloops in file.
* parallel_edges - optional parameter boolean: if false all parallel edges from edge file will be ignored otherwise graph will contain all parallel edges in file.
    
Returns - g - Generic graph from package Graphs.jl

**Examples:**
```jl
    g = read_edges_from_file("julia/workspace/graph1.txt")
    g = read_edges_from_file("julia/workspace/mesh/mesh2d100.mat",last_vertex = 100)
    g = read_edges_from_file("julia/workspace/mesh/mesh2d100.mat",selfloops = false, parallel_edges =false)
```

#### save_graph_to_file(g::GenericGraph;file::String = "graph.txt",edge_key_att::String = "")
Saves graph to the file as edge list. Note that this function is not using any compresion methods and was created just for school project where I had graphs in this particular format. There are more efficient ways how to store graphs.

**Parameters:**

*   g - Generic graph from package Graphs.jl.
*   file -optional parameter string: path with the file name where graph should by saved. If none given graph will be saved as graph.txt in default directory. Default directory can be find by pwd() function in julia.
*   edge_key_att - optional parameter string: key to the dictionary of ExEdge. If none given the function will save 1 as third value to the edge list. If wrong key is given error will be raised.

Returns nothing

**Examples:**

```jl
    save_graph_to_file(g;file = "julia/workspace/graph1.txt",edge_key_att = "cost")
```
#### create_subgraph(vertex_set::AbstractArray,edge_list::AbstractArray,directed::Bool)
Create subgraph of previous graph where only vertices from vertex_set are included and edges which contain vertex which is not in list are deleted.

**Parameters:**

*   vertex_set - Array if int
*   edge_list - Array of ExVertex from Graphs.jl
*   directed - boolean

Return subgraph of type Generic graph from Graphs.jl

#### all_neighbors(v::Int64,g::GenericGraph)
Get the neighbors of vertex v. If the graph is directed than neighbors is sum of outneighbors and inneighbors.

**Parameters:**

*    v - vertex
*    g - Graph

return neighbors of vertex v

#### all_degree(v::Int64,g::GenericGraph)
Get the degree of vertex v. If the graph is directed than degree is sum of outdegree and in degree.

**Parameters:**

*    v - vertex
*    g - Graph

return degree of vertex v

#### occurrence_of_degree(g::GenericGraph)
Create histogram of vertex degrees in given graph.

**Parameters:**

*   g - Generic graph from package Graphs.jl.

Returns array where index is degree and value is number of vertices having that degree.
