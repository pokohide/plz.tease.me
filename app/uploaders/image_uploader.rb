# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  version :medium do
    process resize_to_fit: [638, 479]
  end

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{secure_token}.png" if original_filename.present?
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
