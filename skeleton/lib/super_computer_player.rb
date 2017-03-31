require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    initial_node = TicTacToeNode.new(game.board, mark)
    initial_node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    initial_node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise 'There are no non-losing nodes. This is impossible.
           You should never see this. :(' 

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
