# encoding: utf-8

class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 画像の上限を700pxにする
  process resize_to_limit: [700, 700]

  # 保存形式をJPGにする
  process convert: 'png'

  # サムネイルを生成する設定
  version :thumb do
    process resize_to_limit: [300, 300]
  end

  if Rails.env.development? || Rails.env.test?
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
    time = Time.zone.now
    name = time.strftime('%Y%m%d%H%M%S') + '.png'
    name.downcase
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
