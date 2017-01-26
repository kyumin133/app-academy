require 'set'
class WordChainer
  def initialize(dictionary_file_name)
    dict_array = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(dict_array)
    run("meat","aria")
  end

  def adjacent_words(word)
    adj = Set.new
    alphabet = ("a".."z").to_a
    word.chars.each_with_index do |letter, index|
      possible = word.dup
      alphabet.each do |change|
        next if letter == change
        possible[index] = change
        adj << possible if @dictionary.include?(possible)
      end
    end
    adj
  end

  def run(source, target)
    @current_words = Set.new([source])
    @all_seen_words = Hash.new
    @all_seen_words[source] = nil
    while !@current_words.empty? && !@all_seen_words.include?(target)
      explore_current_words
    end
    if @all_seen_words.include?(target)
      puts "Word found!"
      p build_path(target)
      # p target
    else
      puts "Word not found!"
    end
  end

  def explore_current_words
    new_current_words = Set.new
    @current_words.each do |word|
      adj = adjacent_words(word)
      adj.each do |neighbor|
        unless @all_seen_words.include?(neighbor)
          new_current_words << neighbor
          @all_seen_words[neighbor] = word
        end
      end
    end
    # p new_current_words
    @current_words = new_current_words
  end

  def build_path(target)
    moving_target = target.dup
    path = [moving_target]

    until @all_seen_words[moving_target] == nil
      path << @all_seen_words[moving_target]
      moving_target = @all_seen_words[moving_target]
    end
    path.reverse
  end
end

if __FILE__ == $PROGRAM_NAME
  WordChainer.new("dictionary.txt")
end
