class PolyTreeNode
  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    unless new_parent == parent
      new_parent.children.push(self) unless new_parent.nil?
      parent.children.delete(self) unless parent.nil?
      @parent = new_parent
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    if value == target_value
      return self
    else
      children.each do |child|
        search = child.dfs(target_value)
        return search unless search.nil?
      end
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      cur_node = queue.shift
      if cur_node.value == target_value
        return cur_node
      else
        queue.concat(cur_node.children)
      end
    end

    nil
  end
end
