# == Schema Information
#
# Table name: slide_outlines
#
#  id         :integer          not null, primary key
#  slide_id   :integer
#  body       :text(16777215)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_slide_outlines_on_slide_id  (slide_id)
#

class SlideOutline < ApplicationRecord
  belongs_to :slide

  after_save :update_slide_document

  private

  def update_slide_document
    # slide.__elasticsearch__.index_document
  end
end
