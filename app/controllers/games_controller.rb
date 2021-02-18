class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << [*('A'..'Z')].sample
    end
    @letters
  end

  def score
    # raise
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @valid_word = valid_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def valid_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
