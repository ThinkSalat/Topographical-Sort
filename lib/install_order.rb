# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative "graph"
require_relative "topological_sort"
def install_order(arr)
  vertices = []
  ids = arr.map{|t|t[0]}
  (1..ids.max).to_a.reject {|id| ids.include?(id)} .each do |id|
    vertices << Vertex.new(id)
  end

  arr.each do |(id, dependency)|
    if vertices.none? { |v| v.value == id}
      vertex = Vertex.new(id)
      vertices << vertex 
    else
      vertex = vertices.find { |v| v.value == id}
    end

    if vertices.none?{|v| v.value == dependency }
      dependent = Vertex.new(dependency)
      vertices << dependent
    else
      dependent = vertices.find {|v| v.value == dependency}
    end
    edge = Edge.new(dependent, vertex)
    vertex.in_edges << edge
    dependent.out_edges << edge
  end
  sort = topological_sort(vertices)
  sort.map(&:value)
end
