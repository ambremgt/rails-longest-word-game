require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
    # Display a new random grid and a form
  end

  def score
    # The form will be submitted (with POST) to the score action.
    @word = params[:word].upcase
    @letter_params = params[:letter_params]
    if @word.chars.all? { |letter| @word.count(letter) <= @letter_params.count(letter) }
      if english_word?(@word) == true
        @answer = "Congratulations! #{@word} is an English word!"
      else
        @answer = "Sorry but #{@word} doesn't seems to be a valid english word"
      end
    else
      @answer = "Sorry but #{@word} can't be built out of #{@letter_params}"
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    json = JSON.parse(response)
    return json['found']
  end
end
