# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  #include CarrierWave::MiniMagick
  include CarrierWave::RMagick

  # 画像の上限を700pxにする
  process :resize_to_limit => [700, 700]

  # 保存形式をJPGにする
  process convert: 'png'

  # サムネイルを生成する設定
  version :thumb do
    process resize_to_limit: [300, 300]
  end

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # ファイル名は日本語が入ってくると嫌なので、下記のようにしてみてもいい。
  # 日付(20131001.jpgみたいなファイル名)で保存する
  def filename
    time = Time.now
    name = time.strftime('%Y%m%d%H%M%S') + '.png'
    name.downcase
  end
  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
