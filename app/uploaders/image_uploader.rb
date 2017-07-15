# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  resize_to_fit(250, "") # 横250px にリサイズ

  # if Rails.env.development? || Rails.env.test?
  #   storage :file
  # else
  #   storage :fog
  # end
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(png)
  end
end