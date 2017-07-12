# == Schema Information
#
# Table name: slides
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string
#  slug          :string
#  is_public     :boolean          default(FALSE), not null
#  original_file :string
#  pdf_file      :string
#  image_file    :string
#  published_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_slides_on_user_id  (user_id)
#

class Slide < ApplicationRecord

  # before_validation :generate_slug

  mount_uploader :original_file, PdfUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_file, ImageUploader

  belongs_to :user
  # has_one :presentation_outline, dependent: :destroy

  scope :is_public, -> { where(is_public: true) }
  scope :published_at_desc, -> { order(published_at: :desc) }

  VALID_SLUG_REGEX = /\A[0-9A-Za-z\-_]+\z/ # 英数と - _ の 2 つの半角記号
  validates :title,        presence: true
  validates :slug,         presence: true, format: { with: VALID_SLUG_REGEX, message: "英数と-_ のみで入力してください" }
  validates :published_at, presence: true

  # has_attached_file :pdf_file,
  #   storage: :s3,
  #   default_style: :original,
  #   s3_permissions: :public,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   bucket: ENV.fetch('AWS_BUCKET_NAME'),
  #   path: ":class/:attachment/:id/:style/:filename",
  #   s3_protocol: 'https'

  #validates_attachment_content_type :download, content_type: [/application\/(x\-)?pdf/i]

  private
  def generate_slug
    return if slug # generate only once

    self.slug = Zipang.to_slug(title)
    if user.presentations.where(slug: self.slug).exists?
      # slug が重複していた場合は現在時刻を付与して重複回避。
      # これで重複したら諦めてエラー
      self.slug += Time.current.strftime("%Y%m%d%H%M%S")
    end
  end
end
