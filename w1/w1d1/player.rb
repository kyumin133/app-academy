# Authors: Kyumin (Ken) Lee and James Stack
class Player
  attr_reader :name

  def initialize(name = nil)
    if name == nil
      @name = "player"
    else
      @name = name
    end
  end

  def guess
    puts "#{@name}, make a guess: "
    player_guess = gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess."
  end
end
