require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << Array('A'..'Z').sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')

    # is it inside the grid?
    attempt_array = @word.upcase.split(/w*/)
    grid = attempt_array.all? { |letter| attempt_array.count(letter) <= @letters.count(letter) }

    # is it a avlid word
    word_check = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    valid = JSON.parse(word_check)['found']

    @ouput = grid && valid ? 'good' : 'bad'
  end
end
