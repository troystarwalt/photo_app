require 'sinatra'
require 'sinatra/activerecord'
require './config/environment'
require './models/photo'
require './models/admin'
require 'slim'
require 'carrierwave'
require 'pry'
require 'carrierwave/processing/mini_magick'

CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/public"
end
require "carrierwave/orm/activerecord"

require 'better_errors'

# Just in development!
configure :development do
  use BetterErrors::Middleware
  # you need to set the application root in order to abbreviate filenames
  # within the application:
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  slim :index
end

get '/new' do
  @photo = Photo.last(5)
 slim  :new_photo
end

post '/submit' do
    @photo = Photo.new(params[:photo])
    if @photo.save
      puts @photo.file
      redirect '/photos'
    else
      puts "Sorry, there was an error!"
    end
end

get '/photos' do
    @photos = Photo.all
    slim :photos
end

get '/login' do
  slim :admin_login
end

post '/login' do
  puts "clicked login"
end
