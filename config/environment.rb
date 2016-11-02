#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path

require 'zlib'
require 'carrierwave'
require "carrierwave/orm/activerecord"

configure :production, :development do
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

    ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
    )
end
# grab all css files
# @files = Dir["public/css/*.css"]

def my_css_files
  files.each do |file_name|
    file_name
  end
end
