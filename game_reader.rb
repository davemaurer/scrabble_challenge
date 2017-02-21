require 'csv'
require './scrabble_challenge_new'

class GameReader
  def initialize(file)
    @player_data = parse_data(file)
  end

  def parse_data(file)
    players_hash = { player_1: [], player_2: [] }
    CSV.foreach(file, headers: true) do |row|
      players_hash["player_#{row["player_id"]}".to_sym] << row["word"]
    end
    p players_hash
    players_hash
  end

  def word_count(player)
    @player_data[player].count
  end

  def score(player)
    scorer = Scrabble.new
    @player_data[player].map { |word| scorer.score(word) }.reduce(:+)
  end
end

reader = GameReader.new('./input.csv')
p reader.word_count(:player_1)
p reader.score(:player_1)
p reader.word_count(:player_2)
p reader.score(:player_2)
