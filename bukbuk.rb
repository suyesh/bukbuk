require 'rubygems'
require 'sinatra'
require 'haml'
require 'bundler/setup'
require 'sinatra/activerecord'
configure(:development){ set :database, "sqlite3:///bukbuk.sqlite3" }
require './models'


get '/' do
	haml :landing
end

post '/users/sign_up' do
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