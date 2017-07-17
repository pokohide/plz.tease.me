# encoding: utf-8

class PdfUploader < CarrierWave::Uploader::Base
  # if Rails.env.development? || Rails.env.test?
  #   storage :file
  # else
  #   storage :fog
  # end
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def move_to_cache
    true
  end

  def move_to_store
    true
  end
end
