class WordFinder
  attr_reader :words

  def initialize
    @words = File.read('/usr/share/dict/words').split("\n")
  end

  def for_letters(letters)
    possibles = []
    # letters.each do |letter|
    #   @words.each do |word|
    #     possibles << word if word.include?(letter) unless possibles.include?(word)
    #   end
    # end
    @words.each do |word|
      possibles << word if word.chars.all? { |letter| letters.count(letter) >= word.count(letter) }
      # possibles << word if letters.any? { |letter| word.include?(letter) } unless possibles.include?(word)
    end
    possibles
  end

  def for_letters_with(letters, mandatory_letter)
    all_letters = letters << mandatory_letter
    result = for_letters(all_letters).map { |word| word if word.chars.include?(mandatory_letter) }.compact
    p result
  end
end

finder = WordFinder.new
puts finder.for_letters(['r', 'e', 'x', 'a', 'p', 't', 'o']).count
puts finder.for_letters_with(['e', 'x', 'a', 'p', 't', 'o'], 'r').count
