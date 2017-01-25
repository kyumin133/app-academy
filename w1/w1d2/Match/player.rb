require_relative 'game'

class HumanPlayer

  def initialize(board, name="HumanPlayer")
    @name = name
    @board = board
  end
  def prompt
    valid_input = false
    first_guess = ''
    while valid_input == false do
      puts "Pick first position (e.g. r,c): "
      first_guess = gets.chomp.split(",").map(&:to_i)
      valid_input = valid_guess?(first_guess)
      if valid_input == false
        puts "Invalid input\n"
      end
    end
    first_pos = first_guess
    make_guess(first_pos)

    valid_input = false
    second_guess = ''
    while valid_input == false do
      puts "Pick second position (e.g. r,c): "
      second_guess = gets.chomp.split(",").map(&:to_i)
      valid_input = valid_guess?(second_guess)
      if valid_input == false
        puts "Invalid input\n"
      end
    end
    second_pos = second_guess
    make_guess(second_pos)

    [first_pos, second_pos]
  end

  def valid_guess?(pos)
    if pos.length != 2
      return false
    end

    if @board[pos] == nil
      return false
    end

    if @board[pos].is_face_up
      return false
    end

    true

  end

  def make_guess(pos)
    if @board[pos] != nil && @board[pos].is_face_up == false
      @board[pos].reveal
      system("clear")
      @board.render
    end
  end
end

class ComputerPlayer

  def initialize(board, name="ComputerPlayer")
    @board = board
    @name = name
    @known_cards = {}
    @unknown_cards = {}
    @matched_cards = {}

    for i in (0...@board.grid.length) do
      for j in (0...@board.grid[i].length) do
        @unknown_cards[[i, j]] = 1
      end
    end
  end

  def prompt
    found_match = false
    first_guess = []
    second_guess = []
    @known_cards.each do |k1, v1|
      @known_cards.each do |k2, v2|
        if k1 == k2
          next
        elsif v1 == v2
          # receive_match(k1, k2)
          # return reveal_positions(k1, k2)
          first_guess = k1
          second_guess = k2
          found_match = true
          break
        end
      end
      if found_match == true
        break
      end
    end

    first_guess = @unknown_cards.keys.sample unless found_match

    value = @board.reveal(first_guess)

    self.receive_revealed_card(first_guess, value)

    if found_match == false
      @known_cards.each do |k, v|
        if k == first_guess
          next
        elsif v == value
          # self.receive_match(k, v)
          # return reveal_positions(first_guess, k)
          found_match = true
          second_guess = k
          break
        end
      end

      second_guess = @unknown_cards.keys.sample unless found_match
    end

    value = @board.reveal(second_guess)
    receive_revealed_card(second_guess, value)
    if found_match
      receive_match(first_guess, second_guess)
    end
    reveal_positions(first_guess, second_guess)
  end

  def reveal_positions(first_guess, second_guess)
    system("clear")
    @board.reveal(first_guess)
    @board.reveal(second_guess)
    @board.render
    puts "First guess: #{first_guess.join(",")}"
    puts "Second guess: #{second_guess.join(",")}"
    sleep(2)
    
    return [first_guess, second_guess]
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
    @unknown_cards.delete(pos)
  end

  def receive_match(first_pos, second_pos)
    @matched_cards[first_pos] = 1
    @matched_cards[second_pos] = 1
    @known_cards.delete(first_pos)
    @known_cards.delete(second_pos)
  end
end
