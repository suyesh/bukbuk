require 'rubygems'
require 'sinatra'
require 'haml'
require 'bundler/setup'
require 'sinatra/activerecord'
configure(:development){ set :database, "sqlite3:///bukbuk.sqlite3" }
require './models'


['/', '/home'].each do |path|
get path do
if session[:userid].nil? then
haml :landing
else
redirect "/#{User.get(session[:userid])}"
end
end
end
