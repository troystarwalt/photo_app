class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  version :thumb do
    process resize_to_fit: [200,200]
  end

  version :medium do
    process resize_to_limit: [800,800]
  end

end
