require 'sinatra'
require 'json'

team_info = JSON.parse(File.read('roster.json'))

get '/' do
  @teams = team_info.keys
  @positions = team_info.values[0].keys
  erb :index
end

get '/team/:team' do
  team_key = params[:team].gsub("_", " ")
  @team_name = team_key
  @players = team_info[team_key]
  erb :team_page
end

get '/position/:pos' do
  pos_key = params[:pos].gsub("_", " ")
  list_of_players = {}
  team_info.each do |team, team_data|
    list_of_players[team_data[pos_key]] = team
  end
  @pos_name = pos_key
  @players = list_of_players
  erb :pos_page
end


set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
