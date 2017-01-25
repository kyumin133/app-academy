require_relative "card"

class Board
  NUM_COLUMNS = 8
  attr_reader :num_values, :grid

  def initialize(num_values=12)
    populate(num_values)
    @num_values = num_values
  end

  def [](pos)
    if pos[1] < 0 || pos[1] >= NUM_COLUMNS
      return nil
    elsif pos[0] < 0 || pos[0] >= @grid.length
      return nil
    elsif pos[0] * NUM_COLUMNS + pos[1] >= @deck.length
      return nil
    else
      @grid[pos[0]][pos[1]]
    end
  end

  def []=(pos, value)
    # @grid[]
  end


  def populate(num_values)
    @deck = []
    (1..num_values).to_a.each do |num|
      2.times { @deck << Card.new(num.to_s) }
    end
    @deck.shuffle!
    @grid = []
    row = []
    for i in (0...@deck.length) do
      if i % NUM_COLUMNS == 0
        row = []
      end

      row[i % NUM_COLUMNS] = @deck[i]
      if i % NUM_COLUMNS == NUM_COLUMNS - 1 || i == @deck.length - 1
        @grid << row
      end
    end
  end

  def render
    total_string = "\n"
    for i in (0...@grid.length) do
      string = ''
      for j in (0...@grid[i].length) do
        string +=  @grid[i][j].to_s
      end
      string += "\n"
      total_string += string
    end
    puts total_string
  end

  def won?
    @deck.each do |card|
      if card.is_face_up == false
        return false
      end
    end
    true
  end

  def reveal(guessed_pos)
    card = self[guessed_pos]
    if card.is_face_up == false
      card.reveal
      return card.face_value
    end
    nil
  end
end
