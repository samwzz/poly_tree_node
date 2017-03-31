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


end
