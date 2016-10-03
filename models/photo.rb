# require "carrierwave/orm/activerecord"
require './uploader/photo_uploader'
class Photo < ActiveRecord::Base
  mount_uploader :file, PhotoUploader

end
