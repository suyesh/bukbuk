require 'rubygems'
require 'sinatra'
require 'haml'
require 'bundler/setup'
require 'sinatra/activerecord'
configure(:development){ set :database, "sqlite3:///bukbuk.sqlite3" }
require './models'
require 'sinatra/base'
require 'rack-flash'

enable :sessions
use Rack::Flash, :sweep => true

set :sessions => true


helpers do
  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end
end


get '/' do
	haml :landing
end

post '/users/sign_up' do
  User.create(params)
  @users = User.all
  redirect '/home'
end

post '/users/sign_in' do
  @user = User.where(:username => params[:username]).first
  if @user
    if @user.password == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back to BukBuk, #{@user.full_name}."
      redirect '/home' + @user.id.to_s
    else
      flash[:notice] = "Your password was wrong."
      redirect '/'
    end
  else
    flash[:notice] = "User not found. Please sign up for BukBuk."
    redirect '/'
  end
end



get '/home' do
	@tweets = Tweet.all
	haml :home
end

get '/profile' do
	haml :profile
end

get '/followers' do
	haml :followers
end

get '/following' do
	haml :following
end

post '/users/:id/tweets/new' do
  @tweet = Tweet.create(:text => params[:tweet])
  @user = User.find(params[:id])
  @user.tweets << @tweet
  redirect '/users/' + @user.id.to_s
end

get '/users/:id' do
  @user = User.find(params[:id])
  haml :profile
end
