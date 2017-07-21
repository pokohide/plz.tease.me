# encoding: utf-8

class PageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 保存形式をJPGにする
  process convert: 'jpg'

  version :medium do
    process resize_to_fit: [638, 479]
  end

  version :large do
    process resize_to_fill: [1024, 768]
  end

  storage :fog

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def filename
    "#{secure_token}.jpg" if original_filename.present?
  end

  def store_dir
    "uploads/slides/#{model.slide.id}/#{model.class.to_s.underscore}"
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
