# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  image      :string           not null
#  num        :integer          not null
#  slide_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pages_on_slide_id  (slide_id)
#

class Page < ApplicationRecord
  belongs_to :slide

  mount_uploader :image, PageUploader
end
