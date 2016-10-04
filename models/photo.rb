# require "carrierwave/orm/activerecord"
require './uploader/photo_uploader'
class Photo < ActiveRecord::Base
  belongs_to :admin
  mount_uploader :file, PhotoUploader
end
