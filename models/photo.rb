# require "carrierwave/orm/activerecord"
require './uploader/photo_uploader'
class Photo < ActiveRecord::Base
  belongs_to :admin
  mount_uploader :file, PhotoUploader

  class << self
    def in_order
      order(created_at: :desc)
    end

    def recent(n)
      in_order.endmost(n)
    end

    def endmost(n)
      all.only(:order).from(all.reverse_order.limit(n), table_name)
    end
  end
end
