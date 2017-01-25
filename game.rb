# Authors: Kyumin (Ken) Lee and James Stack
require_relative 'player.rb'

class Game
  def initialize(players = nil, dictionary = nil)
    if dictionary != nil
      @dictionary = dictionary
    else
      @dictionary = {}
      File.foreach("dictionary.txt") do |f|
        @dictionary[f.chomp] = 1
      end
    end
    @alphabet = ("a".."z").to_a
    @fragment = ""

    if players == nil
      @players_array = [Player.new("player1"), Player.new("player2"), Player.new("player3")]
    else
      @players_array = players
    end
    @all_players = @players_array.dup

    @current_player = @players_array[0]
    @previous_player = @players_array[@players_array.length - 1]
    @losses = {}
    for i in 0...@players_array.length do
      @losses[@players_array[i]] = 0
    end
  end

  def play_round
    while !@dictionary.include?(@fragment) do
      puts "\nCurrent Fragment: " + @fragment
      take_turn(@current_player)
      if @dictionary.include?(@fragment)
        puts "\n#{@current_player.name} loses!"
        if @losses[@current_player] == nil
          @losses[@current_player] = 1
        else
          @losses[@current_player] += 1
        end
      else
        next_player!
      end
    end
  end

  def record(player)
    ghost = "GHOST"
    num_losses = @losses[player]
    if num_losses == nil
      return "-"
    else
      return ghost[0,num_losses]
    end
  end

  def run
    game_over = false
    while game_over == false do
      @fragment = ""
      @current_player = @players_array[0]
      @previous_player = @players_array[@players_array.length - 1]
      play_round
      display_standing
      @players_array.each do |player|
        if @losses[player] > 4
          puts "#{player.name} loses!"
          @players_array.delete_at(@players_array.index(player))
          if @players_array.length <= 1
            puts "#{@players_array[0].name} wins!"
            game_over = true
          end
        end
      end
    end
  end

  def display_standing
    puts "\n"
    for i in 0...@all_players.length do
      puts "#{@all_players[i].name}: #{record(@all_players[i])}"
    end
  end

  def current_player
    @players_array.index(@current_player)
  end

  def previous_player
    @players_array.index(@previous_player)
  end

  def next_player!
    @previous_player = @current_player
    @current_player = @players_array[(self.current_player + 1) % @players_array.length]
  end

  def take_turn(player)
    valid_guess = false
    while valid_guess == false do
      player_guess = player.guess
      if valid_play?(player_guess)
        @fragment += player_guess
        valid_guess = true
      else
        player.alert_invalid_guess
      end
    end
  end

  def valid_play?(string)
    return false if !@alphabet.include?(string)
    word = @fragment + string
    @dictionary.each do |key, value|
      return true if word == key[0..word.length - 1]
    end
    return false
  end


end

if __FILE__ == $PROGRAM_NAME
  Game.new
end
