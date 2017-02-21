require './scrabble_node'

class WordList
  attr_reader :head

  def initialize
    @head    = nil
    @counter = 0
    @total_score = 0
  end

  def add_word(word)
    if @head.nil?
      @head = ScrabbleNode.new(word)
    else
      current = @head
      until current.next_node.nil?
        current = current.next_node
      end
      current.next_node = ScrabbleNode.new(word)
    end
  end

  def count
    current = @head
    @counter = 0
    until current.nil?
      @counter += 1
      current = current.next_node
    end
    @counter
  end

  def total_score
    return "No nodes to play with" if @head.nil?
    current = @head
    @total_score = 0
    until current.nil?
      @total_score += current.score
      current = current.next_node
    end
    @total_score
  end

end

list = WordList.new
puts list.count
list.add_word("hello")
puts list.count
puts list.head.score
puts list.total_score
list.add_word("hi")
puts list.count
puts list.total_score
list.add_word("snacker")
puts list.count
puts list.total_score
