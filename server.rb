require "sinatra"
require "pry"


use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe",
}

def calculate_winner (computer, player)
  if computer == player
    tie
  elsif (computer == 'r' && player == 'p') || (computer == 'p' && player == 's') || (computer == 's' && player == 'r')
    player_win
  else
    computer_win
  end
end

def player_win
  session[:player_score] += 1
  result_text = "Player gains a point!"
end

def computer_win
  session[:computer_score] += 1
  result_text = "Computer gains a point!"
end

def tie
  result_text = "Tie! Try again."
end

def check_if_game_is_setup
  if session[:player_score].nil?
    session[:player_score] = 0
  end
  if session[:computer_score].nil?
    session[:computer_score] = 0
  end
end

def check_if_winner
  if session[:player_score] == 3
    session[:winner] = true
    session[:current_result] = "Player wins!"
  elsif session[:computer_score] == 3
    session[:winner] = true
    session[:current_result] = "Computer wins!"
  end
end

get '/' do
  check_if_game_is_setup
  check_if_winner
  erb :index
end

post '/' do
  computer_choice = ['r','p','s'].sample
  player_choice = params[:rps]
  session[:current_result] = calculate_winner(computer_choice, player_choice)
  redirect '/'
end

post '/reset' do
  session[:player_score] = 0
  session[:computer_score] = 0
  session[:current_result] = nil
  session[:winner] = nil
  redirect '/'
end
