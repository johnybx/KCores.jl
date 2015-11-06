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

