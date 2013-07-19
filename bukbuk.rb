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