# == Schema Information
#
# Table name: slide_outlines
#
#  id         :integer          not null, primary key
#  slide_id   :integer
#  body       :text(16777215)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :text
#
# Indexes
#
#  index_slide_outlines_on_slide_id  (slide_id)
#

require 'test_helper'

class SlideOutlineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
