require './scrabble_challenge_new'

class ScrabbleNode
  attr_reader   :score
  attr_accessor :next_node

  def initialize(word=nil, next_node=nil)
    @word      = word
    @score     = Scrabble.new.score(word)
    @next_node = next_node
  end
end
