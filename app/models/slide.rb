# == Schema Information
#
# Table name: slides
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  title        :string
#  slug         :string
#  is_public    :boolean          default(FALSE), not null
#  pdf_file     :string
#  image_file   :string
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  page_view    :integer          default(0)
#
# Indexes
#
#  index_slides_on_user_id  (user_id)
#

class Slide < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :slide_outline, dependent: :destroy

  # Uploader
  mount_uploader :original_file, PdfUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_file, ImageUploader

  # Scope
  scope :is_public, -> { where(is_public: true) }
  scope :published_at_desc, -> { order(published_at: :desc) }

  # Validate
  before_validation :generate_slug
  VALID_SLUG_REGEX = /\A[0-9A-Za-z\-_]+\z/ # 英数と - _ の 2 つの半角記号
  validates :title,        presence: true
  validates :slug,         presence: true, format: { with: VALID_SLUG_REGEX, message: "英数と-_ のみで入力してください" }
  validates :published_at, presence: true

  # redis-objects override AR lock method
  class << self
    alias_method :ar_lock, :lock
  end
  include Redis::Objects
  class << self
    alias_method :redis_lock, :lock
    alias_method :lock, :ar_lock
    remove_method :ar_lock
  end
  include RedisObjectsDestroyable

  def owner?(user)
    user_id == user.try!(:id)
  end

  def reupload(file)
    self.original_file.remove!
    self.pdf_file.remove!
    self.image_file.remove!
    self.presentation_outline.destroy

    self.original_file = file
    self.save!
    Ppt2pdfJob.perform_later(self)
  end

  private

  def generate_slug
    return if slug # generate only once

    # self.slug = Zipang.to_slug(title)
    self.slug = SecureRandom.urlsafe_base64
    if user.slides.where(slug: self.slug).exists?
      # slug が重複していた場合は現在時刻を付与して重複回避。
      # これで重複したら諦めてエラー
      self.slug += Time.current.strftime("%Y%m%d%H%M%S")
    end
  end
end
