require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @message = ""
    @word = params[:word].split("")
    @letters = params[:letters].split(",")
    # raise
    @word.each do |letter|
      @index = -1
      @index = @letters.index(letter)
      if @index
        @letters.delete_at(@index)
      else
        @message = "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}"
      end
    end
    if @message == ""
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      user_serialized = open(url).read
      user = JSON.parse(user_serialized)
      if user[:found] == "true"
        @message = "Congratulation! #{params[:word]} is a valid english word!"
      else
        @message = "Sorry, but #{params[:word]} does not seems to be a valid english word."
      end
    end
  end
end
