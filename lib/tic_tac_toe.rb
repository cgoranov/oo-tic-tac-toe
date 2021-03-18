
require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0, 1, 2], 
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        @board = Array.new(9, " ")   
    end

    def display_board    
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "----------- "
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end
  
    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count
        @board.count {|x| x == "X" || x == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end   

    def turn
        puts "Specify a position between 1-9:"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
        else
           turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.detect do |combination|
          @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]] && position_taken?(combination[0])
        end
    end

    def full?
        @board.none?{|position| position == " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        won? ? @board[won?[0]] : nil 
    end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
        won?
    end

end