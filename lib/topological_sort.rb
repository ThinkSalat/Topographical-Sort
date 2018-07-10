require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms
# BFS
# def topological_sort(vertices)
#   return [] if cyclical_or_unconnected?(vertices)
#   sorted = []
#   queue = []

#   vertices.each do |v|
#     queue.unshift(v) if v.in_edges.empty?
#   end

#   until queue.empty?
#     current = queue.pop
#     sorted << current
#     current.out_edges.each do |e|
#       if e.to_vertex.in_edges.reject {|edge| e == edge}.empty?
#         queue.unshift(e.to_vertex) 
#         e.destroy!
#       end
#     end
#     current.destroy!
#     vertices.delete(current)
#     vertices.each do |v|
#       queue.unshift(v) if v.in_edges.empty? && !queue.include?(v)
#     end
#   end
#   sorted
# end

# DFS
def topological_sort(vertices)
  return [] if vertices.all? {|v| v.in_edges.empty? && v.out_edges.empty?}
  sorted = []
  stack = []

  vertices.each do |v|
    stack << v if v.in_edges.empty?
  end

  until stack.empty?
    current = stack.pop
    sorted << current
    current.out_edges.each do |e|
      if e.to_vertex.in_edges.reject {|edge| e == edge}.empty?
        stack << e.to_vertex
        e.destroy!
      end
    end
    current.destroy!
    vertices.delete(current)
    vertices.each do |v|
      stack << v if v.in_edges.empty? && !stack.include?(v)
    end
  end
  sorted
end

def cyclical_or_unconnected?(vertices)
  false
end