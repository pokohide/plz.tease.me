# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  slide_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stars_on_slide_id  (slide_id)
#  index_stars_on_user_id   (user_id)
#

require 'test_helper'

class StarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
