require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/game.rb'


set :bind, '' #set if working remotely
enable :sessions

game = Game.new
word = game.word
link = '<a href="/">Play Again?</a>'

get '/' do
  message = "Welcome to Hangman! 5 guesses to complete a word"
  erb :index, :locals => { :message => message } 
end


post '/result' do
  guess = params["guess"].downcase
  board = game.board(guess)
  if !game.game_over?
    message = game.turn(guess)
  else
    message = "Sorry – you are out of turns."     
    game.reset
    word = game.word
  end

  erb :result, :locals => { :word => word, :guess => guess, :message => message, :link => link, :board => board }
end

  post '/saved' do
    message = game.saved
  erb :saved, :locals => { :message => message, :link => link }
end

  post '/reload' do
    num = params["num"]
    message = game.load(num)
  erb :reload, :locals => { :message => message, :link => link }
end
