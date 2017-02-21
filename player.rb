require './scrabble_challenge_new'

class Player
  attr_reader :tiles, :words, :score

  def initialize
    @scrabble = Scrabble.new
    @tile_box = @scrabble.point_values.keys.map(&:downcase)
    @tiles = Hash.new(0)
    @words = []
    @score = 0
    starting_tiles
  end

  def play(word)
    letters = word.chars
    return invalid_word unless letters_are_valid?(letters)
    until letters.empty?
      letter = letters.shift
      @tiles[letter] -= 1
      @tiles.delete(letter) if @tiles[letter] == 0
    end
    record_score(word)
  end

  def record_score(word)
    word_length = word.length
    @words << word
    @score += @scrabble.score(word)
    @score += 10 if word_length == 7
    word_length.times { get_random_tile }
  end

  def starting_tiles
    14.times { get_random_tile }
    Hash[@tiles.sort_by { |_, v| v }.reverse]
  end

  def get_random_tile
    @tiles[@tile_box.sample] += 1
  end

  def letters_are_valid?(letters)
    letters.all? { |letter| @tiles[letter] >= letters.count(letter) }
  end

  def invalid_word
    puts "This word sucks"
  end

  def set_tiles(letters)
    @tiles = Hash.new(0)
    letters.each { |letter| @tiles[letter] += 1 }
  end

  def tile_count
    @tiles.values.reduce(:+)
  end

end

player_1 = Player.new
puts player_1.tiles
puts player_1.tile_count
player_1.set_tiles(['h', 'e', 'l', 'l', 'o', 't', 'h', 'e', 'r', 'e', 'a', 'b', 'x', 'z'])
player_1.play("hello")
puts player_1.score
puts player_1.words
puts player_1.tile_count
puts player_1.tiles
