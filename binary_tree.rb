class Node
  attr_accessor :parent_node, :child_node0, :child_node1, :value

  def initialize(value)
    @value = value
  end
end

def build_tree(array)
  counter = 1
  root_node = Node.new(array[0])
  node = root_node
  while counter < array.length
    bool = true
    while bool == true
      if node.value >= array[counter]
        if node.child_node0 != nil
          node = node.child_node0
        else
          node.child_node0 = Node.new(array[counter])
          node.child_node0.parent_node = node
          bool = false
        end
      else
        if node.child_node1 != nil
          node = node.child_node1
        else
          node.child_node1 = Node.new(array[counter])
          node.child_node1.parent_node = node
          bool = false
        end
      end
    end
    while node.parent_node != nil
      node = node.parent_node
    end
    root_node = node
    counter += 1
  end
  return root_node
end

def breadth_first_search(target_value, root_node)
  queue = [root_node]
  counter = 0
  #collects all nodes into a queue array and goes through them all until either the target value is matched or no match is found.
  #Had to be careful not to try to find value of an array element that doesn't exist.
  while target_value != queue[counter].value
    if queue[counter].child_node0 != nil
      queue << queue[counter].child_node0
    end
    if queue[counter].child_node1 != nil
      queue << queue[counter].child_node1
    end
    if queue[counter + 1] == nil
      return nil
    end
    counter += 1
  end
  return true
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
root_node = build_tree(arr)
print breadth_first_search(67, root_node)
