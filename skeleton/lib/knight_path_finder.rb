require_relative "00_tree_node.rb"
require 'byebug'

class KnightPathFinder
  attr_reader :move_tree
  def initialize(starting_pos)
    @starting_node = PolyTreeNode.new(starting_pos)
    @visited_positions = [@starting_node.value]
    build_move_tree
  end

  def self.valid_moves(pos)
    x, y = pos
    shift1, shift2 = [-2, 2], [-1, 1]
    valid_moves = []
    shift1.each do |s1|
      shift2.each do |s2|
        valid_moves << [x + s1, y + s2]
        valid_moves << [x + s2, y + s1]
      end
    end
    valid_moves.select { |row, col| row.between?(0, 7) && col.between?(0, 7) }
  end

  def new_move_positions(pos)
    valid_moves = self.class.valid_moves(pos)
    return [] if valid_moves.nil?
    new_positions = valid_moves - @visited_positions
    @visited_positions.concat(new_positions)
    new_positions
  end

  def build_move_tree
    queue = [@starting_node]
    until queue.empty?
      cur_node = queue.shift
      new_moves = new_move_positions(cur_node.value)
      new_moves.each do |pos|
        new_node = PolyTreeNode.new(pos)
        queue.push(new_node)
        cur_node.add_child(new_node)
      end
    end
  end

  def find_path(end_pos)
    end_node = @starting_node.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = []
    cur_node = end_node
    until cur_node.parent.nil?
      path.push(cur_node.value)
      cur_node = cur_node.parent
    end
    path << @starting_node.value
    path.reverse
  end
end
