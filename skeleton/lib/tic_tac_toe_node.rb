require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    childs = []
    0.upto(2).each do |row|
      0.upto(2).each do |col|
        pos = [row, col]
        if @board.empty?(pos)
          new_board = board.dup
          new_board[pos] = next_mover_mark
          next_mark = (next_mover_mark == :x ? :o : :x)
          childs << TicTacToeNode.new(new_board, next_mark, pos)
        end
      end
    end
    childs
  end

  def losing_node?(evaluator)
    winner = @board.winner
    if @board.over?
      if winner.nil? || winner == evaluator
        return false
      else
        return true
      end
    end

    if (evaluator == next_mover_mark &&
      children.all? { |child| child.losing_node?(evaluator) })
      return true
    end

    if (evaluator != next_mover_mark &&
      children.any? { |child| child.losing_node?(evaluator) })
      return true
    end

    false
  end


  def winning_node?(evaluator)
    # debugger
    if @board.over?
      return @board.winner == evaluator ? true : false
    end

    if evaluator == next_mover_mark &&
      children.any? { |child| child.winning_node?(evaluator) }
       return true
    end

    if evaluator != next_mover_mark &&
      children.all? { |child| child.winning_node?(evaluator) }
      return true
    end

    false
  end


end
