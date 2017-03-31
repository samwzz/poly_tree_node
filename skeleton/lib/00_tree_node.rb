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
end
