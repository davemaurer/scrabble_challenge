require 'benchmark'

class Scrabble
  def point_values
    {
      "A" => 1, "B" => 3, "C" => 3, "D" => 2,
      "E" => 1, "F" => 4, "G" => 2, "H" => 4,
      "I" => 1, "J" => 8, "K" => 5, "L" => 1,
      "M" => 3, "N" => 1, "O" => 1, "P" => 3,
      "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
      "U" => 1, "V" => 4, "W" => 4, "X" => 8,
      "Y" => 4, "Z" => 10
    }
  end

  def score(word) #=> "hello"
    numbers = word.chars.map do |letter| #word.chars #=> ["h", "e", "l", "l", "o"]
      point_values[letter.capitalize] #=> [4, 1, 1, 1, 1]
    end
    numbers.reduce(0) do |aggregate_value, thing_to_add|
      aggregate_value + thing_to_add
    end
  end

  def score_with_multipliers(word, multipliers, word_bonus=1) #word should be [1,4,2,1,1,], multipliers should be the array passed in
    letters = word.chars
    numbers = letters.map.with_index { |letter, index| point_values[letter.capitalize] * multipliers[index] } #=> [4, 2, 3, 2, 1]
    numbers.reduce(:+) * word_bonus
  end

  def highest_scoring_word(words)
    sorted_words = words.sort_by { |word| word.length }
    possibles = sorted_words.group_by { |word| score(word) }.max[1]
    return possibles.find { |w| w.length == 7 } if possibles.any? { |word| word.length == 7 }
    possibles.first
  end

  def another_highest_score(words)
    result = words.first
    words.each do |word|
      if word.length == 7
        result = word unless result.length == 7 && score(word) <= score(result)
      else
        result = word if score(word) > score(result) || (score(word) == score(result) && word.length < result.length)
      end
    end
    result
  end

end

game = Scrabble.new
puts game.score("hello")
puts game.score_with_multipliers("hello", [2, 2, 2, 2, 2])
puts game.score_with_multipliers("hello", [2, 2, 2, 2, 2], 2)
puts game.highest_scoring_word(['hello', 'word', 'sound']) #=> "word"
puts game.highest_scoring_word(['home', 'word', 'hello', 'sound']) #=> "home"
puts game.highest_scoring_word(['home', 'silence', 'word']) #=> "silence"
puts game.highest_scoring_word(['hi', 'word', 'ward']) # => "word"

Benchmark.bmbm(20) do |bm|
  bm.report('using group by') do
    game.highest_scoring_word(['home', 'silence', 'word'])
  end

  bm.report('using each') do
    game.another_highest_score(['home', 'silence', 'word'])
  end
end
