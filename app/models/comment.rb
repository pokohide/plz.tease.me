# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  slide_id   :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_slide_id  (slide_id)
#  index_comments_on_user_id   (user_id)
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :slide
  counter_culture :slide

  scope :desc, -> { order(created_at: :desc) }

  validates :body, presence: true, length: { maximum: 255 }
end
