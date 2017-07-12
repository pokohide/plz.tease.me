class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  resize_to_fit(250, '') # 横250pxにリサイズ

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(png)
  end
end
