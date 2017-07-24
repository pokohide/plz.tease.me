# == Schema Information
#
# Table name: slides
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  title          :string
#  slug           :string
#  is_public      :boolean          default(FALSE), not null
#  pdf_file       :string
#  image_file     :string
#  published_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  page_view      :integer          default(0)
#  uploaded       :boolean          default(FALSE)
#  comments_count :integer          default(0)
#  category       :integer          default("books"), not null
#  stars_count    :integer          default(0)
#
# Indexes
#
#  index_slides_on_user_id  (user_id)
#

class Slide < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_one :slide_outline, dependent: :destroy
  has_one :statistic, dependent: :destroy
  accepts_nested_attributes_for :slide_outline

  # Category
  enum category: { books: 1, business: 2, design: 3, education: 4, entertainment: 5,
                   finance: 6, games: 7, health: 8, how_to: 9, humor: 10, photos: 11,
                   programming: 12, research: 13, science: 14, technology: 15, travel: 16 }

  # Uploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_file, ImageUploader

  # Scope
  scope :is_public, -> { where(uploaded: true, is_public: true) }
  scope :not_public, -> { where(uploaded: true) }
  scope :published_at_desc, -> { order(published_at: :desc) }

  # Validate
  before_validation :generate_slug
  VALID_SLUG_REGEX = /\A[0-9A-Za-z\-_]+\z/ # 英数と - _ の 2 つの半角記号
  validates :title,        presence: true
  validates :slug,         presence: true, format: { with: VALID_SLUG_REGEX, message: '英数と-_ のみで入力してください' }
  validates :published_at, presence: true
  validates :category,     presence: true

  # redis-objects override AR lock method
  class << self
    alias ar_lock lock
  end
  include Redis::Objects
  class << self
    alias redis_lock lock
    alias lock ar_lock
    remove_method :ar_lock
  end
  include RedisObjectsDestroyable

  def owner_display_name
    user.try(:display_name) || '未登録'
  end

  def owner_username
    user.try(:username)
  end

  def owner?(user)
    user_id == user.try!(:id)
  end

  def reupload(file)
    original_file.remove!
    pdf_file.remove!
    image_file.remove!
    presentation_outline.destroy

    self.original_file = file
    save!
    Ppt2pdfJob.perform_later(self)
  end

  private

  def generate_slug
    return if slug # generate only once

    # self.slug = Zipang.to_slug(title)
    self.slug = SecureRandom.urlsafe_base64
  end
end
