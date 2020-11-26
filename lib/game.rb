class Game

    attr_accessor :board, :player_1, :player_2
    
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2],
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    end


    def current_player
        #look at how many spots are taken up of 9. ON odd count means its X turn
        empty_cells = []
        board.cells.each do |cell|
            if cell != "X" && cell != "O"
          empty_cells << cell
            end
        end
        if empty_cells.count.odd?
            player_1
        else
            player_2
        end
    end

    def won?
        # itereate through all win combinations and see if the board cell is taken and see if they all match the Winning patterns
        WIN_COMBINATIONS.find do |sub_array|
            # binding.pry
            board.cells[sub_array[0]] != " " && board.cells[sub_array[0]] == board.cells[sub_array[1]] && board.cells[sub_array[0]] == board.cells[sub_array[2]]
        end
    end

    def draw?
        #Sees that the entire board is full without winning combinations
        @board.full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if winning_combo = won?
            @winner = @board.cells[winning_combo.first]
        end
      end
    
    def turn
        player = current_player
        current_move = player.move(@board)
        if !@board.valid_move?(current_move)
          turn
        else
          puts "Turn: #{@board.turn_count+1}\n"
          @board.display
          @board.update(current_move, player)
          puts "#{player.token} moved #{current_move}"
          @board.display
          puts "\n\n"
        end
    end

    def play
        while !over?
            turn

        end
        if won?
            puts "Congratulations #{winner}!"
          elsif draw?
            puts "Cat's Game!"
        end
    end


end