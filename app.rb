require 'sinatra'
require 'sinatra/activerecord'
require './config/environment'
require './models/photo'
require './models/admin'
require 'slim'
require 'carrierwave'
require 'pry'
require 'carrierwave/processing/mini_magick'
require 'better_errors'
require 'bootstrap'
enable :sessions
set :session_secret, SecureRandom.hex(64)

CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/public"
end
require "carrierwave/orm/activerecord"

# Just in development!
configure :development do
  use BetterErrors::Middleware
  # you need to set the application root in order to abbreviate filenames
  # within the application:
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# root
get '/' do
  slim :index
end

# create new photo
get '/new' do
  if current_admin
    puts "welcome" + @current_admin.email
    slim  :'photos/new'
  else
    redirect '/'
  end
end

# post route for new photo
post '/submit' do
    @photo = Photo.new(params[:photo])
    if @photo.save
      puts @photo.file
      redirect '/photos'
    else
      puts "Sorry, there was an error!"
    end
end

# See all photos
get '/photos' do
    @photos = Photo.all
    slim :'photos/photos'
end

# admin login
get '/login' do
  if current_admin
    puts "You are already logged in"
    redirect "/"
  else
  slim :'sessions/admin_login'
  end
end

# post route for login
post '/sessions' do
  @admin = Admin.find_by(email: params[:admin][:email], encrypted_password: params[:admin][:password])
  session[:id] = @admin.id
  puts "clicked login"
  redirect '/'
end

# Logout path for admin
get '/sessions/logout' do
  session.clear
  redirect '/'
end

private

helpers do
  def current_admin
    @current_admin ||= Admin.find(session[:id]) if session[:id]
  end
end
