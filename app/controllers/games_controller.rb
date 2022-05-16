class GamesController < ApplicationController
  require 'open-uri'

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  # def included?(input, grid)
  #   input = input.upcase
  #   input.chars.all? do |lettre|
  #     input.count(lettre) <= grid.count(lettre)
  #   end
  # end

  def score
    @word = params[:word] # html <forme> => input user => name prend word comme value
    found = isWord # appel de method stocké dans found => word_parsed
    letters = params[:letters].split # lettres de la grille en array .SPLIT
    word_letters = params[:word].upcase.chars # saisie de l'user en array .CHARS
    # iteration de la sasie de l'user .ALL? pour checker si elles correspondent à la grille
    valid_word = word_letters.all? do |letter|
        letters.include?(letter)
      end
      if found && valid_word
        @message = "Congratulations #{@word} is a valid English word"
      # elsif included?(params[:word], @letters) == false
      #   @message = "Sorry, but #{@word} can not be built out of the grid"
      else
        @message = "Sorry, but #{@word} is not a valid English word"
      end
  end

  def isWord
    url = "https://wagon-dictionary.herokuapp.com/#{@word}" # word est interpolé pour le parser
    hash = URI.open(url).read # require URI en haut de page necessaire pour lire l'api puis stocké dans hash
    word_parsed = JSON.parse(hash) # mon hash word est parsé et stocké dans word_parsed
    word_parsed['found'] # dans le hash de l'api je vais chercher [la clé found] STRING!
  end
end

  #     if word_parsed && included?(params[:word], @letters)
  #       @message = "Congratulations #{@word} is a valid English word"
  #     elsif included?(params[:word], @letters) == false
  #       @message = "Sorry, but #{@word} can not be built out of #{@letters}"
  #     else
  #       @message = "Sorry, but #{@word} is not a valid English word"
  #     end
  #   end
